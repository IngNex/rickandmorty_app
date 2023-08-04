import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/bloc/charac_episode/charac_episode_bloc.dart';
import 'package:rickandmorty/bloc/characters/characters_bloc.dart';
import 'package:rickandmorty/bloc/episodes/episodes_bloc.dart';
import 'package:rickandmorty/bloc/search_character/search_character_bloc.dart';
import 'package:rickandmorty/domain/models/character_models.dart';
import 'package:rickandmorty/helpers/bloc_observer.dart';
import 'package:rickandmorty/ui/routers/routers.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CharactersBloc()..add(GetCharactersEvent()),
        ),
        BlocProvider(
          create: (context) => EpisodesBloc()..add(GetEpisodesEvent()),
        ),
        BlocProvider(
          create: (context) =>
              SearchCharacterBloc()..add(GetSearchCharacterEvent(query: '')),
        ),
        BlocProvider(
          create: (context) => CharacterEpisodeBloc()
            ..add(GetCharacterEpisodeEvent(character: Character())),
        ),
      ],
      child: MaterialApp.router(
        title: 'App RickAndMorty',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        routerConfig: route,
      ),
    );
  }
}
