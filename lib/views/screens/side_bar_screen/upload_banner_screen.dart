import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_multi_store_web_admin/views/screens/widgets/banner_button.dart';
import 'package:ecom_multi_store_web_admin/views/screens/widgets/banner_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadBannerScreen extends StatefulWidget {
  const UploadBannerScreen({super.key});
  static const String routeName = '\UploadBannerScreen';

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  dynamic _image;
  String? fileName;

  final SupabaseClient _supabase = Supabase.instance.client;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      _image = result.files.first.bytes;
      fileName = result.files.first.name;
      setState(() {});
    }
  }

  Future<String?> _uploadFile(Uint8List image) async {
    try {
      if (image.isEmpty) {
        throw 'Image data is empty';
      }

      final String path = 'Banners/$fileName';

      await _supabase.storage.from('storage_bucket').uploadBinary(
            path,
            image,
          );

      final fileUrl =
          _supabase.storage.from('storage_bucket').getPublicUrl(path);
      // print(fileUrl);

      return fileUrl;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
    return null;
  }

  Future _uploadToFireStore() async {
    String? imageUrl = await _uploadFile(_image);
    EasyLoading.show();

    if (imageUrl != null) {
      await _firestore.collection('banners').doc(fileName).set({
        'image': imageUrl,
      }).whenComplete(() {
        EasyLoading.dismiss();
        _image = null;
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Banners',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          border: Border.all(color: Colors.grey.shade800),
                          borderRadius: BorderRadius.circular(10)),
                      child: _image != null
                          ? Image.memory(
                              _image,
                              fit: BoxFit.cover,
                            )
                          : const Center(
                              child: Text('Banners'),
                            ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BannerButton(
                      text: 'Upload Image',
                      onPressed: () {
                        pickImage();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              BannerButton(
                text: 'Save',
                onPressed: () {
                  _uploadToFireStore();
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Banners',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          BannerWidget(),
        ],
      ),
    );
  }
}
