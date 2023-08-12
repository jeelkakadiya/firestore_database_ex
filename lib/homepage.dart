import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:newtask/updatepage.dart';
import 'insertpage.dart';

class Homepage_ui extends StatefulWidget {
  const Homepage_ui({Key? key}) : super(key: key);

  @override
  State<Homepage_ui> createState() => _Homepage_uiState();
}

class _Homepage_uiState extends State<Homepage_ui> {
  String? selectC;

  List? textdata = ['Very high', 'High', 'Medium', 'Low'];

  CollectionReference user = FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text("H O M E P A G E"),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            child: ListView.builder(
              itemCount: textdata!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {

    if(selectC == textdata![index])
      {
        selectC=null;
      }
    else
      {
        selectC = textdata![index];
      }
                    //selectC = textdata![index];
                    setState(() {});
                  },
                  child: Container(
                    width: 100,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(35)),
                    child: Card(
                        color: Colors.white38,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          textdata![index],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                  ),
                );
              },
            ),
          ),
          StreamBuilder(
            stream: selectC != null
                ? user.where("Drop", isEqualTo: selectC).snapshots()
                : user.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(
                    "********************E R R O R*********************");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              print(snapshot.data!.docs.length);

              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var item = snapshot.data!.docs[index].data() as Map;
                    return Card(
                      color: item['Drop'] == "Very high"
                          ? Colors.redAccent
                          : item['Drop'] == "High"
                              ? Colors.orangeAccent
                              : item['Drop'] == "Medium"
                                  ? Colors.yellowAccent
                                  : Colors.lightGreen,
                      child: ListTile(
                        leading: Image.network(item['Image']),
                        trailing: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UpdatePage_Ui(
                                              doc:
                                                  ("${snapshot.data!.docs[index].id}"),
                                              drop: ("${item['Drop']}"),
                                              name: ("${item['Name']}"),
                                              dec: ("${item['Dec']}"),
                                              price: ("${item['Price']}"),
                                            ),
                                          ));
                                    },
                                    icon: Icon(Icons.edit,)),
                                IconButton(
                                    onPressed: () {
                                      user
                                          .doc(snapshot.data!.docs[index].id)
                                          .delete();
                                    },
                                    icon: Icon(Icons.delete)),
                              ],
                            ),
                            Expanded(
                              child: Row(mainAxisSize: MainAxisSize.min,
                                children: [
                                  LikeButton(size: 19,)
                                ],
                              ),
                            )
                          ],
                        ),

                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("NAME : ${item["Name"]}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                          ],
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("DESC  : ${item["Dec"]}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("PRICE  : ${item["Price"]}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                            ]),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InsertPage(),
                ));
          },
          child: Icon(Icons.add)),
    );
  }
}
