import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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
int cartQty = 0;

// _getCart<String>() async {
//   var documentSnapshot = await FirebaseFirestore.instance.collection('data').doc('cart').get();
//   if (documentSnapshot.exists) {
//     print("Phaonch gya");
//     var data = documentSnapshot.data()!['qty'];
//     setState(() {
//       cartQty = int.parse(data);
//     });
//     return data.toString();
//   }
//   return "0";
// }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
   // _getCart();
  }
@override
void dispose() {
  // Clean up the controller when the widget is disposed.
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton:  Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('cart').snapshots(),
          builder: (context, snapshot) {
            cartQty = int.parse(snapshot.data!.docs[0].data()['qty'].toString());

            if (!snapshot.hasData) return const SizedBox.shrink();
            return Text('Cart Qty: ${snapshot.data!.docs[0].data()['qty'].toString()}');
          },
        ),
      ),
      body:
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('data').snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) return const SizedBox.shrink();
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 500,
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final docData = snapshot.data!.docs[index].data();
                      final data = docData['item'];

                      return ListTile(
                        title: Text(snapshot.data!.docs[index].data()["item"].toString()),
                        trailing: IconButton(
                          onPressed: () {

                              FirebaseFirestore.instance.collection('cart').doc('qlVXt1DAMcKsxtbzVIkK').set(
                                  {
                                    "qty": "${cartQty + 1}",
                                  });

                          },

                          icon: Icon(Icons.add_shopping_cart_outlined),
                        ),
                      );
                    },),
                ),

              ],
            ),
          );
        },
      ),

    );
  }



}



/*class GlassCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(60, 32, 189, 0.91),
              Color.fromRGBO(60, 38, 223, 0.71)
            ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned(
                    top: constraints.maxHeight * 0.3,
                    left: constraints.maxWidth * 0.00,
                    child: Container(
                      height: constraints.maxHeight * 0.15,
                      width: constraints.maxWidth * 0.35,
                      decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Color.fromRGBO(52, 64, 245, 1),
                              Color.fromRGBO(44, 130, 177, 1)
                            ],
                            radius: 0.7,
                          ),
                          //color: Colors.red,
                          shape: BoxShape.circle),
                    )),
                Positioned(
                    top: constraints.maxHeight * 0.55,
                    right: constraints.maxWidth * 0.00,
                    child: Container(
                      height: constraints.maxHeight * 0.15,
                      width: constraints.maxWidth * 0.35,
                      decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Colors.red,
                              Colors.pink.withOpacity(0.5)
                            ],
                            radius: 0.7,
                          ),
                          // color: Colors.red,
                          shape: BoxShape.circle),
                    )),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(
                        height: constraints.maxHeight * 0.3,
                        width: constraints.maxWidth * 0.85,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.2),
                                  Colors.white.withOpacity(0.05)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.08)),
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 10,
                              right: 17,
                              child: Container(
                                height: constraints.maxHeight * 0.3 * 0.15,
                                width: constraints.maxWidth * 0.85 * 0.15,
                                child: Image.asset('assets/images/visa.png'),
                              ),
                            ),
                            Positioned(
                              top: constraints.maxHeight * 0.3 * 0.45,
                              left: 20,
                              child: Container(
                                height: constraints.maxHeight * 0.3 * 0.15,
                                width: constraints.maxWidth * 0.85 * 0.15,
                                child:
                                Image.asset('assets/images/smartChip.png'),
                              ),
                            ),
                            Positioned(
                              top: constraints.maxHeight * 0.3 * 0.62,
                              left: 20,
                              child: Container(
                                height: constraints.maxHeight * 0.3 * 0.13,
                                width: constraints.maxWidth * 0.85 * 0.7,
                                //color: Colors.red,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "1234  5678  9012  3456",
                                    style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: constraints.maxHeight * 0.3 * 0.82,
                              left: 20,
                              child: Container(
                                height: constraints.maxHeight * 0.3 * 0.07,
                                width: constraints.maxWidth * 0.85 * 0.4,
                                //color: Colors.red,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "AMAN TIWARI",
                                    style:  TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 1,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: constraints.maxHeight * 0.3 * 0.82,
                              left: constraints.maxWidth * 0.85 * 0.65,
                              child: Container(
                                height: constraints.maxHeight * 0.3 * 0.07,
                                width: constraints.maxWidth * 0.85 * 0.12,
                                //color: Colors.red,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "06/20",
                                    style:  TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 1,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: constraints.maxHeight * 0.3 * 0.82,
                              left: constraints.maxWidth * 0.85 * 0.8,
                              child: Container(
                                height: constraints.maxHeight * 0.3 * 0.07,
                                width: constraints.maxWidth * 0.85 * 0.12,
                                //color: Colors.red,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "08/26",
                                    style:  TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 1,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}*/

