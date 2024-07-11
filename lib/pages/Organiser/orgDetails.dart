// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import 'package:image_picker/image_picker.dart';
import 'package:zero/pages/Organiser/organiserHomePage.dart';
import 'dart:io';

import 'package:zero/pages/Settings/settings.dart' as MySettings;
import 'package:zero/pages/Settings/delAcc.dart';

import 'package:zero/styles/color.dart';


class OrganiserDetails extends StatefulWidget{
  OrganiserDetails({super.key});

  @override
  State<OrganiserDetails> createState() => _OrganiserDetailsState();

}

class _OrganiserDetailsState extends State<OrganiserDetails>{

  File? _image; 

  String dropdownValue = 'Student'; 

  //current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  //all users
  final userCollection = FirebaseFirestore.instance.collection("Users");

  //future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
      .collection("Users")
      .doc(currentUser!.email)
      .get();
  }

  //edit field
  Future<void> editField(String field) async {
    String? newValue;
    
    // Check if the field being edited is "Birthday"
    if (field == 'Birthday') {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );

      if (picked != null) {
        // Convert the selected date to the yyyy-mm-dd format
        newValue = DateFormat('yyyy-MM-dd').format(picked);
        setState(() {});
      }
    } else {
      // For other fields, show a text input dialog
      newValue = await showDialog<String>(
        context: context, 
        builder: (context) => AlertDialog(
          backgroundColor: background,
          title: Text(
            "Edit $field",
            style: TextStyle(
              color: word,
            ),
          ),
          content: TextField(
            autofocus: true,
            style: TextStyle(
              color: word,
            ),
            decoration: InputDecoration(
              hintText: "Enter new $field",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontFamily: "FjallaOne",
              ),
            ),
            onChanged: (value) {
              newValue = value;
            },
          ),
          actions: [      
            //cancel button
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: word,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),

            //save button
            TextButton(
              child: Text(
                'Save',
                style: TextStyle(
                  color: word,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(newValue);
                setState(() {});
              }
            ),
          ]
        ),
      );
    }

    // Update in firestore
    if (newValue != null && newValue!.trim().isNotEmpty) {
      // Only update if there's something in the new value
      await userCollection.doc(currentUser!.email).update({field: newValue});
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: topbar,
          title: null,
          leading: IconButton(
            onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrganiserHomePage()),
            );
            },
            icon: Icon(Icons.arrow_back_ios),
            color: word,
          ),

          actions: [
            IconButton(
              onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => delAcc()),
              );
              },
              icon: Icon(Icons.delete),
              color: word,
            ),
          ],

          bottom: PreferredSize(
            preferredSize: Size.fromHeight(25),
            child: Padding(
              padding: EdgeInsets.all(5.0),

            child: Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [

                Icon(
                  Icons.account_circle,
                  size: 30,
                  color: word,
                ),
                SizedBox(width: 8.0),

                Text(
                  "Account Details",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: word,
                    fontFamily: "FjallaOne",
                  ),
                ),
              ],
            ),
            ),
          ),
        ),


          body: ListView(
            children: [
              
              //avatar
              Container(
                width: double.maxFinite, // center,
                margin: EdgeInsets.only(top:12),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius:60,
                      backgroundImage: AssetImage('assets/sadBee.png'),
                    ), 
                    SizedBox(height: 8),
                    Text(
                      "Upload / Edit Photo",
                      style: TextStyle(
                        fontSize: 11,
                        color: word,
                        wordSpacing:0, 
                        fontFamily: "FjallaOne",
                      ),
                    ),
          
                    //Full Name
                    SizedBox(height: 16),
                    Container(
                      width: 390,
                      height: 105,
                      decoration: BoxDecoration(
                        color: lightbrown,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(255, 123, 121, 119),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          //First Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Transform.translate(
                                  offset: Offset(0, 5), // Adjust the offset to lower the text
                                  child: Text(
                                  "User Name",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: word,
                                    fontFamily: "FjallaOne",
                                  ),
                                  ),
                                  ),
                                ),

                              Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Transform.translate(
                                    offset: Offset(0, 5), // Adjust the offset to lower the icon
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        size: 26,
                                      ),
                                      onPressed: () {
                                        editField('User Name');
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),

                          //Second Row
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(  
                                  width: 350,   
                                  height: 35,
                                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                    future: getUserDetails(),
                                    builder: (context, snapshot) {
                                      //loading
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      //error
                                      else if (snapshot.hasError){
                                        return Text("Error: ${snapshot.error}");
                                      }

                                      //data received
                                      else if (snapshot.hasData) {
                                        //extract data
                                        Map<String, dynamic>? user = snapshot.data!.data();

                                        return TextField(
                                          readOnly: true,
                                          controller: TextEditingController(text: user!['User Name']),
                                          maxLines: 1,
                                          textAlignVertical: TextAlignVertical.top,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "FjallaOne"
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color.fromARGB(32, 138, 112, 112),
                                            border: OutlineInputBorder()
                                          ),
                                        );
                                      }else {
                                      return Text("No data");
                                      } 
                                    }
                                  )
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    //Company Name
                    SizedBox(height: 25),
                    Container(
                      width: 390,
                      height: 105,
                      decoration: BoxDecoration(
                        color: lightbrown,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(255, 123, 121, 119),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          //First Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Transform.translate(
                                  offset: Offset(0, 12), // Adjust the offset to lower the text
                                  child: Text(
                                    "Company Name",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: word,
                                      fontFamily: "FjallaOne",
                                    ),
                                  ),
                                ),
                              ),
                              
                              Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Transform.translate(
                                    offset: Offset(0, 5), // Adjust the offset to lower the icon
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        size: 26,
                                      ),
                                      onPressed: () {
                                        editField('Company');
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),

                          //Second Row
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(  
                                  width: 350,   
                                  height: 35,
                                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                    future: getUserDetails(),
                                      builder: (context, snapshot) {
                                      //loading
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      //error
                                      else if (snapshot.hasError){
                                        return Text("Error: ${snapshot.error}");
                                      }

                                      //data received
                                      else if (snapshot.hasData) {
                                        //extract data
                                        Map<String, dynamic>? user = snapshot.data!.data();

                                        return TextField(
                                          readOnly: true,
                                          controller: TextEditingController(text: user!['Company Name']),
                                          maxLines: 1,
                                          textAlignVertical: TextAlignVertical.top,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "FjallaOne"
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color.fromARGB(32, 138, 112, 112),
                                            border: OutlineInputBorder()
                                          ),
                                        );
                                      }else {
                                      return Text("No data");
                                      } 
                                    },
                                  )
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    //Email Address
                    SizedBox(height: 25),
                    Container(
                      width: 390,
                      height: 105,
                      decoration: BoxDecoration(
                        color: lightbrown,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(255, 123, 121, 119),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          //First Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Transform.translate(
                                  offset: Offset(0, 5), // Adjust the offset to lower the text
                                  child: Text(
                                    "Email Address",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: word,
                                      fontFamily: "FjallaOne",
                                    ),
                                  ),
                                ),
                              ),
                              
                              Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Transform.translate(
                                    offset: Offset(0, 5), // Adjust the offset to lower the icon
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        size: 26,
                                      ),
                                      onPressed: () {
                                        editField('Email');
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),

                          //Second Row
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(  
                                  width: 350,   
                                  height: 35,
                                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                    future: getUserDetails(),
                                    builder: (context, snapshot) {
                                      //loading
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      //error
                                      else if (snapshot.hasError){
                                        return Text("Error: ${snapshot.error}");
                                      }

                                      //data received
                                      else if (snapshot.hasData) {
                                        //extract data
                                        Map<String, dynamic>? user = snapshot.data!.data();

                                        return TextField(
                                          readOnly: true,
                                          controller: TextEditingController(text: user!['Email']),
                                          maxLines: 1,
                                          textAlignVertical: TextAlignVertical.top,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "FjallaOne"
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color.fromARGB(32, 138, 112, 112),
                                            border: OutlineInputBorder()
                                          ),
                                        );
                                      }else {
                                      return Text("No data");
                                      } 
                                    }
                                  )
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),


                    //Password
                    SizedBox(height: 25),
                    Container(
                      width: 390,
                      height: 105,
                      decoration: BoxDecoration(
                        color: lightbrown,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(255, 123, 121, 119),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          //First Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Transform.translate(
                                  offset: Offset(0, 5), // Adjust the offset to lower the text
                                  child: Text(
                                    "Password",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: word,
                                      fontFamily: "FjallaOne",
                                    ),
                                  ),
                                ),
                              ),
                              
                              Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Transform.translate(
                                    offset: Offset(0, 5), // Adjust the offset to lower the icon
                                    child:IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        size: 26,
                                      ),
                                      onPressed: () {
                                        editField('Password');
                                      },
                                    ),
                                   ),
                                  ),
                                 )
                               ],
                              ),

                          //Second Row
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(  
                                  width: 350,   
                                  height: 35,
                                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                    future: getUserDetails(),
                                    builder: (context, snapshot) {
                                      //loading
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      //error
                                      else if (snapshot.hasError){
                                        return Text("Error: ${snapshot.error}");
                                      }

                                      //data received
                                      else if (snapshot.hasData) {
                                        //extract data
                                        Map<String, dynamic>? user = snapshot.data!.data();

                                        return TextField(
                                          readOnly: true,
                                          controller: TextEditingController(text: user!['Password']),
                                          maxLines: 1,
                                          textAlignVertical: TextAlignVertical.top,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "FjallaOne"
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color.fromARGB(32, 138, 112, 112),
                                            border: OutlineInputBorder()
                                          ),
                                        );
                                      }else {
                                      return Text("No data");
                                      } 
                                    },
                                  )
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    //Phone Number
                    SizedBox(height: 25),
                    Container(
                      width: 390,
                      height: 105,
                      decoration: BoxDecoration(
                        color: lightbrown,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(255, 123, 121, 119),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          //First Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Transform.translate(
                                  offset: Offset(0, 5), // Adjust the offset to lower the text
                                  child: Text(
                                    "Phone Number",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: word,
                                      fontFamily: "FjallaOne",
                                    ),
                                  ),
                                ),
                              ),
                              
                              Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Transform.translate(
                                    offset: Offset(0, 5), // Adjust the offset to lower the icon
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        size: 26,
                                      ),
                                      onPressed: () {
                                        editField('Phone Number');
                                      },
                                    ),
                                   ),
                                  ),
                                 )
                               ],
                              ),

                          //Second Row
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(  
                                  width: 350,   
                                  height: 35,
                                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                    future: getUserDetails(),
                                    builder: (context, snapshot) {
                                      //loading
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      //error
                                      else if (snapshot.hasError){
                                        return Text("Error: ${snapshot.error}");
                                      }

                                      //data received
                                      else if (snapshot.hasData) {
                                        //extract data
                                        Map<String, dynamic>? user = snapshot.data!.data();

                                        return TextField(
                                          readOnly: true,
                                          controller: TextEditingController(text: user!['Phone Number']),
                                          maxLines: 1,
                                          textAlignVertical: TextAlignVertical.top,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "FjallaOne"
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color.fromARGB(32, 138, 112, 112),
                                            border: OutlineInputBorder()
                                          ),
                                        );
                                      }else {
                                      return Text("No data");
                                      } 
                                    },
                                  )
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    //Birthday
                    SizedBox(height: 25),
                    Container(
                      width: 390,
                      height: 105,
                      decoration: BoxDecoration(
                        color: lightbrown,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(255, 123, 121, 119),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          //First Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Transform.translate(
                                  offset: Offset(0, 5), // Adjust the offset to lower the text
                                  child: Text(
                                    "Birthday",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: word,
                                      fontFamily: "FjallaOne",
                                    ),
                                  ),
                                ),
                              ),
                              
                              Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Transform.translate(
                                    offset: Offset(0, 5), // Adjust the offset to lower the icon
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        size: 26,
                                      ),
                                      onPressed: () {
                                        editField('Birthday');
                                      },
                                    ),
                                    ),
                                  ),
                                 )
                               ],
                              ),

                          //Second Row
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(  
                                  width: 350,   
                                  height: 35,
                                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                    future: getUserDetails(),
                                    builder: (context, snapshot) {
                                      //loading
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      //error
                                      else if (snapshot.hasError){
                                        return Text("Error: ${snapshot.error}");
                                      }

                                      //data received
                                      else if (snapshot.hasData) {
                                        //extract data
                                        Map<String, dynamic>? user = snapshot.data!.data();

                                        return TextField(
                                          readOnly: true,
                                          controller: TextEditingController(text: user!['Birthday']),
                                          maxLines: 1,
                                          textAlignVertical: TextAlignVertical.top,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "FjallaOne"
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color.fromARGB(32, 138, 112, 112),
                                            border: OutlineInputBorder()
                                          ),
                                        );
                                      }else {
                                      return Text("No data");
                                      } 
                                    },
                                  )
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    //Role
                    SizedBox(height: 25),
                    Container(
                      width: 390,
                      height: 105,
                      decoration: BoxDecoration(
                        color: lightbrown,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(255, 123, 121, 119),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          //First Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Transform.translate(
                                  offset: Offset(0, 12), // Adjust the offset to lower the text
                                  child: Text(
                                    "Role",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: word,
                                      fontFamily: "FjallaOne",
                                    ),
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(right: 25),
                              //   child: Align(
                              //     alignment: Alignment.bottomCenter,
                              //     child: Transform.translate(
                              //       offset: Offset(0, 11), // Adjust the offset to lower the icon
                              //       child: Icon(
                              //         Icons.edit,
                              //         size: 26,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),

                          //Second Row
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 340,
                                  height: 35,
                                  child: TextField(
                                    controller: null,
                                    maxLines: 1,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color.fromARGB(32, 138, 112, 112),
                                      hintText: 'Organiser',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "FjallaOne"
                                      ),
                                      border: OutlineInputBorder()
                                    ),
                                  ),
                                ),
                              ]
                            ),
                          )
                        ],
                      ),
                    ),
                    


                    //pbt
                    SizedBox(height: 25),
                      Container(
                      width: 390,
                      height: 105,
                      decoration: BoxDecoration(
                        color: lightbrown,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(255, 123, 121, 119),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          //First Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Transform.translate(
                                  offset: Offset(0, 12), // Adjust the offset to lower the text
                                  child: Text(
                                  "PBT License",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: word,
                                    fontFamily: "FjallaOne",
                                  ),
                                ),
                              ),
                            ),
                              
                            // Padding(
                            //   padding: EdgeInsets.only(right: 25),
                            //   child: Align(
                            //     alignment: Alignment.bottomCenter,
                            //     child: Transform.translate(
                            //     offset: Offset(0, 11), // Adjust the offset to lower the icon
                            //       child: Icon(
                            //         Icons.edit,
                            //         size: 26,
                            //       ),
                            //      ),
                            //     ),
                            //    )
                            ],
                          ),

                          //Second Row
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 350, 
                                  height: 36, 
                                  child: Transform.translate(
                                    offset: Offset(0, 4),
                                    //Upload Image Button
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                        if (pickedFile != null) {
                                          _image = File(pickedFile.path);
                                        }
                                      },
                                      icon: Icon(Icons.image),
                                      label: Text(
                                        'Select Image',
                                        style: TextStyle(
                                          fontFamily: "FjallaOne",
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all(Color(0xff414141))
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}

