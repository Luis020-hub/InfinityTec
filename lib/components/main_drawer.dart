import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget _createDrawer(IconData icon, String label) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25,
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomCenter,
            color: Colors.blueGrey,
            child: const Text(
              'Welcome to \nWorld News',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          _createDrawer(
            Icons.home,
            'Home',
          ),
          _createDrawer(
            Icons.notifications,
            'Notifications',
          ),
          _createDrawer(
            Icons.star,
            'Favorites',
          ),
          _createDrawer(
            Icons.settings,
            'Settings',
          ),
        ],
      ),
    );
  }
}
