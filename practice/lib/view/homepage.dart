import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

 

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(
       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(widget.title,),
      ),
      
      body:  Container(
          decoration:const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg_high.png'),
              fit: BoxFit.cover,
            ),
          ),
        child :Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Jannah Quiz',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onPrimary, backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login_page');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ), 
    ),
    );
  }
}
