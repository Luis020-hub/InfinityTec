// ignore_for_file: await_only_futures

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:infinity/screens/detail_screen.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({super.key});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  final Xml2Json xml2json = Xml2Json();
  List lista = [];

  void refresh() {
    setState(() {});
  }

  Future business() async {
    final uri = Uri.parse('https://feeds.feedburner.com/ndtvprofit-latest');
    final response = await http.get(uri);
    xml2json.parse(response.body.toString());
    var jsondata = await xml2json.toGData();
    var data = jsonDecode(jsondata);
    lista = data['rss']['channel']['item'];
    // print(lista);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Business',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          size: 28.0,
          color: Colors.black,
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: FutureBuilder(
            future: business(),
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
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            controller: ScrollController(),
                            itemCount: lista.length,
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
                                            title: lista[index]['title']
                                                ['__cdata'],
                                            imageData: lista[index]
                                                ['media\$content']['url'],
                                            description: lista[index]
                                                ['description']['__cdata'],
                                            date: lista[index]['pubDate']
                                                ['__cdata'],
                                            link: lista[index]['link']
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
                                    lista[index]['title']['__cdata'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: Image.network(
                                    lista[index]['media\$content']['url'],
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
