import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/blocs/theme_bloc.dart';
import '../blocs/connectivity_bloc.dart';
//import '../models/character_model.dart';

class Item extends StatelessWidget {
  final dynamic _data;

  static List<Color> alive = [Color(0xFF7AD123), Color(0xFFC1F178)];

  Item(this._data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeBloc>(context);
    final network = Provider.of<ConnectivityBloc>(context);

    return Card(
      child: ListTile(
        onTap: () => openDetail(context, _data),
        leading: network.status == NetworkStatus.offline
            ? const Image(
                image: AssetImage("assets/image/offline.jpg"),
                width: 56,
              )
            : Image.network(_data.image, width: 56),
        title: Text(_data.name),
        subtitle: Row(
          children: [
            Text(_data.status,
                style: TextStyle(
                    color: _data.status == "Alive"
                        ? alive[theme.getIsDark() ? 0 : 1]
                        : Theme.of(context).colorScheme.error)),
            const Text(" - "),
            Expanded(
                child: Text(
              _data.species,
              overflow: TextOverflow.fade,
              softWrap: false,
            )),
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
  final network = Provider.of<ConnectivityBloc>(context, listen: false);
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
                  network.status == NetworkStatus.offline
                      ? const Image(
                          image: AssetImage("assets/image/offline.jpg"),
                          width: 280,
                        )
                      : Image.network(_data.image, width: 280),
                  const SizedBox(height: 16,),
                  Text(_data.name,
                      style: Theme.of(context).textTheme.titleLarge),
                  Text(_data.status,
                      style: TextStyle(
                          color: _data.status == "Alive"
                              ? Item.alive[theme.getIsDark() ? 0 : 1]
                              : Theme.of(context).colorScheme.error)),
                  const SizedBox(height: 12,),
                  Row(
                    children: [
                      LabelLarge(
                          "Species: ", Theme.of(context).colorScheme.primary),
                      LabelLarge(_data.species,
                          Theme.of(context).colorScheme.onSurface),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    children: [
                      LabelLarge(
                          "Type: ", Theme.of(context).colorScheme.primary),
                      LabelLarge(
                          _data.type, Theme.of(context).colorScheme.onSurface),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    children: [
                      LabelLarge(
                          "Gender: ", Theme.of(context).colorScheme.primary),
                      LabelLarge(_data.gender,
                          Theme.of(context).colorScheme.onSurface),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    children: [
                      LabelLarge(
                          "Origin: ", Theme.of(context).colorScheme.primary),
                      LabelLarge(_data.origin.name,
                          Theme.of(context).colorScheme.onSurface),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    children: [
                      LabelLarge(
                          "Location: ", Theme.of(context).colorScheme.primary),
                      LabelLarge(_data.location.name,
                          Theme.of(context).colorScheme.onSurface),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelLarge(
                          "Episodes: ", Theme.of(context).colorScheme.primary),
                      for (var episode in _data.episode)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.movie_filter,
                                color: Theme.of(context).colorScheme.primary),
                            SizedBox(
                              width: 16,
                            ),
                            LabelLarge("Episode ${episode.split("/").last}",
                                Theme.of(context).colorScheme.onSurface),
                          ],
                        ),
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
