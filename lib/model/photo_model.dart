class PhotoModel {
  String? id;
  Urls? urls;

  PhotoModel({this.id, this.urls});

  PhotoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urls = json['urls'] != null ? Urls.fromJson(json['urls']) : null;
  }

  @override
  String toString() {
    return 'PhotoModel{id: $id, urls: $urls}';
  }
}

class Urls {
  String? regular;

  Urls({this.regular});

  Urls.fromJson(Map<String, dynamic> json) {
    regular = json['regular'];
  }

  @override
  String toString() {
    return 'Urls{regular: $regular}';
  }
}