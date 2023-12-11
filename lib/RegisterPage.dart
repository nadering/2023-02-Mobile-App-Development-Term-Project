import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:madteamproject/SuccessRegister.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: const RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _authentication = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Email'
              ),
              onChanged: (value){
                email = value;
              },
            ),
            SizedBox(height: 20,),
            TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
                onChanged: (value){
                  password = value;
                }
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () async {
              try {
                final newUser =
                await _authentication.createUserWithEmailAndPassword(
                    email: email, password: password);
                if (newUser.user != null) {
                  _formKey.currentState!.reset();
                  if (!mounted) return; // anync 때문에 트리가 아직 mount 되지 않았을 수 있다.
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SuccessRegisterPage()));
                }
              }catch(e){
                print(e);
              }

            }, child: Text('Enter')),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('이미 회원가입을 하셨다면?'),
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('로그인 하기')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

