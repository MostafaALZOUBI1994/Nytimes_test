import 'dart:convert';
import 'package:nytimes_test/models/story.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

//here we write the services we need for top stroies
class TopStoryServices {
  //get top stories
  Future<List<Story>> fetchTopStories() async {
    List<Story> stories = [];
    var response = await http.get(
        "https://api.nytimes.com/svc/topstories/v2/world.json?api-key=$ApiKey");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var result = data["results"];
      //convert result to map then from json to object and add every object to list
      result.map((story) => stories.add(Story.fromJson(story))).toList();
      return stories;
    }
  }
}
