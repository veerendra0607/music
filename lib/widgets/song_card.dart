import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/songs_models.dart';
import 'package:get/get.dart';


class SongCard extends StatelessWidget {
  const SongCard({
    super.key,
    required this.songs,
  });

  final Song songs;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed('/song',arguments:songs);
      },
      child:  Container(
          margin: EdgeInsets.only(right: 10),
          child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: AssetImage(
                          songs.CoverUrl),
                      fit:BoxFit.cover,

                    ),

                  ),
                ),
                Container(
                  // width: MediaQuery.of(context).size.width*0.37,
                  // height: MediaQuery.of(context).size.height*0.10,
                  margin: EdgeInsets.only(top: 100),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white.withOpacity(0.8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Text(
                            overflow: TextOverflow.ellipsis,
                            songs.title,style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.deepPurple,fontWeight: FontWeight.bold),)),
                          Expanded(child: Text(
                            overflow: TextOverflow.ellipsis,
                            songs.description,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color:Colors.deepPurple ),)),
                        ],
                      ),
                      Icon(Icons.play_circle,color: Colors.deepPurple,)
                    ],
                  ),
                )]
          ),
        )
    );
  }
}