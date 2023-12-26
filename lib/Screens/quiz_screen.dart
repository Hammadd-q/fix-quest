import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hip_quest/Screens/result_screen.dart';
import 'package:hip_quest/data/data.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:hip_quest/util/Dimensions.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

class QuizScreen extends StatefulWidget {
  final String image;
  final String quizname;
  final String quizdescription;
  final int id;
  final List<dynamic> quizData;

  QuizScreen(
      {required this.quizData,
      required this.image,
      required this.quizdescription,
      required this.id,
      required this.quizname});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    setState(() {
      selectedAnswers = List.filled(widget.quizData.length, null);
    });
    super.initState();
  }

  int currentIndex = 0;
  List<String?>? selectedAnswers;

  final List<Map<String, String>> answers = [];

  void handleAnswerSelect(String answer) {
    setState(() {
      selectedAnswers![currentIndex] = answer;
    });
  }

  Future<void> submitForm() async {
    print('hit');

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${AppConstants.stagingurl}v1/quizzes/submit_answers/${widget.id}'));
    request.fields['user_id'] = userid;
    for (int i = 0; i < answers.length; i++) {
      request.fields['answers[$i]'] = selectedAnswers![i].toString();
    }
    print(request.fields);
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBytes = await response.stream.toBytes();
      final responseString = utf8.decode(responseBytes);
      final jsonData = json.decode(responseString);
      dev.log('Response: ${jsonData}');
      setState(() {
        havehistory = true;
        resultData = jsonData;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            resultData: resultData,
          ),
        ),
      );
    } else {
      print('Error: ${response.stream.bytesToString()}');
    }
  }

  void goToNextQuestion() {
    if (selectedAnswers![currentIndex] == null) {
      var snackBar = SnackBar(content: Text('Please select an answer!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    if (currentIndex < widget.quizData.length - 1 &&
        selectedAnswers![currentIndex] != null) {
      setState(() {
        currentIndex++;
      });
    }

    if (currentIndex == widget.quizData.length - 1) {
      submitForm();
      answers.clear();

      for (int i = 0; i < widget.quizData.length; i++) {
        answers.add({
          "answer[$i]": selectedAnswers![i] ?? "No answer selected",
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final currentQuestion = widget.quizData[currentIndex];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.quizname,
          style: sansSemiBold.copyWith(
            color: ColorResources.colorPrimary,
            fontSize: Dimensions.fontSizeMedium,
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: ColorResources.colorPrimary,
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () => Navigator.pop(context),
        //     icon: const Icon(
        //       Icons.cancel,
        //       color: ColorResources.colorPrimary,
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.image,
                fit: BoxFit.fill,
                height: height / 3,
                width: width,
              ),
              SizedBox(height: 30.0),
              Text(
                widget.quizdescription,
                style: sansSemiBold.copyWith(
                  color: ColorResources.grey,
                  fontSize: Dimensions.fontSizeMedium,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                  "Question ${(currentIndex + 1).toString()} of ${widget.quizData.length}",
                  style: sansSemiBold.copyWith(
                    color: ColorResources.colorPrimary,
                    fontSize: Dimensions.fontSizeMedium,
                  )),
              SizedBox(height: 30.0),
              Text(currentQuestion['question'],
                  style: TextStyle(fontSize: 18.0)),
              SizedBox(height: 20.0),
              Column(
                children:
                    (currentQuestion['answer'] as List<dynamic>).map((option) {
                  return RadioListTile(
                    title: Text(option.toString()),
                    value: option.toString(),
                    groupValue: selectedAnswers![currentIndex] ?? "",
                    onChanged: (value) => handleAnswerSelect(value.toString()),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              Container(
                width: width,
                child: ElevatedButton(
                  onPressed: goToNextQuestion,
                  style: ElevatedButton.styleFrom(
                    primary: (selectedAnswers![currentIndex] == null)
                        ? ColorResources.grey
                        : Colors.red,
                    onPrimary: (selectedAnswers![currentIndex] == null)
                        ? ColorResources.white
                        : Colors.white,
                  ),
                  child: Text(
                    currentIndex < widget.quizData.length - 1
                        ? 'Next'
                        : 'Submit',
                    style: sansSemiBold.copyWith(
                      color: (selectedAnswers![currentIndex] == null)
                          ? ColorResources.white
                          : Colors.white,
                      fontSize: Dimensions.fontSizeLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
