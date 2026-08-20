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
      backgroundColor:   Color(0xffF8F7FC),

      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        elevation: 0,
        title:   Text(
          "Add Task",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                  Text(
                  'Create a new task',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2D2438),
                  ),
                ),

                  SizedBox(height: 8),

                  Text(
                  'Add the details below and stay organized.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                  SizedBox(height: 32),

                  Text(
                  'Task Title',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff2D2438),
                  ),
                ),

                  SizedBox(height: 8),

                TextfieldWidgets(
                  controller: titleController,
                  vali: 'Please enter a title',
                  hint: 'Enter task title',
                ),

                  SizedBox(height: 24),

                  Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff2D2438),
                  ),
                ),

                  SizedBox(height: 8),

                TextfieldWidgets(
                  controller: descriptionController,
                  vali: 'Please enter a description',
                  hint: 'Enter task description',
                ),

                  SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
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

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),

                    child:   Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_task),
                        SizedBox(width: 10),
                        Text(
                          'Add Task',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}