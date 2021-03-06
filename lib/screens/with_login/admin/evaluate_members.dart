import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:smallorgsys/models/user.dart';
import 'package:smallorgsys/providers/users_provider.dart';
import 'package:smallorgsys/widgets/network_error_widget.dart';

class EvalMembers extends StatefulWidget {
  @override
  _EvalMembersState createState() => _EvalMembersState();
}

class _EvalMembersState extends State<EvalMembers> {
  UsersController providerUsersController;
  Future<List<User>> users;
  @override
  void initState() {
    super.initState();
    providerUsersController =
        Provider.of<UsersController>(context, listen: false);
    providerUsersController.fetchAndSetUsers().then((_) {
      setState(() {
        users = Future.value(providerUsersController.users);
      });
    });
  }

  Future<void> _refresh(context) async {
    setState(() {
      providerUsersController.fetchAndSetUsers();
      users = Future.value(providerUsersController.users);
    });
  }

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
              onChanged: (val) {
                users = Future.value(providerUsersController.users);
                setState(() {
                  users.then((u) {
                    users = Future.value(u
                        .where((user) =>
                            user.name.toLowerCase().contains(val.toLowerCase()))
                        .toList());
                  });
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: users,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      // List<User> users = providerUsersController.users;
                      print(users);
                      return RefreshIndicator(
                        onRefresh: () => _refresh(context),
                        child: ListView(
                          children: [
                            for (final User user in snapshot.data)
                              member(
                                  name: user.name,
                                  imagePath: user.imagePath,
                                  id: user.id,
                                  rating: user.rating)
                          ],
                        ),
                      );
                    } else
                      return NetworkErrorWidget(
                          retryButton: () => _refresh(context));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget member(
      {@required String name,
      @required String imagePath,
      @required String id,
      @required int rating}) {
    return Card(
      elevation: 3.0,
      child: ListTile(
        // leading: Icon(Icons.person),
        leading: new CircleAvatar(
          backgroundColor: Colors.black87,
          minRadius: 10.0,
          maxRadius: 20.0,
          child: new ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: new Image.network(
              imagePath,
            ),
          ),
        ),
        title: Text(name),
        subtitle: StarDisplay(
          value: rating,
          id: id,
        ),
        onTap: () {},
      ),
    );
  }
}

class StarDisplay extends StatelessWidget {
  final dynamic value;
  final dynamic id;
  StarDisplay({@required this.value, @required this.id});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: value.toDouble(),
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        Provider.of<UsersController>(context, listen: false)
            .updateUserRating(userId: id, rating: rating.toInt());
      },
    );
  }
}
