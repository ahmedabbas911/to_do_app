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
      appBar: AppBar(
        title: Text("Welcome $name" ,style: TextStyle(
          fontWeight:FontWeight.bold,
          fontSize: 30,
          color: Colors.white
        ),),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,

      ),

      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurpleAccent,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTask()),
            ).then((value) {
              setState(() {});
            });
          },
        ),

      body: Column(
        children: [

             Expanded(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Text("My Task" ,style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white
                        ),),
                      )
                  ),

                  SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(

                          title: check
                              ? Text(
                            box.getAt(index)["title"],
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                            ),
                          )
                              : Text(box.getAt(index)["title"]),

                          subtitle: Text(box.getAt(index)["description"]),

                          leading: Checkbox(
                            value: check,
                            onChanged: (value) {
                              setState(() {
                                check = !value!;

                                doneBox.add(box.getAt(index));
                                box.deleteAt(index);
                              });
                            },
                          ),

                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              box.deleteAt(index);
                              setState(() {});
                            },
                            color: Colors.red,
                          ),

                        );
                      },
                    ),
                  ),
                ],
              ),
            ),


          Expanded(
            child: Column(
              children: [

                Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(400),
                    ),
                    child: Center(
                      child: Text("Done Task" ,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white
                      ),),
                    )
                ),

                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 280,
                  child: ListView.builder(
                    itemCount: doneBox.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: doneTaskCheck
                            ? Text(
                          doneBox.getAt(index)["title"],
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                          ),
                        )
                            : Text(doneBox.getAt(index)["title"]),
                        subtitle: Text(doneBox.getAt(index)["description"]),
                        leading: Checkbox(
                          value: doneTaskCheck,
                          onChanged: (value) {
                            setState(() {
                              doneTaskCheck = !value!;

                              box.add(doneBox.getAt(index));
                              doneBox.deleteAt(index);
                            });
                          },
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            doneBox.deleteAt(index);
                            setState(() {});
                          },
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
