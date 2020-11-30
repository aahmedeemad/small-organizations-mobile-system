import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class EvalMembers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Evaluate members')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                labelText: 'Search by name',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return
                    member(name: "Mark Refaat $index", imagePath: null);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget member({@required name, @required imagePath}) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(name),
      ),
    );
  }
}

// class StarDisplay extends StatelessWidget {
//   final int value;
//   const StarDisplay({Key key, this.value = 0})
//       : assert(value != null),
//         super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(5, (index) {
//         return Icon(
//           index < value ? Icons.star : Icons.star_border,
//         );
//       }),
//     );
//   }
// }
