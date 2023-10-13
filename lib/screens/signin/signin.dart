import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/bloc/category/category_bloc.dart';
import 'package:grocery_app/utils/Session.dart';

import '../../bloc/Auth/auth_bloc.dart';
import '../../bloc/Auth/auth_event.dart';
import '../../bloc/Auth/auth_state.dart';
import '../../bloc/category/category_event.dart';
import '../../models/auth.dart';
import '../../utils/colors.dart';
import '../home/home.dart';

class SigninScreen extends StatefulWidget {
  static String routeName = '/signin-screen';

  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _visiblePassword = false;
  bool isFirst = true;
  String password = "";
  String phone = "";
  submitLogin() {
    setState(() {
      isFirst = false;
    });
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      BlocProvider.of<AuthBloc>(context).add(
          AuthLogin(Auth(phone: phone, password: password, country: "ETH")));
    }
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        autovalidateMode: isFirst ? null : AutovalidateMode.onUserInteraction,
        child: ListView(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/placeholderbanner.png'),
                  fit: BoxFit.cover,
                ),
              ),
              height: MediaQuery.of(context).size.height * .5,
              child: Container(
                height: 20,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
              ),
            ),
            Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: const Text(
                  "Sigin",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: TextFormField(
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                style: const TextStyle(fontSize: 18),
                maxLength: 9,
                decoration: const InputDecoration(
                  counterText: '',
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 0, minHeight: 0),
                  alignLabelWithHint: true,
                  labelText: "Phone",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(style: BorderStyle.solid),
                  ),
                ),
                validator: (value) {
                  String _value = value.toString().trim();
                  if (_value.isEmpty) {
                    return "Phone cannot be empty";
                  } else if (_value.length < 9) {
                    return "Phone length error";
                  }
                  return null;
                },
                onChanged: (value) {},
                onSaved: (value) {
                  phone = value!;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: TextFormField(
                style: const TextStyle(fontSize: 18),
                obscureText: true,
                decoration: InputDecoration(
                  counterText: '',
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 0, minHeight: 0),
                  alignLabelWithHint: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _visiblePassword = !_visiblePassword;
                      });
                    },
                    icon: Icon(_visiblePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  labelText: "Password",
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(style: BorderStyle.solid),
                  ),
                ),
                validator: (value) {
                  String _value = value.toString().trim();
                  if (_value.isEmpty) {
                    return "please enter password";
                  }
                  return null;
                },
                onChanged: (value) {},
                onSaved: (value) {
                  password = value!;
                },
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 40),
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        backgroundColor: ColorProvider().lightYellow),
                    onPressed: () {
                      submitLogin();
                    },
                    child: BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                      Session().logSession("login state", state.toString());
                      if (state is AuthOperationFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(state.reason!),
                          ),
                        );
                      }
                      if (state is AuthLoginSuccess) {
                        BlocProvider.of<CategoryBloc>(context)
                            .add(CategoryLoad());
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomeScreen.routeName, (route) => false);
                      }
                    }, builder: (context, state) {
                      if (state is AuthSigningIn) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "   signing in...",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        );
                      }
                      return const Text("SIGN IN");
                    })))
          ],
        ),
      ),
    );
  }
}
