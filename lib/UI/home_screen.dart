import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/songs_models.dart';
import '../widgets/section_header.dart';
import '../widgets/song_card.dart';
import '../models/playlist_mopdel.dart';
import '../widgets/playlistCard.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Song> songs=Song.songs;
    List<PlayList> playlists=PlayList.playlists;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade800.withOpacity(0.8),
              Colors.deepPurple.shade400.withOpacity(0.8)])
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: customAppBar(),
        bottomNavigationBar: CustomNavigationBar(),
        body: SingleChildScrollView(
         child: Column(
           children: [
            DiscoverMusic(),
             TrendingMusic(songs: songs),
             Column(
               children: [
                 SelectionHeader(title: "Play List"),
                 ListView.builder(
                   shrinkWrap: true,
                   padding: EdgeInsets.only(top: 20),
                   physics: NeverScrollableScrollPhysics(),
                   itemCount: playlists.length,
                     itemBuilder: (context,index){
                      return PlaylistCard(songs: songs[index]);
                 }),
               ],
             )
           ],
         ),
        ),
      ),
    );
  }
}



class TrendingMusic extends StatelessWidget {
  const TrendingMusic({
    super.key,
    required this.songs,
  });

  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return Padding(
               padding: const EdgeInsets.only(left: 20.0,top: 20.0,bottom: 20.0),
               child: Column(children: [
                 Padding(
                   padding: const EdgeInsets.only(right: 20.0),
                   child: SelectionHeader(title:"Trending Music"),
                 ),
                 SizedBox(height: 20,),
                 SizedBox(
                   height: MediaQuery.of(context).size.height *0.27,
                   child: ListView.builder(
                       scrollDirection: Axis.horizontal,
                       itemCount: songs.length,
                       itemBuilder: (context,index){
                     return SongCard(songs: songs[index]);
                   }),
                 )

               ],),
             );
  }
}


class DiscoverMusic extends StatelessWidget {
  const DiscoverMusic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Hello Developer",style: Theme.of(context).textTheme.bodyLarge,),
        SizedBox(height: 8,),
        Text('I love Music',style: Theme.of(context).textTheme.headline6,)
        ,SizedBox(height: 20,),
        TextFormField(
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            hintText: 'Search',
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey.shade400),
            prefixIcon: Icon(Icons.search,color: Colors.grey.shade400,),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none
            )
          ),
        )
      ],
    ),
    );
  }
}

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepPurple.shade700,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
      BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined),label: 'Fevorites'),
      BottomNavigationBarItem(icon: Icon(Icons.play_circle_fill_outlined),label: 'Play'),
      BottomNavigationBarItem(icon: Icon(Icons.people_alt_outlined),label: 'Profile'),

    ]);
  }
}

class customAppBar extends StatelessWidget with PreferredSizeWidget {
  const customAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Icon(Icons.grid_view_rounded),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: CircleAvatar(
            backgroundImage: NetworkImage('url'),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56.0);
}
