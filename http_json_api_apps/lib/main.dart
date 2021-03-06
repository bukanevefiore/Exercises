import 'package:flutter/material.dart';
import 'package:http_json_api_apps/dizi_iceren_local_json.dart';
import 'package:http_json_api_apps/local_json.dart';
import 'package:http_json_api_apps/uzak_api_jso.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Local Json "),
              color: Colors.blue,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocalJsonKullanimi(),));
              },
            ),
            RaisedButton(
              child: Text("Dizi i??eren Local Json "),
              color: Colors.blue,
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DiziIcerenLocalJson(),));
              },
            ),
            RaisedButton(
              child: Text("Uzak Api Kaullan??m?? "),
              color: Colors.blue,
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UzakApiKullanimi(),));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
