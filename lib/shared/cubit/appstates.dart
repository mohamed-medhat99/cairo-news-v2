abstract class AppStates {}

class AppInitialState extends AppStates{}

class AppNavBarState extends AppStates{}

class AppBusinessLoadingState extends AppStates{}

class AppGetBusinessArticlesSuccessState extends AppStates{}

class AppGetBusinessArticlesErrorState extends AppStates{
  final String error;
  AppGetBusinessArticlesErrorState(this.error);
}

class AppSportsLoadingState extends AppStates{}

class AppGetSportsArticlesSuccessState extends AppStates{}

class AppGetSportsArticlesErrorState extends AppStates{
  final String error;
  AppGetSportsArticlesErrorState(this.error);
}

class AppScienceLoadingState extends AppStates{}

class AppGetScienceArticlesSuccessState extends AppStates{}

class AppGetScienceArticlesErrorState extends AppStates{
  final String error;
  AppGetScienceArticlesErrorState(this.error);
}

class AppChangeModeState extends AppStates {}

class AppSearchLoadingState extends AppStates{}

class AppGetSearchArticlesSuccessState extends AppStates{}

class AppGetSearchArticlesErrorState extends AppStates{
  final String error;
  AppGetSearchArticlesErrorState(this.error);
}