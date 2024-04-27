class News{
  String title;
  String text;
  String time; 

  News({
    required this.title,
    required this.text,
    required this.time
  });

  factory News.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty ||
        !json.containsKey("text") ||
        !json.containsKey("time") ||
        !json.containsKey("title")) {
      return News(title: "0", text: "0", time: "0");
    }
    return News(
      title: json["title"],
      text: json["text"],
      time: json["time"]
    );
  }
}