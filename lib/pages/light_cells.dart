import 'dart:async';

import 'package:flutter/material.dart';

class LightCells extends StatefulWidget {
  const LightCells({super.key});

  @override
  State<LightCells> createState() => _LightCellsState();
}

class _LightCellsState extends State<LightCells> {
  Color color = Colors.red;

  List<Color> gridList = [
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red
  ];

  int changedColorCount = 0;
  Timer? timer;

  void checkOrChangeGridColor(int index) {
    setState(() {
      gridList[index] = Colors.green;
      changedColorCount += 1;

      if (changedColorCount == gridList.length) {
        int currentIndex = gridList.length - 1;

        timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
          setState(() {
            gridList[currentIndex] = Colors.red;
          });

          currentIndex--;

          if (currentIndex < 0) {
            timer.cancel();
            changedColorCount = 0;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Light Cells"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
        itemCount: gridList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (gridList[index] != Colors.green) {
                checkOrChangeGridColor(index);
              }
            },
            child: Container(color: gridList[index]),
          );
        },
      ),
    );
  }
}
