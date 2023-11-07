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
}
