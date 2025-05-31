import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: MainScreen(),
));

//Wa Ode Amerta Lambelu Jamaluddin

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int counter = 0;
  int setcount = 0;
  void _incrementCounter() {
    setState(() {
      counter += 1;
      if (counter > 33) {
        setcount += 1;
        counter = 1;
      }
    });
  }

  void restartCounter() {
    setState(() {
      counter = 0;
      setcount = 0;
    });
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff004a87),
        elevation: 20,
        title:
        Text('Z I K R C O U N T E R', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff004a87),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(20),
              child: Text(
                '$counter',
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Text(
                'Set: $setcount',
                style: TextStyle(fontSize: 16, color: Colors.blueGrey)
            ),
            ElevatedButton(
              onPressed: _incrementCounter,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              child:
              Text('Tap', style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: restartCounter,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blueGrey,
              ),
              child:
              Text('Restart', style: TextStyle(color: Colors.blueGrey)),
            )
          ],
        ),
      ),
    );
  }
}
