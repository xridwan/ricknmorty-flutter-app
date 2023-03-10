import 'package:flutter/material.dart';
import 'package:ricknmorty/data/api/api_service.dart';
import 'package:ricknmorty/data/model/character.dart';
import 'package:ricknmorty/data/result_state.dart';

class CharacterProvider extends ChangeNotifier {
  final ApiService apiService;

  CharacterProvider({required this.apiService});

  CharacterProvider getCharacterList() {
    _fetchAllCharacter();
    return this;
  }

  CharacterProvider getCharacter(int id) {
    _fetchCharacter(id);
    return this;
  }

  late CharacterList _characterList;
  late ResultState _state;
  String _message = '';

  CharacterList get result => _characterList;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchAllCharacter() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final character = await ApiService().characterList();
      if (character.characters.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _characterList = character;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  late Character _character;
  late ResultState _stateDetail;
  String _messageDetail = '';

  Character get character => _character;
  ResultState get stateDetail => _stateDetail;
  String get messageDetail => _messageDetail;

  Future<dynamic> _fetchCharacter(int id) async {
    try {
      _stateDetail = ResultState.loading;
      notifyListeners();
      final character = await ApiService().character(id);
      if (character.id == null) {
        _stateDetail = ResultState.noData;
        notifyListeners();
        return _messageDetail = 'Empty Data';
      } else {
        _stateDetail = ResultState.hasData;
        notifyListeners();
        return _character = character;
      }
    } catch (e) {
      _stateDetail = ResultState.error;
      notifyListeners();
      return _messageDetail = 'Error --> $e';
    }
  }
}
