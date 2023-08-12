import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'homepage.dart';

class UpdatePage_Ui extends StatefulWidget {
  String? name;
  String? dec;
  String? price;
  String? drop;
  String? doc;

  UpdatePage_Ui(
      {Key? key,
      required this.name,
      required this.dec,
      required this.price,
      required this.drop,
      required this.doc})
      : super(key: key);

  @override
  State<UpdatePage_Ui> createState() => _UpdatePage_UiState();
}

class _UpdatePage_UiState extends State<UpdatePage_Ui> {
  CollectionReference user = FirebaseFirestore.instance.collection('user');

  TextEditingController name = TextEditingController();
  TextEditingController dec = TextEditingController();
  TextEditingController price = TextEditingController();

  File? file;

  String dropdownvalue = 'Low';

  // List of items in our dropdown menu
  var items = [
    'Very high',
    'High',
    'Medium',
    'Low',
  ];

  String? selectedCat;

  @override
  Widget build(BuildContext context) {
    name.text = widget.name!;
    dec.text = widget.dec!;
    price.text = widget.price!;

    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text("U P D A T E "),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    ImagePi();
                  },
                  child: Text("T A K E    I M A G E")),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: name,
                decoration: InputDecoration(
                    hintText: "N A M E ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: dec,
                decoration: InputDecoration(
                    hintText: "D E S C R I P T I O N ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: price,
                decoration: InputDecoration(
                    hintText: "P R I C E",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: DropdownButton(
              borderRadius: BorderRadius.circular(20),
              value: dropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                if (file != null) {
                  Reference reference = FirebaseStorage.instance
                      .ref("Image/${file!.path.split('/').last}");
                  print(reference);
                  await reference.putFile(file!);

                  String path = await reference!.getDownloadURL();

                  user.doc(widget.doc).update({
                    'Name': name.text,
                    'Dec': dec.text,
                    'Price': price.text,
                    'Drop': dropdownvalue,
                    'Image' : path
                  });
                }else {
                  user.doc(widget.doc).update({
                    'Name': name.text,
                    'Dec': dec.text,
                    'Price': price.text,
                    'Drop': dropdownvalue
                  });
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage_ui(),
                    ));
              },
              child: Text("U P D A T E "))
        ],
      ),
    );
  }

  ImagePi() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      file = File(image.path);

      print(file!.path);
    }
  }
}
