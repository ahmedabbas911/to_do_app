import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var box = Hive.box("my_task");
  var doneBox = Hive.box("done_task");
  var check = false;
  var doneTaskCheck = true;
  String name = "";

  username() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('username').toString();
    setState(() {});
    return name;
  }

  @override
  void initState() {
    super.initState;
    username();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xffF8F7FC),

      appBar: AppBar(
        title: Text(
          "Welcome $name",
          style:  TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        elevation: 0,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child:  Icon(Icons.add, size: 28),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
          ).then((value) {
            setState(() {});
          });
        },
      ),

      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Column(
            children: [

              // My Tasks Section
              Container(
                width: double.infinity,
                height: 58,
                decoration: BoxDecoration(
                  gradient:  LinearGradient(
                    colors: [
                      Color(0xffFF5A52),
                      Color(0xffF44336),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(.18),
                      blurRadius: 12,
                      offset:  Offset(0, 5),
                    ),
                  ],
                ),
                child:  Center(
                  child: Text(
                    "My Tasks",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

               SizedBox(height: 12),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: box.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin:  EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            blurRadius: 10,
                            offset:  Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding:  EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),

                        title: check
                            ? Text(
                          box.getAt(index)["title"],
                          style:  TextStyle(
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.lineThrough,
                          ),
                        )
                            : Text(
                          box.getAt(index)["title"],
                          style:  TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),

                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: 4),
                          child: Text(
                            box.getAt(index)["description"],
                            style:  TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),

                        leading: Checkbox(
                          value: check,
                          activeColor: Colors.deepPurpleAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onChanged: (value) {
                            setState(() {
                              check = !value!;

                              doneBox.add(box.getAt(index));
                              box.deleteAt(index);
                            });
                          },
                        ),

                        trailing: IconButton(
                          icon:  Icon(Icons.delete_outline),
                          onPressed: () {
                            box.deleteAt(index);
                            setState(() {});
                          },
                          color: Colors.redAccent,
                        ),
                      ),
                    );
                  },
                ),
              ),

               SizedBox(height: 12),


              Container(
                width: double.infinity,
                height: 58,
                decoration: BoxDecoration(
                  gradient:  LinearGradient(
                    colors: [
                      Color(0xff66BB6A),
                      Color(0xff43A047),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(.18),
                      blurRadius: 12,
                      offset:  Offset(0, 5),
                    ),
                  ],
                ),
                child:  Center(
                  child: Text(
                    "Done Tasks",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

               SizedBox(height: 12),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: doneBox.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin:  EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color:  Color(0xffF3FAF4),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.04),
                            blurRadius: 10,
                            offset:  Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding:  EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),

                        title: doneTaskCheck
                            ? Text(
                          doneBox.getAt(index)["title"],
                          style:  TextStyle(
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.lineThrough,
                          ),
                        )
                            : Text(
                          doneBox.getAt(index)["title"],
                          style:  TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),

                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: 4),
                          child: Text(
                            doneBox.getAt(index)["description"],
                            style:  TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),

                        leading: Checkbox(
                          value: doneTaskCheck,
                          activeColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onChanged: (value) {
                            setState(() {
                              doneTaskCheck = !value!;

                              box.add(doneBox.getAt(index));
                              doneBox.deleteAt(index);
                            });
                          },
                        ),

                        trailing: IconButton(
                          icon:  Icon(Icons.delete_outline),
                          onPressed: () {
                            doneBox.deleteAt(index);
                            setState(() {});
                          },
                          color: Colors.redAccent,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}