import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:just_audio/just_audio.dart';
import '../models/songs_models.dart';
import '../widgets/seekBar.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class SongsScreen extends StatefulWidget {
  const SongsScreen({Key? key}) : super(key: key);

  @override
  State<SongsScreen> createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {

  Song song= Get.arguments ?? Song.songs[0];
  AudioPlayer audioPlayer=AudioPlayer();

  @override
  void initState(){
    super.initState();
    audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
            children: [
              AudioSource.uri(Uri.parse('asset:///${song.url}')),
              AudioSource.uri(Uri.parse('asset:///${Song.songs[1].url}')),
              AudioSource.uri(Uri.parse('asset:///${Song.songs[2].url}')),
              AudioSource.uri(Uri.parse('asset:///${Song.songs[3].url}')),
              AudioSource.uri(Uri.parse('asset:///${Song.songs[4].url}')),
            ]
        )
    );

  }
  @override
  void dispose(){
    audioPlayer.dispose();
    super.dispose();
  }
  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration,Duration?,
           SeekBarData>(
          audioPlayer.positionStream,
          audioPlayer.durationStream,
              (Duration position,Duration? duration){
            return SeekBarData(position, duration?? Duration.zero);
          }
      );
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            song.CoverUrl,fit: BoxFit.cover,),
          maskFilter(),
          MusicPlayer(
              song:song,
              seekBarDataStream: _seekBarDataStream,
              audioPlayer: audioPlayer)
        ],
      ),
    );
  }
}

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({
    super.key,
    required this.song,
    required Stream<SeekBarData> seekBarDataStream,
    required this.audioPlayer,
  }) : _seekBarDataStream = seekBarDataStream;

  final Song song;
  final Stream<SeekBarData> _seekBarDataStream;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 50.0
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(song.title,style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 10,),
          Text(song.description,style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 5,),
          Text(song.artist,style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 30,),
          /// facing issue in seek bar
          // seekBarWidget(seekBarDataStream: _seekBarDataStream, audioPlayer: audioPlayer),
          PlayerButton(audioPlayer: audioPlayer)
        ],
      ),
    );
  }
}

class seekBarWidget extends StatelessWidget {
  const seekBarWidget({
    super.key,
    required Stream<SeekBarData> seekBarDataStream,
    required this.audioPlayer,
  }) : _seekBarDataStream = seekBarDataStream;

  final Stream<SeekBarData> _seekBarDataStream;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SeekBarData>(
        stream: _seekBarDataStream,
        builder: (context,snapshot){
          final positionData=snapshot.data;
          return SeekBar(
            position: positionData?.position ?? Duration.zero,
              duration:  positionData?.duration ?? Duration.zero,
          onChagedEnd: audioPlayer.seek,
          );

        });
  }
}

class PlayerButton extends StatelessWidget {
  const PlayerButton({
    super.key,
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context,index){
            return IconButton(onPressed: audioPlayer.hasPrevious ? audioPlayer.seekToPrevious :null,
                iconSize: 45,
                icon: Icon(Icons.refresh,color: Colors.white,));

          },
        ),
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context,index){
            return IconButton(onPressed: audioPlayer.hasPrevious ? audioPlayer.seekToPrevious :null,
                iconSize: 45,
                icon: Icon(Icons.skip_previous,color: Colors.white,));

          },
        ),
        StreamBuilder<PlayerState>(
            stream: audioPlayer.playerStateStream,
            builder: (context,snapShot){
              if(snapShot.hasData){
                final playerState=snapShot.data;
                final processingState=(playerState! as PlayerState).processingState;
                if(processingState==ProcessingState.loading||
                processingState==ProcessingState.buffering){
                  return Container(
                    width: 64.0,
                      height: 64.0,
                    margin: EdgeInsets.all(10.0),
                    child: CircularProgressIndicator(),
                  );
                }
                else if(!audioPlayer.playing){
                  return IconButton(onPressed:audioPlayer.play,
                      iconSize: 45,
                      icon: Icon(
                        Icons.play_circle,color: Colors.white,));

                }
                else if(processingState!=ProcessingState.completed){
                  return  IconButton(onPressed:audioPlayer.pause,
                      iconSize: 45,
                      icon: Icon(
                        Icons.pause_circle,color: Colors.white,));
                } else{
                return  IconButton(
                      onPressed:()=>audioPlayer.seek(Duration.zero,
                      index: audioPlayer.effectiveIndices!.first,
                      ),
                      iconSize: 45,
                      icon: Icon(
                        Icons.replay_circle_filled,color: Colors.white,));
                }

              }
              else{
                return CircularProgressIndicator();
              }
            }),

        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context,index){
            return IconButton(onPressed: audioPlayer.hasNext
                ? audioPlayer.seekToNext :null,
                iconSize: 45,
                icon: Icon(Icons.skip_next,color: Colors.white,));

          },
        ),
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context,index){
            return IconButton(onPressed: audioPlayer.hasNext
                ? audioPlayer.seekToNext :null,
                iconSize: 45,
                icon: Icon(Icons.shuffle_sharp,color: Colors.white,));

          },
        ),
      ],
    );
  }
}

class maskFilter extends StatelessWidget {
  const maskFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect){
        return LinearGradient(
            begin: Alignment.topCenter ,
            end: Alignment.bottomCenter,
            colors:
        [
          Colors.white,
          Colors.white.withOpacity(0.5),
          Colors.white.withOpacity(0.0),
        ],
        stops: [
          0.0,0.4,0.6
        ]
        ).createShader(rect);
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.deepPurple.shade800.withOpacity(0.8),
                  Colors.deepPurple.shade400.withOpacity(0.8)])
        ),
      ),
     );
  }
}
