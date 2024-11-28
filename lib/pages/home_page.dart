import 'package:flutter/material.dart';
import 'package:music_player/components/my_drawer.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/pages/song_page.dart';
import 'package:provider/provider.dart';

import '../models/song.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get the playlist provider
  late final dynamic playlistProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //get playlist provider
    playlistProvider = Provider.of<Playlistprovider>(
      context, listen: false
    );
  }
  // go to a song
  void  goToSong(int songIndex){
    //update currnt song index
    playlistProvider.currentSongIndex = songIndex;

    // navigate to song [age
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SongPage(),),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "P L A Y L I S T",
        ),
      ),
      drawer: const MyDrawer(),
      body: Consumer<Playlistprovider>(builder: (context, value, child) {
        //get the playlist
        final List<Song> playlist = value.playlist;

        //return list view UI
        return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              //get indivisual song
              final Song song = playlist[index];

              //return ListTile
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.songName),
                leading: Image.asset(song.albumbartImagePath),
                onTap: () => goToSong(index),
              );
            });
      }),
    );
  }
}
