// ignore_for_file: await_only_futures

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:infinity/detail_screen.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Xml2Json xml2json = Xml2Json();
  List listaTecnologia = [];

  Future tecnologia() async {
    final uri = Uri.parse('http://rss.uol.com.br/feed/tecnologia.xml');
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
        title: const Text('Uol'),
      ),
      body: Padding(
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
                            'Notícias',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
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
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return DetailScreen(
                                      title: listaTecnologia[index]['title']
                                          ['__cdata'],
                                      // imageData: listaTecnologia[index][''] Problema
                                      // ['url'],
                                      description: listaTecnologia[index]
                                          ['description']['__cdata'],
                                      date: listaTecnologia[index]['pubDate']
                                          ['__cdata'],
                                    );
                                  }));
                                },
                                horizontalTitleGap: 10,
                                minVerticalPadding: 10,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                title: Text(
                                  listaTecnologia[index]['title']['__cdata'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // Problema
                                // leading: Image.network(
                                //   listaTecnologia[index]['media\$content']
                                //       ['url'],
                                //   fit: BoxFit.cover,
                                //   height: 80,
                                //   width: 80,
                                // ),
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
    );
  }
}
