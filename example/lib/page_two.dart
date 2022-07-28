import 'package:dirt_arch/dirt_arch.dart';
import 'package:example/model/sample_model.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatefulWidget {
  final int id;

  const PageTwo({Key key, this.id}) : super(key: key);

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: GetWidget<SampleModel>(
        url: "https://jsonplaceholder.typicode.com/posts/${widget.id}",
        fromMap: (json) => SampleModel.fromMap(json),
        builder: (data) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${data.id}"),
                Text(data.title),
                Text("${data.userId}"),
                Text("${data.completed}"),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: DirtBubbleBottomBar(
        onTapItems: [
          DirtBubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: const Icon(
              Icons.dashboard,
              color: Colors.black,
            ),
            activeIcon: const Icon(
              Icons.dashboard,
              color: Colors.red,
            ),
            title: const Text("Home"),
            onTap: (index) {
              debugPrint("Home $index");
            },
          ),
          DirtBubbleBottomBarItem(
            backgroundColor: Colors.deepPurple,
            icon: const Icon(
              Icons.access_time,
              color: Colors.black,
            ),
            activeIcon: const Icon(
              Icons.access_time,
              color: Colors.deepPurple,
            ),
            title: const Text("Logs"),
            onTap: (index) {
              debugPrint("Logs $index");
            },
          ),
          DirtBubbleBottomBarItem(
            backgroundColor: Colors.indigo,
            icon: const Icon(
              Icons.folder_open,
              color: Colors.black,
            ),
            activeIcon: const Icon(
              Icons.folder_open,
              color: Colors.indigo,
            ),
            title: const Text("Folders"),
            onTap: (index) {
              debugPrint("Folders $index");
            },
          ),
        ],
        //Or
        // items: [
        //   BubbleBottomBarItem(
        //       backgroundColor: Colors.red,
        //       icon: Icon(
        //         Icons.dashboard,
        //         color: Colors.black,
        //       ),
        //       activeIcon: Icon(
        //         Icons.dashboard,
        //         color: Colors.red,
        //       ),
        //       title: Text("Home")),
        //   BubbleBottomBarItem(
        //       backgroundColor: Colors.deepPurple,
        //       icon: Icon(
        //         Icons.access_time,
        //         color: Colors.black,
        //       ),
        //       activeIcon: Icon(
        //         Icons.access_time,
        //         color: Colors.deepPurple,
        //       ),
        //       title: Text("Logs")),
        //   BubbleBottomBarItem(
        //       backgroundColor: Colors.indigo,
        //       icon: Icon(
        //         Icons.folder_open,
        //         color: Colors.black,
        //       ),
        //       activeIcon: Icon(
        //         Icons.folder_open,
        //         color: Colors.indigo,
        //       ),
        //       title: Text("Folders")),
        // ],
      ),
    );
  }
}
