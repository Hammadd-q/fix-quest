import 'package:flutter/foundation.dart';
import '../data/controller/Controllers.dart';
import 'package:hip_quest/data/model/response/BlogModel.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/data/model/response/base/ErrorResponse.dart';

class BlogProvider extends ChangeNotifier {
  final BlogController blogController;

  BlogProvider({required this.blogController});

  List<BlogModel> _blogs = List.empty(growable: true);
  List<BlogModel> _filteredBlogs = List.empty(growable: true);

  List<BlogModel> get blogs => _filteredBlogs;

  BlogModel? _blog;

  BlogModel? get blog => _blog;

  Future<void> getBlogs(context,callback) async {
    try {
      ApiResponse apiResponse = await blogController.blogs(context);
      if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
        var data = apiResponse.response?.data;
        _filteredBlogs = _blogs = [];
        data.forEach((blog) => _blogs.add(BlogModel.fromJson(blog)));
        _filteredBlogs = _blogs;
        notifyListeners();
      } else {
        String? errorMessage;
        if (apiResponse.error is String) {
          errorMessage = apiResponse.error.toString();
        } else {
          ErrorResponse errorResponse = apiResponse.error;
          errorMessage = errorResponse.errors[0];
        }
        print(errorMessage);
        callback(null, false,errorMessage);

      }
    } catch (e) {
      print(e.toString().replaceAll('Exception:', ''));
    }
  }

  search(value) {
    if (value == null) {
      _filteredBlogs = _blogs;
      notifyListeners();
      return;
    }
    _filteredBlogs = [];
    for (var blog in _blogs) {
      if (blog.title.toLowerCase().contains(value.toString().toLowerCase())) {
        _filteredBlogs.add(blog);
      }
    }
    notifyListeners();
  }

  Future<void> getSingleBlog(context, blogId) async {
    try {
      _blog = null;
      notifyListeners();
      ApiResponse apiResponse = await blogController.blog(blogId, context);
      if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
        var data = apiResponse.response?.data;
        _blog = BlogModel.fromJson(data);
        notifyListeners();
      } else {
        String? errorMessage;
        if (apiResponse.error is String) {
          errorMessage = apiResponse.error.toString();
        } else {
          ErrorResponse errorResponse = apiResponse.error;
          errorMessage = errorResponse.errors[0];
        }
        print(errorMessage);
      }
    } catch (e) {
      print(e.toString().replaceAll('Exception:', ''));
    }
  }

  reset() {
    _blogs = List.empty(growable: true);
  }
}
