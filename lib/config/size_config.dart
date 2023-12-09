import 'package:flutter/material.dart';

double getHeight(context, {height = 0.04}) =>
    MediaQuery.sizeOf(context).height * height;

double getWidth(context, {width = 0.04}) =>
    MediaQuery.sizeOf(context).width * width;

SizedBox spaceHeight(context, {height = 0.04}) =>
    SizedBox(height: MediaQuery.sizeOf(context).height * height);

SizedBox spaceWidth(context, {width = 0.04}) =>
    SizedBox(width: MediaQuery.sizeOf(context).width * width);

double padding(context, {padding = 0.04}) =>
    MediaQuery.sizeOf(context).width * padding;

double borderRadius(context, {border = 0.04}) =>
    MediaQuery.sizeOf(context).width * border;

TextStyle smallTextStyle(context, {size = 0.015, color = Colors.black}) =>
    TextStyle(
        fontSize: MediaQuery.sizeOf(context).height * size,
        color: color,
        fontWeight: FontWeight.w400);

TextStyle mediumTextStyle(context,
        {size = 0.025, color = Colors.black, fontWeight = FontWeight.w500}) =>
    TextStyle(
        fontSize: MediaQuery.sizeOf(context).height * size,
        color: color,
        fontWeight: fontWeight);

TextStyle largeTextStyle(context, {size = 0.035, color = Colors.black}) =>
    TextStyle(
        fontSize: MediaQuery.sizeOf(context).height * size,
        color: color,
        fontWeight: FontWeight.bold);

TextStyle smallMediumTextStyle(context, {size = 0.02, color = Colors.black}) =>
    TextStyle(
        fontSize: MediaQuery.sizeOf(context).height * size,
        color: color,
        fontWeight: FontWeight.bold);
