import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class InsertPage extends StatefulWidget {
  const InsertPage({Key? key}) : super(key: key);

  @override
  State<InsertPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text("I N S E R T "),
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

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () async {
              Reference? reference;
              if(file!=null){
                 reference = FirebaseStorage.instance.ref("Image/${file!.path.split('/').last}");
                print(reference);
               await reference.putFile(file!);
              }
              String path =await reference!.getDownloadURL();
             await user.add({
                'Name' : name.text,
                'Dec' : dec.text,
                'Price' : price.text,
                'Drop' : dropdownvalue,
                'Image' : path
              });
              print("Name : ${name.text}");
              print("Dec : ${dec.text}");
              print("Price : ${price.text}");
              print("Drop : ${dropdownvalue}");
              print("Image : ${path}");


              Navigator.pop(context);
            }, child: Text(" P R E S S ")),
          )
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
