import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ios_document_picker_method_channel.dart';

enum DocumentPickerType { file, directory }

class DocumentPickerPath {
  final String url;
  final String path;

  DocumentPickerPath(this.url, this.path);

  static DocumentPickerPath fromMap(Map<dynamic, dynamic> map) {
    return DocumentPickerPath(map['url'], map['path']);
  }

  @override
  String toString() {
    return 'Url: $url | Path: $path';
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

  Future<List<DocumentPickerPath>?> pick(
    DocumentPickerType type, {
    bool? multiple,
    List<String>? allowedUtiTypes,
  }) {
    throw UnimplementedError('pick() has not been implemented.');
  }
}
