import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/character_api_bloc.dart';
import '../blocs/connectivity_bloc.dart';


class OfflineBottomBar extends StatelessWidget {
  const OfflineBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final network = Provider.of<ConnectivityBloc>(context);
    final dataAPI = Provider.of<CharacterApiBloc>(context);
    if(network.status == NetworkStatus.online){
      print("volvimos dude");
      if(dataAPI.characters.isEmpty){
        dataAPI.fetchCharacters();
      }
    }
    return Visibility(
      visible: network.status == NetworkStatus.offline,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 60,
        color: theme.colorScheme.error,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Icon(Icons.wifi_off, color: theme.colorScheme.onError),
          Text('You\'re Offline brow! :(',
              style: theme.textTheme.labelLarge
                  ?.copyWith(color: theme.colorScheme.onError))
        ]),
      ),
    );
  }
}
