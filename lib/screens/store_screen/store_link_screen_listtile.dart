import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_plain_no_gain/models/store.dart';
import 'package:no_plain_no_gain/screens/common_screen/message_dialog.dart';
import 'package:no_plain_no_gain/services/store_service.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreLinkListTileScreen extends StatefulWidget {
  final Store? store;

  StoreLinkListTileScreen({
    Key? key,
    this.store,

  }) : super(key: key);

  @override
  State<StoreLinkListTileScreen> createState() => _StoreLinkListTileScreenState();
}

class _StoreLinkListTileScreenState extends State<StoreLinkListTileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {    
    return ListTile(
        title: Card(
          elevation: 5,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 180,
                      width: 180,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          'https://drive.google.com/uc?export=view&id=${widget.store!.logo}',
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset(
                              '',
                              fit: BoxFit.cover,
                            );
                          },
                          fit: BoxFit.cover,
                        ), //Image.asset(
                        //   'assets/images/exu.webp',
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.store!.descricao,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.store!.url,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Cupom: ${widget.store!.cupom}',
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: (){
          messageDialog(context, 'Não esqueça de utilizar o cupom de desconto: ${widget.store!.cupom}');
          _launchUrl(widget.store!.url);
          saveCountClick();
        },
    );
  }

  void saveCountClick() {
    StoreService _storeService = StoreService();
    
    Store storeSaveClick = Store(
        id: widget.store!.id,
        descricao: widget.store!.descricao,
        url: widget.store!.url,
        ramo: widget.store!.ramo,
        contTotal: widget.store!.contTotal + 1,
        contMensal: widget.store!.contMensal,
        ativo: widget.store!.ativo,
        rateEmpresa: widget.store!.rateEmpresa,
        cupom: widget.store!.cupom,
        logo: widget.store!.logo);
    
    _storeService.edit(widget.store!.id, storeSaveClick);
  }
}

Future<void> _launchUrl(url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}
