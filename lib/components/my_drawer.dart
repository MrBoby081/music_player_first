import 'package:flutter/material.dart';
import 'package:music_player/pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          //logo
          DrawerHeader(
            child: Center(
              child: Icon(Icons.music_note, size: 40,
                color: Theme.of(context).colorScheme.primary,),

            ),
          ),

          //Home tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25),
            child: ListTile(
              title: const Text(
                'H O M E',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.home),
              onTap: () => Navigator.pop(context),
            ),
          ),

          ///settings
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 10),
            child: ListTile(
              title: const Text(
                'S E T T I N G S',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.settings),
              onTap: () {
                //pop drawer
                Navigator.pop(context);

                // Navigate to
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => const SettingPage()),
                );
              },
            ),
          ),

        ],
      ),

    );
  }
}


