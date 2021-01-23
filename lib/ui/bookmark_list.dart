import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';
import 'package:nytimes_test/constants.dart';
import 'package:nytimes_test/models/bookmark.dart';

import 'details_page.dart';

//bookmarks are stored in hive database in this approach we can get bookmarks in online/offline
class BookmarkList extends StatefulWidget {
  @override
  _BookmarkListState createState() => _BookmarkListState();
}

class _BookmarkListState extends State<BookmarkList> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
          child: FutureBuilder(
              //open hive box
              future: Hive.openBox('bookmarks'),
              builder: (context, snapshot) {
                final bookmarks = Hive.box('bookmarks');
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return PlatformCircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text("Error");
                  } else {
                    return GridView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        //get every bookmark object from hive to work in offline
                        final bookmark = bookmarks.get(index) as Bookmark;
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                        //pass object to details page
                                        title: bookmark.title,
                                        abstract: bookmark.abstract,
                                        publishedDate: bookmark.publishedDate,
                                        url: bookmark.url,
                                        photo: bookmark.photo,
                                      )),
                            );
                          },
                          child: Card(
                            elevation: 8.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      height: 50,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(360.0),
                                        //this for widget take Unit8list format
                                        child: Image.memory(bookmark.photo),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Title",
                                    style: titleStyle,
                                  ),
                                  Text(
                                    bookmark.title,
                                    style: subTitleStyle,
                                  ),
                                  Text(
                                    "Published Date",
                                    style: titleStyle,
                                  ),
                                  Text(
                                    bookmark.publishedDate,
                                    style: subTitleStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                    );
                  }
                }
              })),
    );
  }
}
