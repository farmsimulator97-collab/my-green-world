import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// تخزين محلي بصيغة JSON داخل مساحة التطبيق الخاصة.
/// لا يتصل هذا الملف بأي قاعدة بيانات أو خدمة سحابية.
class LocalGardenStore {
  static const _fileName = 'my_green_world_garden.json';

  Future<File> _gardenFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  Future<List<Map<String, dynamic>>> loadPlants() async {
    final file = await _gardenFile();
    if (!await file.exists()) return [];
    try {
      final decoded = jsonDecode(await file.readAsString());
      if (decoded is! List) return [];
      return decoded.whereType<Map>().map((item) => Map<String, dynamic>.from(item)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> savePlants(List<Map<String, dynamic>> plants) async {
    final file = await _gardenFile();
    await file.writeAsString(jsonEncode(plants), flush: true);
  }

  Future<File> exportBackup() async {
    final source = await _gardenFile();
    if (!await source.exists()) {
      await source.writeAsString('[]', flush: true);
    }
    final directory = await getApplicationDocumentsDirectory();
    final stamp = DateTime.now().toIso8601String().replaceAll(':', '-');
    return source.copy('${directory.path}/my_green_world_backup_$stamp.json');
  }

  Future<void> importBackup(File backup) async {
    final content = await backup.readAsString();
    final decoded = jsonDecode(content);
    if (decoded is! List) {
      throw const FormatException('ملف النسخة الاحتياطية غير صالح');
    }
    final destination = await _gardenFile();
    await destination.writeAsString(jsonEncode(decoded), flush: true);
  }
}
