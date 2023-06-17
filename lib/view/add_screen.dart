// import 'package:document_manager_app/functions/mobile.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';

// class AddScreen extends StatelessWidget {
//   const AddScreen({super.key});

//   Future<void> _createPdf() async {
//     PdfDocument document = PdfDocument();
//     document.pages.add();

//     List<int> bytes = await document.save();
//     document.dispose();

//     saveAndLaunchFile(bytes, 'Output.pdf');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Create PDF"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 onPressed: _createPdf, child: const Text("Create PDF"))
//           ],
//         ),
//       ),
//     );
//   }
// }
