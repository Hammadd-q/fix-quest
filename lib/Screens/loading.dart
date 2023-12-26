import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:hip_quest/util/Dimensions.dart';

class loading extends StatelessWidget {
  const loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Spacer(),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(80.0, 10, 80, 10),
                  child: Column(
                    children: [
                      const CircularProgressIndicator(
                          color: ColorResources.colorPrimary),
                      const SizedBox(height: 20.0),
                      Text(
                        "Please Wait",
                        style: sansSemiBold.copyWith(
                          color: ColorResources.colorPrimary,
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
