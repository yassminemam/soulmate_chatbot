import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_button/swipeable_button.dart';
import '../../../../app_router.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/strings/app_assets.dart';
import '../../../../core/constants/strings/strings.dart';
import '../../../../core/util/tools.dart';
import '../../provider/user/user_provider.dart';
import '../../widget/animated_txt.dart';
import '../../widget/input_widget.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  final _welcomeAnimatedTxt = AnimatedTxt(
    label: 'Welcome',
    color: AppColors.color_333333,
    child: DefaultTextStyle(
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 22.sp,
        backgroundColor: Colors.transparent,
        decorationColor: Colors.transparent,
        fontWeight: FontWeight.bold,
        color: AppColors.color_333333,
      ),
      child: AnimatedTextKit(
        repeatForever: true,
        pause: const Duration(milliseconds: 2500),
        animatedTexts: [
          TyperAnimatedText(AppStrings.welcome),
          TyperAnimatedText(AppStrings.welcomeToYour),
          TyperAnimatedText(AppStrings.soulmateChatBot),
          TyperAnimatedText(AppStrings.nextStartSelectingYour),
          TyperAnimatedText(AppStrings.soulmateChatBot),
          TyperAnimatedText(AppStrings.character),
          TyperAnimatedText(AppStrings.pleaseSwipeToStart),
        ],
      ),
    ),
  );
  final TextEditingController _userNameCon = TextEditingController();
  final TextEditingController _userAgeCon = TextEditingController(text: "");
  final FocusNode _nodeUserAge = FocusNode(skipTraversal: false);

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
                      left: 15,
                      right: 20,
                      bottom: _nodeUserAge.hasFocus ? 100 : 10),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: maxHeightConstr,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 300.h,
                            margin: EdgeInsets.only(top: 80.h),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image:
                                        AssetImage(AppAssets.chatBotImgPath))),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          SizedBox(
                            height: 40.h,
                            child: _welcomeAnimatedTxt.child,
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15.w,
                              ),
                              Text(
                                AppStrings.whatIsYourName,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  backgroundColor: Colors.transparent,
                                  decorationColor: Colors.transparent,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.color_333333,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                  child: SizedBox(
                                height: 30.h,
                                child: InputWidget(
                                  controller: _userNameCon,
                                  maxLines: 1,
                                  hint: "optional",
                                ),
                              )),
                              SizedBox(
                                width: 15.w,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 15.w,
                              ),
                              Text(
                                AppStrings.whatIsYourAge,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  backgroundColor: Colors.transparent,
                                  decorationColor: Colors.transparent,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.color_333333,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 50.h,
                                  child: KeyboardActions(
                                    config: Tools.buildConfig(
                                        context, _nodeUserAge),
                                    disableScroll: true,
                                    child: InputWidget(
                                      controller: _userAgeCon,
                                      height: 50.h,
                                      contentPadding: EdgeInsets.zero,
                                      inputType: TextInputType.number,
                                      focusNode: _nodeUserAge,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      hint: "optional",
                                      onChanged: (t) {
                                        _userAgeCon.text = t;
                                      },
                                      onDone: (t) {
                                        _userAgeCon.text = t;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 35.h,
                          ),
                          Expanded(
                              child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 30.h),
                              child: SwipeableButton.simple(
                                label: Center(
                                  child: Text(
                                    AppStrings.start,
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: AppColors.color_333333,
                                      fontSize: 16.0.sp,
                                    ),
                                  ),
                                ),
                                height: 50.0.h,
                                oneTime: false,
                                color: AppColors.color_C3C5C8,
                                thumbColor: AppColors.appMainColor,
                                thumbIconColor: Colors.black,
                                borderRadius: BorderRadius.circular(5.0.r),
                                onSwipe: () {
                                  Provider.of<UserChangeNotifier>(context,
                                          listen: false)
                                      .setUserName(name: _userNameCon.text);
                                  Provider.of<UserChangeNotifier>(context,
                                          listen: false)
                                      .setUserAge(age: _userAgeCon.text);
                                  context.push('/$charactersRoute');
                                },
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ));
            })));
  }
}
