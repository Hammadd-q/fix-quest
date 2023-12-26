import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hip_quest/Widgets/GlobalAppBar.dart';
import 'package:hip_quest/Widgets/PrimaryButton.dart';
import 'package:hip_quest/data/model/response/EbookModel.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:hip_quest/util/Dimensions.dart';

import '../util/ImagesResources.dart';

class EbookViewScreen extends StatefulWidget {
  static String routeKey = '/ebookview';
  final EbookModel ebook;

  const EbookViewScreen({Key? key, required this.ebook}) : super(key: key);

  @override
  State<EbookViewScreen> createState() => _EbookViewScreenState();
}

class _EbookViewScreenState extends State<EbookViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.colorSecondary,
      appBar: const GlobalAppBar(title: 'eBooks'),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Card(
                elevation: 15,
                color: ColorResources.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: ColorResources.white, width: 5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: widget.ebook.image == ''
                    ?
                ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child:
                    Image.network(
                      ImagesResources.noImageUrl,
                      fit: BoxFit.fill,
                      width: 220,
                      height: 250,
                    ),
                )
                    :
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child:
                  Image.network(
                    widget.ebook.image,
                    fit: BoxFit.fill,
                    width: 220,
                    height: 250,
                  ),
                )

            ),
          ),

          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: SizedBox(
          //     width: 109,
          //     height: 27,
          //     child: Container(
          //       decoration: const BoxDecoration(
          //         color: ColorResources.black,
          //         borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(40),
          //           bottomLeft: Radius.circular(40),
          //         ),
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Text("Expiry",
          //               style: sansRegular.copyWith(
          //                 color: ColorResources.white,
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: Dimensions.fontSizeSmall,
          //               ),
          //               textAlign: TextAlign.right),
          //           Text("6 Jan 2022",
          //               style: sansRegular.copyWith(
          //                 color: ColorResources.white,
          //                 fontWeight: FontWeight.w300,
          //                 fontSize: Dimensions.fontSizeExtraSmall,
          //               ),
          //               textAlign: TextAlign.right),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 25),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: ColorResources.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.ebook.title,
                      style: sansSemiBold.copyWith(
                        color: ColorResources.black,
                        fontSize: Dimensions.fontSizeMaximum * 1.1,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Html(
                      data: widget.ebook.body,
                    ),
                    // Text(
                    //   ,
                    //   style: sansRegular.copyWith(
                    //     color: ColorResources.black,
                    //   ),
                    // ),
                    // const SizedBox(height: 50),
                    // PrimaryButton(
                    //   onPress: () {},
                    //   text: "Read Ebook",
                    //   fontSize: Dimensions.fontSizeLarge,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
