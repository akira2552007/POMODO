import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pomodo/Pages/circular_timer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              if (task != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Slidable(
                    key: ValueKey(task),
                    endActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            setState(() {
                              task = null;
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
                      margin: const EdgeInsets.only(bottom: 20),
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
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '$task',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    height: 350,
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
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _iconContainer(icon: Icons.refresh_rounded, onPressed: () {}),
                  _textButton(label: 'START', onTap: () {}, width: 200),
                  _iconContainer(
                    icon: Icons.arrow_forward_ios_rounded,
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _textButton(
                label: 'ADD A NEW TASK',
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController controller =
                          TextEditingController();
                      return CupertinoActionSheet(
                        title: const Text('Add a new task'),
                        message: CupertinoTextField(
                          placeholder: 'Enter task here',
                          controller: controller,
                        ),
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                task = controller.text;
                              });
                            },
                            child: const Text('Add Task'),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      );
                    },
                  );
                },
                width: 400,
              ),
              const SizedBox(height: 20),
              _textButton(label: 'ADD TIME', onTap: () {}, width: 400),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconContainer({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
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
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.grey, size: 30),
        ),
      ),
    );
  }

  Widget _textButton({
    required String label,
    required VoidCallback onTap,
    required double width,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: width,
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
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
