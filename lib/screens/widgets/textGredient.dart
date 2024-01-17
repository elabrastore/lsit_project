// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TextGradient extends StatefulWidget {
  final String data;
  final double? size;
  final FontWeight? weight;
  const TextGradient({Key? key, required this.data, this.size, this.weight})
      : super(key: key);

  @override
  State<TextGradient> createState() => _TextGradientState();
}

class _TextGradientState extends State<TextGradient> {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: Text(
        widget.data,
        style: TextStyle(
            fontSize: widget.size,
            color: Colors.white,
            fontWeight: widget.weight),
      ),
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [
            Color.fromARGB(255, 10, 64, 158),
            Color(0xFFFF6D00),
            Color.fromARGB(255, 255, 77, 0),
          ],
          stops: [0.0, 0.5, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(bounds);
      },
    );
  }
}
