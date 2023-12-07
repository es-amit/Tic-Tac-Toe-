import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,required this.hintText,required this.containerColor,required this.nextScreen});
  final String hintText;
  final Color containerColor;
  final void Function() nextScreen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: nextScreen,
      splashColor: containerColor.withOpacity(1),
      child: Container(
        width: MediaQuery.of(context).size.width /2.5,
        height: 55,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            containerColor.withOpacity(0.7),
            containerColor.withOpacity(0.9),     
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight
          ),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(hintText,
            style: Theme.of(context).textTheme.titleSmall,),
        ),
      ),
    );
  }
}