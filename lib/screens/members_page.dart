import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smallorgsys/controllers/users_controller.dart';
import 'package:smallorgsys/screens/drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';

// class Members extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('IT members')),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 icon: Icon(Icons.search),
//                 labelText: 'Search by name',
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 15,
//               itemBuilder: (context, index) {
//                 return eventCard(
//                       imagePath: providerUsersController.news[index].imagePath,
//                       id: providerNewsController.news[index].id);
//                 },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget member({@required name, @required imagePath}) {
//     return Card(
//       child: ListTile(
//         leading: Icon(Icons.person),
//         title: Text(name),
//       ),
//     );
//   }
// }
class Members extends StatefulWidget {
  @override
  _MembersPageState createState() => _MembersPageState();
}

class _MembersPageState extends State<Members> {

  var _isLoading = true;
  var providerUsersController;
  @override
  void initState() {
    Provider.of<UsersController>(context, listen: false)
        .fetchAndSetUsers()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  Future<void> _refresh(context) async {
    await providerUsersController.fetchAndSetUsers();
  }

  @override
  Widget build(BuildContext context) {
    providerUsersController = Provider.of<UsersController>(context);
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        title: Text('Members'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => _refresh(context),
              child: ListView.builder(
                itemCount: providerUsersController.users.length,
                itemBuilder: (context, index) {
                  return eventCard(
                      imagePath: providerUsersController.users[index].imagePath,
                      name: providerUsersController.users[index].name);
                },
              ),
            ),
    );
  }

  Widget eventCard({@required imagePath, @required name}) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => NewsDetailsPage(id),
            // ));
          },
          child: Card(
            child: Hero(
              tag: name,
              child: CachedNetworkImage(
                imageUrl: imagePath,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                height: 160,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}