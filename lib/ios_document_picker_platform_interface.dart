import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ios_document_picker_method_channel.dart';

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

abstract class IosDocumentPickerPlatform extends PlatformInterface {
  /// Constructs a IosDocumentPickerPlatform.
  IosDocumentPickerPlatform() : super(token: _token);

  static final Object _token = Object();

  static IosDocumentPickerPlatform _instance = MethodChannelIosDocumentPicker();

  /// The default instance of [IosDocumentPickerPlatform] to use.
  ///
  /// Defaults to [MethodChannelIosDocumentPicker].
  static IosDocumentPickerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IosDocumentPickerPlatform] when
  /// they register themselves.
  static set instance(IosDocumentPickerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List<IosDocumentPickerPath>?> pick(
    IosDocumentPickerType type, {
    bool? multiple,
    List<String>? allowedUtiTypes,
  }) {
    throw UnimplementedError('pick() has not been implemented.');
  }
}
