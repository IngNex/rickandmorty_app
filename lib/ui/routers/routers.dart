import 'package:go_router/go_router.dart';
import 'package:rickandmorty/domain/models/character_models.dart';
import 'package:rickandmorty/ui/screens/characters/characters_screen.dart';
import 'package:rickandmorty/ui/screens/detailscharacter/detailscharacter_screen.dart';
import 'package:rickandmorty/ui/screens/episodes/episodes_screen.dart';
import 'package:rickandmorty/ui/screens/home/home.dart';
import 'package:rickandmorty/ui/screens/login/login_screen.dart';
import 'package:rickandmorty/ui/screens/searchcharacter/searchcharacter_screen.dart';
import 'package:rickandmorty/ui/screens/splash/splash_screen.dart';

final GoRouter route = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginScreen();
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
