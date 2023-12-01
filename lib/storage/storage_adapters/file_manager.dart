import 'dart:convert';
import 'dart:io';
import 'package:giusseppe_flut/service/file_manager_mixin.dart';
import 'package:path_provider/path_provider.dart';

class FileManager with FileManagerMixin {
  static final FileManager _instance = FileManager._internal();

  factory FileManager() {
    return _instance;
  }

  FileManager._internal();

  static Directory get directory => _directory!;
  static Directory? _directory;

  static Future<void> initialFile() async {
    _directory = await getApplicationDocumentsDirectory();
  }

  Future<Map<String, dynamic>?> read(File file) async {
    return beforeExec(() async {
      await ensureFileExist(file);
      String json = await file.readAsString();
      if (json.isEmpty) return null;
      return jsonDecode(json);
    });
  }

  Future<FileSystemEntity?> write(File file, String json) async {
    return beforeExec(() async {
      await ensureFileExist(file);
      file = await file.writeAsString(json);
      return file;
    });
  }

  Future<FileSystemEntity?> delete(File file) async {
    return beforeExec(() async {
      if (file.existsSync()) return file.delete();
      return null;
    });
  }

   void saveImagesLocally(List<File> images) async {
    try {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String appDirPath = appDir.path;

      for (int i = 0; i < images.length; i++) {
        final String imagePath = '$appDirPath/image_$i.jpg';
        await images[i].copy(imagePath);
      }
      print('Images saved successfully.');
    } catch (error) {
      print("Error saving images locally: $error");
    }
  }

Future<List<File>> getLocalImages() async {
  List<File> localImages = [];

  try {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String appDirPath = appDir.path;
    final String imageDirectoryPath = '$appDirPath';

    final Directory imageDirectory = Directory(imageDirectoryPath);
    final List<FileSystemEntity> files = imageDirectory.listSync();

    for (final FileSystemEntity file in files) {
      if (file is File) {
        if (file.path.contains('.jpg')) {
          localImages.add(file);
        }
      }
    }
  } catch (error) {
    print("Error getting local images: $error");
  }

  return localImages;
}

  void deleteStoredImages() async {
  try {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String appDirPath = appDir.path;
    final String imageDirectoryPath = '$appDirPath';

    final Directory imageDirectory = Directory(imageDirectoryPath);
    final List<FileSystemEntity> files = imageDirectory.listSync();

    for (final FileSystemEntity file in files) {
      if (file is File) {
        if (file.path.contains('.jpg')) {
          file.deleteSync();
        }
      }
    }

    print('All images deleted successfully.');
  } catch (error) {
    print("Error deleting stored images: $error");
  }
}
}
