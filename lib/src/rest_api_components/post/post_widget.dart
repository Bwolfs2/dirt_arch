import 'package:dio/dio.dart';
import 'package:dirt_arch/dirt_arch.dart';
import 'package:flutter/material.dart';

class PostWidget<T> extends StatefulWidget {
  final String url;
  final Widget Function(void Function(T) execute) builder;
  final Map<String, dynamic> Function(T data) toMap;
  final Widget loader;

  final void Function(dynamic)? onError;
  final void Function(Response)? onSuccess;

  final Dio? customDio;

  const PostWidget({
    Key? key,
    required this.url,
    required this.builder,
    required this.toMap,
    this.loader = const CircularProgressIndicator(),
    this.onError,
    this.onSuccess,
    this.customDio,
  }) : super(key: key);

  @override
  _PostWidgetState<T> createState() => _PostWidgetState<T>();
}

class _PostWidgetState<T> extends State<PostWidget<T>> {
  Future<void> sendPost(T data) async {
    BotToast.showCustomLoading(toastBuilder: (_) => widget.loader);

    try {
      var dio = widget.customDio ?? Dio();
      var response = await dio.post(widget.url, data: widget.toMap(data));
      widget.onSuccess?.call(response);
    } catch (e) {
      widget.onError?.call(e);
    } finally {
      BotToast.closeAllLoading();
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(sendPost);
}
