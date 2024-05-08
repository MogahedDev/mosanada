import 'package:flutter/material.dart';
import 'package:mosanadah2024/user_type.dart';
import 'register_page.dart';
import 'donor_page.dart';
import 'constants.dart';
import 'auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final String usertype1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => UserType())),
        ),
        titleSpacing: 1,
        title: Center(
            child: Text(
          "    المتبرع",
          style: TextStyle(
              color: Color(0xffB1D4D6),
              fontSize: 30.0,
              fontWeight: FontWeight.bold),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _emailController,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك أدخل الايميل';
                  }
                  return null; // Return null if the input is valid
                },
                decoration:
                    KTextFieldDecoration.copyWith(hintText: 'ادخل الايميل '),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _passwordController,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك أدخل كلمة المرور';
                  } else if (value.length < 6) {
                    return 'من فضلك كلمة المرور اكبر من 6 حروف';
                  }
                  return null; // Return null if the input is valid
                },
                decoration: KTextFieldDecoration.copyWith(
                    hintText: 'ادخل كلمة المرور '),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xffE5B895), // Text color
                  padding: EdgeInsets.all(16), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8.0), // Button border radius
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await auth
                        .handleSignInEmail(
                            _emailController.text, _passwordController.text)
                        .then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DonorScreen()));
                    }).catchError((e) => print(e));
                    // Login successful, navigate to home page or perform other actions
                  } else {}
                },
                child: Text('دخــول'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xffE5B895), // Text color
                  padding: EdgeInsets.all(16), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8.0), // Button border radius
                  ),
                ),
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));

                  // Login successful, navigate to home page or perform other actions

                  // Login failed, show an error message
                },
                child: Text(' إنشاء حــســاب  '),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
