import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ricknmorty/data/api/api_service.dart';
import 'package:ricknmorty/data/model/character.dart';
import 'package:ricknmorty/data/result_state.dart';
import 'package:ricknmorty/provider/character_provider.dart';
import 'package:ricknmorty/widgets/custom_network_image.dart';

class CharacterDetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  final int id;

  const CharacterDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CharacterProvider>(
      create: (context) {
        CharacterProvider provider =
            CharacterProvider(apiService: ApiService());
        return provider.getCharacter(id);
      },
      child: Scaffold(
        body: Consumer<CharacterProvider>(
          builder: (context, state, child) {
            if (state.stateDetail == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.stateDetail == ResultState.hasData) {
              return _detail(context, state.character);
            } else if (state.stateDetail == ResultState.noData) {
              return Center(child: Material(child: Text(state.message)));
            } else {
              return const Center(child: Material(child: Text('')));
            }
          },
        ),
      ),
    );
  }

  Widget _detail(BuildContext context, Character character) {
    return SafeArea(
      child: Stack(
        children: [
          ListView(
            children: [
              Stack(
                children: [
                  Container(
                    foregroundDecoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Color(0xff0e0f11),
                        ],
                        begin: Alignment(0, 0.3),
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: CustomNetworkImage(
                      image: character.image ?? '',
                      height: 400,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 15,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned.fill(
            top: 300,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      character.name ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      character.type ?? '',
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 14,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          character.status ?? '',
                          style: const TextStyle(
                            color: Colors.orangeAccent,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // const Icon(
                            //   Icons.star,
                            //   color: Colors.yellowAccent,
                            //   size: 20,
                            // ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              character.type ?? '',
                              style: const TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
