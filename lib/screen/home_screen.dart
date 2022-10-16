import 'package:firebasenote/Database/local_database.dart';
import 'package:firebasenote/modul/date.dart';
import 'package:firebasenote/modul/worknote.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Note>>? dbData;
  int notComplete = 0;
  int complete = 0;

  getDataFromDatabase() async {
    dbData = MyDatabase.getAllNote();
    complete = await MyDatabase.completeTask();
    notComplete = await MyDatabase.notCompleteTask();
    setState(() {});
  }

  @override
  void initState() {
    getDataFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getDataFromDatabase();
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Note"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "${MyDate.weekday},\t\t",
                  style: MyDate.textStyle,
                ),
                Text(
                  "${MyDate.day}\t",
                  style: MyDate.textStyle,
                ),
                Text(
                  "${MyDate.month}",
                  style: MyDate.textStyle,
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("$notComplete", style: TextStyle(fontSize: 24)),
                      Text("Created Task", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("$complete", style: TextStyle(fontSize: 24)),
                      Text("Completed Task", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: FutureBuilder(
                future: dbData,
                builder: (context, ss) {
                  if (ss.hasData) {
                    List<Note> dd = ss.data as List<Note>;
                    return ListView.builder(
                      itemCount: dd.length,
                      itemBuilder: (context, i) {
                        bool check = (dd[i].isDone == "true") ? true : false;
                        return Card(
                          child: ListTile(
                            leading: Checkbox(
                              onChanged: (bool? val) {
                                if (val == true) {
                                  MyDatabase.isTaskComplete(
                                      id: dd[i].id, done: 'true');
                                } else {
                                  MyDatabase.isTaskComplete(
                                      id: dd[i].id, done: 'false');
                                }
                                setState(() {
                                  getDataFromDatabase();
                                });
                              },
                              value: check,
                            ),
                            title: Text('${dd[i].work}'),
                            trailing: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showMyUpdateDialog(dd[i].work,dd[i].id);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    showMyDeleteDialog(dd[i].id);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/create_note_screen')!.then((value) {
            getDataFromDatabase();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  showMyUpdateDialog(String editWork,int editId) {
    TextEditingController txtController = TextEditingController();
    RxInt maxLength = 0.obs;
    txtController.text = editWork;
    maxLength.value = txtController.text.length;

    return Alert(
      context: context,
      title: 'Edit data',
      content: Container(
        width: Get.width * 0.75,
        child: TextField(
          controller: txtController,
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
      ),
      buttons: [
        DialogButton(
          child: Text("Cancel"),
          color: Colors.redAccent,
          onPressed: () {
            Get.back();
          },
        ),
        DialogButton(
          child: Text("Edit"),
          color: Colors.green,
          onPressed: () async {
            if(txtController.text.length > 1){
              await MyDatabase.editData(editWork: txtController.text, id: editId);
              Get.back();
              Get.snackbar(
                'Successful',
                'Data updated successfully ... ',
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                backgroundColor: Colors.black87,
                colorText: Colors.white,
              );
            }else{
              Get.snackbar(
                'Warning',
                'Minimum length 2 or more ... ',
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                backgroundColor: Colors.black87,
                colorText: Colors.white,
              );
            }
          },
        ),
      ],
    ).show();
  }

  showMyDeleteDialog(int willDeleteID) {
    return Alert(
      context: context,
      title: "Are you sure delete this data?",
      type: AlertType.warning,
      closeIcon: null,
      buttons: [
        DialogButton(
          child: Text("No"),
          color: Colors.grey,
          onPressed: () {
            Get.back();
          },
        ),
        DialogButton(
          child: Text("Yes"),
          color: Colors.green,
          onPressed: () async {
            int res = await MyDatabase.deleteData(id: willDeleteID);
            if (res == 1) {
              Get.back();
              Get.snackbar(
                'Success',
                'Data deleted successfully ... ',
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                backgroundColor: Colors.black87,
                colorText: Colors.white,
              );
            } else {
              Get.snackbar(
                'Failed',
                'Data is not deleted ... ',
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                backgroundColor: Colors.black87,
                colorText: Colors.white,
              );
            }
            getDataFromDatabase();
          },
        ),
      ],
    ).show();
  }
}
