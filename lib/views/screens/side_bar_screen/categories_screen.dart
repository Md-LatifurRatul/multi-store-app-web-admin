import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_multi_store_web_admin/views/screens/widgets/banner_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  static const String routeName = '\CategoriesScreen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SupabaseClient _supabase = Supabase.instance.client;
  final TextEditingController _categoryEditingController =
      TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  dynamic _image;

  String? fileName;

  Future<void> _pickImage() async {
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

  Future _uploadCategoryBannerStorage(Uint8List image) async {
    try {
      final String path = 'categoryImages/$fileName';

      await _supabase.storage.from('storage_bucket').uploadBinary(
            path,
            image,
          );

      final imageUrl =
          _supabase.storage.from('storage_bucket').getPublicUrl(path);

      return imageUrl;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
  }

  Future _upLoadCategory() async {
    try {
      EasyLoading.show();
      if (_formKey.currentState!.validate()) {
        String? imageUrl = await _uploadCategoryBannerStorage(_image);

        await _firestore.collection('categories').doc(fileName).set({
          'image': imageUrl,
          'categoryName': _categoryEditingController.text.trim(),
        }).whenComplete(() {
          EasyLoading.dismiss();
          _image = null;
          _categoryEditingController.clear();

          setState(() {});
        });
      } else {
        print('selecting image error');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Category',
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
                                child: Text('Category'),
                              ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      BannerButton(
                        text: 'Upload Image',
                        onPressed: () {
                          _pickImage();
                        },
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    width: 180,
                    child: TextFormField(
                      controller: _categoryEditingController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Category Name Must not be empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter Category Name',
                        hintText: 'Enter Category Name',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                BannerButton(
                  text: 'Save',
                  onPressed: () {
                    _upLoadCategory();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _categoryEditingController.dispose();
    super.dispose();
  }
}
