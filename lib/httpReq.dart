import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;


Future<String> fetchPage(String mainUrl) async{

  Map<String,String> body={
    "hash":"abcdefg",
    "data":mainUrl
  };
  http.Response response = await http.post(Uri.parse("https://ctf.cb.amrita.edu/amritarepo/proxy.php"),headers: {
    "Accept":"*/*",
    "Content-Type":"application/x-www-form-urlencoded; charset=UTF-8",
    "Connection":"Keep-Alive",
    "Content-Length":(utf8.encode("hash=${body['hash']}&data=${body['data']!.replaceAll("%", "%25").replaceAll(":", "%3A").replaceAll("/", "%2F").replaceAll("&", "%26").replaceAll("?", "%3F").replaceAll("=", "%3D")}").length).toString(),
    "host":"ctf.cb.amrita.edu"
  },body: body);
  if(response.statusCode==200){
    return response.body;
  }
  return Future.error(Exception("Network error ${response.statusCode}"));
}

Future<List<Map<String,String>>> getData(String mainUrl,int opt,String bTech) async {
  var ele;
  var ele1;
  var ele6;
  var fetchPageDocument = await fetchPage(mainUrl);
  dom.Document document = parser.parse(fetchPageDocument);
  List<Map<String, String>> options = [];
  if(opt==3){
    ele = document.getElementById("aspect_discovery_CollectionRecentSubmissions_div_collection-recent-submission");
  }else{
    ele = document.getElementById("aspect_artifactbrowser_CommunityViewer_div_community-view");
  }

  if(opt==2 && bTech=="true" && mainUrl!="http://dspace.amritanet.edu:8080/xmlui/handle/123456789/229" && mainUrl!="http://dspace.amritanet.edu:8080/xmlui/handle/123456789/234"){
    ele1 = ele!.getElementsByTagName("ul")[1];
  }else{
    ele1 = ele!.getElementsByTagName("ul")[0];
  }
  var ele2 = ele1.getElementsByTagName("li");
  for (int i = 0; i < ele2.length; i++) {
    var ele3 = ele2[i].getElementsByTagName("div")[0];
    var ele4 = ele3.getElementsByTagName("div")[0];
    var ele5 = ele4.getElementsByTagName("a")[0];
    if(opt==3){
      print("yes");
      ele6=ele5.text;
      List<Map<String,String>> pdfOptions= await pdfData("http://dspace.amritanet.edu:8080"+ele5.attributes['href']!, 4);
      for(int j=0;j<pdfOptions.length;j++){
        options.add(pdfOptions[j]);
      }
    }else{
      ele6 = ele5.getElementsByTagName("span")[0].text;
    }
    if(ele6=="Communication"){
      List<Map<String,String>> communicationOptions=await getData("http://dspace.amritanet.edu:8080"+ele5.attributes['href']!,0,bTech);
      // print(communicationOptions);
      for(int j=0;j<communicationOptions.length;j++){
        options.add(communicationOptions[j]);
      }
    }else if(opt!=3){
      options.add({
        "name": ele6,
        "link": ele5.attributes['href']!
      });
    }
  }
  // print(options);
  return options;
}

Future<String> linkFromName(String name) async{
  List<Map<String,String>> options=await getData("http://dspace.amritanet.edu:8080/xmlui/handle/123456789/16", 0, "");
  for(int i=0;i<options.length;i++){
    if(options[i]['name']==name){
      print(options[i]['link']!);
      return options[i]['link']!;
    }
  }
  return '';

}


Future<List<Map<String,String>>> pdfData(String mainUrl,int opt) async {
  var fetchPageDocument = await fetchPage(mainUrl);
  dom.Document document = parser.parse(fetchPageDocument);
  List<Map<String, String>> options = [];
  var ele = document.getElementsByClassName("file-wrapper clearfix");
  for(int i=0;i<ele.length;i++){
    var ele3=ele[i].getElementsByTagName('div')[1].getElementsByTagName('div')[0].getElementsByTagName('span')[1].text;
    var ele4=ele[i].getElementsByClassName("file-link")[0].getElementsByTagName("a")[0];
    // var ele2=ele[i].getElementsByTagName("div")[2].getElementsByTagName('a');
    // var ele4=ele2[0].attributes['href'];
    options.add({
      "name": ele3,
      "link": ele4.attributes['href']!
    });
  }

  return options;
}


Future<List<int>> getPdfAsBytes(mainUrl) async{
  Map<String,String> body={
    "hash":"abcdefg",
    "data":mainUrl
  };

  http.Response response = await http.post(Uri.parse("https://ctf.cb.amrita.edu/amritarepo/proxy.php"),headers: {
    "Accept":"*/*",
    "Content-Type":"application/x-www-form-urlencoded; charset=UTF-8",
    "Connection":"Keep-Alive",
    "Content-Length":(utf8.encode("hash=${body['hash']}&data=${body['data']!.replaceAll("%", "%25").replaceAll(":", "%3A").replaceAll("/", "%2F").replaceAll("&", "%26").replaceAll("?", "%3F").replaceAll("=", "%3D")}").length).toString(),
    "host":"ctf.cb.amrita.edu"
  },body: body);
  if(response.statusCode==200){
    return response.bodyBytes;
  }
  return Future.error(Exception("Network error ${response.statusCode}"));
}
