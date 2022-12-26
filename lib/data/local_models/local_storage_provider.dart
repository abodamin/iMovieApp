
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@injectable
class LocalStorageProvider {
  const LocalStorageProvider();

  static Future<File> createInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/favorite_movies_storage.txt');
    return file;
  }

}