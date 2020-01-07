import 'package:flutter/material.dart';


class second extends StatefulWidget {
  List<Widget> l1 = new List();
  List<Widget> l2 = new List();
  String title ='';
  second(this.title , this.l1 , this.l2 );
  @override
  _secondState createState() => _secondState();
}

class _secondState extends State<second> {
  @override
  Widget build(BuildContext context) {
    //print(widget.l2.toString());
    widget.l1.addAll(widget.l2);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:  SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(this.context).size.height  - MediaQuery.of(context).padding.top -MediaQuery.of(context).padding.bottom- kToolbarHeight,
            child: ListView.builder(
                itemCount: widget.l1.length,
                itemBuilder: (BuildContext ctxt, int Index) {
                  return Center(child: widget.l1[Index],);
                }

            ),
          )
      ),
    );
  }
}
