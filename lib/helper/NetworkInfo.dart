import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hip_quest/util/ColorResources.dart';

class NetworkInfo {
  final Connectivity connectivity;

  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  static Future<void> checkConnectivity(BuildContext? context) async {
    bool showing = false;
    bool isNotConnected;
    var connectivityResult = await Connectivity().checkConnectivity();
    if (context != null) {
      bool isNotConnected;
      if (connectivityResult == ConnectivityResult.none) {
        isNotConnected = true;
      } else {
        isNotConnected = !await _updateConnectivityStatus();
      }
      if (isNotConnected && !showing) {
        showing = true;
        showNetworkInfo(context);
      }
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if (context != null) {
        if (result == ConnectivityResult.none) {
          isNotConnected = true;
        } else {
          isNotConnected = !await _updateConnectivityStatus();
        }
        if (isNotConnected && !showing) {
          showing = true;
          showNetworkInfo(context);
        } else if (!isNotConnected && showing) {
          showing = false;
          Navigator.pop(context);
        }
      }
    });
  }

  static Future<bool> _updateConnectivityStatus() async {
    bool isConnected = false;
    try {
      final List<InternetAddress> result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } catch (e) {
      isConnected = false;
    }
    return isConnected;
  }

  static showNetworkInfo(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(color: ColorResources.colorPrimary),
                SizedBox(height: 20.0),
                Text(
                  "Connecting To Internet",
                  style: TextStyle(
                    color: ColorResources.colorPrimary,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
