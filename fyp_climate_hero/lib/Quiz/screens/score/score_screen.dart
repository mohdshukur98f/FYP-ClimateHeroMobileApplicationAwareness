import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fyp_climate_hero/Quiz/constants.dart';
import 'package:fyp_climate_hero/Quiz/controllers/question_controller.dart';

class ScoreScreen extends StatefulWidget {
  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  double screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    QuestionController _qnController = Get.put(QuestionController());

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: screenHeight,
            decoration: BoxDecoration(color: Colors.blue),
          ),
          Column(
            children: [
              SizedBox(height: 60),
              Text(
                "Quiz Result",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/trophy.png'),
                          fit: BoxFit.cover))),
              SizedBox(height: 20),
              Text(
                "Congratulations!",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                "Y O U R  S C O R E",
                style: TextStyle(fontSize: 20, color: Colors.grey[400]),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${_qnController.correctAns * 10}/${_qnController.questions.length * 10}",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(kDefaultPadding * 1), // 15
                    decoration: BoxDecoration(
                      gradient: kPrimaryGradient,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Text(
                      "DONE",
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
