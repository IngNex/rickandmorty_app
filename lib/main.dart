import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty/bloc/charac_episode/charac_episode_bloc.dart';
import 'package:rickandmorty/bloc/characters/characters_bloc.dart';
import 'package:rickandmorty/bloc/episodes/episodes_bloc.dart';
import 'package:rickandmorty/bloc/search_character/search_character_bloc.dart';
import 'package:rickandmorty/domain/models/character_models.dart';
import 'package:rickandmorty/helpers/bloc_observer.dart';
import 'package:rickandmorty/ui/screens/detailscharacter/detailscharacter_screen.dart';
import 'package:rickandmorty/ui/screens/searchcharacter/searchcharacter_screen.dart';
import 'package:rickandmorty/ui/screens/characters/characters_screen.dart';
import 'package:rickandmorty/ui/screens/episodes/episodes_screen.dart';
import 'package:rickandmorty/ui/screens/home/home.dart';
import 'package:rickandmorty/ui/screens/splash/splash_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

final GoRouter _route = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
            path: 'characters',
            builder: (context, state) {
              return const CharactersScreen();
            },
            routes: [
              GoRoute(
                path: 'details',
                builder: (context, state) {
                  final character = state.extra as Character;
                  return DetailsScreen(
                    character: character,
                  );
                },
              )
            ]),
        GoRoute(
          path: 'episodes',
          builder: (context, state) {
            return const EpisodesScreen();
          },
        ),
        GoRoute(
          path: 'search_character',
          builder: (context, state) {
            return const SearchCharacterScreen();
          },
          routes: [
            GoRoute(
              path: 'details',
              builder: (context, state) {
                final character = state.extra as Character;
                return DetailsScreen(
                  character: character,
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

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
        routerConfig: _route,
      ),
    );
  }
}
