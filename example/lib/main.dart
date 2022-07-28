import 'package:asuka/asuka.dart' as asuka;
import 'package:dirt_arch/dirt_arch.dart';
import 'package:example/model/sample_model.dart';
import 'package:example/page_four.dart';
import 'package:example/page_three.dart';
import 'package:example/page_two.dart';
import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      builder: (BuildContext context, Widget child) {
        return asuka.builder(context, BotToastInit()(context, child));
      },
      navigatorObservers: [
        BotToastNavigatorObserver()
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

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
        actions: [
          IconButton(
            icon: const Icon(Icons.threesixty),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return const PageThree();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text('Next Page'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PageFour(),
                ),
              );
            },
          ),
          Expanded(
            child: GetWidget<List<SampleModel>>(
              url: 'https://jsonplaceholder.typicode.com/posts',
              fromMap: (json) => (json as List).map((e) => SampleModel.fromMap(e)).toList(),
              builder: (data) => ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index].title),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return PageTwo(id: data[index].id);
                        },
                      ),
                    ),
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
              debugPrint('Home');
            },
          ),
          DirtTabItem(
            icon: Icons.map,
            title: 'Discovery',
            onTap: (_) {
              debugPrint('Discovery');
            },
          ),
          DirtTabItem(
            icon: Icons.add,
            title: 'Add',
            onTap: (_) {
              debugPrint('Add');
            },
          ),
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
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
