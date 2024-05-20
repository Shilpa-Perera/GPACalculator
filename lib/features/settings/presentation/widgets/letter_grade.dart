import 'package:flutter/material.dart';

class LetterGrade {
  final TextEditingController letterController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  bool isValid() {
    return letterController.text.isNotEmpty && valueController.text.isNotEmpty;
  }

  Widget buildRow(BuildContext context, int index, Function(int) onRemove,
      Function(int) onAdd, bool isLast) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: letterController,
              decoration: const InputDecoration(
                labelText: 'Letter Grade',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: valueController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Numerical Value',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          if (isLast)
            IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: () => onAdd(index),
            ),
          IconButton(
            icon: const Icon(Icons.remove_circle),
            onPressed: () => onRemove(index),
          ),
        ],
      ),
    );
  }
}
