import 'package:flutter/material.dart';
import 'package:no_plain_no_gain/models/store.dart';
import 'package:no_plain_no_gain/screens/home_screen/home_screen.dart';
import 'package:no_plain_no_gain/screens/store_screen/store_link_database.dart';

class StoreLinkScreen extends StatefulWidget {
  //final Store? store;
  final Map<int, Store>? databaseStoreRamo;
  final String? ramo;

  StoreLinkScreen({
    Key? key,
    //this.store,
    this.databaseStoreRamo,
    this.ramo,
  }) : super(key: key);

  @override
  State<StoreLinkScreen> createState() => _StoreLinkScreenState();
}

class _StoreLinkScreenState extends State<StoreLinkScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.greenAccent,
        title: Text(
          widget.ramo!,
          style: const TextStyle(color: Colors.greenAccent),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.greenAccent),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomeScreen(
                        selectedIndex: 2,
                      )),
            );
          },
        ),
      ),
      body: ListView(
        children: generateStoreLinkScreen(
          databaseStoreRamo: widget.databaseStoreRamo!,
          ramo: widget.ramo!,
        ),
      ),
    );
  }
}
