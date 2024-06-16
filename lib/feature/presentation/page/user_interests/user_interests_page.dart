import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import '../../../../app_router.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/strings/strings.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import '../../../../core/util/tools.dart';
import '../../provider/user/user_provider.dart';
import '../../widget/button_primary_widget.dart';
import '../../widget/input_widget.dart';

class UserInterestsPage extends StatefulWidget {
  const UserInterestsPage({Key? key}) : super(key: key);

  @override
  State<UserInterestsPage> createState() => _UserInterestsPageState();
}

class _UserInterestsPageState extends State<UserInterestsPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _botNameCon = TextEditingController();
  final TextEditingController _botAgeCon = TextEditingController();
  final FocusNode _nodeBotAge = FocusNode();
  final bool _symmetry = false;
  final bool _startDirection = false;
  final bool _horizontalScroll = false;
  final int _column = 4;
  final double _fontSize = 14;
  late List _tagsItems;
  List<String> selectedInterests = [];
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  @override
  void initState() {
    _tagsItems = AppStrings.interestsList.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double maxHeightConstr = constraints.maxHeight;
            return Padding(
              padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 40,
                  bottom: _nodeBotAge.hasFocus ? 120 : 0),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: maxHeightConstr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: maxHeightConstr < 300 ? 10.h : 30.h,
                      ),
                      Text(
                        AppStrings.tellMeMoreAboutYou,
                        style: TextStyle(
                          fontSize: 18.sp,
                          backgroundColor: Colors.transparent,
                          decorationColor: Colors.transparent,
                          fontWeight: FontWeight.bold,
                          color: AppColors.color_333333,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        AppStrings.whatAreYourInterests,
                        style: TextStyle(
                          fontSize: 16.sp,
                          backgroundColor: Colors.transparent,
                          decorationColor: Colors.transparent,
                          fontWeight: FontWeight.bold,
                          color: AppColors.color_333333,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      tagsListWgt,
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        AppStrings.nowGuessMyNameAndAge,
                        style: TextStyle(
                          fontSize: 18.sp,
                          backgroundColor: Colors.transparent,
                          decorationColor: Colors.transparent,
                          fontWeight: FontWeight.bold,
                          color: AppColors.color_333333,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        AppStrings.mySoulmateChatBotNameIs,
                        style: TextStyle(
                          fontSize: 16.sp,
                          backgroundColor: Colors.transparent,
                          decorationColor: Colors.transparent,
                          fontWeight: FontWeight.bold,
                          color: AppColors.color_333333,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: 150.w,
                        height: 50.h,
                        child: InputWidget(
                          controller: _botNameCon,
                          inputType: TextInputType.text,
                          maxLines: 1,
                          hint: "required *",
                          onDone: (s) {},
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        AppStrings.mySoulmateChatBotAgeIs,
                        style: TextStyle(
                          fontSize: 16.sp,
                          backgroundColor: Colors.transparent,
                          decorationColor: Colors.transparent,
                          fontWeight: FontWeight.bold,
                          color: AppColors.color_333333,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      SizedBox(
                          width: 150.w,
                          height: 50.h,
                          child: KeyboardActions(
                            config: Tools.buildConfig(context, _nodeBotAge),
                            disableScroll: true,
                            child: InputWidget(
                              controller: _botAgeCon,
                              inputType: TextInputType.number,
                              focusNode: _nodeBotAge,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              maxLines: 1,
                              hint: "required *",
                              onChanged: (t) {
                                _botAgeCon.text = t;
                              },
                              onDone: (t) {
                                _botAgeCon.text = t;
                              },
                            ),
                          )),
                      Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ButtonPrimaryWidget(
                              AppStrings.letsChat,
                              onTap: () {
                                if (selectedInterests.isEmpty ||
                                    _botNameCon.text.isEmpty ||
                                    _botAgeCon.text.isEmpty) {
                                  Tools.showHintMsg(
                                      AppStrings.pleaseAnswerAllTheQuestions);
                                } else {
                                  Provider.of<UserChangeNotifier>(context,
                                          listen: false)
                                      .setUserInterests(
                                          interests: selectedInterests);
                                  Provider.of<UserChangeNotifier>(context,
                                          listen: false)
                                      .setBotName(botName: _botNameCon.text);
                                  Provider.of<UserChangeNotifier>(context,
                                          listen: false)
                                      .setBotAge(botAge: _botAgeCon.text);
                                  context.push('/$chatRoute');
                                }
                              },
                            )),
                      ),
                      SizedBox(
                        height: 80.h,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget get tagsListWgt {
    ItemTagsCombine combine = ItemTagsCombine.onlyText;
    return Tags(
      key: _tagStateKey,
      symmetry: _symmetry,
      columns: _column,
      horizontalScroll: _horizontalScroll,
      verticalDirection:
          _startDirection ? VerticalDirection.up : VerticalDirection.down,
      textDirection: _startDirection ? TextDirection.rtl : TextDirection.ltr,
      heightHorizontalScroll: 60 * (_fontSize / 14),
      itemCount: _tagsItems.length,
      itemBuilder: (index) {
        final item = _tagsItems[index];
        return GestureDetector(
          child: ItemTags(
            key: Key(index.toString()),
            index: index,
            title: item,
            activeColor: AppColors.appMainColor,
            color: AppColors.color_1DBF73,
            combine: combine,
            textScaleFactor:
                utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
            textStyle: TextStyle(
              fontSize: _fontSize,
            ),
            onPressed: (item) => selectedInterests.add(item.title!),
          ),
        );
      },
    );
  }
}
