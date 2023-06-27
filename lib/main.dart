import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Pt. Avia avian'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> apiData = [];
  String _temp = '';
  String? _pelanggan;
  Color getButtonColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return Colors.orange.withOpacity(0.8);
      ;
    } else {
      return Color.fromARGB(255, 255, 72, 0);
    }
  }

  @override
  Future<String> fetchData() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/customer/'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaData() {
    Future<String> data = fetchData();
    data.then((value) {
      setState(() {
        _temp = value;
      });
    });
  }

  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150, // Adjust the width value as per your requirement
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green, // Green border color
                        width: 2.0, // Border width
                      ),
                    ),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.home), // Home icon on the left
                        ),
                        Expanded(
                          child: DropdownButton(
                            icon: null,
                            value: _pelanggan,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Data Dummy"),
                                value: "Traditional",
                              ),
                              DropdownMenuItem(
                                child: Text("Data Dummy"),
                                value: "Japanese",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _pelanggan = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.card_giftcard_rounded),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5),
                        backgroundColor:
                            MaterialStateProperty.resolveWith(getButtonColor),
                        padding: MaterialStateProperty.all(EdgeInsets.all(13))),
                    onPressed: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text('Dummy'),
                                content: Text('Test'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => [
                                      Navigator.pop(context, 'OK'),
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const Resep()))
                                    ],
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    },
                    // child: const Text('SUBMIT'),
                    label: const Text('Total Hadiah'),
                  ),
                )
              ],
            ),
            Card(
              margin: EdgeInsets.all(5),
              elevation: 20,
              child: Container(
                color: Color.fromARGB(
                    255, 1, 123, 103), // Set the background color to green
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Mandiri Baru",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                color:
                                    Colors.white, // Set the text color to white
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Belum Diberikan",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                color:
                                    Colors.white, // Set the text color to white
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Tengku Iskandari (Blang Bintang Lama)",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                color:
                                    Colors.white, // Set the text color to white
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "+6285277163045",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                                color:
                                    Colors.white, // Set the text color to white
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Card(
                      margin: EdgeInsets.all(10),
                      elevation: 20,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                            child: Container(
                              color: Color.fromARGB(255, 0, 223, 235),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.card_giftcard_rounded,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 100),
                                  Expanded(
                                    child: Text(
                                      "TTOL-00A-2306-90079",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            child: Container(
                              color: Color.fromARGB(255, 0, 223, 235),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.card_giftcard_rounded,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 100),
                                  Expanded(
                                    child: Text(
                                      "TTOL-00A-2306-90079",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            child: Container(
                              color: Color.fromARGB(255, 0, 223, 235),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.card_giftcard_rounded,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 100),
                                  Expanded(
                                    child: Text(
                                      "TTOL-00A-2306-90079",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            child: Container(
                              color: Color.fromARGB(255, 0, 223, 235),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.card_giftcard_rounded,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 100),
                                  Expanded(
                                    child: Text(
                                      "TTOL-00A-2306-90079",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              _temp,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
