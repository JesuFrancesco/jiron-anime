import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http_status/http_status.dart';
import 'package:jiron_anime/config/config.dart';
import 'package:jiron_anime/model/entity/upload_file.dart';
import 'package:jiron_anime/utils/supabase_utils.dart';
import 'package:path/path.dart';

class FileUploadService {
  final BuildContext context;

  FileUploadService(this.context);

  void _showSnackBar(String message, {Color backgroundColor = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: backgroundColor),
    );
  }

  Future<UploadedFile?> uploadSingleFile(File file) async {
    final uri = Uri.parse('${Config.apiUrl}/storage/single');

    try {
      final request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      request.headers.addAll(getSupabaseAuthHeaders());

      final response = await request.send();

      if (response.statusCode.isSuccessfulHttpStatusCode) {
        final responseData = await http.Response.fromStream(response);

        final Map<String, dynamic> jsonResponse = jsonDecode(responseData.body);
        final uploadedFile = UploadedFile.fromJson(jsonResponse["file"]);

        // _showSnackBar('¡Imagen guardada de forma exitosa!');

        return uploadedFile;
      } else {
        _showSnackBar(
          'Algo salió mal: ${response.statusCode}',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      _showSnackBar('Algo salió muy mal: $e', backgroundColor: Colors.red);
    }
    return null;
  }

  Future<List<UploadedFile>> uploadMultipleFiles(List<File> files) async {
    final uri = Uri.parse('${Config.apiUrl}/storage/multiple');

    final request = http.MultipartRequest('POST', uri);

    for (var file in files) {
      final fileName = basename(file.path);
      request.files.add(
        await http.MultipartFile.fromPath(
          'files',
          file.path,
          filename: fileName,
        ),
      );
    }

    request.headers.addAll(getSupabaseAuthHeaders());

    try {
      final response = await request.send();

      if (response.statusCode.isSuccessfulHttpStatusCode) {
        final responseData = await http.Response.fromStream(response);

        final dynamic jsonResponse = jsonDecode(responseData.body);

        final List<dynamic> data = jsonResponse["files"];

        final uploadedFiles =
            data
                .map(
                  (map) => UploadedFile.fromJson(map as Map<String, dynamic>),
                )
                .toList();

        return uploadedFiles;
      } else {
        _showSnackBar(
          "Algo salió mal, error ${response.statusCode}",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      _showSnackBar(
        "Algo salió muy muy mal, error $e",
        backgroundColor: Colors.red,
      );
    }

    return [];
  }
}
