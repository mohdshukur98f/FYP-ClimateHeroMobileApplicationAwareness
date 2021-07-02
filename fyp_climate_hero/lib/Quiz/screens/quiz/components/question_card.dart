import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fyp_climate_hero/Quiz/controllers/question_controller.dart';
import 'package:fyp_climate_hero/Quiz/models/Questions.dart';

import '../../../constants.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key key,
    // it means we have to pass this
    @required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(question.question,
              style: TextStyle(
                  color: Color(0xFF01579B),
                  fontSize: 25,
                  fontWeight: FontWeight.bold)

              // Theme.of(context)
              //     .textTheme
              //     .headline5
              //     .copyWith(color: Color(0xFF01579B)),
              ),
          SizedBox(height: kDefaultPadding / 2),
          // ignore: sdk_version_ui_as_code
          ...List.generate(
            question.options.length,
            (index) => Option(
              index: index,
              text: question.options[index],
              press: () => _controller.checkAns(question, index),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: InkWell(
              onTap: _controller.nextQuestion,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.all(kDefaultPadding * 0.75), // 15
                decoration: BoxDecoration(
                  gradient: kPrimaryGradient,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Text(
                  "Next",
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
