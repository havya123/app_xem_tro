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
