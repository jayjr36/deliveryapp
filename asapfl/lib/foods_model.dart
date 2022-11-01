class Foods {
  String? title;
  String? duration;

  bool isSelected=false;

  Foods(this.title, this.duration,);

  Foods.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    duration = json['duration'];
  }
}
