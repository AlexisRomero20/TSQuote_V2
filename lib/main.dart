import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'widgets/MySQL_DataTable_A/datatabledemo.dart';
import 'widgets/MySQL_DataTable_M/datatabledemo.dart';
import 'widgets/apimaps/Mapa.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('Inicio de Sesion')),
            body: Center(child: LoginUser())));
  }
}

class LoginUser extends StatefulWidget {
  LoginUserState createState() => LoginUserState();
}

class LoginUserState extends State {
  // For CircularProgressIndicator.
  bool visible = false;

  // Getting value from TextField widget.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userLogin() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String email = emailController.text;
    String password = passwordController.text;

    // SERVER LOGIN API URL
    var url = 'http://192.168.100.29:80/agendaCita/login_user.php';

    // Store all data with Param Name.
    var data = {'email': email, 'password': password};

    // Starting Web API Call.
    var response = await http.post(Uri.parse(url), body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If the Response Message is Matched.
    /*if(message == 'Maestro')
    {

      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Navigate to Profile Screen & Sending Email to Next Screen.
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen(email : emailController.text))
      );
    }
    else{

      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );}*/

    switch (message) {
      case 'Maestro':
      // Hiding the CircularProgressIndicator.
        setState(() {
          visible = false;
        });

        // Navigate to Profile Screen & Sending Email to Next Screen.
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProfileScreen(email: emailController.text)));
        break;
      case 'Alumno':
      // Hiding the CircularProgressIndicator.
        setState(() {
          visible = false;
        });

        // Navigate to Profile Screen & Sending Email to Next Screen.
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProfileScreenF(email: emailController.text)));
        break;
      default:

      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
        setState(() {
          visible = false;
        });

        // Showing Alert Dialog with Response JSON Message.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(message),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Inicio de Sesion', style: TextStyle(fontSize: 21))),
                  Divider(),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage('https://sites.google.com/site/loupvinrodriguez/_/rsrc/1448582874464/home/UTP.jpg'),
                          radius: 70,
                        ),
                      )
                    ],
                  ),
                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: emailController,
                        autocorrect: true,
                        decoration: InputDecoration(hintText: 'E-Mail (Institucional)'),
                      )),
                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: passwordController,
                        autocorrect: true,
                        obscureText: true,
                        decoration:
                        InputDecoration(hintText: 'Contraseña'),
                      )),
                  RaisedButton(
                    onPressed: userLogin,
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                    child: Text('Iniciar'),
                  ),
                  Container(
                    child: RaisedButton(
                      child: Text('Consulta Mapa'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InvocMapa()),
                        );
                      },
                    ),
                  ),
                  Visibility(
                      visible: visible,
                      child: Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: CircularProgressIndicator())),
                ],
              ),
            )));
  }
}

class ProfileScreen extends StatelessWidget {
// Creating String Var to Hold sent Email.
  final String email;

// Receiving Email using Constructor.
  ProfileScreen({required this.email});

// User Logout Function.
  logout(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataTableDemo(),
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.green
      ),
    );
  }
}

class ProfileScreenF extends StatelessWidget {
// Creating String Var to Hold sent Email.
  final String email;

// Receiving Email using Constructor.
  ProfileScreenF({required this.email});

// User Logout Function.
  logout(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataTableDemoA(),
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.green
      ),
    );
  }
}

class InvocMapa extends StatelessWidget {
// User Logout Function.
  logout(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyAppMapa(),
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),
    );
  }
}
