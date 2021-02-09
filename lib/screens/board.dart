import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smallorgsys/controllers/board_controller.dart';

class BoardPage extends StatefulWidget {
  BoardPage();
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  var _isLoading = true;
  var providerBoardController;
  @override
  void initState() {
    Provider.of<BoardController>(context, listen: false)
        .fetchAndSetBoard()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    providerBoardController = Provider.of<BoardController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Board'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: providerBoardController.board.length,
              itemBuilder: (context, index) {
                return boardWidget(
                  imagePath: providerBoardController.board[index].imagePath,
                  name: providerBoardController.board[index].name,
                  position: providerBoardController.board[index].position,
                );
              },
            ),
    );
  }

  Widget boardWidget(
      {@required imagePath, @required name, @required position}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 10.0),
          CachedNetworkImage(
            imageUrl: imagePath,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(75.0)),
                ),
              ),
            ),
            imageBuilder: (context, imageProvider) => Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)],
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.fitWidth,
            repeat: ImageRepeat.noRepeat,
          ),
          SizedBox(height: 15.0),
          Text(
            name,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            position,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
