import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return getDynamicListView();
  }

  List<String> getListElement() {
    var item = List<String>.generate(1000, (counter) => "Item $counter");
    return item;
  }

  void showSnackBar(BuildContext context, String item) {
    SnackBar snackBar = SnackBar(
      content: Text("You have tapped on $item"),
      action: SnackBarAction(
          label: "Okay",
          onPressed: () {
            debugPrint("Okay click");
          }),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget getDynamicListView() {
    var listItem = getListElement();
    var listview = ListView.builder(itemBuilder: (context, index) {
      return ListTile(
        leading: Icon(Icons.arrow_forward),
        title: Text(listItem[index]),
        onTap: () {
          showSnackBar(context, listItem[index]);
          debugPrint("${listItem[index]} was tapped");
        },
      );
    });

    return listview;
  }

  Widget getListView() {
    var listview = ListView(
      children: [
        ListTile(
          leading: Icon(Icons.supervised_user_circle_sharp),
          title: Text("Bhoomika Prajapati"),
          subtitle: Text("Android Developer"),
          trailing: Icon(Icons.edit_location_outlined),
        ),
        Text("Hello"),
        Container(
          color: Colors.amber,
          child: Text(""),
        )
      ],
    );
    return listview;
  }
}
