import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';

import '../constants/colors/app_colors.dart';

class Tools {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void showErrorMessage(message) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white),),
      backgroundColor: Colors.red,
    ));
  }

  static void showHintMsg(message) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white),),
      duration: const Duration(seconds: 3),
      backgroundColor: AppColors.color_0066FF,
    ));
  }
  static KeyboardActionsConfig buildConfig(BuildContext context, FocusNode nodeNum)  {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: nodeNum,
        ),
      ],
    );
  }
}