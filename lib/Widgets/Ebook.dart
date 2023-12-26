import 'package:flutter/material.dart';
import 'package:hip_quest/Screens/Screens.dart';
import 'package:hip_quest/data/model/response/EbookModel.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/Utils.dart';

class Ebook extends StatelessWidget {
  final EbookModel ebook;

  const Ebook({Key? key, required this.ebook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EbookViewScreen(ebook: ebook),
            ));
      },
      child: Container(
        alignment: Alignment.center, // This is needed
        padding: const EdgeInsets.all(10),

        child:
        Card(
          elevation: 15,
          color: ColorResources.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: ColorResources.white, width: 5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ebook.image == ''
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    ImagesResources.noImageUrl,
                    fit: BoxFit.fill,
                    width: 220,
                    height: 250,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    ebook.image,
                    fit: BoxFit.fill,
                    width: 300,
                    height: 300,
                  ),
                ),
        ),
      ),
    );
  }
}
