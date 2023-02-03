import 'package:flutter/material.dart';
import 'package:amrit_rep/httpReq.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/card.dart';
import '../openFile.dart';
import 'waitingScreen.dart';

class DataScreen extends StatefulWidget {
  String folderLevelUrl;
  String bTech;
  String course;
  DataScreen({Key? key, required this.folderLevelUrl, required this.bTech, required this.course}) : super(key: key);

  @override
  State<DataScreen> createState() => _DataScreenState(folderLevelUrl, bTech, course);
}

class _DataScreenState extends State<DataScreen> {
  final String root = "http://dspace.amritanet.edu:8080";
  List<String> folderLevels = [];
  String bTech;
  String folderLevelUrl;
  String course;
  _DataScreenState(this.folderLevelUrl, this.bTech, this.course);


  @override
  void initState() {
    folderLevels.add(folderLevelUrl);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context, constraints) {
      return WillPopScope(
        onWillPop: () {
          if (folderLevels.length == 1) {
            Navigator.pop(context);
          } else if (folderLevels.length > 1) {
            setState(() {
              folderLevels.removeLast();
            });
          }
          return Future(() => false);
        },
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      if (folderLevels.length == 1) {
                        Navigator.pop(context);
                      } else if (folderLevels.length > 1) {
                        setState(() {
                          folderLevels.removeLast();
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  backgroundColor: Color(0xFFf2dfd1),
                  bottom: PreferredSize(
                      preferredSize: const Size(0, 90),
                      child: Column(
                        children: [
                          Text(
                            course,
                            style: GoogleFonts.quicksand(fontSize: 40.0, fontWeight: FontWeight.w500),textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 20,)
                        ],
                      ))),
              backgroundColor: Color(0xFFf2dfd1),
              body: FutureBuilder(
                  future: getData(root + folderLevels.last, folderLevels.length, bTech),
                  builder: (BuildContext context, AsyncSnapshot<List<Map<String, String>>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator(color: Color(0xFFf2dfd1)));
                    } else if(snapshot.connectionState==ConnectionState.waiting){
                      return WaitingScreen();
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return OptionCard(
                              text: snapshot.data![index]['name'].toString(),
                              onPressed: () async {

                                  if (folderLevels.length == 3) {
                                    List<int> pdfBytes =
                                    await getPdfAsBytes("http://dspace.amritanet.edu:8080${snapshot.data![index]['link'].toString()}");
                                    await openByteFile(pdfBytes);

                                  } else {
                                    folderLevels.add(snapshot.data![index]["link"]!);
                                    setState(() {});
                                  }




                              },
                            );
                          });
                    }
                  })),
        ),
      );
    });
  }
}
