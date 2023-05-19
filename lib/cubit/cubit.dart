import 'package:breaking_bad/cubit/states.dart';
import 'package:breaking_bad/network/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/character_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<CharacterModel> modelsList = [];
  bool isSearching = false;
  var searchController = TextEditingController();
  List<CharacterModel> searchingList = [];


  void getCharactersData() {
    emit(AppGetCharactersDataLoadingState());
    DioHelper.getData(url: 'characters').then((value) {
      var data = value.data;
      data.forEach((characterItem) {
        CharacterModel character = CharacterModel.fromJson(characterItem);
        modelsList.add(character);
      });
      // print(value.data);
      // model=value.data.map((e)=>CharacterModel.fromJson(e)).toList();
      print('................................');
      print(modelsList[0].name);
      emit(AppGetCharactersDataSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(AppGetCharactersDataErrorState(onError));
    });
  }


  void searchForCharacters(String character) {
    searchingList = modelsList
        .where((element) => element.name.toLowerCase().startsWith(character))
        .toList();
    emit(AppSearchingState());
  }

  Widget defaultIcon = const Icon(
    Icons.search_rounded,
    size: 30,
  );

  Widget defaultTitleAppBar = const Text(
    'Breaking Bad',
    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
  );

  double titleSpacing = 22;

  void search() {
    if(searchController.text!=''){
      searchController.text='';
    }else{
    isSearching = !isSearching;
    if (isSearching) {
      defaultIcon = const Icon(
        Icons.close,
        size: 30,
      );
      defaultTitleAppBar = TextFormField(
        keyboardType: TextInputType.name,
        style: const TextStyle(
          fontSize: 20,color: Colors.white
        ),
        controller: searchController,
        cursorColor: Colors.white,
        cursorHeight: 20,
        onChanged: (character) {
          searchForCharacters(character);
          //print(searchingList);
        },
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'search',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 20)),
      );
      titleSpacing = 40;

      emit(AppSearchingState());
    } else {
      defaultIcon = const Icon(
        Icons.search_rounded,
        size: 30,
      );
      defaultTitleAppBar = const Text(
        'Breaking Bad',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      );
      titleSpacing = 22;
      searchingList = [];
      emit(AppSearchingState());
    }}

}}
