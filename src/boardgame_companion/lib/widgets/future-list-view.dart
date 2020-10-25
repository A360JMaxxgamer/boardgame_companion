import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureListView<T> extends StatelessWidget {
  final Future<List<T>> future;

  final Widget Function(T) itemBuilder;

  const FutureListView({Key key, this.future, this.itemBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        initialData: List<T>.empty(),
        future: future,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, int pos) {
                    T item = snapshot.data[pos];
                    return itemBuilder(item);
                  },
                )
              : Center(child: CircularProgressIndicator());
        });
  }
}
