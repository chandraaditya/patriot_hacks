import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'controller/form_controller.dart';
import 'model/form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(247, 205, 84, 1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 800,
                  child: Image.asset('assets/logo-2018-hi-res-green.png')
              ),
              SizedBox(
                height: 100,
              ),
              SizedBox(
                  width: 500,
                  height: 600,
                  child: SignUpForm()
              )
            ],
          ),
        ),
      ),
    );

    // return MaterialApp(
    //   title: 'Flutter Google Sheet Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //     backgroundColor:
    //   ),
    //   home: MyHomePage(title: 'Flutter Google Sheet Demo'),
    // );
  }
}

class SignUpForm extends StatefulWidget {
  SignUpForm({Key key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      FeedbackForm feedbackForm = FeedbackForm(
          nameController.text,
          emailController.text,
          mobileNoController.text,
          feedbackController.text);
      FormController formController = FormController();
      _showSnackbar("Submitting Feedback");
      formController.submitForm(feedbackForm, (String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          _showSnackbar("Feedback Submitted");
        } else {
          _showSnackbar("Error Occurred!");
        }
      });
    }
  }

  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            offset: Offset(10, 10)
          ),
          BoxShadow(
            color: Colors.grey,
          )
        ]
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(42, 100, 56, 1),
        key: _scaffoldKey,
        body: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sign up",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 90,
                      color: Colors.white,
                  ),
                ),
                Form(
                    key: _formKey,
                    child:
                    Padding(padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Valid Name';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: 'Name',
                              labelStyle: TextStyle(color: Colors.white54),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (!value.contains("@") || !value.contains(".")) {
                                return 'Enter Valid Email';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white54),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: mobileNoController,
                            validator: (value) {
                              if (value.trim().length != 10) {
                                return 'Enter 10 Digit Mobile Number';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Mobile Number',
                              labelStyle: TextStyle(color: Colors.white54),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: feedbackController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Valid Feedback';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                labelText: 'Feedback',
                              labelStyle: TextStyle(color: Colors.white54),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                ButtonTheme(
                  minWidth: 300,
                  height: 45,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: OutlineButton(
                      highlightElevation: 0,
                      textColor: Color.fromRGBO(255, 255, 255, 1),
                      onPressed:_submitForm,
                      child: Text('Submit Feedback'),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}