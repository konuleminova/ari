class HtmlModel {
  String header;
  String content;
  String image;

  HtmlModel.fromJson(Map<String, dynamic> json) {
    header = json['header'];
    content = json['content'];
    image = json['image'];
  }
}
