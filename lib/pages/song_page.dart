import 'package:flutter/material.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

import '../components/neu_box.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});
  // convert duration into min:sec
  String formatTime(Duration duration){
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inSeconds}:$twoDigitSeconds}";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Playlistprovider>(
      builder: (context, value, child) {
        // get playlist
        final playlist = value.playlist;

        //get curent song index
        final currntSong = playlist[value.currentSongIndex ?? 0];

        // return scaffold ui

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // app bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //back button
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      //title
                      const Text(
                        "P L A Y L I S T",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),

                      //menu button
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  //album artwork

                  //image
                  NeuBox(
                    child: Column(
                      children: [
                        //image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(currntSong.albumbartImagePath),
                        ),

                        //song and artist name
                         Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //song and artist name
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currntSong.songName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(currntSong.artistName),
                                ],
                              ),

                              //heart icon
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // song duration progress
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //start time
                              Text(formatTime(value.currentDuration)),

                              //shuffle icon
                              const Icon(Icons.shuffle),

                              //repeat time
                              const Icon(Icons.repeat),

                              //end time
                               Text(formatTime(value.totalDuration)),
                            ],
                          ),
                        ),
                        Slider(
                          min: 0,
                          max: value.totalDuration.inSeconds.toDouble(),
                          value: value.currentDuration.inSeconds.toDouble(),
                          activeColor: Colors.green,
                          onChanged: (double double) {
                            //during when the user is sliding arround
                          },
                          onChangeEnd: (double double){
                            // sliding has finished, go to that positionin song duration
                            value.seek(Duration(seconds: double.toInt()));
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 5),

                  //playback controls
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        // skip previou
                        Expanded(
                          child: GestureDetector(
                            onTap: value.playPreviousSong,
                            child: const NeuBox(
                              child: Icon(Icons.skip_previous),
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 20,
                        ),
                        //play pause
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: value.pauseOrResume,
                            child: NeuBox(
                              child: Icon(value.isPlaying ? Icons.pause:  Icons.play_arrow),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        // skip forword
                        Expanded(
                          child: GestureDetector(
                            onTap: value.playNextSong,
                            child: const NeuBox(
                              child: Icon(Icons.skip_next),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
