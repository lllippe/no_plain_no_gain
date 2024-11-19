import 'package:flutter/material.dart';
import 'package:no_plain_no_gain/models/banco_conhecimento.dart';
import 'package:no_plain_no_gain/screens/home_screen/home_screen.dart';
import 'package:no_plain_no_gain/services/banco_conhecimento_service.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  final ScrollController _controllerScroll = ScrollController();
  BancoConhecimentoService _bancoConhecimentoService =
      BancoConhecimentoService();
  Map<int, BancoConhecimento> databaseBancoConhecimento = {};
  List<VideoPlayerController> listVideoController = [];
  List<Card> listCardVideoPlayer = [];
  bool videosLoaded = false;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.greenAccent,
        title: const Text(
          'Banco de conhecimento',
          style: TextStyle(color: Colors.greenAccent),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.greenAccent),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomeScreen(
                        selectedIndex: 0,
                      )),
            );
          },
        ),
      ),
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 10,
        radius: const Radius.circular(15),
        controller: _controllerScroll,
        child: SingleChildScrollView(
          controller: _controllerScroll,
          child: videosLoaded
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: listCardVideoPlayer,
                )
              : const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void refresh() {
    int sizeList = 0;
    _bancoConhecimentoService
        .getAll()
        .then((List<BancoConhecimento> listBancoConhecimento) {
      setState(() {
        databaseBancoConhecimento = {};
        for (BancoConhecimento video in listBancoConhecimento) {
          databaseBancoConhecimento[sizeList] = video;
          sizeList++;
        }
        createListVideoPlayer();
      });
    });
  }

  void createListVideoPlayer() {
    setState(() {
      videosLoaded = false;
    });
    if (databaseBancoConhecimento.isNotEmpty) {
      var deviceData = MediaQuery.of(context);
      double width_screen = deviceData.size.width;

      databaseBancoConhecimento.forEach((key, value) {
        late VideoPlayerController key;
        key =
            VideoPlayerController.networkUrl(Uri.parse(value.endereco))
              ..initialize().then((_) {
                // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                setState(() {
                  videosLoaded = true;
                  listCardVideoPlayer.add(
                    Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              value.descricao,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: key.value.isInitialized
                                ? AspectRatio(
                                    aspectRatio: key.value.aspectRatio,
                                    child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: <Widget>[
                                          VideoPlayer(key),
                                          VideoProgressIndicator(key,
                                              allowScrubbing: true),
                                        ]),
                                  )
                                : Container(),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                key.value.isPlaying
                                    ? key.pause()
                                    : key.play();
                              });
                            },
                            icon: Icon(
                              key.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              });
      });
    }
  }
}
