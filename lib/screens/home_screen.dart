import 'package:blood_donation_app/constance/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final CollectionReference donor =
      FirebaseFirestore.instance.collection("donor");

  void deleteDonor(docId){
    donor.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: tdBlue,
          title: const Text(
            "Blood Donation App",
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
            backgroundColor: tdBlue,
            child: const Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: StreamBuilder(
            stream: donor.orderBy('name').snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Error loading data'));
              }
              if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
                return const Center(child: Text('No donors found'));
              }
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot donorsnap =
                            snapshot.data.docs[index];
                        return ListTile(
                          tileColor: tdBGColor,
                          leading: CircleAvatar(
                            radius: 30,
                            child: Text(
                              donorsnap['bloodgroup'],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(donorsnap['name'],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          subtitle: Text(donorsnap['phone number'].toString(),
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/update",arguments: {
                                    'name': donorsnap['name'],
                                    'phone': donorsnap['phone number'].toString(),
                                    'group': donorsnap['bloodgroup'],
                                    'id': donorsnap.id,
                                  });

                                },
                                icon: Icon(Icons.edit,size: 30,color: tdGray,),
                              ),
                              IconButton(
                                onPressed: () {
                                 deleteDonor(donorsnap.id);

                                },
                                icon: Icon(Icons.delete,size: 30,color: tdRed,),
                              ),
                            ],
                          ),
                        );
                      }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 20,); },),
                );
              }
              return Container();
            }));
  }
}




