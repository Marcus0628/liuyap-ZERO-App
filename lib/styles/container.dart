// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:zero/styles/color.dart';

class AddressContainer extends StatelessWidget {
  final String label;
  final IconData icon;
  final String initialValue;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onDelete; // Add onDelete callback

  const AddressContainer({
    required this.label,
    required this.icon,
    required this.initialValue,
    this.onChanged,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(label), // Use label as the key for each address
      onDismissed: (_) {
        if (onDelete != null) onDelete!(); // Call onDelete callback when dismissed
      },
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: lightbrown,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Color.fromARGB(255, 123, 121, 119),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: word,
                  size: 28,
                ),
                SizedBox(width: 10),
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: word,
                    fontFamily: "FjallaOne",
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            TextField(
              onChanged: onChanged,
              controller: TextEditingController(text: initialValue),
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
              style: TextStyle(
                color: Colors.grey,
                fontFamily: "FjallaOne",
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(32, 138, 112, 112),
                border: OutlineInputBorder(),
                hintText: 'Enter your address',
                hintStyle: TextStyle(
                  color: Colors.grey, // Set the color of the hintText
                  fontFamily: "FjallaOne", // Set the font family of the hintText
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}