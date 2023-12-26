import 'package:flutter/material.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:hip_quest/util/Dimensions.dart';

class ResultScreen extends StatelessWidget {
  final dynamic resultData;

  ResultScreen({required this.resultData});

  @override
  Widget build(BuildContext context) {
    // Extract data from the resultData JSON
    final Map<String, dynamic> data = resultData['data'];
    final int correctAns = data['correct_ans'];
    final int yourPoints = data['your_points'];
    final int yourTotalPoints = data['your_total_points'];
    final List<dynamic> reviewAnswers = data['review_answers'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Results",
          style: sansSemiBold.copyWith(
            color: ColorResources.colorPrimary,
            fontSize: Dimensions.fontSizeMedium,
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.cancel,
              color: ColorResources.colorPrimary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: ColorResources.colorPrimary,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildScoreItem('Correct Answers', correctAns),
                    _buildDivider(),
                    _buildScoreItem('Your Points', yourPoints),
                    _buildDivider(),
                    _buildScoreItem('Your Total Points', yourTotalPoints),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Answers:',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: reviewAnswers.length,
                itemBuilder: (context, index) {
                  final question = reviewAnswers[index]['question'];
                  final options = reviewAnswers[index]['options'];
                  final correctAnswer = reviewAnswers[index]['answer']['text'];
                  final isCorrect =
                      reviewAnswers[index]['answer']['correct'] == 'yes';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0),
                      Text(
                        'Question ${index + 1} : $question',
                        style: sansSemiBold.copyWith(
                          color: ColorResources.colorPrimary,
                          fontSize: Dimensions.fontSizeDefault,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: (options as List<dynamic>).map((option) {
                          final isSelected = option == correctAnswer;
                          final color = isSelected
                              ? isCorrect
                                  ? Colors.green
                                  : Colors.red
                              : Colors.black;

                          return ListTile(
                            title: Text(
                              option,
                              style: TextStyle(
                                color: color,
                                fontWeight: isSelected ? FontWeight.bold : null,
                              ),
                            ),
                            leading: Radio<String>(
                              activeColor: isSelected
                                  ? isCorrect
                                      ? Colors.green
                                      : Colors.red
                                  : Colors.black,
                              value: option.toString(),
                              groupValue: correctAnswer.toString(),
                              onChanged: (String? value) {},
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreItem(String label, int value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Text(
          value.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(
        color: Colors.white,
        thickness: 2.0,
      ),
    );
  }
}
