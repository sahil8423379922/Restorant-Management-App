import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyImagePicker extends StatefulWidget {
  const MyImagePicker(
      {Key? key,
      this.maxImageWidth,
      this.maxImageHeight,
      required this.uploadType,
      required this.child,
      this.onImageSelected})
      : super(key: key);

  final double? maxImageWidth, maxImageHeight;
  final Widget child;
  final ValueChanged<File>? onImageSelected;
  final ImageSource uploadType;

  @override
  State<MyImagePicker> createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    var size2 = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          getImage(widget.uploadType);
        },
        child: Container(
            width: size2.width * 0.150,
            height: size2.height * 0.150,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: widget.child));
  }

  getImage(ImageSource src) async {
    // ignore: invalid_use_of_visible_for_testing_member
    final img = await ImagePicker().pickImage(
        source: src,
        maxHeight: widget.maxImageHeight ?? 200,
        maxWidth: widget.maxImageWidth ?? 200);
    if (img == null) {
      return;
    }
    final images = File(img.path);

    setState(() {
      imageFile = images;
      widget.onImageSelected!(images);
    });
  }
}
