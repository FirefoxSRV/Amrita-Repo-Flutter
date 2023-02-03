import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class OptionCard extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const OptionCard({Key? key,required this.text,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xFFf2dfd1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              MaterialButton(
                hoverColor: Colors.white,
                splashColor: Colors.white,
                height: MediaQuery.of(context).size.height*0.1,
                onPressed: onPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        text,style: GoogleFonts.quicksand(
                          fontSize: 16.0, fontWeight: FontWeight.w500,),textAlign: TextAlign.left,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),

          ],
        ),
    );
  }
}