import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constance/colors.dart';

class AddUsers extends StatelessWidget {
   AddUsers({super.key});

  final CollectionReference donor =
  FirebaseFirestore.instance.collection("donor");

  final donorname = TextEditingController();

  final donorphone = TextEditingController();

  final BloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  void Addonor(){
    final data = {"name": donorname.text, "phone number":donorphone.text ,"bloodgroup":selectedGroup,};
    donor.add(data);
  }

  String? selectedGroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tdBlue,
        title: const Text(
          "Add Donor Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(

          children: [
             Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: donorname,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Donor Name"),
                ),
              ),
            ),
             Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: donorphone,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Donor's Phone Number"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                  decoration:
                      InputDecoration(label: Text("Select Blood Group")),
                  items: BloodGroups.map((e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      )).toList(),
                  onChanged: (val) {
                    selectedGroup = val as String;
                  }),
            ),
            SizedBox(height: 150,),
            ElevatedButton(
              onPressed: () {
                Addonor();
                Navigator.pop(context);

              },
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white,fontSize: 25),
              ),
              style: ButtonStyle(

                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 50),),
                backgroundColor: MaterialStateProperty.all(tdBlue),

              ),
            )
          ],
        ),
      ),
    );
  }
}
