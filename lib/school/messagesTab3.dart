import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Second Page.dart';

class messages extends StatefulWidget {
  @override
  _messagesState createState() => _messagesState();
}

class _messagesState extends State<messages> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(this.context)
              .size
              .height - MediaQuery
              .of(context)
              .padding
              .top - MediaQuery
              .of(context)
              .padding
              .bottom - kToolbarHeight,
          child: notif(),
        )
    );
  }

  Widget notif() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          // print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        if (!projectSnap.hasData) {
          return getoffline();
        }
        return ListView.separated(
          separatorBuilder: (context, index) =>
              Divider(
                color: Colors.black12,
                indent: 20.0,
                endIndent: 20.0,
              ),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: projectSnap.data.length,
          itemBuilder: (context, index) {
            //   ProjectModel project = projectSnap.data[index];
            return ListTile(
              leading: CircleAvatar(child: Icon(Icons.notifications_none),),
              title: Text(projectSnap.data[index]['title'].toString()),
              subtitle: Text(projectSnap.data[index]['description'].toString()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      second(
                          'Message',
                          [
                            Text(projectSnap.data[index]['title'].toString()),
                            Text(projectSnap.data[index]['description']
                                .toString()),
                            Text(projectSnap.data[index]['created_at']
                                .toString()),

                          ], []

                      )),
                );
              },
            );
          },
        );
      },
      future: getnotif(),
    );
  }

  Future<List<dynamic>> getnotif() async
  {
    String url = 'http://skoobudy.com/b-wire/api/getMessages';
    Map<String, String> headers = {"Content-type": "application/json"};
    int id = 3539;
    /*
    for (var entry in MyApp.childs.entries) {
      if (entry.value == MyApp.dropdownValue)
        id = int.parse(entry.key);
    }
*/

    String body = '{"id":$id }';

    // make POST request
    Response response = await post(url, headers: headers, body: body);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String bodyresponse = '';

    if (response.statusCode == 200) {
      prefs.setString('messagesbody', response.body);
      bodyresponse = response.body;
    }
    else
      bodyresponse = prefs.getString('messagesbody');

    Map<String, dynamic> data = json.decode(bodyresponse);
    print(data['code'].toString());

    if (data['code'].toString() == '1') {
      // print(data['data'].toString());
      List<dynamic> l = data['data'].toList();
      return l;
    }
    return new List(0);
  }

  Widget getoffline() {
    return FutureBuilder(
      future: offline(),
      builder: (context, snap) {
        if (!snap.hasData)
          return Center(child: CircularProgressIndicator(),);
        return snap.data;
      },
    );
  }

  Future<Widget> offline() async
  {
    print('offline');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // make POST request
    String bodyresponse;
    bodyresponse = prefs.getString('messagesbody');
    print(prefs.getString('messagesbody'));
    if (bodyresponse == null)
      return Center(child: LinearProgressIndicator(),);
    // print(prefs.getString('body'));
    print(bodyresponse);
    Map<String, dynamic> data = json.decode(bodyresponse);
    print(data['code'].toString());
    if (data['code'].toString() == '1') {
       print(data['data'].toString());
      List<dynamic> l = data['data'].toList();
      return ListView.separated(
        separatorBuilder: (context, index) =>
            Divider(
              color: Colors.black12,
              indent: 20.0,
              endIndent: 20.0,
            ),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: l.length,
        itemBuilder: (context, index) {
          //   ProjectModel project = projectSnap.data[index];
          return ListTile(
            leading: CircleAvatar(child: Icon(Icons.notifications_none),),
            title: Text(l[index]['title'].toString()),
            subtitle: Text(l[index]['description'].toString()),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    second(
                        'Message',
                        [
                          Text(l[index]['title'].toString()),
                          Text(l[index]['description']
                              .toString()),
                          Text(l[index]['created_at']
                              .toString()),

                        ], []

                    )),
              );
            },
          );
        },
      );
    }
  }
}

