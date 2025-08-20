// Flutter Imports
import "package:flutter/material.dart";

double screenWidth(BuildContext context, double percent) =>
    MediaQuery.of(context).size.width * percent;

double screenHeight(BuildContext context, double percent) =>
    MediaQuery.of(context).size.height * percent;
