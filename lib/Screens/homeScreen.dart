import 'package:amrit_rep/Screens/settingScreen.dart';
import 'package:amrit_rep/httpReq.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amrit_rep/widgets/courseDialog.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dataScreen.dart';
import '../sharedPref.dart';
import 'package:animations/animations.dart';
import 'dart:io';
import 'dummy.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String bTech = '';
    late String greet;
    int dayHour = DateTime.now().hour;
    if (dayHour >= 0 && dayHour < 12) {
      greet = "Good Morning";
    } else if (dayHour >= 12 && dayHour < 18) {
      greet = "Good Afternoon";
    } else if (dayHour >= 18 && dayHour < 24) {
      greet = "Good Evening";
    }

    return LayoutBuilder(builder: (context, constraints) {
      String course = '';
      late double containerHeight = constraints.maxHeight;
      return Scaffold(
          floatingActionButton: AnimatedScale(
            duration: const Duration(milliseconds: 950),
            scale: 1,
            child: OpenContainer(
              closedColor: Colors.lightGreen.shade200,
              middleColor: Colors.lightGreen.shade200,
              transitionType: ContainerTransitionType.fadeThrough,
              closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              openBuilder: (BuildContext context, VoidCallback closeContainer) {
                return const SettingScreen();
              },
              closedBuilder: (BuildContext context, VoidCallback openContainer) {
                return FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onPressed: () {
                    openContainer();
                  },
                  backgroundColor: Colors.lightGreen.shade200,
                  elevation: 10.0,
                  splashColor: Colors.grey,
                  child: const Icon(
                    Icons.settings,
                    color: Color(0XFF464035),
                    size: 25,
                  ),
                );
              },
              useRootNavigator: true,
            ),
          ),
          appBar: AppBar(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))),
            toolbarHeight: containerHeight * 0.4,
            backgroundColor: const Color(0XFFf2dfd1),
            flexibleSpace: Center(
              child: Text(
                greet,
                style: GoogleFonts.quicksand(
                  color: Colors.black54,
                  fontSize: 40.0,
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return FutureBuilder(
                            future: getStoredData(),
                            builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                              if(snapshot.hasError){
                                return Dummy();
                              }else{
                                if (snapshot.data == '') {
                                  return FutureBuilder(
                                      future: getData("http://dspace.amritanet.edu:8080/xmlui/handle/123456789/16", 0, bTech),
                                      builder: (BuildContext context, AsyncSnapshot<List<Map<String, String>>> snapshot) {
                                        if (!snapshot.hasData) {
                                          return const Center(child: CircularProgressIndicator( strokeWidth: 2,color: Color(0xFFf2dfd1),));
                                        }
                                        return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              side: const BorderSide(color: Colors.grey),
                                            ),
                                            title: Text(
                                              "Select course",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.quicksand(fontSize: 25),
                                            ),
                                            content: SizedBox(
                                              width: 300,
                                              height: containerHeight * 0.72,
                                              child: ListView.builder(
                                                  itemCount: snapshot.data!.length - 3,
                                                  itemBuilder: (context, index) {
                                                    return Column(
                                                      children: [
                                                        InkWellDialog(
                                                            title: snapshot.data![index]['name']!,
                                                            onTap: () {
                                                              setDataToLink(snapshot.data![index]['name']!);
                                                              Navigator.pop(context);
                                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                return DataScreen(

                                                                  folderLevelUrl: snapshot.data![index]['link']!,
                                                                  bTech: snapshot.data![index]['name'] == 'B.Tech' ? 'true' : '',
                                                                  course: snapshot.data![index]['name']!,
                                                                );
                                                              }));
                                                            }),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                            ));
                                      });
                                }
                                course = snapshot.data == null ? '' : snapshot.data!;
                                return FutureBuilder(
                                    future: linkFromName(course),
                                    builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                                      if (!snapshot.hasData) {
                                        return const SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: Color(0xFFf2dfd1),
                                                strokeWidth: 2,
                                              ),
                                            ));
                                      }
                                      return DataScreen(
                                        folderLevelUrl: snapshot.data!,
                                        bTech: course == 'B.Tech' ? 'true' : '',
                                        course: course,
                                      );
                                      // Navigator.push (context, MaterialPageRoute(builder: (context) {
                                      //   return DataScreen(folderLevelUrl:snapshot.data!,bTech:course=='B.Tech'?'true':'');
                                      // }));
                                    });
                              }

                            });
                      });
                },
                shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black), borderRadius: BorderRadius.circular(20.0)),
                child: const Text("Question Papers"),
              ),
            ],
          ));
    });
  }
}
