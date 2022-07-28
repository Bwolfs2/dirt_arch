import 'package:dirt_arch/dirt_arch.dart';
import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';

class QueryWidget<T> extends StatefulWidget {
  final String? url;
  final String query;
  final Widget Function(List<T> list) builder;
  final List<T> Function(dynamic json) fromListMap;

  final Widget loader;
  final void Function(dynamic)? onError;
  final HasuraConnect? hasuraConnect;
  const QueryWidget({
    super.key,
    required this.query,
    required this.builder,
    required this.fromListMap,
    this.loader = const CircularProgressIndicator(),
    this.onError,
    this.url,
    this.hasuraConnect,
  }) : assert(hasuraConnect == null);

  @override
  _QueryWidgetState<T> createState() => _QueryWidgetState<T>();
}

class _QueryWidgetState<T> extends State<QueryWidget<T>> {
  Future<List<T>> getData() async {
    try {
      final hasuraConnect = widget.hasuraConnect ?? HasuraConnect(widget.url!);
      final result = await hasuraConnect.query(widget.query);
      return widget.fromListMap(result['data']);
    } catch (e) {
      widget.onError?.call(e);
      debugPrint('$e');
      return [];
    }
  }

  late Future future;

  @override
  void initState() {
    super.initState();
    future = getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          BotToast.showCustomLoading(toastBuilder: (_) => widget.loader);
          return Container();
        }
        BotToast.closeAllLoading();
        return widget.builder(snapshot.data == null ? [] : snapshot.data! as List<T>);
      },
    );
  }
}
