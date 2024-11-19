import 'package:no_plain_no_gain/models/store.dart';
import 'package:no_plain_no_gain/screens/store_screen/store_link_screen_listtile.dart';

List<StoreLinkListTileScreen> generateStoreLinkScreen({
  required Map<int, Store> databaseStoreRamo,
  required String? ramo,
}) {
  List<StoreLinkListTileScreen> list = [];

  databaseStoreRamo.forEach(
    (key, value) {
      if (ramo == value.ramo) {
        list.add(
          StoreLinkListTileScreen(
            store: value,
          ),
        );
      }
    },
  );
  return list;
}
