import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Leave extends StatefulWidget {
  const Leave({super.key});
  @override
  State<Leave> createState() => _LeaveState();
}

TextEditingController _subject = TextEditingController();
TextEditingController _reason = TextEditingController();
bool file_name_visi=false;

List<String> months = <String>['jan','feb','march','april','may','june','july','august','sept','oct','nov','dec'];
String monthValue = months.first;
bool riviewApplication=false;

class _LeaveState extends State<Leave> {
  var reason;
  var subject;
  var duration;
  String detail="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appilication",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      body: Container(

        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
        // wraping the column widget for both left and right in a row widget
        child: Row(
          children: [
            // column format for the left side of elements of this page
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 25,),
                const Text("Subject :",
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
              ),
                const SizedBox(height: 30,),
                const Text("Duration :",
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30,),
                const Text("Reason :",
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 190,),
                const Text("Attachment :",
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40,),
                const Text(" Recheck:",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 10,color:Colors.red,fontWeight: FontWeight.bold),
                ),
                Checkbox(
                    value: riviewApplication,
                    tristate: false,
                    onChanged: (newbool){
                      setState(() {
                        riviewApplication=newbool!;
                      });
                    })
              ],
            ),
            const SizedBox(width: 15,),
            // column widget for the right side of the widget that is there for the view and for design
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _subject,
                      autocorrect: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        hintText: "Subject-for-application",
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DropdownButton(
                        value: monthValue,
                        elevation: 0,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        menuMaxHeight: 175,
                        dropdownColor: Colors.lightGreenAccent[400],
                        autofocus: true,
                        focusColor: Colors.green,
                        style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        items:months
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            print(value);
                            monthValue=value!;
                          });
                        },
                      ),

                      const SizedBox(width: 10,),
                      Text(DateTime.now().year.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _reason,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: " Reason ",
                          hintStyle: TextStyle(color: Colors.grey,),
                          alignLabelWithHint: true
                        ),
                        maxLines: null,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(fixedSize: WidgetStatePropertyAll(Size(100,15)),elevation: WidgetStatePropertyAll(0.0)),
                      onPressed: () async {
                        final result=await FilePicker.platform.pickFiles(allowMultiple: false);
                        if (result == null) return;
                        detail=result.files.first.name;
                        file_name_visi=true;
                        setState(() {
                        });
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Upload"),
                          SizedBox(width: 5,),
                          Icon(Icons.upload_outlined,size: 18,)
                        ],
                      )),
                  Visibility(
                    visible: file_name_visi,
                    child: Row(
                      children: [
                        Text(
                          detail,
                          style: const TextStyle(color: Colors.red,),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 55,),
                  const Text(
                      "kindly check the information before sending it to the admin",
                      style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold)
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          style: const ButtonStyle(
              fixedSize: WidgetStatePropertyAll(
                  Size(250, 30)
              )
          ),
          onPressed: (){
            if (riviewApplication==false){
              showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      content: const Text("check the details and click on checkbox before submitting the form"),
                      elevation: 10,
                      actions: [
                        MaterialButton(onPressed: () => Navigator.pop(context),child: const Text("OK"),)
                      ],
                    );
                  });
            }
            else if(riviewApplication!=false){
              AwesomeNotifications().createNotification(
                  content: NotificationContent(
                      id: 1,
                      channelKey: "testing",
                      title: "Application",
                      body: "Application was sent successfully to the admin you will get the notification regarding submission later\n kindly stay tuned"
                  ));
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context){
                    return const AlertDialog(
                      content: Text("Application submitted successfully"),
                      elevation: 10,
                      actions: [
                        Text("Thank You 😊😊😊",textAlign: TextAlign.start),
                        // MaterialButton(
                        //   onPressed: () => Navigator.pop(context),
                        //   color: Colors.grey,
                        //   child: const Text("OK"),)
                      ],
                    );
                  });
            }
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Submit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
              SizedBox(width: 10,),
              Icon(Icons.save),
            ],
          ),
        ),
    );
  }
}
