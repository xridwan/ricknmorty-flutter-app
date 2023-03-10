import 'package:flutter/material.dart';
import 'package:ricknmorty/data/model/character.dart';
import 'package:ricknmorty/ui/character_detail_page.dart';

class CardCharacter extends StatelessWidget {
  final Character character;

  const CardCharacter({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(character.image??''),
      ),
      onTap: () => Navigator.pushNamed(
        context,
        CharacterDetailPage.routeName,
        arguments: character.id,
      ),
    );
  }
}
