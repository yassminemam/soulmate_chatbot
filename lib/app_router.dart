import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'feature/presentation/page/characters/characters_page.dart';
import 'feature/presentation/page/chat/chat_page.dart';
import 'feature/presentation/page/user_interests/user_interests_page.dart';
import 'feature/presentation/page/welcome/welcome_page.dart';

const String welcomeRoute = 'welcome';
const String charactersRoute = "characters";
const String interestsRoute = "interests";
const String chatRoute = "chat";
List<RouteBase> allRouts = <RouteBase>[
  GoRoute(
    path: "/",
    builder: (c, s) => const WelcomePage(),
    routes: <RouteBase>[
      GoRoute(
        path: welcomeRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomePage();
        },
      ),
      GoRoute(
        path: charactersRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const CharactersPage();
        },
      ),
      GoRoute(
        path: interestsRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const UserInterestsPage();
        },
      ),
      GoRoute(
        path: chatRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const ChatPage();
        },
      ),
    ],
  ),
];
