// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class Botones extends StatelessWidget {
  final VoidCallback onDescripcion;
  final VoidCallback onStock;
  final VoidCallback onPreguntas;

  const Botones({
    required this.onDescripcion,
    required this.onStock,
    required this.onPreguntas,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onDescripcion,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            "DESCRIPCION",
          ),
        ),
        TextButton(
          onPressed: onStock,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            "STOCK",
          ),
        ),
        TextButton(
          onPressed: onPreguntas,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            "COMENTARIOS",
          ),
        ),
      ],
    );
  }
}
