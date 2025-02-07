import 'package:flutter/material.dart';


class Assignment extends StatefulWidget {
  const Assignment({super.key});
  @override
  State<Assignment> createState() => _Assignment();
}

class _Assignment extends State<Assignment> {
  // Future<String?> uploadPdf(String fileName,File file) async{
  //   final refrence=FirebaseStorage.instance.ref().child("assignments/$fileName.pdf");
  //   final uploadTask =refrence.putFile(file);
  //   await uploadTask.whenComplete(() => {});
  //   final downloadLink=await refrence.getDownloadURL();
  //   return downloadLink;
  // }
  //
  // void pickFile()async{
  //   final pickedFile=FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );
  //
  //   if(pickedFile!= null){
  //     String fileName=pickedFile.files[0].name;
  //         uploadPdf(fileName, file)
  //   }
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 80,
        title: const Text(
          "Assignments",
          style: TextStyle(
            color: Colors.red,
            fontSize: 25,
          ),),
      ),
      body: const Expanded(
        child:Column(
          children: [

          ],
        ) ,
    ),
    );
  }
}