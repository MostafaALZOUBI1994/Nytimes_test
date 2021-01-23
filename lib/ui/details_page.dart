import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../constants.dart';

class DetailsPage extends StatelessWidget {
  String title;
  String abstract;
  String url;
  String publishedDate;
  //this parameter we get when we navigate from bookmark list that sored in hive database
  Uint8List photo;
  //this parameter we get when we navigate from top story list
  String photoLink;
  DetailsPage(
      {this.title,
      this.abstract,
      this.url,
      this.publishedDate,
      this.photo,
      this.photoLink});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.deepOrange, Colors.pinkAccent])),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(360),
                  //if photo link==null that mean we were in book mark list else we were in top story list
                  child: photoLink == null
                      ? Image.memory(photo)
                      : Image.network(photoLink),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Title:", style: titleStyle),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(title, style: subTitleStyle),
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Published Date:", style: titleStyle),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(publishedDate, style: subTitleStyle),
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Link:", style: titleStyle),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(url, style: subTitleStyle),
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Abstract:", style: titleStyle),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(abstract, style: subTitleStyle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
