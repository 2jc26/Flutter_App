import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  final List<File> images;

  const ImageSelector({super.key, required this.images});

  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {

  List<File>? _images;

  // Function to handle image selection from gallery
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _images!.add(File(pickedFile.path));
      });
    }
  }

  @override
  void initState() {
    _images = widget.images;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius:
                const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _images!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(_images![index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () =>
                  _pickImage(ImageSource.camera),
              child: const Text('Take Photo'),
            ),
            ElevatedButton(
              onPressed: () =>
                  _pickImage(ImageSource.gallery),
              child: const Text('Choose Photo'),
            ),
          ],
        ),
      ],
    );
  }
  
}