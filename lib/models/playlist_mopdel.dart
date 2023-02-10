import 'songs_models.dart';
class PlayList{
  final String titel;
  final String songs;
  final String  imageUrl;
  final String artist;
  final String description;
  PlayList({
    required this.titel,
    required this.songs,
    required this.imageUrl,
    required this.artist,
    required this.description,

});
  static List<PlayList> playlists=[
   PlayList(titel: "Google dev music",artist: 'All Ok',
       description: 'Mr Bachelor titel Song',
       songs: 'assets/songs/Baare Baare Rajakumari.mp3', imageUrl: 'assets/image/SV1.jpg'),
    PlayList(
        description: 'Mr dev titel Song',
        titel: "Mr Bachelor", artist: 'Raghu dixit',
       songs: 'assets/songs/Baare Baare Rajakumari.mp3', imageUrl: 'assets/image/SV2.jpg'),
    PlayList(titel: "Mr perfect", artist: 'Raghu dixit',
        description: 'Hip Hop titel Song',
       songs: 'assets/songs/Baare Baare Rajakumari.mp3', imageUrl: 'assets/image/SV3.jpg'),
    PlayList(
        description: 'Mr Bachelor titel Song',
        titel: "Upadykash titel", artist: 'Raghu dixit',
       songs: 'assets/songs/Baare Baare Rajakumari.mp3', imageUrl: 'assets/image/song1.jpg'),
    PlayList(titel: "All ok", artist: 'Raghu dixit',
        description: 'flutter dev music',
        songs: 'assets/songs/Baare Baare Rajakumari.mp3', imageUrl: 'assets/image/SV4.jpg'),
    PlayList(titel: "Lofi Flip", artist: 'Raghu dixit',

        description: 'Upadykash titel songs',songs: 'assets/songs/Baare Baare Rajakumari.mp3', imageUrl: 'assets/image/song2.jpg'),
  ];

}