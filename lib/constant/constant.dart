import 'package:flutter/material.dart';

abstract class ConstantTextStyle {
  static const textBig =
      TextStyle(fontSize: 80, fontWeight: FontWeight.w500, color: Colors.white);

  static const textMediumLight =
      TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white);
  static const textMediumNormal =
      TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white);

  static const textMediumBold =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  static const textCity =
      TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.white);

  static const textLight =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16);

  static const textNormal =
      TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);

  static const subTitle = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );
  static const subTitleBig = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );
}

abstract class ConstantText {
  static const textProx24h = Text(
    'Proximas 24 Horas',
    style: TextStyle(
        color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
  );
}

abstract class ColorsGradient {
  static const gradientRain = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Color.fromARGB(255, 2, 40, 71), Colors.blueGrey]);

  static const gradientSun = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Colors.blue, Colors.blueGrey]);
}

abstract class DecorateionBox {
  static final boxDecoration = BoxDecoration(
      color: const Color.fromRGBO(62, 66, 107, 0.2),
      borderRadius: BorderRadius.circular(20));
}
