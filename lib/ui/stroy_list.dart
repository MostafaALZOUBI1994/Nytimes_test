import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';
import 'package:nytimes_test/constants.dart';
import 'package:nytimes_test/models/bookmark.dart';
import 'package:nytimes_test/services/top_story_services.dart';
import 'package:nytimes_test/ui/details_page.dart';

//Top story ui
class StoryList extends StatefulWidget {
  @override
  _StoryListState createState() => _StoryListState();
}

class _StoryListState extends State<StoryList> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
            future: TopStoryServices().fetchTopStories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return PlatformCircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text("Error");
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        elevation: 8.0,
                        child: ListTile(
                          onTap: () {
                            //navigate to details page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  //pass all requiered parameter to detials page
                                  builder: (context) => DetailsPage(
                                        title: snapshot.data[index].title,
                                        abstract: snapshot.data[index].abstract,
                                        publishedDate:
                                            snapshot.data[index].publishedDate,
                                        url: snapshot.data[index].url,
                                        photoLink: snapshot
                                            .data[index].multimedia[1].url,
                                      )),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data[index].multimedia[2].url),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Title:",
                                style: titleStyle,
                              ),
                              Text(
                                snapshot.data[index].title,
                                style: subTitleStyle,
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Published Date:",
                                style: titleStyle,
                              ),
                              Text(
                                snapshot.data[index].publishedDate,
                                style: subTitleStyle,
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed: () async {
                              //covert image to Unit8Lit to save it in hive data base for offline mode
                              Uint8List imageInUnit8List =
                                  await networkImageToByte(
                                      snapshot.data[index].multimedia[2].url);
                              //create bookmark object that save it in hive database
                              final bookmark = Bookmark(
                                  snapshot.data[index].title,
                                  snapshot.data[index].abstract,
                                  snapshot.data[index].url,
                                  snapshot.data[index].publishedDate,
                                  imageInUnit8List);
                              //add the object to hive
                              addBookmark(bookmark);
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              }
            }));
  }

//to add bookmark objects to hive database
  void addBookmark(Bookmark bookmark) {
    final bookMarksBox = Hive.box('bookmarks');
    bookMarksBox.add(bookmark);
  }
}
