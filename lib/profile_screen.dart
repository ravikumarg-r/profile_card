import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_panning/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final dio = Dio();
  String profileImg = "";
  final result = [];
  void getBannerImages() async {
    final response =
        await dio.post('https://dev.elred.io/selectedCardDesignDetails',
            data: {"cardImageId": "6300ba8b5c4ce60057ef9b0c"},
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization":
                  "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiclhnY1Y2YXh3eVRobTNQdE04aGtSaXJTQ2ZsMiIsImlhdCI6MTY5NTIzMTc5MSwiZXhwIjoxNjk2NTI3NzkxfQ.9W-QURjNQWAtZIqzYB3-yvJWeCayXvojHcIRmjpVD4A"
            }));
    // response.data['result'];
    for (var profImage in response.data['result']) {
      setState(() {
        profileImg =
            profImage['customImageCardDesignInfo']['profileBannerImageURL'];
      });

      print(profImage['customImageCardDesignInfo']['profileBannerImageURL']);
    }
  }

  @override
  void initState() {
    getBannerImages();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Artist"),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              profileImg.isEmpty
                  ? Image.asset(
                      'assets/4.jpeg',
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      profileImg,
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
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
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Text(
                      "Visakhapatnam",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Software Engineer",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Text(
                      "Bangalore",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          color: const Color.fromARGB(255, 69, 61, 61),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.sledding,
                                color: Colors.white,
                              ))),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          color: const Color.fromARGB(255, 69, 61, 61),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.mail,
                                color: Colors.white,
                              ))),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          color: const Color.fromARGB(255, 69, 61, 61),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.phone,
                                  color: Colors.white))),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        color: const Color.fromARGB(255, 69, 61, 61),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.location_city_sharp,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        color: const Color.fromARGB(255, 69, 61, 61),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.work_outlined,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
          SizedBox(
            // height: 100, //height of button
            width: 300, //width of button
            child: OutlinedButton(
              style: ElevatedButton.styleFrom(
                // backgroundColor: Colors.red,
                foregroundColor: Colors.red,
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditProfileScreen(profImg: profileImg)),
                );
              },
              child: const Text("Edit Card"),
            ),
          ),
          // Container(
          //   width: 100,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.teal,
          //       foregroundColor: Colors.white,
          //       shape: const BeveledRectangleBorder(
          //           borderRadius: BorderRadius.all(Radius.circular(5))),
          //     ),
          //     onPressed: () {},
          //     child: const Text("Save"),
          //   ),
          // ),
        ],
      ),
    );
  }
}
