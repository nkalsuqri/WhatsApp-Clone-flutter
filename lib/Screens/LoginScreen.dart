import 'package:chatapp/CustomUI/ButtonCard.dart';
import 'package:chatapp/Model/ChatModel.dart';
import 'package:chatapp/Screens/Homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ChatModel sourceChat;
  List<ChatModel> chatmodels = [
    ChatModel(
      name: "ناصر الصقري",
      isGroup: false,
      currentMessage: " السلام عليكم",
      time: "4:00",
      icon: "person.svg",
      id: 1,
    ),
    ChatModel(
      name: "محمد عبدالله",
      isGroup: false,
      currentMessage: "عليكم السلام ورحمة الله وبركاته ",
      time: "13:00",
      icon: "person.svg",
      id: 2,
    ),

    ChatModel(
      name: "أبو محمد",
      isGroup: false,
      currentMessage: "أهلا وسهلا  ",
      time: "8:00",
      icon: "person.svg",
      id: 3,
    ),

    ChatModel(
      name: "٩٣٤٥٢٧٨٤",
      isGroup: false,
      currentMessage: "مراحب   ",
      time: "2:00",
      icon: "person.svg",
      id: 4,
    ),

    // ChatModel(
    //   name: "NodeJs Group",
    //   isGroup: true,
    //   currentMessage: "New NodejS Post",
    //   time: "2:00",
    //   icon: "group.svg",
    // ),
  ];
  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
              itemCount: chatmodels.length,
              itemBuilder: (contex, index) => InkWell(
                    onTap: () {
                      sourceChat = chatmodels.removeAt(index);
                      print(sourceChat.name.toString());
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => Homescreen(
                                    chatmodels: chatmodels,
                                    sourchat: sourceChat,
                                  )));
                    },
                    child: ButtonCard(
                      name: chatmodels[index].name,
                      icon: Icons.person,
                    ),
                  ))),
    );
  }
  */

  List data;

  Future getData() async {
    var response = await http.get(
        Uri.parse("http://alsuqri.com/other/post.php"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = jsonDecode(response.body);
    });

    print(data[1]["name"]);

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Listviews"), backgroundColor: Colors.blue),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Card(
              child: ButtonCard(
                name: data[index]["name"],
                icon: Icons.person,
              ), //new Text(data[index]["title"]),
            ),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => Homescreen(
                            name: data[index]["name"],
                            currentMessage: data[index]["currentMessage"],
                            isGroup: data[index]["isGroup"],
                            time: data[index]["time"],
                            icon: data[index]["icon"],
                            id: data[index]["id"],
                          )));
            },
          );
        },
      ),
    );
  }
}
