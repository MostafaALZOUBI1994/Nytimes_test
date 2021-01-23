import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'bookmark.g.dart'; // Name of the TypeAdapter that we will generate in the future
//this class for hive database
@HiveType(typeId: 0)
class Bookmark extends HiveObject{
  @HiveField(0)
  String title;

  @HiveField(1)
  String abstract;

  @HiveField(2)
  String url;

  @HiveField(3)
  String publishedDate;

  @HiveField(4)
  Uint8List photo;

  Bookmark(this.title, this.abstract, this.url,this.publishedDate,this.photo);
}