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
      floatingActionButton: MutationWidget<SampleModel>(
        url: 'https://bwolfdev.herokuapp.com/v1/graphql',
        variables: {
          'urlImage':
              'https://img.freepik.com/fotos-gratis/3d-rendem-de-uma-mesa-de-madeira-com-uma-imagem-defocussed-de-um-barco-em-um-lago_1048-3432.jpg?size=626&ext=jpg'
        },
        mutation: r'''mutation insertUser($urlImage: String) {
                      insert_user(objects: {title: "Titulo Legal", urlImage: $urlImage, userId: 1}) {
                        affected_rows
                      }
                    }''',
        onSuccess: (dynamic value) {
          if (value['insert_user']['affected_rows'] > 0) {
            DirtSnackBar.done('Added Success')();
          } else {
            DirtSnackBar.warning('I guess something is wrong')();
          }
        },
        //  toMap: (data) => data.toMap(),
        builder: (execute) {
          return FloatingActionButton(
            onPressed: () => execute(),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        },
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
