import 'package:dirt_arch/dirt_arch.dart';
import 'package:flutter/material.dart';

import 'model/sample_model.dart';

class PageFour extends StatefulWidget {
  @override
  _PageFourState createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            child: SubscriptionWidget<SampleModel>(
              url: "https://bwolfdev.herokuapp.com/v1/graphql",
              subscription: '''subscription MyQuery {
                            user{
                              id,
                              title,
                              userId,
                              completed
                              urlImage 
                            }
                          }''',
              fromListMap: (json) {
                return json['user'].map<SampleModel>((data) {
                  return SampleModel.fromMap(data);
                }).toList();
              },
              builder: (list) {
                list.sort((a, b) => a.id.compareTo(b.id));
                return ListView.builder(
                  itemCount: list.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(list[index].urlImage),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: QueryWidget<SampleModel>(
              url: "https://bwolfdev.herokuapp.com/v1/graphql",
              query: '''query MyQuery {
                          user{
                            id,
                            title,
                            userId,
                            completed
                            urlImage 
                          }
                        }''',
              fromListMap: (json) {
                return json['user'].map<SampleModel>((data) {
                  return SampleModel.fromMap(data);
                }).toList();
              },
              builder: (list) => ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, index) => ListTile(
                  title: Text(list[index].title),
                  subtitle: Text(list[index].userId.toString()),
                  leading: Image.network(list[index].urlImage),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
