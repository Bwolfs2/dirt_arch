import 'package:dirt_arch/dirt_arch.dart';
import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';

class MutationWidget<T> extends StatefulWidget {
  final String mutation;
  final Map<String, dynamic> variables;
  final String? url;
  final Widget Function(void Function() execute) builder;
  final Widget loader;

  final void Function(dynamic)? onError;
  final void Function(dynamic)? onSuccess;

  final HasuraConnect? hasuraConnect;

  const MutationWidget({
    super.key,
    required this.mutation,
    required this.variables,
    required this.builder,
    this.loader = const CircularProgressIndicator(),
    this.onError,
    this.onSuccess,
    this.url,
    this.hasuraConnect,
  });

  @override
  _MutationWidgetState<T> createState() => _MutationWidgetState<T>();
}

class _MutationWidgetState<T> extends State<MutationWidget<T>> {
  Future<void> sendMutation() async {
    BotToast.showCustomLoading(toastBuilder: (_) => widget.loader);

    try {
      final hasuraConnect = widget.hasuraConnect ?? HasuraConnect(widget.url!);
      final response = await hasuraConnect.mutation(
        widget.mutation,
        variables: widget.variables,
      );
      widget.onSuccess?.call(response['data']);
      setState(() {});
    } catch (e) {
      widget.onError?.call(e);
    } finally {
      BotToast.closeAllLoading();
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(sendMutation);
}
