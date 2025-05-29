import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pomodo/Pages/circular_timer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = 'https://github.com/akira2552007';
  bool isDarkMode = false; // Dark mode toggle
  bool showTimer = false;
  String? task;
  int? time;
  final CountDownController _controller = CountDownController();
  final AudioPlayer audioPlayer = AudioPlayer();
  void _launchURL() async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Could not launch URL
      print('Could not launch $url');
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Color get backgroundColor =>
      isDarkMode ? const Color(0xFF121212) : const Color(0xffdadbdd);
  Color get primaryTextColor =>
      isDarkMode ? Colors.orange.shade300 : Colors.orange;
  Color get taskTextColor => isDarkMode ? Colors.white70 : Colors.black87;
  Color get drawerBackgroundColor =>
      isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xffdadbdd);

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      color: isDarkMode ? const Color(0xFF2A2A2A) : const Color(0xffdadbdd),
      borderRadius: BorderRadius.circular(10),
      boxShadow:
          isDarkMode
              ? [
                BoxShadow(
                  color: Colors.black87,
                  offset: const Offset(6, 6),
                  spreadRadius: 1,
                  blurRadius: 15,
                ),
                BoxShadow(
                  color: Colors.grey.shade800,
                  offset: const Offset(-6, -6),
                  spreadRadius: 1,
                  blurRadius: 15,
                ),
              ]
              : const [
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
    );
  }

  Widget buildTaskContainer() {
    return Container(
      height: 70,
      decoration: buildBoxDecoration(),
      child: Center(
        child: Text(
          '$task',
          style: TextStyle(fontSize: 20, color: taskTextColor),
        ),
      ),
    );
  }

  Widget buildNeumorphicButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 70,
      width: 70,
      decoration: buildBoxDecoration(),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: primaryTextColor, size: 30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Pomodoro Timer',
          style: TextStyle(
            color: primaryTextColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryTextColor),
      ),
      drawer: Drawer(
        backgroundColor: drawerBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: drawerBackgroundColor),
              child: Center(
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Text(
                'SET TIME',
                style: TextStyle(
                  color: primaryTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                TextEditingController timeController = TextEditingController();
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      title: Text(
                        'Set Time',
                        style: TextStyle(color: primaryTextColor),
                      ),
                      message: CupertinoTextField(
                        placeholder: 'Enter time in minutes',
                        keyboardType: TextInputType.number,
                        controller: timeController,
                        placeholderStyle: TextStyle(
                          color: primaryTextColor.withOpacity(0.5),
                        ),
                        style: TextStyle(color: primaryTextColor),
                        decoration: BoxDecoration(
                          color:
                              isDarkMode ? Colors.grey.shade800 : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.pop(context);
                            if (timeController.text.isNotEmpty) {
                              final newTime = int.tryParse(timeController.text);
                              if (newTime != null) {
                                setState(() {
                                  time = newTime;
                                  _controller.restart(duration: time! * 60);
                                });
                              }
                            }
                          },
                          child: Text(
                            'Set Time',
                            style: TextStyle(color: primaryTextColor),
                          ),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: primaryTextColor),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: Text(
                'DARK MODE',
                style: TextStyle(
                  color: primaryTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Switch(
                value: isDarkMode,
                activeColor: Colors.orange,
                onChanged: (bool value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
            ),
            SizedBox(height: 50),
            ListTile(
              leading: Text(
                'ABOUT',
                style: TextStyle(
                  color: primaryTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      title: Text(
                        'ABOUT ME',
                        style: TextStyle(color: primaryTextColor),
                      ),
                      message: RichText(
                        text: TextSpan(
                          style: TextStyle(color: primaryTextColor),
                          children: [
                            const TextSpan(
                              text:
                                  'This app is developed by [MRIDUL].\n\n'
                                  'Version: 1.0.0\n\n'
                                  'For more information, visit my GitHub profile:\n',
                            ),
                            TextSpan(
                              text: 'https://github.com/akira2552007',
                              style: const TextStyle(
                                color: CupertinoColors.activeBlue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () async {
                                      final url = Uri.parse(
                                        'https://github.com/akira2552007',
                                      );
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(
                                          url,
                                          mode: LaunchMode.externalApplication,
                                        );
                                      } else {
                                        print('Could not launch URL');
                                      }
                                    },
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        CupertinoActionSheetAction(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              if (task != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
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
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ],
                    ),
                    child: buildTaskContainer(),
                  ),
                ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 330,
                    height: 330,
                    decoration: buildBoxDecoration(),
                    child:
                        showTimer && time != null
                            ? MyWidget(controller: _controller, time: time!)
                            : const SizedBox.shrink(),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildNeumorphicButton(
                    icon: Icons.refresh_rounded,
                    onTap: () {
                      setState(() {
                        showTimer = false;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      if (task != null && time != null) {
                        setState(() {
                          showTimer = true;
                          _controller.restart(duration: time! * 60);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please add a task and time from settings.',
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            backgroundColor:
                                isDarkMode
                                    ? Colors.grey[800]
                                    : Colors.orange[100],
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 70,
                      width: 200,
                      decoration: buildBoxDecoration(),
                      child: Center(
                        child: Text(
                          'START',
                          style: TextStyle(
                            color: primaryTextColor,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  buildNeumorphicButton(
                    icon: Icons.music_note,
                    onTap: () async {
                      try {
                        await audioPlayer.setAsset(
                          'assets/ambientAudio/Arizona Dreaming.mp3',
                        );
                        await audioPlayer.play();
                      } catch (e) {
                        debugPrint('Audio Error: $e');
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 60),
              GestureDetector(
                onTap: () {
                  TextEditingController controller = TextEditingController();
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoActionSheet(
                        title: Text(
                          'Add a new task',
                          style: TextStyle(color: primaryTextColor),
                        ),
                        message: CupertinoTextField(
                          placeholder: 'Enter task here',
                          controller: controller,
                          placeholderStyle: TextStyle(
                            // ignore: deprecated_member_use
                            color: primaryTextColor.withOpacity(0.5),
                          ),
                          style: TextStyle(color: primaryTextColor),
                          decoration: BoxDecoration(
                            color:
                                isDarkMode
                                    ? Colors.grey.shade800
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                task = controller.text;
                              });
                            },
                            child: Text(
                              'Add Task',
                              style: TextStyle(color: primaryTextColor),
                            ),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: primaryTextColor),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  height: 70,
                  width: 370,
                  decoration: buildBoxDecoration(),
                  child: Center(
                    child: Text(
                      'ADD A NEW TASK',
                      style: TextStyle(color: primaryTextColor, fontSize: 30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
