import 'package:flutter/widgets.dart';
import 'package:smallorgsys/models/board.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BoardController with ChangeNotifier {
  List<Board> _boardList = [];

  void addBoard(Board board) {
    for (int i = 0; i < 10; i++) {
      http.post(
        'https://tedxmiu-11c76-default-rtdb.firebaseio.com/board.json',
        body: json.encode(
          {
            'name': "Board ${i + 1}",
            'imagePath':
                "https://upload.wikimedia.org/wikipedia/commons/3/3f/TechCrunch_Disrupt_2019_%2848834434641%29_%28cropped%29.jpg",
            'position': "Board Position ${i + 1}",
            'order': "${i + 1}",
          },
        ),
      );
    }
    notifyListeners();
  }

  List<Board> get board {
    return [..._boardList];
  }

  Future<void> fetchAndSetBoard() async {
    try {
      final response = await http
          .get('https://tedxmiu-11c76-default-rtdb.firebaseio.com/board.json');
      final dbData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Board> dbBoard = [];
      dbData.forEach((key, data) {
        dbBoard.add(Board(
          id: key,
          position: data['position'],
          order: int.parse(data['order']),
          name: data['name'],
          imagePath: data['imagePath'],
        ));
      });
      _boardList = dbBoard;
      _boardList.sort((a, b) => a.order.compareTo(b.order));
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }
}
