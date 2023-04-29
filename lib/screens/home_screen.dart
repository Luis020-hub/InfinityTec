import 'package:flutter/material.dart';
import 'package:infinity/screens/health_screen.dart';
import 'package:infinity/screens/sports_screen.dart';
import 'package:infinity/screens/technology_screen.dart';
import 'package:infinity/screens/business_screen.dart';
import 'package:infinity/components/main_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'World News',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(5),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: [
          InkWell(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Ink.image(
                  image: const NetworkImage(
                    'https://static.thenounproject.com/png/965230-200.png',
                  ),
                  height: 160,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                const Text(
                  'Technology',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const TechScreen()),
              );
            },
          ),
          InkWell(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Ink.image(
                  image: const NetworkImage(
                    'https://static.thenounproject.com/png/1152587-200.png',
                  ),
                  height: 160,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                const Text(
                  'Business',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const BusinessScreen()),
              );
            },
          ),
          InkWell(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Ink.image(
                  image: const NetworkImage(
                    'https://static.thenounproject.com/png/5678592-200.png',
                  ),
                  height: 160,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                const Text(
                  'Sports',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SportsScreen()),
              );
            },
          ),
          InkWell(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Ink.image(
                  image: const NetworkImage(
                    'https://static.thenounproject.com/png/2098225-200.png',
                  ),
                  height: 160,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                const Text(
                  'Health',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HealthScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
