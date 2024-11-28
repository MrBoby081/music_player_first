import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';


class Playlistprovider extends ChangeNotifier{
  //playlist of songs
  final List<Song > _playlist = [
    //song 1
    Song(
        songName: 'Deewane Ham Nahi Hote',
        artistName: 'Jack',
        albumbartImagePath: 'lib/assets/images/dewane.jpg',
        audioPath: "lib/assets/song/deewane_ham_nahi_hote.mp3"),


    //song 2
    Song(
        songName: 'Apple Song',
        artistName: 'Herry',
        albumbartImagePath: 'lib/assets/images/apple.jpg',
        audioPath: "lib/assets/song/apple_whistle.mp3"),


    //song 3
    Song(
        songName: 'Guitar Song',
        artistName: 'Jessy',
        albumbartImagePath: 'lib/assets/images/guiter.jpg',
        audioPath: "lib/assets/song/karma_guitar.mp3"),

  ];

  /*

  A U D I O P L A Y E R

   */

  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // constructor
  Playlistprovider(){
    listenToDuration();
  }

  // initially not playing
  bool _isPlaying = false;

  // play the song
  void play() async{
    final String path = _playlist[
    _currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path)); //play the new song
    _isPlaying = true;
    notifyListeners();
  }
  // pause current song
  void pause() async{
    await _audioPlayer.pause();
    notifyListeners();
  }

  // resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }


  // pause or resume
  void pauseOrResume() async{
    if (_isPlaying){
      pause();
    }
    else{
      resume();
    }
    notifyListeners();
  }

  // Seek toa specific position in the current song
  void seek(Duration position) async{
    await _audioPlayer.seek(position);
  }
  // play next song
  void playNextSong(){
    if(_currentSongIndex != null) {
      // go to the next song if it's not the last song
      currentSongIndex = _currentSongIndex! +1;
    }
    else{
      //if it's the last song, loop back to the first song
      currentSongIndex = 0;
    }
  }

  // play previous song
  void playPreviousSong() async {
    //if more then 2 seconds haave passed, restart the current song
    if(_currentDuration.inSeconds >2){
      seek(Duration.zero);
    }
    //if it's within first 2 second of the song, gp to thr previous song
    else{
      if(_currentSongIndex!> 0){
        currentSongIndex = _currentSongIndex! -1;
      }
      else{
        //if it's the first song, loop back to the last song
        currentSongIndex = _playlist.length -1;
      }
    }
  }

  // listen to dauratin
  void listenToDuration(){

    // listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    },
    );
    // listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition){
      notifyListeners();
    },
    );
    // listen for song completion
    _audioPlayer.onPlayerComplete.listen((event){
      playNextSong();
    } );
  }

  // dispose audio player

  /*

  G E T T E R S

   */
  // current song playing
  int? _currentSongIndex;



  /*

  GETTERS


   */
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  /*

  SETTERS
  */
  set currentSongIndex(int? newIndex){
    // update current song index
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play(); // play the song at a new index
    }

    //updtae UI
    notifyListeners();
  }

}