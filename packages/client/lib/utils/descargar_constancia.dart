// import 'dart:io';

// import 'package:flutter/services.dart';
// import 'package:flutter_file_saver/flutter_file_saver.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:jiron_anime/main.dart';
// import 'package:jiron_anime/model/entity/order.dart';
// import 'package:jiron_anime/view/components/dialogs.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';

// Future<void> descargarConstancia(Order order) async {
//   final pdf = pw.Document(
//     theme: ThemeData.withFont(
//       base: Font.ttf(await rootBundle.load("assets/font/Rubik-Regular.ttf")),
//       bold: Font.ttf(await rootBundle.load("assets/font/Rubik-Bold.ttf")),
//       italic: Font.ttf(await rootBundle.load("assets/font/Rubik-Italic.ttf")),
//       boldItalic: Font.ttf(
//         await rootBundle.load("assets/font/Rubik-BoldItalic.ttf"),
//       ),
//     ),
//   );

//   pdf.addPage(
//     pw.Page(
//       pageFormat: PdfPageFormat.a6,
//       build:
//           (pw.Context context) => pw.Container(
//             color: PdfColors.red50,
//             padding: const pw.EdgeInsets.all(10),
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Text(
//                   'Recibo de Pago',
//                   style: pw.TextStyle(
//                     fontSize: 24,
//                     fontWeight: pw.FontWeight.bold,
//                     color: PdfColors.red800,
//                   ),
//                 ),
//                 pw.SizedBox(height: 20),
//                 pw.Text(
//                   'ID de Orden: ${order.id ?? ''}',
//                   style: const pw.TextStyle(color: PdfColors.red700),
//                 ),
//                 pw.Text(
//                   'Total: \$${order.totalPrice?.toStringAsFixed(2) ?? ''}',
//                   style: const pw.TextStyle(color: PdfColors.red700),
//                 ),
//                 pw.Text(
//                   'Estado: ${order.status ?? ''}',
//                   style: const pw.TextStyle(color: PdfColors.red700),
//                 ),
//                 pw.Text(
//                   'Fecha: S/. ${DateFormat("dd/MM/yyyy HH:mm:ss").format(order.createdAt ?? DateTime.now())}',
//                   style: const pw.TextStyle(color: PdfColors.red700),
//                 ),
//                 pw.SizedBox(height: 10),
//                 // pw.Text(
//                 //   'Entregado a: ${order.client!.referenceAddress!}',
//                 //   style: const pw.TextStyle(color: PdfColors.red700),
//                 // ),
//                 pw.SizedBox(height: 20),
//                 pw.Text(
//                   'Items:',
//                   style: pw.TextStyle(
//                     color: PdfColors.red800,
//                     fontWeight: pw.FontWeight.bold,
//                   ),
//                 ),
//                 ...?order.orderItems?.map(
//                   (item) => pw.Text(
//                     '- ${item.product!.name ?? ''} x ${item.amount}',
//                     style: const pw.TextStyle(color: PdfColors.red700),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//     ),
//   );

//   try {
//     final output = await getTemporaryDirectory();
//     final fileName = "recibo_${order.id}.pdf";
//     final fullFilePath = "${output.path}/$fileName}";
//     final file = File(fullFilePath);
//     await file.writeAsBytes(await pdf.save());

//     await FlutterFileSaver().writeFileAsBytes(
//       fileName: fileName,
//       bytes: await file.readAsBytes(),
//     );

//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//           "downloads",
//           "Downloads",
//           channelDescription: "Canal de descargas",
//           importance: Importance.defaultImportance,
//           priority: Priority.min,
//         );

//     await flutterLocalNotificationsPlugin.show(
//       12345,
//       "Constancia almacenada en $fileName",
//       "Toca aquí para ver la constancia en .pdf",
//       const NotificationDetails(android: androidPlatformChannelSpecifics),
//       payload: fullFilePath,
//     );

//     Get.snackbar('Descarga', 'Recibo guardado exitosamente');
//   } catch (e) {
//     Get.snackbar('Error', 'No se pudo guardar el recibo');
//     Get.dialog(ErrorDialog(message: e.toString()));
//   }
// }
