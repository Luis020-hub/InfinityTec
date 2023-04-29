// ignore_for_file: await_only_futures

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:infinity/screens/detail_screen.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;
import '../components/main_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Xml2Json xml2json = Xml2Json();
  List listaTecnologia = [];
  void refresh() {
    setState(() {});
  }

  Future tecnologia() async {
    final uri = Uri.parse('https://feeds.feedburner.com/gadgets360-latest');
    final response = await http.get(uri);
    xml2json.parse(response.body.toString());
    var jsondata = await xml2json.toGData();
    var data = jsonDecode(jsondata);
    listaTecnologia = data['rss']['channel']['item'];
    // print(listaTecnologia);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('World News'),
        iconTheme: const IconThemeData(
          size: 28.0,
          color: Colors.white,
          opacity: 10.0,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                refresh();
              },
              child: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: FutureBuilder(
            future: tecnologia(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const SizedBox(
                      height: 45,
                      width: 45,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Text(
                              'Technology',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            controller: ScrollController(),
                            itemCount: listaTecnologia.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      color: Colors.black12,
                                    )
                                  ],
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return DetailScreen(
                                            title: listaTecnologia[index]
                                                ['title']['__cdata'],
                                            imageData: listaTecnologia[index]
                                                ['media\$content']['url'],
                                            description: listaTecnologia[index]
                                                ['description']['__cdata'],
                                            date: listaTecnologia[index]
                                                ['pubDate']['__cdata'],
                                            link: listaTecnologia[index]['link']
                                                ['__cdata'],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  horizontalTitleGap: 10,
                                  minVerticalPadding: 10,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 8,
                                  ),
                                  title: Text(
                                    listaTecnologia[index]['title']['__cdata'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: Image.network(
                                    listaTecnologia[index]['media\$content']
                                        ['url'],
                                    fit: BoxFit.cover,
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
