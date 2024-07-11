// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:zero/styles/color.dart';

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  minimumSize: const Size(329, 53),
  backgroundColor: lightbrown,
  elevation: 5,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(11),
    ),
  ),
);

final ButtonStyle uploadButton = ElevatedButton.styleFrom(
  minimumSize: const Size(203, 44),
  backgroundColor: lightbrown,
  elevation: 5,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(11),
    ),
  ),
);

final ButtonStyle settingsButton = ElevatedButton.styleFrom(
  minimumSize: const Size(150, 150),
  backgroundColor: Color.fromARGB(255, 255, 235, 197),
  elevation: 5,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30),
    ),
  ),
  shadowColor: 
    Color.fromARGB(255, 31, 27, 22),
    fixedSize: Size(150, 150),
);

final ButtonStyle cancelButton = ElevatedButton.styleFrom(
  minimumSize: const Size(390, 53),
  backgroundColor: cancel,
  elevation: 5,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(11),
    ),
  ),
);

final ButtonStyle proceedButton = ElevatedButton.styleFrom(
  minimumSize: const Size(390, 53),
  backgroundColor: lightbrown,
  elevation: 5,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(11),
    ),
  ),
);

final ButtonStyle topUpButton = ElevatedButton.styleFrom(
  minimumSize: const Size(120, 45),
  backgroundColor: lightbrown,
  elevation: 5,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  ),
);

final ButtonStyle topUpConfirmButton = ElevatedButton.styleFrom(
  minimumSize: const Size(335, 58),
  backgroundColor: lightbrown,
  elevation: 5,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  ),
);

final ButtonStyle couponButton = ElevatedButton.styleFrom(
  minimumSize: const Size(100, 40),
  backgroundColor: lightbrown,
  elevation: 10,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
);
