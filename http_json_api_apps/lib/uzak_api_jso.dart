import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_json_api_apps/models/fotograflar.dart';

class UzakApiKullanimi extends StatefulWidget {
  @override
  _UzakApiKullanimiState createState() => _UzakApiKullanimiState();
}

class _UzakApiKullanimiState extends State<UzakApiKullanimi> {

  // veri çekme
  Future<List<Fotograflar>> _fotografGetir() async {
    
    var response =await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    if(response.statusCode == 200) {
     // return Fotograflar.fromJsonMap(jsonDecode(response.body));
      return (jsonDecode(response.body) as List).map((tekGonderiMap) => Fotograflar.fromJsonMap(tekGonderiMap)).toList();
    }
    else{
      throw Exception("Bağlanamadı ${response.statusCode}");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Uzak Api"),),
      body: FutureBuilder(
        future: _fotografGetir(),
        builder: (BuildContext context,
        AsyncSnapshot<List<Fotograflar>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(snapshot.data[index].title),
                  //subtitle: Text(snapshot.data[index].),
                  leading: CircleAvatar(child: Text(snapshot.data[index].id.toString()),
                  ),
                );
              },);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        }),
    );
  }
}
