import 'package:dirt_arch/dirt_arch.dart';
import 'package:flutter/material.dart';

class PageThree extends StatefulWidget {
  final int id;

  const PageThree({Key key, this.id}) : super(key: key);

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageThree> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          ChipMenuList<String>(
            items: [
              ChipMenuItem(item: "Label 1"),
              ChipMenuItem(item: "Label 2  dasd"),
              ChipMenuItem(item: "Label 3"),
              ChipMenuItem(item: "Label 4"),
              ChipMenuItem(item: "Label 5 dasdas "),
              ChipMenuItem(item: "Label 6"),
              ChipMenuItem(item: "Label 7"),
              ChipMenuItem(item: "Label 8 dasdsadsa das"),
              ChipMenuItem(item: "La"),
            ],
            elevation: 5,
            onTap: (index) {
              debugPrint(index);
              setState(() {});
            },
            useTips: true,
          ),
          Expanded(
            key: UniqueKey(),
            child: AnimatedCard(
              curve: Curves.bounceInOut,
              direction: AnimatedCardDirection.bottom, //Initial animation direction
              initDelay: Duration.zero, //Delay to initial animation
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: 10,
                itemBuilder: (_, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: index.isOdd ? Colors.red : Colors.green,
                      ),
                      height: 150,
                      child: Center(child: Text("Card $index")),
                    ),
                  );
                },
              ),
              //Implement this action to active dismiss
            ),
          )
        ],
      ),
    );
  }
}
