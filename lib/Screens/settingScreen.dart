import 'package:amrit_rep/widgets/Custom_Dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../sharedPref.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2dfd1),
      body: LayoutBuilder(builder: (context, constraints) {
        late double containerHeight = constraints.maxHeight;
        late double containerWidth = constraints.maxWidth;
        return CustomScrollView(
          slivers: [
            SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back,color: Colors.black,),
                ),
                backgroundColor: Color(0xFFf2dfd1),
                bottom: PreferredSize(
                    preferredSize: const Size(0, 40),
                    child: Text(
                      "Settings ",
                      style: GoogleFonts.quicksand(fontSize: 40.0,fontWeight: FontWeight.w500),
                    ))),
            SliverToBoxAdapter(
                child:SizedBox(
                  height: containerHeight/28.6,
                )),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Reset",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.quicksand(fontSize: 25.0),
                ),
              ),
            ),

            const SliverToBoxAdapter(
                child: Divider(
                  endIndent: 10,
                  indent: 10,
                  color: Colors.grey,
                )),
            SliverToBoxAdapter(child: SizedBox(height: containerHeight/50,),),
            SliverToBoxAdapter(
                child: MaterialButton(
                  onPressed:(){
                      resetStoredData();
                      showDialog(context: context, builder: (context){
                        return CustomAlertDialogAndroid(
                          title: const Text("Success !"),
                          content: const Text("Preferences have been successfully erased "),
                          actions: [
                            MaterialButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text("Ok"),
                            )
                          ],

                        );
                      });

                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: containerWidth/6.1),
                        child: Text("Store your data locally !",
                            style: GoogleFonts.quicksand(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: containerHeight/42.264,left: containerWidth/20.57),
                            child: const Icon(Icons.home),
                          ),
                          SizedBox(width: containerWidth/16.45,),
                          Expanded(
                            child: Text(
                                "The data of your cards are stored locally and secured using your fingerprint .",

                                style: GoogleFonts.quicksand(fontSize: 16.0)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            SliverToBoxAdapter(child: SizedBox(height: containerHeight/30.26,),),
            SliverToBoxAdapter(
                child: MaterialButton(
                  onPressed: (){

                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:EdgeInsets.only(left: containerWidth/6.1),
                        child: Text("Restore your data",
                            style: GoogleFonts.quicksand(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Padding(
                          padding: EdgeInsets.only(bottom: containerHeight/42.264,left: containerWidth/20.57),
                          child: const Icon(Icons.home),
                        ),
                          SizedBox(width: containerWidth/16.45,),
                          Expanded(
                            child: Text(
                                "If you have already used this app and stored the data , you can restore your cards in a click of a button  ",

                                style: GoogleFonts.quicksand(fontSize: 16.0)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        );
      }),
    );
  }
}
