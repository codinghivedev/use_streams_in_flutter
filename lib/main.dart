
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),

      body: Container(
          child: StreamBuilder<int>(
        stream: createStreamUsingAsyncGenerator(const Duration(seconds: 1), 15),
            builder: (context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasError) {
                // Future completed with an error.
                return Text(
                  'On error : ${snapshot.error}',
                );
              } else if (snapshot.hasData) {
                // Future completed with a value.
                return Text(
                  'On success : ${snapshot.data}',
                );
              } else {
                // Uncompleted.
                return Text(
                  'Waiting',
                );
              }
            },
          )),
    );
  }

  Stream<int> createStreamUsingAsyncGenerator(Duration interval, [int maxCount]) async* {
    print('createStreamUsingAsyncGenerator start');

    int counter = 0;
    while (true) {
      await Future.delayed(interval);
      counter++;
      yield counter;
      if (counter == maxCount) break;
    }

    print('createStreamUsingAsyncGenerator end');

  }

}