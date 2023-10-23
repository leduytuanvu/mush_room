import 'package:flutter/material.dart';

class MushRoomComboBoxWidget extends StatefulWidget {
  final List<String> listItem;
  final Function(String) onChanged;
  const MushRoomComboBoxWidget({required this.listItem, required this.onChanged, super.key});

  @override
  State<MushRoomComboBoxWidget> createState() => _MushRoomComboBoxWidgetState();
}

class _MushRoomComboBoxWidgetState extends State<MushRoomComboBoxWidget> {
  @override
  Widget build(BuildContext context) {
    String selectedItem = "Manual";
    return DropdownButtonFormField<String>(
      value: selectedItem,
      onChanged: (String? newValue) {
        setState(() {
          selectedItem = newValue!;
          widget.onChanged(selectedItem);
        });
      },
      items: widget.listItem.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}
