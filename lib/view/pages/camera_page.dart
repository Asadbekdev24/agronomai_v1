import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_agronom_ai/viewmodel/image_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImagePickerPage extends StatelessWidget {
  ImagePickerPage({super.key});
  final ImagePicker _picker = ImagePicker();

  void _pickImage(BuildContext context, ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final provider = context.read<ImageUploadProvider>();
      provider.setImage(File(pickedFile.path));
      await provider.uploadImage();
      await provider.getDatawithImage(provider.filePath);
      provider.getPredictData();
    }
  }

  void _showImageSourceDialod(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Rasm yuklash"),
          content: Text("Qayerdan rasm yuklamoqchisiz?"),
          actions: [
            TextButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  _pickImage(context, ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text("Kamera")),
            TextButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                _pickImage(context, ImageSource.gallery);
              },
              label: Text("Galereya"),
              icon: Icon(Icons.photo_library),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff1eee7),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 115, 207, 120),
          title: Text(
            "Rasm yuklash",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Consumer<ImageUploadProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (provider.image == null) {
                return Center(
                  child: Text(
                    "Rasm yuklanmagan, pastdagi add tugmasini bosib rasm yuklang va tez orada ma'lumot beriladi",
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (provider.isPredicting) {
                return Center(
                  child: Text("Malumotlar yuklanmoqda"),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.file(
                        provider.image!,
                        height: 200,
                        width: 200,
                      ),
                    ),
                    //Image.file(provider.image!),
                    Text("Hashorat nomi: ${provider.malumot!['name_uz']}"),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Tavsifi: ${provider.malumot!['description']}",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text("Yaratilgan sana: ${provider.createData}"),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showImageSourceDialod(context);
            //context.read<ImageUploadProvider>();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
