class Song{
  final String title;
  final String description;
  final String url;
  final String CoverUrl;
  final String artist;

  Song({
    required this.title,
    required this.description,
    required this.url,
    required this.CoverUrl,
    required this.artist,
});
  static List<Song> songs=[
    Song(title: 'Mr Bachelor',
        description: 'Mr Bachelor titel Song',
        url: 'assets/songs/Mr_Bachelor.mp3',
        CoverUrl: 'assets/image/SV1.jpg',
        artist: 'All Ok'
    ),

    Song(title: 'Upadykash titel',
        description: 'Upadykash titel songs',
        url: 'assets/songs/Collegu Boreu.mp3',
        CoverUrl: 'assets/image/SV1.jpg',
        artist: 'R Aswath'
    ),
    Song(title: 'Glass google',
        description: 'Glass google titel track',
        url: 'assets/songs/Baare Baare Rajakumari.mp3',
        CoverUrl: 'assets/image/SV2.jpg',
        artist: 'All Ok'
    ),
    Song(title: 'Upadykash titel',
        description: 'Upadykash titel songs',
        url: 'assets/songs/Collegu Boreu.mp3',
        CoverUrl: 'assets/image/SV1.jpg',
        artist: 'Rahul ditto'
    ),
    Song(title: 'Google dev music',
        description: 'flutter dev music',
        url: 'assets/songs/Kranti Theme Music.mp3',
        CoverUrl: 'assets/image/SV3.jpg',
        artist: ''
    ),
    Song(title: 'Mr Bachelor',
        description: 'Mr Bachelor titel song',
        url: 'assets/songs/Mr Bachelor Title Song.mp3',
        CoverUrl: 'assets/image/SV4.jpg',
        artist: 'All Ok'
    ),
    Song(title: 'Glass song',
        description: 'Hip Hop',
        url: 'assets/songs/Upadhyaksha Title Track.mp3',
        CoverUrl: 'assets/image/SV2.jpg',
        artist: 'All Ok'),
  ];
}