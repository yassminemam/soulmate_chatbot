import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import '../../../../core/constants/strings/app_assets.dart';
import '../../../../core/constants/strings/strings.dart';
import '../../../../core/util/tools.dart';
import '../../../data/model/character.dart';
import '../../widget/character_item.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  List<Character> characters = [];

  @override
  void initState() {
    characters.add(Character(
        type: CharacterType.KID_GIRL,
        imgPath: AppAssets.kidGirlImgPath,
        introStatements: [
          AppStrings.imKidGirl,
          AppStrings.funAndEnergy,
          AppStrings.orATrueFriend
        ]));
    characters.add(Character(
        type: CharacterType.KID_BOY,
        imgPath: AppAssets.kidBoyImgPath,
        introStatements: [
          AppStrings.imKidBoy,
          AppStrings.funAndEnergy,
          AppStrings.orATrueFriend
        ]));

    characters.add(Character(
        type: CharacterType.YOUNG_LADY,
        imgPath: AppAssets.youngLadyImgPath,
        introStatements: [
          AppStrings.imYoungLady,
          AppStrings.charmAndFeelings,
          AppStrings.orATrueFriend
        ]));
    characters.add(Character(
        type: CharacterType.YOUNG_MAN,
        imgPath: AppAssets.youngManImgPath,
        introStatements: [
          AppStrings.imYoungMan,
          AppStrings.powerAndCompany,
          AppStrings.orATrueFriend
        ]));

    characters.add(Character(
        type: CharacterType.OLD_LADY,
        imgPath: AppAssets.oldLadyImgPath,
        introStatements: [
          AppStrings.imOldLady,
          AppStrings.warmthAndAffection,
          AppStrings.orATrueFriend
        ]));
    characters.add(Character(
        type: CharacterType.OLD_MAN,
        imgPath: AppAssets.oldManImgPath,
        introStatements: [
          AppStrings.imOldMan,
          AppStrings.wisdomAdvice,
          AppStrings.orATrueFriend
        ]));
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Tools.showHintMsg(AppStrings.backHint);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          child: Container(
            color: Colors.white,
            child: Swiper(
              itemBuilder: (context, index) {
                return CharacterItem(character: characters[index]);
              },
              loop: false,
              itemCount: characters.length,
              pagination:
                  const SwiperPagination(builder: SwiperPagination.rect),
              control: const SwiperControl(color: Colors.white),
            ),
          )),
    );
  }
}
