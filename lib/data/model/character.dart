class CharacterList {
  CharacterList({
    required this.characters,
  });

  final List<Character> characters;

  factory CharacterList.fromJson(Map<String, dynamic> json) => CharacterList(
        characters: List<Character>.from((json["results"] as List)
            .map((x) => Character.fromJson(x))
            .where((character) =>
                character.id != null &&
                character.image != null &&
                character.name != null &&
                character.species != null &&
                character.status != null &&
                character.type != null &&
                character.url != null)),
      );
}

class Character {
  Character({
    required this.id,
    required this.image,
    required this.name,
    required this.species,
    required this.status,
    required this.type,
    required this.url,
  });

  int? id;
  String? image;
  String? name;
  String? species;
  String? status;
  String? type;
  String? url;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        image: json['image'],
        name: json['name'],
        species: json['species'],
        status: json['status'],
        type: json['type'],
        url: json['url'],
      );
}
