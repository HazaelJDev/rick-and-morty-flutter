import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/input_search_bloc.dart';
//import '../models/character_model.dart';

class InputSearch extends StatelessWidget {
  String _label;
  
  //Constructor with key
  InputSearch(this._label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final input = Provider.of<InputSearchBloc>(context);
    return TextField(
      onChanged: input.search,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: _label,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        suffixIcon: IconButton(
          icon:  Icon(Icons.search,color: Theme.of(context).colorScheme.primary),
          onPressed: null,
          tooltip: "Search button",
        ),
        errorText: input.messageError != "" ? input.messageError : null,
        errorStyle: TextStyle(color: Theme.of(context).errorColor),
      ),
      
    );
  }
}
