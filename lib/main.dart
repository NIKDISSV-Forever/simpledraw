import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_painting_tools/flutter_painting_tools.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PaintingBoardController controller;

  @override
  void initState() {
    controller = PaintingBoardController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paint (N.D.)'),
        actions: [
          IconButton(
            onPressed: () => controller.deleteLastLine(),
            icon: const Icon(Icons.undo_rounded),
          ),
          IconButton(
            onPressed: () => controller.deletePainting(),
            icon: const Icon(Icons.delete),
          ),
          CircleAvatar(
              backgroundColor: pickerColor,
              child: IconButton(
                  onPressed: () => colorPickerDialog(),
                  icon: const Icon(Icons.brush))),
        ],
      ),
      
      body: PaintingBoard(
        controller: controller,
      ),
    );
  }

  Color pickerColor = const Color.fromARGB(255, 0, 0, 0);
  Color currentColor = const Color.fromARGB(255, 0, 0, 0);

  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
      controller.changeBrushColor(pickerColor);
    });
  }

  colorPickerDialog() => showDialog(
        builder: (context) => AlertDialog(
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
              enableAlpha: true,
              displayThumbColor: true,
              labelTypes: const <ColorLabelType>[
                ColorLabelType.rgb,
                ColorLabelType.hex,
                ColorLabelType.hsv,
                ColorLabelType.hsl,
              ],
              hexInputBar: true,
            ),
          ),
        ),
        context: context,
      );
}
