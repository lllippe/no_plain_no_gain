import 'package:no_plain_no_gain/models/store.dart';
import 'package:no_plain_no_gain/models/store_ramo.dart';
import 'package:no_plain_no_gain/screens/store_screen/store_field_screen.dart';

List<StoreFieldScreen> generateStoreFieldScreen({
  required Map<int, StoreRamo> databaseStoreRamo,
  required Map<int, Store> databaseStore,
}) {
  List<StoreFieldScreen> list = [];

  databaseStoreRamo.forEach(
    (key, value) {
      list.add(
        StoreFieldScreen(
          storeRamo: value,
          databaseStore: databaseStore,
        ),
      );
    },
  );
  return list;
}
