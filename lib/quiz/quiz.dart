import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/quiz/quiz_state.dart';
import 'package:quizapp/services/firestore.dart';
import 'package:quizapp/services/models.dart';
import 'package:quizapp/shared/loading.dart';
import 'package:quizapp/shared/progress_bar.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key, required this.quizId});
  final String quizId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizState(),
      child: FutureBuilder<Quiz>(
        future: FirestoreService().getQuiz(quizId),
        builder: (context, snapshot) {
          var state = Provider.of<QuizState>(context);

          if (!snapshot.hasData || snapshot.hasError) {
            return const Loader();
          } else {
            var quiz = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                title: AnimatedProgressbar(value: state.progress),
                leading: IconButton(
                    icon: const Icon(FontAwesomeIcons.xmark),
                    onPressed: () => Navigator.pop(context)),
              ),
            );
          }
        },
      ),
    );
  }
}
