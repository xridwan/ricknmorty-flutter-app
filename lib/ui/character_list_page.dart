import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ricknmorty/data/api/api_service.dart';
import 'package:ricknmorty/data/result_state.dart';
import 'package:ricknmorty/provider/character_provider.dart';
import 'package:ricknmorty/widgets/card_character.dart';

class CharacterListPage extends StatelessWidget {
  static const routeName = '/main_page';

  const CharacterListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CharacterProvider>(
      create: (context) =>
          CharacterProvider(apiService: ApiService()).getCharacterList(),
      child: Scaffold(
        body: SafeArea(
          child: _buildList(),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<CharacterProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            shrinkWrap: true,
            itemCount: state.result.characters.length,
            itemBuilder: (context, index) {
              var characters = state.result.characters[index];
              return CardCharacter(character: characters);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(child: Material(child: Text(state.message)));
        } else {
          return const Center(child: Material(child: Text('')));
        }
      },
    );
  }
}
