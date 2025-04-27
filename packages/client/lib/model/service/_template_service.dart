// import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle;
// import '../models/template.dart';

// class TemplateService {
//   Future<List<Template>> fetchAll() async {
//     List<Template> templates = [];
//     final String response =
//         await rootBundle.loadString('assets/json/templates.json');
//     final List<dynamic> data = jsonDecode(response);
//     Templates = data
//         .map((map) => Template.fromJson(map as Map<String, dynamic>))
//         .toList();
//     return Templates;
//   }
// }