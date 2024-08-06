import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
    home: Home(),
  ));

class Home extends StatelessWidget {
  const Home({super.key});

  // const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My First App'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    color: Colors.cyan,
                    padding: const EdgeInsets.all(20.0),
                    child: const Text('One')
                ),
              ),
            ),
            Container(
                color: Colors.redAccent,
                padding: const EdgeInsets.all(30.0),
                child: const Text('Two')
            ),
            Container(
              color: Colors.green,
              padding: const EdgeInsets.all(40.0),
              child: const Text('Three')
              ),

          ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        backgroundColor: Colors.purple[300],
        child: const Text('click'),
      ),
    );
  }
}
