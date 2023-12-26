import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hip_quest/Provider/BlogProvider.dart';
import 'package:hip_quest/Widgets/GlobalAppBar.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:hip_quest/util/Dimensions.dart';
import 'package:provider/provider.dart';

import '../util/ImagesResources.dart';

class BlogsViewScreen extends StatefulWidget {
  static String routeKey = '/blogsview';
  final int blogId;

  const BlogsViewScreen({Key? key, required this.blogId}) : super(key: key);

  @override
  State<BlogsViewScreen> createState() => _BlogsViewScreenState();
}

class _BlogsViewScreenState extends State<BlogsViewScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BlogProvider>(context, listen: false).getSingleBlog(context, widget.blogId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.colorSecondary,

      appBar: const GlobalAppBar(title: 'Blogs'),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Consumer<BlogProvider>(builder: (_, data, __) {
          if (data.blog == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorResources.colorPrimary,
              ),
            );
          }
          return Column(
            children: [
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
                        Stack(
                          children: [
                            Image.asset(
                              ImagesResources.logo,

                            ),
                            Positioned(
                              right: 1.0,
                              top: 10.0,
                              child: SizedBox(
                                width: 110,
                                height: 28,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: ColorResources.colorPrimary,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      bottomLeft: Radius.circular(40),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(
                                        Icons.calendar_month,
                                        color: ColorResources.white,
                                      ),
                                      Text(
                                        data.blog?.date.split(' ').first ?? '',
                                        style: sansRegular.copyWith(
                                          color: ColorResources.white,
                                          fontSize: Dimensions.fontSizeSmall,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 340,
                          child: Text(
                            data.blog?.title ?? '',
                            style: sansSemiBold.copyWith(
                              color: ColorResources.black,
                              fontSize: Dimensions.fontSizeMaximum * 1.1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Html(
                          data: data.blog?.body ?? '',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
