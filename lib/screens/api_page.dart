import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mini_ecommerce/model/api_model.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({Key? key}) : super(key: key);

  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  Future<List<ApiModel>> _getUserList() async {
    try {
      var response =
          await Dio().get('https://breakingbadapi.com/api/characters');
      List<ApiModel> _userList = [];
      if (response.statusCode == 200) {
        _userList =
            (response.data as List).map((e) => ApiModel.fromMap(e)).toList();
      }
      return _userList;
    } on DioError catch (e) {
      print(e.toString());
      return Future.error(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    _getUserList();
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<ApiModel>>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var userList = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  var user = userList![index];
                  return ListTile(
                    title: Text(user.img.toString()),
                    subtitle: Text(user.birthday.toString()),
                    leading: Text(user.name.toString()),
                  );
                },
                itemCount: userList!.length,
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else
              return CircularProgressIndicator();
          },
          future: _getUserList(),
        ),
      ),
    );
  }
}
