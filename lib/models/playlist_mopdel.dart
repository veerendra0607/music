import 'songs_models.dart';
class PlayList{
  final String titel;
  final String songs;
  final String  imageUrl;
  PlayList({
    required this.titel,
    required this.songs,
    required this.imageUrl,

});
  static List<PlayList> playlists=[
   PlayList(titel: "Kranti",
       songs: 'assets/songs/Baare Baare Rajakumari.mp3', imageUrl: 'assets/image/SV1.jpg'),
    PlayList(titel: "Hip Hop",
       songs: 'assets/songs/Baare Baare Rajakumari.mp3', imageUrl: 'assets/image/SV2.jpg'),
    PlayList(titel: "Mr perfect",
       songs: 'assets/songs/Baare Baare Rajakumari.mp3', imageUrl: 'assets/image/SV3.jpg'),
    PlayList(titel: "Mr Developer",
       songs: 'assets/songs/Baare Baare Rajakumari.mp3', imageUrl: 'assets/image/song1.jpg'),
    PlayList(titel: "All ok",
       songs: 'assets/songs/Baare Baare Rajakumari.mp3', imageUrl: 'assets/image/SV4.jpg'),
    PlayList(titel: "Lofi Flip",
       songs: 'assets/songs/Baare Baare Rajakumari.mp3', imageUrl: 'assets/image/song2.jpg'),
  ];

}