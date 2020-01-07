import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Second Page.dart';

class homework extends StatefulWidget {
  @override
  _homeworkState createState() => _homeworkState();
}

class _homeworkState extends State<homework> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(this.context).size.height  - MediaQuery.of(context).padding.top -MediaQuery.of(context).padding.bottom- kToolbarHeight,
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
          separatorBuilder: (context, index) => Divider(
            color: Colors.black12,
            indent: 20.0,
            endIndent: 20.0,
          ),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: projectSnap.data.length,
          itemBuilder: (context, index) {

            List<dynamic> h= projectSnap.data[index]['files'];
            List<Widget> hws= new List();
            for(int i = 0 ; i <  h.length ; i++)
              {
                hws.add(Image(image: NetworkImage( h[i]['path'].toString()),));

                hws.add(RaisedButton(
                  onPressed: ()=>_launchURL(h[i]['path']),
                  child: new Text('Download File $i'),
                ),
                );


              }
            //   ProjectModel project = projectSnap.data[index];
            return ListTile(
              leading: CircleAvatar(child: Icon(Icons.notifications_none),) ,
              title: Text(projectSnap.data[index]['title'].toString()),
              subtitle: Text(projectSnap.data[index]['description'].toString()),

              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => second(
                      'HomeWork',
                      [
                        Text(projectSnap.data[index]['title'].toString()),
                        Text(projectSnap.data[index]['description'].toString()),
                        Text(projectSnap.data[index]['delivery_date'].toString()),
                        Text(projectSnap.data[index]['subject_name'].toString()),
                        Text(projectSnap.data[index]['sub_class_name'].toString()),
                        Text(projectSnap.data[index]['class_name'].toString()),

                      ],hws

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
  void _showErrorSnackBar() {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Oops... the URL couldn\'t be opened!'),
      ),
    );
  }
  _launchURL(String url) async {
    //const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<List<dynamic>> getnotif() async
  {
    String url = 'http://skoobudy.com/b-wire/api/getHomeWorks';
    Map<String, String> headers = {"Content-type": "application/json"};
    int id =3539;
    /*
    for (var entry in MyApp.childs.entries) {
      if(entry.value ==MyApp.dropdownValue)
        id = int.parse(entry.key);
    }
*/
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String body = '{"id":$id }';

    // make POST request
    Response response = await post(url, headers: headers , body: body);
    String bodyresponse ='';

    if(response.statusCode == 200)
    {
      prefs.setString('homeworkbody', response.body);
      bodyresponse =response.body;
    }
    else
      bodyresponse = prefs.getString('homeworkbody');

    Map<String, dynamic> data = json.decode(bodyresponse);
    print(data['code'].toString());

    if(data['code'].toString() =='1') {
     // print(data['data'].toString());
      List<dynamic> l = data['data'].toList();
      return l;
    }
    return new List(0);
  }


  Widget getoffline()
  {
    return FutureBuilder(
      future: offline(),
      builder: (context, snap)
      {
        if(!snap.hasData)
          return Center(child: LinearProgressIndicator(),);
        return snap.data;
      },
    );
  }
  Future<Widget> offline()async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // make POST request
    String bodyresponse;
    bodyresponse = prefs.getString('homeworkbody');
    if (bodyresponse == null)
      return Center(child: LinearProgressIndicator(),);
    // print(prefs.getString('body'));
    Map<String, dynamic> data = json.decode(bodyresponse);

    if (data['code'].toString() == '1') {
      // print(data['data'].toString());
      List<dynamic> l = data['data'].toList();

      return ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black12,
          indent: 20.0,
          endIndent: 20.0,
        ),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: l.length,
        itemBuilder: (context, index) {

          List<dynamic> h= l[index]['files'];
          List<Widget> hws= new List();
          for(int i = 0 ; i <  h.length ; i++)
          {
            hws.add(Image(image: NetworkImage( h[i]['path'].toString()),));

            hws.add(RaisedButton(
              onPressed: ()=>_launchURL(h[i]['path']),
              child: new Text('Download File $i'),
            ),
            );


          }
          //   ProjectModel project = projectSnap.data[index];
          return ListTile(
            leading: CircleAvatar(child: Icon(Icons.notifications_none),) ,
            title: Text(l[index]['title'].toString()),
            subtitle: Text(l[index]['description'].toString()),

            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => second(
                    'HomeWork',
                    [
                      Text(l[index]['title'].toString()),
                      Text(l[index]['description'].toString()),
                      Text(l[index]['delivery_date'].toString()),
                      Text(l[index]['subject_name'].toString()),
                      Text(l[index]['sub_class_name'].toString()),
                      Text(l[index]['class_name'].toString()),

                    ],hws

                )),
              );

            },
          );
        },
      );
    }
  }


    }
