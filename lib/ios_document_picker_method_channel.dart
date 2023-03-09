import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ios_document_picker_platform_interface.dart';

/// An implementation of [IosDocumentPickerPlatform] that uses method channels.
class MethodChannelIosDocumentPicker extends IosDocumentPickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ios_document_picker');

  @override
  Future<List<DocumentPickerPath>?> pick(DocumentPickerType type) async {
    var maps = await methodChannel
        .invokeListMethod<Map<dynamic, dynamic>>('pick', {'type': type.index});
    if (maps == null) {
      return null;
    }
    return maps.map((e) => DocumentPickerPath.fromMap(e)).toList();
  }
}
