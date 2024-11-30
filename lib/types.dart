enum IosDocumentPickerType { file, directory }

class IosDocumentPickerPath {
  final String url;
  final String path;
  final String name;

  IosDocumentPickerPath(this.url, this.path, this.name);

  static IosDocumentPickerPath fromMap(Map<dynamic, dynamic> map) {
    return IosDocumentPickerPath(map['url'], map['path'], map['name']);
  }

  @override
  String toString() {
    return 'DocumentPickerPath{name: $name, url: $url, path: $path}';
  }
}
