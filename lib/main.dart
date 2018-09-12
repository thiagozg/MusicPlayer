import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';

void main() => runApp(new MusicPlayer());

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {

  List<Song> _songs;
  MusicFinder audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() async {
    audioPlayer = new MusicFinder();
    var songsOnDevice = await MusicFinder.allSongs();

    setState(() {
      _songs = new List.from(songsOnDevice);
    });
  }

  void turnSong(String songPath) {
    if (isPlaying) {
      audioPlayer.play(songPath, isLocal: true);
    } else {
      audioPlayer.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homePage(),
    );
  }

  Widget homePage() {
    return new Scaffold(

      appBar: new AppBar(
        title: new Text("Music Player - Flutter"),
      ),

      body: new ListView.builder(
        itemCount: _songs.length,
        itemBuilder: (context, int index) {
          var song = _songs[index];
          var songTitle = song.title;
          var songTitleInitial = songTitle[0];

          return new ListTile(
              leading: new CircleAvatar(
                child: new Text(songTitleInitial),
              ),
              title: new Text(songTitle),
              onTap: () {
                isPlaying = !isPlaying;
                turnSong(song.uri);
              }
          );
        },
      ),

    );
  }

}
