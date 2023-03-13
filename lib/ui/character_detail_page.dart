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
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
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
                          Color.fromRGBO(255, 255, 255, 250),
                          Color(0xffffffff),
                        ],
                        begin: Alignment(0, 0.1),
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: CustomNetworkImage(
                      image: character.image ?? 'Unknown',
                      height: 350,
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
                      character.name ?? 'Unknown',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      character.type ?? 'Unknown',
                      style: const TextStyle(
                        color: Colors.black87,
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
                          character.status ?? 'Unknown',
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
                              character.type ?? 'Unknown',
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
