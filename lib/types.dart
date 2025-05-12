enum IosDocumentPickerType { file, directory }

class IosDocumentPickerPath {
  final String url;
  final String path;
  final String name;
  final String bookmark;

  IosDocumentPickerPath(this.url, this.path, this.name, this.bookmark);

  static IosDocumentPickerPath fromMap(Map<dynamic, dynamic> map) {
    return IosDocumentPickerPath(map['url'], map['path'], map['name'], map['bookmark']);
  }

  @override
  String toString() {
    return 'DocumentPickerPath{name: $name, url: $url, path: $path, bookmark: $bookmark}';
  }
}
