import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../app_router.dart';
import '../../../core/constants/strings/strings.dart';
import '../../data/model/character.dart';
import '../provider/user/user_provider.dart';
import 'animated_txt.dart';
import 'button_primary_widget.dart';

class CharacterItem extends StatelessWidget {
  Character character;

  CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final botIntroAnimatedTxt = AnimatedTxt(
      label: 'BotIntro',
      color: Colors.white,
      child: DefaultTextStyle(
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.sp,
          backgroundColor: Colors.transparent,
          decorationColor: Colors.transparent,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          pause: const Duration(milliseconds: 3000),
          animatedTexts: [
            FadeAnimatedText(AppStrings.hey),
            FadeAnimatedText(character.introStatements?[0] ?? ""),
            FadeAnimatedText(character.introStatements?[1] ?? ""),
            FadeAnimatedText(character.introStatements?[2] ?? ""),
            FadeAnimatedText(AppStrings.letsBeFriends),
          ],
        ),
      ),
    );
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage(character.imgPath!))),
        ),
        Positioned(
            bottom: 220,
            left: 10,
            right: 10,
            child: Center(
              child: botIntroAnimatedTxt.child,
            )),
        Positioned(
            bottom: 40,
            left: 10,
            right: 10,
            child: Center(
              child: ButtonPrimaryWidget(
                AppStrings.beMyFriend,
                onTap: () {
                  Provider.of<UserChangeNotifier>(context, listen: false)
                      .setBotType(botType: character.type);
                  context.push('/$interestsRoute');
                },
              ),
            ))
      ],
    );
  }
}
