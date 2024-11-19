import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_plain_no_gain/models/store.dart';
import 'package:no_plain_no_gain/models/store_ramo.dart';
import 'package:no_plain_no_gain/screens/store_screen/store_link_database.dart';
import 'package:no_plain_no_gain/screens/store_screen/store_link_screen.dart';

class StoreFieldScreen extends StatefulWidget {
  final StoreRamo? storeRamo;
  final Map<int, Store>? databaseStore;

  StoreFieldScreen({
    Key? key,
    this.storeRamo,
    this.databaseStore,
  }) : super(key: key);

  @override
  State<StoreFieldScreen> createState() => _StoreFieldScreenState();
}

class _StoreFieldScreenState extends State<StoreFieldScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Card(
        elevation: 5,
        color: Colors.black87,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.storeRamo!.ramo,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.acme(
                        textStyle: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.normal,
                            color: Colors.greenAccent),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StoreLinkScreen(
            databaseStoreRamo: widget.databaseStore!,
            ramo: widget.storeRamo!.ramo),
          ),
        );
      },
    );
  }
}
