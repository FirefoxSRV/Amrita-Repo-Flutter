import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;







//
// Future openDownloadFile({required String url}) async {
//   final fileName = url.split('/').last;
//   final file =await downloadFile(url, fileName);
//   if(file==null){
//     return '';
//   }
//   print("Path:${file.path}");
//   OpenFile.open(file.path);
// }
//
//
//
//
// Future<File?> downloadFile(String url, String name) async {
//   final appStorage = await getApplicationDocumentsDirectory();
//   final file = File('${appStorage.path}/$name');
//   try {
//     final response = await Dio().get(
//       url,
//       options: Options(
//           responseType: ResponseType.bytes,
//           followRedirects: false,
//           receiveTimeout: 0),
//     );
//
//     final raf = file.openSync(mode: FileMode.write);
//     raf.writeFromSync(response.data);
//     await raf.close();
//     return file;
//
//   } catch (e) {
//     return null;
//   }
// }


Future<File?> saveByteAsFile(List<int> response) async {
  final appStorage = await getApplicationDocumentsDirectory();
  final file = File('${appStorage.path}/pdf.pdf');
  try {
    print("PaSS");
    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response);
    await raf.close();
    return file;

  } catch (e) {
    return null;
  }
}

Future openByteFile(List<int> response) async{
  final file =await saveByteAsFile(response);
  if(file==null){
    return '';
  }
  print("Path:${file.path}");
  OpenFile.open(file.path);
}


