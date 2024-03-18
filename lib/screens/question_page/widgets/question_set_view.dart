import 'package:flutter/material.dart';
import 'package:quiz_app/screens/question_page/widgets/question_set.dart';


class QuestionSetView extends StatefulWidget {
  final int index;
  final QuestionSet question;
  final Function(String) onAnswered;
  const QuestionSetView({
    super.key,
    required this.index,
    required this.question,
    required this.onAnswered,
  });

  @override
  State<QuestionSetView> createState() => _QuestionSetViewState();
}

class _QuestionSetViewState extends State<QuestionSetView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Text('${widget.index + 1}.'),
          title: Text(widget.question.question),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: widget.question.options.map<Widget>((e) {
              return ListTile(
                leading: Radio<String>(
                  value: e,
                  groupValue: widget.question.groupValue,
                  onChanged: (value) {
                    setState(() {
                      widget.question.groupValue = value!;
                    });
                    widget.onAnswered(value!);
                  },
                ),
                title: Text(e),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
