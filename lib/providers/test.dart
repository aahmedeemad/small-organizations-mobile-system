import 'package:http/http.dart' as http;
import 'dart:convert';

main(List<String> args) async {
  final userId = '9diA707XhicUhwo3IUJMkxkb4Xb2';
  final res = await http.post(
      'https://tedxmiu-11c76-default-rtdb.firebaseio.com/usersTasks/$userId.json',
      body: jsonEncode({
        'title': 'task1',
        'description': 'desc1',
        'status': true,
        'committee': 'HR'
      }));
  if (res.statusCode == 200) {
    var dbData = jsonDecode(res.body);

    return {
      'success': true,
      'tasks': dbData,
    };
  } else
    return {'success': false};
}
