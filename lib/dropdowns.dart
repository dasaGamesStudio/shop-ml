import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {

  final List<String> iDList;
  late String currentID;

   DropDownMenu({
    Key? key,
    required this.iDList,
     required this.currentID,
  }) : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {

  late String dropdownvalue = widget.currentID;

  DropDownTextChange dropDownTextChange = DropDownTextChange("No Text");

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    return DropdownButton(
      focusColor: Colors.red,
      value: dropdownvalue,
      menuMaxHeight: scSize.height * 0.17,
      icon: const Icon(Icons.keyboard_arrow_down),

      items: widget.iDList.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
          widget.currentID = newValue;
        });
      },
    );
  }
}


class DropDownTextChange extends ValueNotifier<String>{
  DropDownTextChange(String text) : super(text);
}
