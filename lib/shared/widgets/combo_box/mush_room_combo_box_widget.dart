import 'package:flutter/material.dart';

class MushRoomComboBoxWidget extends StatefulWidget {
  final List<String> listItem;
  final Function(String) onChanged;
  const MushRoomComboBoxWidget(
      {required this.listItem, required this.onChanged, super.key});

  @override
  State<MushRoomComboBoxWidget> createState() => _MushRoomComboBoxWidgetState();
}

class _MushRoomComboBoxWidgetState extends State<MushRoomComboBoxWidget> {
  @override
  Widget build(BuildContext context) {
    String selectedItem = "Manual";
    final theme = Theme.of(context);
    return DropdownButtonHideUnderline(
      child: InkWell(
        onTap: () {
          // Handle tap to show the custom dropdown menu
          // You can use a bool flag or a state management solution to show/hide the menu.
        },
        child: Container(
          // width: 200, // Set the desired width for the dropdown menu
          child: Row(
            children: <Widget>[
              Expanded(
                child: DropdownButtonFormField<String>(
                  style: theme.textTheme.titleSmall,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the border radius as needed
                    ),
                  ),
                  value: selectedItem,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedItem = newValue!;
                      widget.onChanged(selectedItem);
                    });
                  },
                  items: widget.listItem
                      .map<DropdownMenuItem<String>>((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),
              ),
              // Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
