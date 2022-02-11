import 'package:flutter/material.dart';
import 'package:http_get_samples/model/user_model.dart';

import 'data/user_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserService _service = UserService();
  bool? isLoading;

  List<UserModelData>? users;

  @override
  void initState() {
    super.initState();
    _service.fetchUsers().then((value) {
      setState(() {
        if (value != null && value.data != null) {
          users = value.data;
          isLoading =true;
        }else{
          setState(() {
            isLoading = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: isLoading == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : isLoading == true ? ListView.builder(
                itemCount: users!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                          '${users![index].firstName} ${users![index].lastName}'),
                      subtitle: Text('${users![index].email}'),
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage('${users![index].avatar}'),
                      ),
                    ),
                  );
                }) : Center(child: Text('Bir Hata Oluştu'),),
      ),
    );
  }
}
