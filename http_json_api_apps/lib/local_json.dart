import 'package:flutter/material.dart';
import 'dart:convert';

class LocalJsonKullanimi extends StatefulWidget {


  @override
  _LocalJsonKullanimiState createState() => _LocalJsonKullanimiState();
}

class _LocalJsonKullanimiState extends State<LocalJsonKullanimi> {

  List postListesi;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  /*  veriKaynaginiGetir().then((gelenpostlistesi) {
      setState(() {
        postListesi=gelenpostlistesi;
      });
    });

   */
  }

  @override
  Widget build(BuildContext context) {
    //veriKaynaginiGetir();
    return Scaffold(
      appBar: AppBar(title: Text("Local Json"),),
      body: Container(
        child:FutureBuilder(
          future: veriKaynaginiGetir(),
          builder: (context,sonuc) {

            if(sonuc.hasData) {
              postListesi=sonuc.data;
              return ListView.builder(
                  itemBuilder: (context,index) {
                    return ListTile(
                      title: Text(postListesi[index]["title"]),
                      subtitle: Text(postListesi[index]["body"]),
                    );
                  },itemCount: postListesi.length,);
            }
            else {
              return Center(child: CircularProgressIndicator(),);
            }
          },
      )
    ),
    );
  }


  /*
  //  birinci yöntem widget ı
  @override
  Widget build(BuildContext context) {
    //veriKaynaginiGetir();
    return Scaffold(
      appBar: AppBar(title: Text("Local Json"),),
      body: postListesi != null ? Container(
        child: ListView.builder(itemBuilder: (context,index) {
          return Column(
            children: [
              ListTile(
                title: Text(postListesi[index]["title"]),
                subtitle: Text(postListesi[index]["body"]),
              ),
              Divider(),
            ],
          );

        },itemCount: postListesi.length,),
      ) : Center(child: CircularProgressIndicator(),),
    );
  }

   */

  Future<List> veriKaynaginiGetir() async {
    /*
 //   birinci yöntem
    Future<String> jsonOku=DefaultAssetBundle.of(context).loadString("assets/data/postlar.json");
    jsonOku.then((okunanjson) {
      debugPrint("gelen json: " +okunanjson);
      return okunanjson;
    });

    */

    // ikinci yöntem
    var gelenJson= await DefaultAssetBundle.of(context).loadString("assets/data/postlar.json");
    debugPrint(gelenJson);

    List postListesi=json.decode(gelenJson.toString());
    debugPrint("post sayısı: " +postListesi.length.toString());
    for(int i=0;i<postListesi.length-1;i++){
      debugPrint(postListesi[i]["title"].toString());
    }
    return postListesi;

  }



}
