import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_ui/api_services/delete_user_services.dart';
import 'package:post_ui/api_services/get_sign_up_user_services.dart';

import '../model/get_signup_model.dart';

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: GetSignUpUserServices.getSignUpUser(),
                builder: (BuildContext context,
                    AsyncSnapshot<Getsignupmodel?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.users!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final user = snapshot.data!.users![index];
                        return Dismissible(
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              DeleteUserServices.deleteuser(
                                  {'username': user.username});
                            }
                          },
                          background: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.blue),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          secondaryBackground: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.red),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          key: ValueKey(user.username),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                user.avatar.toString(),
                              ),
                            ),
                            title: Text(user.firstName.toString()),
                            subtitle: Text(user.username.toString()),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CupertinoActivityIndicator());
                  }
                },
              ),
            ),
            // ElevatedButton(
            //     onPressed: () async {
            //       SharedPreferences prefs =
            //           await SharedPreferences.getInstance();
            //       prefs.remove('username');
            //     },
            //     child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}
