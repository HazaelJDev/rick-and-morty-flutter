import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/blocs/theme_bloc.dart';

class Item extends StatelessWidget {
  dynamic _data;

  static List<Color> alive = [Color(0xFF7AD123), Color(0xFFC1F178)];

  Item(this._data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeBloc>(context);
    return Card(
      child: ListTile(
        onTap: () => openDetail(context, _data),
        leading: Image.network(_data['image'], width: 56),
        title: Text(_data["name"]),
        subtitle: Row(
          children: [
            Text(_data["status"],
                style: TextStyle(
                    color: _data["status"] == "Alive"
                        ? alive[theme.getIsDark() ? 0 : 1]
                        : Theme.of(context).colorScheme.error)),
            const Text(" - "),
            Text(_data["species"]),
          ],
        ),
        trailing: Icon(Icons.arrow_right,
            color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}

openDetail(context, _data) {
  
  Widget makeDismissible({required Widget child}) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.of(context).pop(),
    child: GestureDetector(onTap: () {}, child: child),
  );

  final theme = Provider.of<ThemeBloc>(context, listen: false);
  return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return makeDismissible(
          child: DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            builder: (_, scrollController) => Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              child: ListView(
                controller: scrollController,
                children: <Widget>[
                  Image.network(_data['image'], width: 280),
                  Text(_data["name"],
                      style: Theme.of(context).textTheme.titleLarge),
                  Text(_data["status"],
                      style: TextStyle(
                          color: _data["status"] == "Alive"
                              ? Item.alive[theme.getIsDark() ? 0 : 1]
                              : Theme.of(context).colorScheme.error)),
                  Row(
                    children: [
                      LabelLarge(
                          "Species: ", Theme.of(context).colorScheme.primary),
                      LabelLarge(_data["species"],
                          Theme.of(context).colorScheme.onSurface),
                    ],
                  ),
                  Row(
                    children: [
                      LabelLarge("Type: ", Theme.of(context).colorScheme.primary),
                      LabelLarge(
                          _data["type"], Theme.of(context).colorScheme.onSurface),
                    ],
                  ),
                  Row(
                    children: [
                      LabelLarge(
                          "Gender: ", Theme.of(context).colorScheme.primary),
                      LabelLarge(_data["gender"],
                          Theme.of(context).colorScheme.onSurface),
                    ],
                  ),
                  Row(
                    children: [
                      LabelLarge(
                          "Origin: ", Theme.of(context).colorScheme.primary),
                      LabelLarge(_data["origin"]["name"],
                          Theme.of(context).colorScheme.onSurface),
                    ],
                  ),
                  Row(
                    children: [
                      LabelLarge(
                          "Location: ", Theme.of(context).colorScheme.primary),
                      LabelLarge(_data["location"]["name"],
                          Theme.of(context).colorScheme.onSurface),
                    ],
                  ),
                  Column(
                    children: [
                      LabelLarge(
                          "Episodes: ", Theme.of(context).colorScheme.primary),
                      for (var episode in _data["episode"])
                        LabelLarge("Episodio $episode",
                            Theme.of(context).colorScheme.onSurface),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}



class LabelLarge extends StatelessWidget {
  String text;
  Color color;

  LabelLarge(this.text, this.color, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color));
  }
}
