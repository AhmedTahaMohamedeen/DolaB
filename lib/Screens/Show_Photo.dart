// ignore_for_file: file_names

import 'package:adminappp/constants/constantss.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class ShowPhoto extends StatefulWidget {
  static const String route='/ShowPhoto';

 const ShowPhoto({Key? key}) : super(key: key);

  @override
  State<ShowPhoto> createState() => _ShowPhotoState();
}

class _ShowPhotoState extends State<ShowPhoto> {
String? x;

  @override
  Widget build(BuildContext context) {
     x=ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(backgroundColor: backColor1,
      appBar: AppBar(
        backgroundColor: backColor1,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        child: InteractiveViewer(
          minScale: .1,
          maxScale: 5,

          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width ,
            decoration: BoxDecoration(
                image: DecorationImage(image: CachedNetworkImageProvider(x!),fit: BoxFit.contain)
            ),
          ),
        ),
      ),
    );
  }
}
