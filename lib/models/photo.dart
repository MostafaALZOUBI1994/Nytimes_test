class Multimedia {
  String url;
  String format;
  int height;
  int width;
  String type;
  String subtype;
  String caption;
  String copyright;

  Multimedia(
      {this.url,
      this.format,
      this.height,
      this.width,
      this.type,
      this.subtype,
      this.caption,
      this.copyright});

  Multimedia.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    format = json['format'];
    height = json['height'];
    width = json['width'];
    type = json['type'];
    subtype = json['subtype'];
    caption = json['caption'];
    copyright = json['copyright'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['format'] = this.format;
    data['height'] = this.height;
    data['width'] = this.width;
    data['type'] = this.type;
    data['subtype'] = this.subtype;
    data['caption'] = this.caption;
    data['copyright'] = this.copyright;
    return data;
  }
}
