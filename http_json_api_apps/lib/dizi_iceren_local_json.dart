import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http_json_api_apps/models/araba.dart';





class DiziIcerenLocalJson extends StatefulWidget {


  @override
  _DiziIcerenLocalJsonState createState() => _DiziIcerenLocalJsonState();
}

class _DiziIcerenLocalJsonState extends State<DiziIcerenLocalJson> {
  List<Araba> arabaListesi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    arabaListesi=[];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Local Json"),),
      body: Container(
          child:FutureBuilder(
            future: veriKaynaginiAl(),
            builder: (context,sonuc) {

              if(sonuc.hasData) {
                arabaListesi=sonuc.data;
                return ListView.builder(
                  itemBuilder: (context,index) {
                    return ListTile(
                      title: Text(arabaListesi[index].araba_adi),
                      subtitle: Text(arabaListesi[index].kurulus_tarihi.toString()),
                    );
                  },itemCount: arabaListesi.length,);
              }
              else {
                return Center(child: CircularProgressIndicator(),);
              }
            },
          )
      ),
    );
  }

  Future<List<Araba>> veriKaynaginiAl() async {

    // verilen json içindede dizi olunca

    var gelenJson = await DefaultAssetBundle.of(context).loadString("assets/data/araba.json");
    List<Araba> arabaListesi=(jsonDecode(gelenJson) as List).map((mapYapisi) => Araba.fromJsonMap(mapYapisi)).toList();

    debugPrint("post sayısı: " +arabaListesi.length.toString());
    for(int i=0;i<arabaListesi.length-1;i++){
      debugPrint(arabaListesi[i].araba_adi.toString());
    }
    return arabaListesi;

  }


}




