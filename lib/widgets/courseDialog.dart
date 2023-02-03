import 'package:flutter/material.dart';


class InkWellDialog extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const InkWellDialog({Key? key,required this.title,required this.onTap}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return InkWell(
      hoverColor: Color(0XFFf2dfd1),
      highlightColor: Color(0XFFf2dfd1),
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        padding: EdgeInsets.only(left: 10),
        width: width*0.45,
        height:height*0.09,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(30.0)
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: Text(title,textAlign: TextAlign.center,)),
        ),
      ),
    );
  }
}



