import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../models/songs_models.dart';
class PlaylistCard extends StatelessWidget {
  const PlaylistCard({
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
      child: Container(
        height:  75,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(color: Colors.deepPurple.shade800.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15.0)
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                width: MediaQuery.of(context).size.width*0.20,
                height: MediaQuery.of(context).size.height*0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                    image: AssetImage(
                        songs.CoverUrl),
                    fit:BoxFit.cover,

                  ),

                ),
              ),
              // Image.network(playlist.imageUrl,height: 50,width: 50,fit: BoxFit.cover,),
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(songs.title,style: Theme.of(context).textTheme.bodyLarge!.
                  copyWith(fontWeight: FontWeight.bold),),
                  Text('${songs.description.length } songs',
                    style: Theme.of(context).textTheme.bodySmall,)
                ],
              ),
            ),
            IconButton(onPressed: (){},icon: Icon(Icons.play_circle,color: Colors.white,),),
          ],
        ),
      ),
    );
  }
}