import 'package:dio/dio.dart';
import 'package:dirt_arch/dirt_arch.dart';
import 'package:flutter/material.dart';

class GetWidget<T> extends StatefulWidget {
  final String url;
  final Widget Function(T data) builder;
  final T Function(dynamic json) fromMap;

  final Widget loader;
  final void Function(dynamic)? onError;
  final Dio? customDio;
  const GetWidget({
    Key? key,
    required this.url,
    required this.builder,
    required this.fromMap,
    this.loader = const CircularProgressIndicator(),
    this.onError,
    this.customDio,
  }) : super(key: key);

  @override
  _GetWidgetState<T> createState() => _GetWidgetState<T>();
}

class _GetWidgetState<T> extends State<GetWidget<T>> {
  Future<T?> getData() async {
    try {
      var dio = widget.customDio ?? Dio();
      var result = await dio.get(widget.url);
      return widget.fromMap(result.data);
    } catch (e) {
      widget.onError?.call(e);
      print(e);
      return null;
    }
  }

  late Future<T?> future;

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
          // Center(child: widget.loader);
        }
        BotToast.closeAllLoading();
        return widget.builder(snapshot.data as T);
      },
    );
  }
}
