import 'package:flutter/material.dart';
import 'package:flutter_app/page_login.dart';
import 'package:flutter_app/page_nodes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerLeft extends StatefulWidget {
  @override
  _DrawerLeftState createState() => _DrawerLeftState();
}

class _DrawerLeftState extends State<DrawerLeft> {
  bool isLogined = false;
  String userName = "", avatar = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260.0,
      child: new Drawer(
        child: SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: GestureDetector(
                  onTap: () {
                    if (!isLogined) {
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => new LoginPage()));
                    }
                  },
                  child: new Text(
                    isLogined ? userName : "       登录",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                accountEmail: new Text(""), // todo 邮箱
                currentAccountPicture: new GestureDetector(
                  onTap: () {
                    if (!isLogined) {
                      //未登录
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => new LoginPage()));
                    } else {
                      // todo -> 个人中心页面
                    }
                  },
                  child:
                      /*new FadeInImage.assetNetwork(
                    placeholder: "images/ic_account_circle_white_48dp.png",
                    image: avatar,
                    width: 90.0,
                    height: 90.0,
                  )*/
                      new CircleAvatar(
                    backgroundImage: isLogined
                        ? new NetworkImage(
                            "https://cdn.v2ex.com/gravatar/3896b6baf91ec1933c38f370964647b7?s=73&d=retro")
                        : new AssetImage("assets/images/ic_person.png"),
                  ),
                ),
                // todo 这里可以根据一天的不同时间显示不同的background，增加美观
                /*decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.cover, image: new NetworkImage("https://i.loli.net/2018/12/06/5c08c7b804e89.png"))),*/
              ),

              // todo 目前没必要，这里后面考虑要不要有
              /*new ListTile(
              leading: new Icon(Icons.explore),
              title: new Text("浏览"),
              onTap: () {
                Navigator.pop(context);
              },
            ),*/

              new ListTile(
                leading: new Icon(Icons.apps),
                title: new Text("节点"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new NodesPage()));
                },
              ),
              new ListTile(
                enabled: false, // todo 登录后打开
                leading: new Icon(Icons.notifications),
                title: new Text("通知"),
              ),
              new ListTile(
                enabled: false, // todo 登录后打开
                leading: new Icon(Icons.favorite),
                title: new Text("收藏"),
              ),
              new Divider(),
              new ListTile(
                leading: new Icon(Icons.settings),
                title: new Text("设置"),
              ),
              new ListTile(
                leading: new Icon(Icons.feedback),
                title: new Text("反馈"),
              ),
              new AboutListTile(
                icon: new Icon(Icons.info),
                child: new Text("关于"),
                applicationName: "V2LF",
                applicationVersion: "v0.0.1",
                applicationIcon: new Image.asset(
                  "assets/images/icon/ic_launcher.png",
                  width: 64.0,
                  height: 64.0,
                ),
                aboutBoxChildren: <Widget>[
                  new Text("Another v2ex unoffical app.\n"),
                  new Text("'V2LF' means 'way to love flutter'.\n"),
                  new Text('¯\\_(ツ)_/¯')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future checkLoginState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool("is_login") != null) {
      setState(() {
        isLogined = sharedPreferences.getBool("is_login");
        if (isLogined) {
          userName = sharedPreferences.getString("user_name");
          avatar = sharedPreferences.getString("avatar");
        }
      });
    }
  }
}