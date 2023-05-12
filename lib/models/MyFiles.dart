import 'package:flutter/material.dart';

class CloudStorageInfo {
  final int? id;
  final String? svgSrc, title, specialist, phone, email;
  final Color? color;

  CloudStorageInfo(
      {this.id,
      this.svgSrc,
      this.title,
      this.color,
      this.specialist,
      this.email,
      this.phone});
}
