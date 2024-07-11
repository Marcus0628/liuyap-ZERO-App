// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:zero/pages/Organiser/organiserHomePage.dart';
import 'package:zero/pages/Welcome/survey.dart';

import 'package:zero/styles/button.dart';
import 'package:zero/styles/color.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:file_picker/file_picker.dart';

class pbtLicense extends StatefulWidget {
  const pbtLicense({super.key});

  @override
  State<pbtLicense> createState() => _pbtLicenseState();
}

class _pbtLicenseState extends State<pbtLicense> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');

    setState(() {
      uploadTask = null;
    });
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          backgroundColor: background,
          appBar: AppBar(backgroundColor: topbar, leading: BackButton()),
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
              children: [
                SizedBox(height: 35),
                Text('Please provide your PBT license',
                    style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'FjallaOne',
                        color: Color(0xff414141))),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 260,
                  width: 270,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                        side: BorderSide(width: 2, color: Colors.black)),
                    child: Stack(
                      children: [
                        // Image.asset as background
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Image.asset(
                            'assets/Upload.png',
                            height: 300,
                            width: 310,
                          ),
                        ),
                        if (pickedFile != null)
                          Container(
                            height: 275,
                            width: 340,
                            color: Colors.white,
                            child: Center(
                              child: Image.file(
                                File(pickedFile!.path!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        style: uploadButton,
                        child: const Text('Choose Image',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'FjallaOne',
                                color: Color(0xff414141))),
                        onPressed: selectFile),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: uploadButton,
                    child: const Text('Upload Image',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'FjallaOne',
                            color: Color(0xff414141))),
                    onPressed: uploadFile),
                SizedBox(height: 20,),
                buildProgress(),
                SizedBox(height: 20,),
                ElevatedButton(
                  style: buttonPrimary,
                  child: const Text('Continue',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'FjallaOne',
                          color: Color(0xff414141))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrganiserHomePage()),
                    );
                  },
                ),
              ],
            ),
          )),
        ),
      );

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          if (progress.isFinite) {
            return SizedBox(
                height: 30,
                width: 325,
                child: Stack(fit: StackFit.expand, children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  Center(
                      child: Text(
                    '${(100 * progress).roundToDouble()}%',
                    style: const TextStyle(color: Colors.white),
                  ))
                ]));
          } else {
            return const SizedBox(height: 50);
          }
        } else {
          return const SizedBox(height: 50);
        }
      });
}
