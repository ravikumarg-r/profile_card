import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_panning/profile_screen.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dio = Dio();
  final String endPoint = 'https://dev.elred.io/postProfileBannerImage';
  bool noImage = false;
  bool _isLoading = false;
  // Method 1

  File? imageFile;
  // String state = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Select & Crop Image'),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            imageFile == null
                ? Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    color: Colors.blue[100],
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: TextButton(
                      onPressed: () {
                        showImagePicker(context);
                      },
                      child: const Text(
                        'Upload picture',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                : Image.file(
                    imageFile!,
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width * 0.95,
                    fit: BoxFit.fill,
                  ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child: const Text("Picture ready to be saved"),
            ),
            const SizedBox(
              height: 30,
            ),
            noImage
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        String filename = imageFile!.path.split('/').last;
                        FormData data = FormData.fromMap({
                          "profileBannerImageURL": await MultipartFile.fromFile(
                              imageFile!.path,
                              filename: filename,
                              contentType: MediaType('image', 'jpeg')),
                        });
                        Dio dio = Dio();
                        Response response = await dio.post(endPoint,
                            data: data,
                            options: Options(headers: {
                              "accept": "*/*",
                              "Authorization":
                                  "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiclhnY1Y2YXh3eVRobTNQdE04aGtSaXJTQ2ZsMiIsImlhdCI6MTY5NTIzMTc5MSwiZXhwIjoxNjk2NTI3NzkxfQ.9W-QURjNQWAtZIqzYB3-yvJWeCayXvojHcIRmjpVD4A",
                              "Content-Type": "multipart/form-data"
                            }));

                        // Map<String, dynamic> userMap = jsonDecode(response.data);
                        // var user = ImageModel.fromJson(userMap);
                        print(response.data['result']);

                        // print(result.uid as String);
                        // print(response.statusCode == 200 && );
                        if (response.data['message'] ==
                            "Uploaded Profile Banner Image successfully") {
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileScreen()),
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: !_isLoading
                        ? const Text(
                            'Save & Continue',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        : const CircularProgressIndicator(
                            // backgroundColor: Colors.black26,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white, //<-- SEE HERE
                            ),
                          ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  final picker = ImagePicker();

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                              // color: Colors.amber.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.image,
                              // size: 50.0,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          const Text(
                            "Gallery",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.pop(context);
                      },
                    )),
                    Expanded(
                        child: InkWell(
                      child: SizedBox(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                // color: Colors.amber.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                // size: 50.0,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            const Text(
                              "Camera",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.pop(context);
                      },
                    ))
                  ],
                )),
          );
        });
  }

  _imgFromGallery() async {
    await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
        noImage = true;
      } else {
        noImage = false;
      }
    });
  }

  _imgFromCamera() async {
    await picker
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
        noImage = true;
      } else {
        noImage = false;
      }
    });
  }

  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Image Cropper",
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        imageFile = File(croppedFile.path);
      });
      // reload();
    }
  }
}
