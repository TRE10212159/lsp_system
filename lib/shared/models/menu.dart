import 'package:flutter/cupertino.dart';

class MenuItem {
  final Widget? prefix;
  final Widget? suffix;
  final String title;
  final String value;
  final Color? color;
  final Color? background;
  const MenuItem({
    required this.title,
    required this.value,
    this.prefix,
    this.suffix,
    this.color,
    this.background,
  });
}
