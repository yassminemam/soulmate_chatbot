import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/strings/strings.dart';
import '../../../data/model/user.dart';
import '../../provider/user/user_provider.dart';
import '../../widget/input_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  void initState() {
    User currentUser = Provider.of<UserChangeNotifier>(context, listen: false).user;
    debugPrint(currentUser.name??"non");
    debugPrint(currentUser.age??"non");
    debugPrint(currentUser.selectedBotChar!.type.toString());
    debugPrint(currentUser.selectedBotChar!.name??"non");
    debugPrint(currentUser.selectedBotChar!.age??"non");
    OpenAI.apiKey = "YOUR_API_KEY";
    OpenAI.baseUrl = "https://api.openai.com";
    OpenAI.showLogs = true;
    Stream<OpenAIStreamCompletionModel> completionStream = OpenAI.instance.completion.createStream(
      model: "gpt-3.5-turbo-0125",
      prompt: "what is Github?",
      maxTokens: 100,
      temperature: 0.5,
      topP: 1,
      seed: 42,
      stop: '###',
      n: 2,
    );

    completionStream.listen((event) {
      final firstCompletionChoice = event.choices.first;
      debugPrint(firstCompletionChoice.text);
    });
    super.initState();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Divider(color: AppColors.appMainColor,),
              InputWidget(
                inputType: TextInputType.text,
                onDone: (s) {},
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                hint: AppStrings.chatHint,
                suffixIcon: const Icon(Icons.send, color: AppColors.appMainColor,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
