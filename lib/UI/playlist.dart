import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:just_audio/just_audio.dart';

import '../models/playlist_mopdel.dart';
import '../models/songs_models.dart';
import '../widgets/seekBar.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({Key? key}) : super(key: key);

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {

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
    PlayList playlists=PlayList.playlists[0];
    AudioPlayer audioPlayer=AudioPlayer();
    return  Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
          [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200.withOpacity(0.8),
          ],
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
title: Text("Play List"),
          

        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [

                SizedBox(height: 30,),

                playlistInfo(
                    seekBarDataStream: _seekBarDataStream,
                    playlists: playlists,audioPlayer: audioPlayer),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class playlistInfo extends StatelessWidget {
  const playlistInfo({
    super.key,
    required this.playlists, required this.audioPlayer, required Stream<SeekBarData> seekBarDataStream,
  });

  final PlayList playlists;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.asset(playlists.imageUrl,
          height: MediaQuery.of(context).size.height*0.3,
          // width: MediaQuery.of(context).size.width*0.30,
          ),

        ),
        const SizedBox(height: 80,),
        Text(playlists.titel,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),),
        const SizedBox(height: 80,),
        Row(children: [
          Text('Play')
        ],),
        PlayerButton(audioPlayer: audioPlayer)
      ],
    );
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
      ],
    );
  }
}
