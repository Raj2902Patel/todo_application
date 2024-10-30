import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/common/show_model.dart';
import 'package:todo_app/provider/service_provider.dart';
import 'package:todo_app/widget/card_task.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends ConsumerStatefulWidget {
  HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isLoading = true;

  final Uri _url = Uri.parse('https://www.linkedin.com/in/raj2902patel');

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false; // Update the loading state after 3 seconds
      });
    });
  }

  Future<bool> something() async {
    await Future.delayed(const Duration(seconds: 0));
    return true; // or false based on your condition
  }

  void _exitAlertDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'DO YOU REALLY WANT TO \nEXIT THE APP?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          await Future.delayed(
                            const Duration(milliseconds: 100),
                          );

                          SystemNavigator.pop();
                        },
                        style: OutlinedButton.styleFrom(
                          splashFactory: InkRipple.splashFactory,
                          overlayColor: Colors.blueAccent.withOpacity(0.5),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          side: BorderSide(
                              color: Colors.blueAccent.withOpacity(0.7)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await Future.delayed(
                            const Duration(milliseconds: 100),
                          );

                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          splashFactory: InkRipple.splashFactory,
                          overlayColor: Colors.redAccent.withOpacity(0.5),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          side: BorderSide(
                              color: Colors.redAccent.withOpacity(0.7)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoData1 = ref.watch(fetchStreamProvider);
    final date = DateTime.now();
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        final backNavigationAllowed = await something();
        if (backNavigationAllowed) {
          if (mounted) {
            _exitAlertDialog(context);
          } else {}
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          title: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber.shade200,
              radius: 25,
              child: Image.asset(
                'assets/profile_picture.png',
                height: 40,
                width: 40,
              ),
            ),
            title: const Text(
              "Hey There!",
              style: TextStyle(
                fontSize: 12,
                color: Colors.blueGrey,
              ),
            ),
            subtitle: InkWell(
              enableFeedback: false,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: _launchUrl,
              child: const Text(
                "Developed By RP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "No Notifications!",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.black.withOpacity(0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Okay",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    icon: Icon(CupertinoIcons.bell),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Today's Task",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey.shade200,
                            foregroundColor: Colors.blue.shade800,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => showModalBottomSheet(
                            enableDrag: false,
                            isDismissible: false,
                            isScrollControlled: true,
                            sheetAnimationStyle: AnimationStyle(
                              duration: const Duration(seconds: 2),
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            context: context,
                            builder: (context) => PopScope(
                              canPop: false,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                  top: 15,
                                  left: 15,
                                  right: 15,
                                ),
                                child: const AddNewTaskModel(),
                              ),
                            ),
                          ),
                          child: const Text(
                            "+ New Task",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),

                        //card widget
                      ],
                    ),
                    const Gap(20),
                    todoData1.value?.length == 0
                        ? Center(
                            child: Text("No Data Found!"),
                          )
                        : Container(
                            padding: EdgeInsets.only(bottom: 30),
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: ListView.builder(
                              itemCount: todoData1.value?.length ?? 0,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return CardToDoList(getIndex: index);
                              },
                            ),
                          ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
