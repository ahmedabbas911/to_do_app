import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../widgets/Text_field_Widgets.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var box = Hive.box("my_task");
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text("Add Task", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25
          ),),
          centerTitle: true,
        ),

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [

                SizedBox(height: 20),

                TextfieldWidgets(
                  controller: titleController,
                  vali: 'Please enter a title',
                  hint: 'Task Title',
                ),

                SizedBox(height: 20),

                TextfieldWidgets(
                  controller: descriptionController,
                  vali: 'Please enter a description',
                  hint: 'Task Description',
                ),

                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      var taskData = {
                        "title": titleController.text,
                        "description": descriptionController.text,
                      };
                      box.add(taskData);
                      titleController.clear();
                      descriptionController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add Task'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    fixedSize: Size(MediaQuery
                        .of(context)
                        .size
                        .width, 50),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
