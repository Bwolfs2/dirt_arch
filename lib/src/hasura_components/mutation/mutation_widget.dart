import 'package:dirt_arch/dirt_arch.dart';
import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';

class MutationWidget<T> extends StatefulWidget {
  final String mutation;
  final Map<String, dynamic> variables;
  final String url;
  final Widget Function(void Function(T) execute) builder;
  final Widget loader;

  final void Function(dynamic) onError;
  final void Function(dynamic) onSuccess;

  final HasuraConnect hasuraConnect;

  const MutationWidget({
    Key key,
    @required this.mutation,
    @required this.variables,
    @required this.builder,
    this.loader = const CircularProgressIndicator(),
    this.onError,
    this.onSuccess,
    this.url,
    this.hasuraConnect,
  }) : super(key: key);

  @override
  _MutationWidgetState<T> createState() => _MutationWidgetState<T>();
}

class _MutationWidgetState<T> extends State<MutationWidget<T>> {
  Future<void> sendMutation(T data) async {
    BotToast.showCustomLoading(toastBuilder: (_) => widget.loader);

    try {
      var dio = widget.hasuraConnect ?? HasuraConnect(widget.url);
      var response = await dio.mutation(
        widget.mutation,
        variables: widget.variables,
      );
      widget.onSuccess(response);
    } catch (e) {
      widget.onError?.call(e);
    } finally {
      BotToast.closeAllLoading();
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(sendMutation);
}
