abstract class AppStates{}

class AppInitialState extends AppStates{}

class AppGetCharactersDataLoadingState extends AppStates{}

class AppGetCharactersDataSuccessState extends AppStates{}

class AppGetCharactersDataErrorState extends AppStates{
  final String error;

  AppGetCharactersDataErrorState(this.error);

}

class AppSearchingState extends AppStates{}
