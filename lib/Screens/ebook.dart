// screens/book_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hip_quest/Screens/loading.dart';
import 'package:hip_quest/data/data.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:hip_quest/util/Dimensions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// screens/pdf_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class Book {
  final int id;
  final String title;
  final String bookImage;
  final String pdf;

  Book({
    required this.id,
    required this.title,
    required this.bookImage,
    required this.pdf,
  });
}

class BookListScreen extends StatefulWidget {
  static String routeKey = '/myebooks';
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<Book> books = [];
  bool showloading = false;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    print(userid);
    setState(() {
      showloading = true;
    });
    final response = await http.get(
      Uri.parse('${AppConstants.baseUrl}ebooks?user_id=$userid'),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        showloading = false;
      });
      final data = json.decode(response.body);
      final bookData = data['data'];
      books = List<Book>.from(bookData.map((book) => Book(
            id: book['id'],
            title: book['title'],
            bookImage: book['book_image'],
            pdf: book['pdf'],
          )));
      setState(() {});
    } else {
      setState(() {
        showloading = false;
      });
      showToast(
        "Failed to load ebooks",
        context: context,
        position: StyledToastPosition.top,
        textStyle: sansMedium.copyWith(
          color: ColorResources.white,
        ),
        backgroundColor: ColorResources.errorStatus,
        fullWidth: true,
        animDuration: const Duration(milliseconds: 500),
        duration: const Duration(seconds: 3),
        animationBuilder: (
          BuildContext context,
          AnimationController controller,
          Duration duration,
          Widget child,
        ) {
          return SlideTransition(
            position: getAnimation<Offset>(
              const Offset(3.0, 0.0),
              const Offset(0, 0),
              controller,
              curve: Curves.bounceIn,
            ),
            child: child,
          );
        },
        reverseAnimBuilder: (
          BuildContext context,
          AnimationController controller,
          Duration duration,
          Widget child,
        ) {
          return SlideTransition(
            position: getAnimation<Offset>(
              const Offset(0.0, 0.0),
              const Offset(-3.0, 0),
              controller,
              curve: Curves.bounceOut,
            ),
            child: child,
          );
        },
      );
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (showloading == true)
        ? loading()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      style: sansSemiBold.copyWith(
                        color: ColorResources.colorPrimary,
                        fontSize: Dimensions.fontSizeOverLarge,
                      ),
                      text: "EBooks",
                    ),
                    TextSpan(
                      style: sansLight.copyWith(
                        color: ColorResources.colorPrimary,
                        fontSize: Dimensions.fontSizeOverLarge,
                        fontWeight: FontWeight.w300,
                      ),
                      text: " ",
                    )
                  ],
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
            ),
            body: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Column(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30.0, horizontal: 12),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PdfScreen(
                                      pdfUrl: book.pdf,
                                      titile: book.title,
                                    ),
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    color: ColorResources.white,
                                    height:
                                        MediaQuery.of(context).size.height / 4,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.network(
                                      book.bookImage,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.grey.withOpacity(0.6),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Text(book.title,
                                                style: sansSemiBold.copyWith(
                                                  color:
                                                      ColorResources.darkGrey,
                                                  fontSize:
                                                      Dimensions.fontSizeLarge,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                    Divider(
                      color: Colors.black,
                      height: 10,
                    )
                  ],
                );
              },
            ),
          );
  }
}

class PdfScreen extends StatefulWidget {
  final String pdfUrl;
  final String titile;
  const PdfScreen({Key? key, required this.pdfUrl, required this.titile})
      : super(key: key);

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.titile,
          style: sansRegular.copyWith(
            color: ColorResources.colorPrimary,
            fontSize: Dimensions.fontSizeDefault,
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
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: ColorResources.colorPrimary,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 12, 12, 12),
              child: PDF().cachedFromUrl(
                widget.pdfUrl,
                placeholder: (progress) => Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                            color: ColorResources.colorPrimary),
                        SizedBox(
                          height: 50,
                        ),
                        Center(child: Text('Downloading $progress %')),
                      ],
                    )),
                errorWidget: (error) => Center(child: Text(error.toString())),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
