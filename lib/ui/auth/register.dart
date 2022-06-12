import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:socialpet/ui/components/AllquAppBar.dart';
import 'package:socialpet/utils/mixins/input_validation_mixin.dart';


class RegisterPage extends StatefulWidget {
  fb.User? _user;
  RegisterPage({Key? key, fb.User? user})
  : _user = user,
    super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with InputValidationMixin{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? countryController;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
              children: [
                AllquAppBar(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Registrate',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      border: OutlineInputBorder(),
                                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8)
                                    ),
                                    validator: (email) => isEmailValid(email!) ? null : 'Email inválido',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: DropdownButtonFormField<String>(
                                    items: ['Perú', 'Chile', 'Argentina'].map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      );
                                    }).toList(),
                                    decoration: InputDecoration(
                                      hintText: 'País',
                                      border: OutlineInputBorder(),
                                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8)
                                    ),
                                    validator: (email) => isEmailValid(email!) ? null : 'Email inválido',
                                    value: countryController,
                                    onChanged: (value) {
                                      setState(() {
                                        countryController = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      
                     ],
                   ),
                 ),
               )
             ],
           )
        ),
      ),
    );
  }
}