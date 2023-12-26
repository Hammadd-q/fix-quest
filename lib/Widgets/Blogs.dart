import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:hip_quest/Screens/BlogsViewScreen.dart';
import 'package:hip_quest/Screens/Screens.dart';
import 'package:hip_quest/data/model/response/BlogModel.dart';
import 'package:hip_quest/util/Utils.dart';

class Blogs extends StatelessWidget {
  final BlogModel blog;

  const Blogs({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => BlogsViewScreen(blogId: blog.id)));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * .20,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          image: DecorationImage(
            image: NetworkImage(blog.image),
            fit: BoxFit.cover,
          ),
        ),
        child: BlurryContainer(
          blur: 1,
          height: MediaQuery.of(context).size.height * .20,
          width: double.infinity,
          elevation: 0,
          color: ColorResources.black.withOpacity(0.4),
          padding: const EdgeInsets.all(8),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              blog.title,
              style: sansMedium.copyWith(
                fontSize: Dimensions.fontSizeMedium,
                color: ColorResources.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
