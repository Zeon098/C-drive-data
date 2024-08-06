import 'package:coffee_masters/datamanager.dart';
import 'package:coffee_masters/pages/menupage.dart';
import 'package:coffee_masters/pages/offerspage.dart';
import 'package:coffee_masters/pages/orderpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Greet extends StatefulWidget {
  const Greet({super.key});

  @override
  State<Greet> createState() => _GreetState();
}

class _GreetState extends State<Greet> {
  var name = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hello $name'),
        TextField(
            onChanged: (value) => setState(() {
                  name = value;
                }))
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Masters',
      theme: ThemeData(colorSchemeSeed: Colors.brown),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var dataManager= DataManager();
  var seletedIndex =0;
  @override
  Widget build(BuildContext context) {
    late Widget currentPage;
    switch(seletedIndex){
      case 0: 
        currentPage =  MenuPage(dataManager: dataManager,);

        break;
      case 1:
        currentPage= const OffersPage();
        break;
      case 2: 
      currentPage= OrderPage(dataManager: dataManager,);

    }

    return Scaffold(
      appBar: AppBar(
        title: Image.asset("images/logo.png"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:  seletedIndex,
        onTap: (newIndex) {
          setState(() {
            seletedIndex=newIndex;
          });
          
        },
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Color.fromARGB(255, 199, 172, 90),
        unselectedItemColor: const Color.fromARGB(255, 219, 209, 209),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.coffee), label: "Menu"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer), label: "Offer"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_checkout_outlined),
              label: "Orders"),
        ],
      ),
      body: currentPage
    );
  }
}
