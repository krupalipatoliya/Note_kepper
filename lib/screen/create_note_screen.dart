import 'package:firebasenote/Database/local_database.dart';
import 'package:firebasenote/modul/worknote.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNoteScreen extends StatelessWidget {

  TextEditingController textEditingController = TextEditingController();
  RxInt maxLength = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Note"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: textEditingController,
              maxLength: 40,
              cursorColor: Colors.deepOrange,
              onChanged: (val) {
                if (val.length <= 40) {
                  maxLength.value = val.length;
                }
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.note,
                  color: Colors.deepOrange,
                ),
                hintText: "Write Note",
                counter: Obx(
                  () => Text("${maxLength.value}/40"),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange),
                ),
                focusColor: Colors.deepOrange,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(Get.width / 3, 50),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Note note =
                        Note(work: textEditingController.text, isDone: 'false');
                    await MyDatabase.insertDB(note);
                    await Future.delayed(Duration(seconds: 2),(){
                      print("Delay is called");
                    });
                    Get.back();
                    Get.snackbar(
                      'Success',
                      'Data added successfully ... ',
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      backgroundColor: Colors.black87,
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(Get.width / 3, 50),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text("Create"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}