import 'package:flutter/material.dart';
import 'constants.dart';
import 'login_page.dart';
import 'package:provider/provider.dart';
import 'auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 1,
        title: Center(
            child: Text(
          "  تسجيل الدخول",
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
              Expanded(
                child: SizedBox(
                  height: 30,
                ),
              ),
              Expanded(
                child: Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Expanded(
                      child: Container(
                        height: 600.0,
                        width: 300,
                        child: Image.asset('assets/logo.png'),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                    controller: _emailController,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'من فضلك أدخل الايميل';
                      }
                      return null; // Return null if the input is valid
                    },
                    decoration: KTextFieldDecoration.copyWith(
                        hintText: 'ادخل الايميل ')),
              ),
              Expanded(
                child: TextFormField(
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
              ),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك أدخل تأكيد كلمة المرور';
                    } else if (value.length < 6) {
                      return 'من فضلك كلمة المرور اكبر من 6 حروف';
                    } else if (value != _passwordController.text) {
                      return 'كلمة المرور غير متطابقة ';
                    }
                    return null; // Return null if the input is valid
                  },
                  decoration: KTextFieldDecoration.copyWith(
                      hintText: 'تأكيد كلمة المرور '),
                  obscureText: true,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 30,
                ),
              ),
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
                        .handleSignUp(
                            _emailController.text, _passwordController.text)
                        .then((value) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }).catchError((e) => print(e));
                  }
                },
                child: Text('التسجيل'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
