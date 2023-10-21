import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart';
import 'package:photo_gallery_app/common/components.dart';

class DownloadHelper {
  Future<String?> _getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      log("Cannot get download folder path");
    }
    return directory?.path;
  }

  downloadFile({required String url}) async {
    PermissionStatus permissionStatus;
    final deviceInfo = await DeviceInfoPlugin().androidInfo;

    if (deviceInfo.version.sdkInt > 32) {
      permissionStatus = await Permission.photos.request();
    } else {
      permissionStatus = await Permission.storage.request();
    }
    if (permissionStatus.isGranted) {
      showToast("Download Started");
      final Request request = Request('GET', Uri.parse(url));
      final StreamedResponse response = await Client().send(request);
      List<int> bytes = [];
      String? pathName = await _getDownloadPath();
      String fileName = await _extractFileFormatFromUrl(url);
      final file = await _getFile(pathName, fileName);
      response.stream.listen((value) {
        bytes.addAll(value);
      }, onDone: () async {
        await file.writeAsBytes(bytes).then((value) => showToast(
            "Download Completed.Check your phone downloads folder to view this file"));
      });
    } else if (permissionStatus.isPermanentlyDenied) {
      openAppSettings();
    } else {
      showToast("Storage permission needed!");
    }
  }

  Future<File> _getFile(path, fileName) async {
    return File('$path/${DateTime.now().millisecondsSinceEpoch.toString()}.$fileName');
  }

  Future<String> _extractFileFormatFromUrl(String url) async {
    Uri uri = Uri.parse(url);
    String? formatParameter = uri.queryParameters['fm'];
    return formatParameter!;
  }
}
