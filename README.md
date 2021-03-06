# dirt_arch

This package has the reference of many packages to facilitate the creation of apps without having to look for packages

## Getting Started

This works fine for my project, but maybe can`t work for urs :C

```dart
import 'package:dirt_arch/dirt_arch.dart';
import 'package:flutter/material.dart';

import 'model/sample_model.dart';
import 'page_two.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetWidget<List<SampleModel>>(
              url: 'https://jsonplaceholder.typicode.com/posts',
              fromMap: (json) =>
                  (json as List).map((e) => SampleModel.fromMap(e)).toList(),
              builder: (data) => ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index].title),
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) {
                      return PageTwo(id: data[index].id);
                    })),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: DirtBottomBar(
        //This
        onTapItems: [
          DirtTabItem(
              icon: Icons.home,
              title: 'Home',
              onTap: (_) {
                print('Home');
              }),
          DirtTabItem(
              icon: Icons.map,
              title: 'Discovery',
              onTap: (_) {
                print('Discovery');
              }),
          DirtTabItem(
              icon: Icons.add,
              title: 'Add',
              onTap: (_) {
                print('Add');
              }),
        ],
        //Or
        // items: [
        //   TabItem(icon: Icons.home, title: 'Home'),
        //   TabItem(icon: Icons.map, title: 'Discovery'),
        //   TabItem(icon: Icons.add, title: 'Add'),
        // ],
        //  onTap: (int i) => print('click index=$i'),
      ),
      floatingActionButton: PostWidget<SampleModel>(
        url: 'https://jsonplaceholder.typicode.com/posts',
        toMap: (data) => data.toMap(),
        builder: (execute) {
          return FloatingActionButton(
            onPressed: () => execute(
              SampleModel(
                userId: 1,
                title: "Test",
                completed: true,
              ),
            ),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}

```
