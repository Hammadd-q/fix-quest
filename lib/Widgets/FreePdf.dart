import 'package:flutter/material.dart';
import 'package:hip_quest/Screens/PDFViewerScreen.dart';
import 'package:hip_quest/data/model/response/FreeResourceModel.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:provider/provider.dart';

class FreePdf extends StatefulWidget {
  final FreeResourceModel freeResourceModel;

  const FreePdf({Key? key, required this.freeResourceModel}) : super(key: key);

  @override
  State<FreePdf> createState() => _FreePdfState();
}

class _FreePdfState extends State<FreePdf> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color:  ColorResources.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 28,
                        child: Image.asset(ImagesResources.alisonsignature)),
                    SizedBox(
                        height: 28,
                        child: Image.asset(ImagesResources.pdfcolor))
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                widget.freeResourceModel.title,
                style: sansSemiBold.copyWith(
                  color: ColorResources.black,
                  fontWeight: FontWeight.w400,
                  fontSize: Dimensions.fontSizeSmall,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return PDFViewerScreen(
                        url: widget.freeResourceModel.pdfUrl);
                  }));
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  decoration: const BoxDecoration(
                    color: ColorResources.colorPrimary,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(1.0),
                        bottomRight: Radius.circular(1.0)),
                  ),
                  child: const Text(
                    "Download",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
