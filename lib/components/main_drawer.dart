// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:infinity/screens/home_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/219/219983.png',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: NetworkImage(
                  'https://static.vecteezy.com/system/resources/thumbnails/001/963/715/small/paper-cut-luxury-gold-background-metal-texture-3d-abstract-vector.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            accountName: const Text('User'),
            accountEmail: const Text('user@gmail.com'),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.black),
            title: const Text('Home', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.black),
            title: const Text('Notifications', style: TextStyle(fontSize: 16)),
            onTap: () => print('Notifications'),
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 23,
                height: 23,
                child: const Center(
                  child: Text(
                    '99+',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.black),
            title: const Text('Favorites', style: TextStyle(fontSize: 16)),
            onTap: () => print('Favorites'),
          ),
          ListTile(
            leading: const Icon(Icons.share, color: Colors.black),
            title: const Text('Share', style: TextStyle(fontSize: 16)),
            onTap: () => print('Share'),
          ),
          const Divider(color: Colors.black26),
          ListTile(
            leading: const Icon(Icons.description, color: Colors.black),
            title: const Text('Policies', style: TextStyle(fontSize: 16)),
            onTap: () => print('Policies'),
          ),
          ListTile(
            leading: const Icon(Icons.source, color: Colors.black),
            title: const Text('Source', style: TextStyle(fontSize: 16)),
            onTap: () => print('Source'),
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.black),
            title: const Text('Settings', style: TextStyle(fontSize: 16)),
            onTap: () => print('Settings'),
          ),
          const Divider(color: Colors.black26),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.black),
            title: const Text('Exit', style: TextStyle(fontSize: 16)),
            onTap: () => print('Exit'),
          ),
        ],
      ),
    );
  }
}
