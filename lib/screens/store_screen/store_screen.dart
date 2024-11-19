import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_plain_no_gain/models/store.dart';
import 'package:no_plain_no_gain/models/store_ramo.dart';
import 'package:no_plain_no_gain/screens/store_screen/store_field_database.dart';
import 'package:no_plain_no_gain/services/store_service.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  StoreService _storeService = StoreService();
  Map<int, Store> databaseStore = {};
  Map<int, StoreRamo> databaseStoreRamo = {};
  String url = '';
  ScrollController _controller = ScrollController();
  bool isSearchReady = false;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    double widthScreen = deviceData.size.width;
    double heightScreen = deviceData.size.height;

    return Scrollbar(
      controller: _controller,
      thumbVisibility: true,
      thickness: 3,
      child: SingleChildScrollView(
        controller: _controller,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSearchReady
                ? databaseStoreRamo.isEmpty
                    ? const Row(
                        children: [
                          Text(
                            'Nenhum item na loja',
                            style: TextStyle(fontSize: 30),
                          ),
                          Icon(
                            Icons.remove_shopping_cart_outlined,
                            size: 100,
                          )
                        ],
                      )
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Card(
                            elevation: 8,
                            color: Colors.greenAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: widthScreen,
                                child: Text(
                                  'Navegue nas seções para encontrar as lojas que procura.\nNão esqueça de utilizar'
                                  ' nossos cupons de desconto!',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.acme(
                                    textStyle: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black87),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 8,
                          color: Colors.greenAccent,
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: generateStoreFieldScreen(
                                databaseStoreRamo: databaseStoreRamo,
                                databaseStore: databaseStore),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Card(
                            elevation: 8,
                            color: Colors.greenAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: widthScreen,
                                child: Text(
                                  'Para parcerias entre em contato: frpelissari23@gmail.com',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.acme(
                                    textStyle: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black87),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  void refresh() {
    isSearchReady = false;
    _storeService.getRamo().then((List<StoreRamo> listStoreRamo) {
      setState(() {
        int size = 0;
        databaseStoreRamo = {};
        for (StoreRamo ramo in listStoreRamo) {
          databaseStoreRamo[size] = ramo;
          size++;
        }
      });
    });

    _storeService.getAll().then((List<Store> listStore) {
      setState(() {
        int size = 0;
        databaseStore = {};
        for (Store store in listStore) {
          databaseStore[size] = store;
          size++;
        }
        databaseStore.forEach((key, value) {
          url = value.url;
          isSearchReady = true;
        });
      });
    });
  }
}
