import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pomodo/Pages/circular_timer.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CountDownController _controller = CountDownController();
  String? task;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdadbdd),
      body: Stack(
        children: [
          if (task != null)
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 35, right: 35),
              child: Slidable(
                key: ValueKey(task),
                endActionPane: ActionPane(
                  motion: BehindMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        setState(() {
                          task = null; // Deletes the task
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Color(0xffdadbdd),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-6, -6),
                        spreadRadius: 1,
                        blurRadius: 15,
                      ),
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(6, 6),
                        spreadRadius: 1,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '$task',
                      style: TextStyle(fontSize: 20, color: Colors.black87),
                    ),
                  ),
                ),
              ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 450,
                    height: 400,
                    decoration: BoxDecoration(
                      color: const Color(0xffdadbdd),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-6, -6),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(6, 6),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: MyWidget(controller: _controller),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xffdadbdd),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-6, -6),
                          spreadRadius: 1,
                          blurRadius: 15,
                        ),
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(6, 6),
                          spreadRadius: 1,
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.refresh_rounded,
                          color: Colors.orange,
                          size: 30,
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 70,
                      width: 200,

                      decoration: BoxDecoration(
                        color: Color(0xffdadbdd),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-6, -6),
                            spreadRadius: 1,
                            blurRadius: 15,
                          ),
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(6, 6),
                            spreadRadius: 1,
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'START',
                          style: TextStyle(color: Colors.orange, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: 70,

                    decoration: BoxDecoration(
                      color: const Color(0xffdadbdd),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-6, -6),
                          spreadRadius: 1,
                          blurRadius: 15,
                        ),
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(6, 6),
                          spreadRadius: 1,
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.orange,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  GestureDetector(
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController controller =
                              TextEditingController();

                          return CupertinoActionSheet(
                            title: Text('Add a new task'),
                            message: CupertinoTextField(
                              placeholder: 'Enter task here',
                              controller: controller,
                            ),
                            actions: [
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                  print('New task added: $task');
                                  setState(() {
                                    task = controller.text;
                                  });
                                },
                                child: Text('Add Task'),
                              ),
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                          );
                        },
                      );
                    },

                    child: Container(
                      height: 70,
                      width: 400,
                      decoration: BoxDecoration(
                        color: const Color(0xffdadbdd),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-6, -6),
                            spreadRadius: 1,
                            blurRadius: 15,
                          ),
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(6, 6),
                            spreadRadius: 1,
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'ADD A NEW TASK',
                          style: TextStyle(color: Colors.orange, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
