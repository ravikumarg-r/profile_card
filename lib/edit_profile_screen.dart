import 'package:flutter/material.dart';
import 'package:image_panning/customized_screen.dart';
import 'package:image_panning/profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key, required this.profImg});
  String profImg;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Image Card"),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              widget.profImg != null
                  ? Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: Image.network(
                        widget.profImg,
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      'assets/4.jpeg',
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
              Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(right: 20, top: 10),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text(
                    "Customize",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CustomizedScreen(profileImage: widget.profImg)),
                    );
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
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
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Visakhapatnam",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            // height: 100, //height of button
            width: 300, //width of button
            child: OutlinedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
              child: const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
