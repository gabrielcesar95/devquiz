import 'package:dev_quiz/pages/challenge_page/challenge_page.dart';
import 'package:dev_quiz/core/core.dart';
import 'package:dev_quiz/pages/home_page/home_controller.dart';
import 'package:dev_quiz/pages/home_page/home_state.dart';
import 'package:dev_quiz/pages/home_page/widgets/app_bar/app_bar_widget.dart';
import 'package:dev_quiz/pages/home_page/widgets/level_button/level_button_widget.dart';
import 'package:dev_quiz/pages/home_page/widgets/quiz_card/quiz_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();

    controller.getUser();
    controller.getQuizzes();
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Implement level filtering

    if (controller.state == HomeState.success) {
      return Scaffold(
        appBar: AppBarWidget(user: controller.user!),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LevelButtonWidget(label: 'Fácil'),
                  LevelButtonWidget(label: 'Médio'),
                  LevelButtonWidget(label: 'Difícil'),
                  LevelButtonWidget(label: 'Perito'),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  crossAxisCount: 2,
                  children: controller.quizzes!
                      .map((quiz) => QuizCardWidget(
                            title: quiz.title,
                            completed:
                                "${quiz.questionAnswered}/${quiz.questions.length}",
                            percent:
                                quiz.questionAnswered / quiz.questions.length,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => ChallengePage(
                                      questions: quiz.questions,
                                      title: quiz.title,
                                    ),
                                  ));
                            },
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.darkGreen,
            ),
          ),
        ),
      );
    }
  }
}
