import 'dart:async';

import 'package:dirt_arch/dirt_arch.dart';
import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';

class SubscriptionWidget<T> extends StatefulWidget {
  final String? url;
  final String subscription;
  final Widget Function(List<T> data) builder;
  final List<T> Function(dynamic json) fromListMap;

  final Widget loader;
  final void Function(dynamic)? onError;
  final HasuraConnect? hasuraConnect;
  const SubscriptionWidget({
    super.key,
    required this.subscription,
    required this.builder,
    required this.fromListMap,
    this.loader = const CircularProgressIndicator(),
    this.onError,
    this.url,
    this.hasuraConnect,
  }) : assert(url == null || hasuraConnect == null);

  @override
  _SubscriptionWidgetState<T> createState() => _SubscriptionWidgetState<T>();
}

class _SubscriptionWidgetState<T> extends State<SubscriptionWidget<T>> {
  late Snapshot<dynamic> result;

  Future<Snapshot<List<T>?>?> getData() async {
    try {
      final hasuraConnect = widget.hasuraConnect ?? HasuraConnect(widget.url!);
      result = await hasuraConnect.subscription(widget.subscription);
      return result.map((event) {
        return event == null ? null : widget.fromListMap(event!['data']);
      });
    } catch (e) {
      widget.onError?.call(e);
      return null;
    }
  }

  late Future<Snapshot<List<T>?>?> future;

  @override
  void initState() {
    super.initState();
    future = getData();
  }

  @override
  void dispose() {
    result.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Snapshot<List<T>?>?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          BotToast.showCustomLoading(toastBuilder: (_) => widget.loader);
          return Container();
        }
        BotToast.closeAllLoading();
        return StreamBuilder(
          stream: snapshot.data,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              BotToast.showCustomLoading(toastBuilder: (_) => widget.loader);
              return Container();
            }
            return widget.builder(snapshot.data == null ? [] : snapshot.data! as List<T>);
          },
        );
      },
    );
  }
}
