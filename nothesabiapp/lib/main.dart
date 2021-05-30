import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.orangeAccent,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dersAdi;
  int dersKredi = 1;
  double dersHarfDegeri = 4;
  List<Ders> tumDersler;
  var formKey = GlobalKey<FormState>();
  double ortalama = 0;
  static int sayac=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Ortalama Hesapla"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
        child: Icon(Icons.add),
      ),
      body: OrientationBuilder(
        builder: (context,orientation) {
          if(orientation ==Orientation.portrait){
            return uygulamaGovdesi();
          }else{
            return uygulamaGovdesiLandscape();
          }

          }),
    );
  }

  Widget uygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Ders Adı",
                        hintText: "Ders Adı Giriniz",
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.orangeAccent, width: 2),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.length > 0) {
                          return null;
                        } else
                          return "Ders Adı Boş Olamaz ";
                      },
                      onSaved: (kaydedilecekDeger) {
                        dersAdi = kaydedilecekDeger;
                        setState(() {
                          tumDersler
                              .add(Ders(dersAdi, dersHarfDegeri, dersKredi, rastgeleRenkOlustur()));
                          ortalama = 0;
                          ortalamaHesapla();
                        });
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                  items: dersKredileriItems(),
                                  value: dersKredi,
                                  onChanged: (secilenKredi) {
                                    setState(() {
                                      dersKredi = secilenKredi;
                                    });
                                  }),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.orangeAccent, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          Container(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<double>(
                                items: dersHarfDegerleriItems(),
                                value: dersHarfDegeri,
                                onChanged: (secilenHarf) {
                                  setState(() {
                                    dersHarfDegeri = secilenHarf;
                                  });
                                },
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.orangeAccent, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.deepOrange,
            height: 60,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Center(
                child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: "Ortalama : ", style: TextStyle(fontSize: 18)),
                  TextSpan(
                      text: tumDersler.length == 0 ? "0.0" : "${ortalama.toStringAsFixed(2)}",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
                ],
              ),
            )),
          ),
          Expanded(
              child: Container(
                  color: Colors.white24,
                  child: ListView.builder(
                    itemBuilder: _listeElemanlariniOlustur,
                    itemCount: tumDersler.length,
                  ))),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> dersKredileriItems() {
    List<DropdownMenuItem<int>> krediler = [];
    for (int i = 1; i <= 10; i++) {
      krediler.add(DropdownMenuItem<int>(
        value: i,
        child: Text("$i Kredi"),
      ));
    }
    return krediler;
  }

  List<DropdownMenuItem<double>> dersHarfDegerleriItems() {
    List<DropdownMenuItem<double>> harfnotlari = [];

    harfnotlari.add(DropdownMenuItem(
      child: Text("AA"),
      value: 4,
    ));
    harfnotlari.add(DropdownMenuItem(
      child: Text("BA"),
      value: 3.5,
    ));
    harfnotlari.add(DropdownMenuItem(
      child: Text("BB"),
      value: 3,
    ));
    harfnotlari.add(DropdownMenuItem(
      child: Text("CB"),
      value: 2.5,
    ));
    harfnotlari.add(DropdownMenuItem(
      child: Text("CC"),
      value: 2,
    ));
    harfnotlari.add(DropdownMenuItem(
      child: Text("DC"),
      value: 1.5,
    ));
    harfnotlari.add(DropdownMenuItem(
      child: Text("DD"),
      value: 1,
    ));
    harfnotlari.add(DropdownMenuItem(
      child: Text("FF"),
      value: 0,
    ));

    return harfnotlari;
  }

  Widget _listeElemanlariniOlustur(BuildContext context, int index) {

    sayac++;
    debugPrint(sayac.toString());
    //Color olusanRastgeleRenk= rastgeleRenkOlustur();

    return Dismissible(
      key: Key(sayac.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          tumDersler.removeAt(index);
          ortalamaHesapla();
        });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: tumDersler[index].renk,width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ListTile(
          leading: Icon(Icons.done,size: 30,color: tumDersler[index].renk,),
          title: Text(tumDersler[index].ad.toString()),
          trailing: Icon(Icons.keyboard_arrow_right),
          subtitle: Text(tumDersler[index].kredi.toString() +
              "kredi Ders not değeri" +
              tumDersler[index].harfDegeri.toString()),
        ),
      ),
    );
  }

  void ortalamaHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;

    for (var oankiDers in tumDersler) {
      var kredi = oankiDers.kredi;
      var harfDegeri = oankiDers.harfDegeri;

      toplamKredi += kredi;
      toplamNot = toplamNot + (harfDegeri + kredi);
    }
    ortalama = toplamNot / toplamKredi;
  }

  Color rastgeleRenkOlustur() {

    return Color.fromARGB(150 + Random().nextInt(105), Random().nextInt(255), Random().nextInt(255), Random().nextInt(255));

  }

  Widget uygulamaGovdesiLandscape() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Ders Adı",
                          hintText: "Ders Adı Giriniz",
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black26, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.orangeAccent, width: 2),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (girilenDeger) {
                          if (girilenDeger.length > 0) {
                            return null;
                          } else
                            return "Ders Adı Boş Olamaz ";
                        },
                        onSaved: (kaydedilecekDeger) {
                          dersAdi = kaydedilecekDeger;
                          setState(() {
                            tumDersler
                                .add(Ders(dersAdi, dersHarfDegeri, dersKredi, rastgeleRenkOlustur()));
                            ortalama = 0;
                            ortalamaHesapla();
                          });
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                    items: dersKredileriItems(),
                                    value: dersKredi,
                                    onChanged: (secilenKredi) {
                                      setState(() {
                                        dersKredi = secilenKredi;
                                      });
                                    }),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.orangeAccent, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            Container(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<double>(
                                  items: dersHarfDegerleriItems(),
                                  value: dersHarfDegeri,
                                  onChanged: (secilenHarf) {
                                    setState(() {
                                      dersHarfDegeri = secilenHarf;
                                    });
                                  },
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.orangeAccent, width: 2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    border: Border.all(color: Colors.deepOrange, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  height: 60,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: "Ortalama : ", style: TextStyle(fontSize: 18)),
                            TextSpan(
                                text: tumDersler.length == 0 ? "0.0" : "${ortalama.toStringAsFixed(2)}",
                                style:
                                TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
          flex: 1,
          ),
          Expanded(
              child: Container(
                  color: Colors.white24,
                  child: ListView.builder(
                    itemBuilder: _listeElemanlariniOlustur,
                    itemCount: tumDersler.length,
                  )),flex: 1,
          ),
        ],
      ),
    );

  }
}

class Ders {
  String ad;
  double harfDegeri;
  int kredi;
  Color renk;

  Ders(this.ad, this.harfDegeri, this.kredi,this.renk);
}
