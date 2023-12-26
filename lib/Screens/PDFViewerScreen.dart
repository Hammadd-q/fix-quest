import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:provider/provider.dart';
import '../util/Utils.dart';

class PDFViewerScreen extends StatelessWidget {
  final String url;

  const PDFViewerScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor:  ColorResources.colorSecondary,

        body: const PDF().cachedFromUrl(
        url,
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      )
    );
  }
}
