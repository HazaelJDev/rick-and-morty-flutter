import 'package:flutter/material.dart';

class InputSearch extends StatelessWidget {
  String _label;

  //Constructor with key
  InputSearch(this._label, {Key? key}) : super(key: key);

  void search(){
    
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: _label,
        suffixIcon: const IconButton(
          icon:  Icon(Icons.search),
          onPressed: null,
          tooltip: "Search button",
        ),
      ),
    );
  }
}
