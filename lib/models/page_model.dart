class PageModel {
  final String id;
  final String title;

  PageModel({this.id, this.title});

  @override
  String toString() {
    return title;
  }
}
