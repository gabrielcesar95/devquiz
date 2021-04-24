import 'package:DevQuiz/core/core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NextButtonWidget extends StatelessWidget {
  final String label;
  final Color backgroudColor;
  final Color fontColor;
  final Color borderColor;
  final Color overlayColor;
  final VoidCallback onTap;

  const NextButtonWidget(
      {Key? key,
      required this.label,
      required this.backgroudColor,
      required this.fontColor,
      required this.borderColor,
      required this.overlayColor,
      required this.onTap})
      : super(key: key);

  NextButtonWidget.white(String label, VoidCallback onTap)
      : this.backgroudColor = AppColors.white,
        this.fontColor = AppColors.grey,
        this.borderColor = AppColors.border,
        this.overlayColor = AppColors.grey,
        this.onTap = onTap,
        this.label = label;

  NextButtonWidget.green(String label, VoidCallback onTap)
      : this.backgroudColor = AppColors.darkGreen,
        this.fontColor = AppColors.white,
        this.borderColor = AppColors.darkGreen,
        this.overlayColor = AppColors.green,
        this.onTap = onTap,
        this.label = label;

  NextButtonWidget.purple(String label, VoidCallback onTap)
      : this.backgroudColor = AppColors.purple,
        this.fontColor = AppColors.white,
        this.borderColor = AppColors.purple,
        this.overlayColor = AppColors.lightPurple,
        this.onTap = onTap,
        this.label = label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            backgroudColor,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(
              color: borderColor,
            ),
          ),
          overlayColor: MaterialStateProperty.all(
            overlayColor,
          ),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: fontColor,
          ),
        ),
      ),
    );
  }
}
