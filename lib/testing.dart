import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool containerVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resizable Container'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                containerVisible = !containerVisible;
              });
            },
            child: Text('Toggle Container'),
          ),
          if (containerVisible) ResizableContainer(),
        ],
      ),
    );
  }
}

class ResizableContainer extends StatefulWidget {
  @override
  _ResizableContainerState createState() => _ResizableContainerState();
}

class _ResizableContainerState extends State<ResizableContainer> {
  double containerHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          containerHeight += details.primaryDelta!;
        });
      },
      child: Container(
        height: containerHeight,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: Center(
          child: Text(
            'Resizable Container',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
