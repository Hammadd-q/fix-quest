import 'package:flutter/material.dart';
import 'package:hip_quest/Screens/Screens.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/Utils.dart';

class Course extends StatelessWidget {
  const Course({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CoursesViewScreen.routeKey);
      },
      child: Container(
        alignment: Alignment.center, // This is needed
        padding: const EdgeInsets.all(5),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius:  const BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
                child: Image.asset(
                  ImagesResources.book,
                  fit: BoxFit.fill,
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const ListTile(
                title: Text("widget.tit"),
                subtitle: Text("widget.subtitle"),
              ),


            ],
          ),
        ),


      ),

    );
  }
}
