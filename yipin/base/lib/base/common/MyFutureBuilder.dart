
import 'package:base/base/viewmodel/BaseViewModel.dart';
import 'package:flutter/material.dart';

import 'StateWidget.dart';


class MyFutureBuilder<T> extends StatefulWidget {


  final Future<T> Function() future;

  final BaseViewModel model;

  final Widget Function(BuildContext context) builder;

  const MyFutureBuilder({Key key, this.future, this.builder, this.model,
  }) : super(key: key);

  @override
  _MyFutureBuilderState createState() => _MyFutureBuilderState<T>();
}

class _MyFutureBuilderState<T> extends State<MyFutureBuilder<T>> {


  Object _activeCallbackIdentity;
  AsyncSnapshot<T> _snapshot;

  bool init = true;

  @override
  void initState() {
    super.initState();
    _snapshot = AsyncSnapshot<T>.nothing();
    _subscribe();
  }


  @override
  void didUpdateWidget(covariant MyFutureBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.model.requestTrue){
      if (_activeCallbackIdentity != null) {
        _unsubscribe();
        _snapshot = _snapshot.inState(ConnectionState.none);
      }
      _subscribe();
    }
  }


  @override
  Widget build(BuildContext context){
    if(!init){
      return widget.builder(context);
    }

    if(_snapshot.connectionState == ConnectionState.done && _snapshot.data == 1){
      init = false;
      return widget.builder(context);
    }
    else{
      dynamic state;
      if(_snapshot.connectionState == ConnectionState.none || _snapshot.connectionState == ConnectionState.waiting){
        state = 0;
      }
      else{
        if(_snapshot.hasError || _snapshot.data == -1){
          state = -1;
        }
        else
          state = _snapshot.data;
      }

      return widget.model.stateWidget(state: state);
    }

  }


  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    if (widget.future != null) {
      widget.model?.requestTrue = false;
      final Object callbackIdentity = Object();
      _activeCallbackIdentity = callbackIdentity;
      widget.future?.call()?.then<void>((T data) {
        if (_activeCallbackIdentity == callbackIdentity) {
          setState(() {
            _snapshot = AsyncSnapshot<T>.withData(ConnectionState.done, data);
          });
        }
      }, onError: (Object error, StackTrace stackTrace) {
        if (_activeCallbackIdentity == callbackIdentity) {
          setState(() {
            _snapshot = AsyncSnapshot<T>.withError(ConnectionState.done, error);
          });
        }
      });
      _snapshot = _snapshot.inState(ConnectionState.waiting);
    }
  }

  void _unsubscribe() {
    _activeCallbackIdentity = null;
  }
}
