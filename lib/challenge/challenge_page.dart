import 'package:DevQuiz/challenge/challenge_controller.dart';
import 'package:DevQuiz/challenge/widgets/next_button/next_button_widget.dart';
import 'package:DevQuiz/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:DevQuiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:DevQuiz/result/result_page.dart';
import 'package:DevQuiz/shared/models/question_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  final String title;

  ChallengePage({
    Key? key,
    required this.questions,
    required this.title,
  }) : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final ChallengeController controller = ChallengeController();
  final PageController pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });

    super.initState();
  }

  void nextPage() {
    if (controller.currentPage < widget.questions.length) {
      pageController.nextPage(
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    }
  }

  void onSelected(bool value) {
    if (value) {
      controller.qtdAnswerRight++;
    }

    nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(86),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                builder: (context, currentPage, _) => QuestionIndicatorWidget(
                  currentPage: currentPage,
                  length: widget.questions.length,
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: widget.questions
            .map(
              (quiz) => QuizWidget(question: quiz, onSelected: onSelected),
            )
            .toList(),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ValueListenableBuilder<int>(
            valueListenable: controller.currentPageNotifier,
            builder: (context, currentPage, _) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (currentPage < widget.questions.length)
                  Expanded(
                    child: NextButtonWidget.white('Pular', () {
                      nextPage();
                    }),
                  ),
                if (currentPage == widget.questions.length) SizedBox(width: 7),
                Expanded(
                  child: NextButtonWidget.green('Confirmar', () {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ResultPage(
                          title: widget.title,
                          length: widget.questions.length,
                          result: controller.qtdAnswerRight,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
