import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_panning/profile_screen.dart';
import 'package:image_picker/image_picker.dart';

class CustomizedScreen extends StatefulWidget {
  CustomizedScreen({super.key, required this.profileImage});
  String profileImage;
  @override
  State<CustomizedScreen> createState() => _CustomizedScreenState();
}

class _CustomizedScreenState extends State<CustomizedScreen> {
  final dio = Dio();
  final String endPoint = 'https://dev.elred.io/postProfileBannerImage';
  File? imageFile;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customized Card"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            color: Colors.blue[100],
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: TextButton(
              onPressed: () {
                showImagePicker(context);
              },
              child: const Text('Change Photo'),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Stack(
            children: [
              imageFile == null
                  ? Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: Image.network(
                        widget.profileImage,
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    )
                  : Image.file(
                      imageFile!,
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage("assets/me.png"),
                          ),
                          Positioned(
                              bottom: 10,
                              right: -20,
                              child: RawMaterialButton(
                                onPressed: () {},
                                elevation: 2.0,
                                fillColor: const Color(0xFFF5F6F9),
                                padding: const EdgeInsets.all(10.0),
                                shape: const CircleBorder(),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Sridhar G",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Visakhapatnam",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Software Engineer",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Bangalore",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            // height: 100, //height of button
            width: 300, //width of button
            child: imageFile != null
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
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
                        ? const Text("Save")
                        : const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              // backgroundColor: Colors.black26,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white, //<-- SEE HERE
                              ),
                            ),
                          ),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()),
                      );
                    },
                    child: !_isLoading
                        ? const Text("Save")
                        : const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              // backgroundColor: Colors.black26,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white, //<-- SEE HERE
                              ),
                            ),
                          ),
                  ),
          ),
        ],
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
      }
    });
  }

  _imgFromCamera() async {
    await picker
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
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
