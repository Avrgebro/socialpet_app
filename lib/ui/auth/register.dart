import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:socialpet/core/auth/register/bloc/register_bloc.dart';
import 'package:socialpet/data/providers/country_provider.dart';
import 'package:socialpet/data/repositories/auth_repository.dart';
import 'package:socialpet/ui/components/AllquAppBar.dart';
import 'package:socialpet/utils/mixins/input_validation_mixin.dart';
import 'package:socialpet/core/auth/authentication/bloc/authentication_bloc.dart';



class RegisterPage extends StatefulWidget {
  final fb.User? _user;
  RegisterPage({Key? key, fb.User? user})
  : _user = user,
    super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with InputValidationMixin{
  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final dateController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  Map<String,dynamic>? _countryController;
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> _countries = [];
  DateTime? _selectedDate = DateTime.now();

  Future<void> getCountries() async {
    var response = await CountryProvider.fetchCountries();
    setState(() {
      this._countries = response!;
    });
  }

  Map<String,dynamic> mapData() {
    final Map<String,dynamic> data = new Map<String,dynamic>();

    data['name'] = nameController.text;
    data['lastname'] = lastnameController.text;
    data['email'] = emailController.text;
    data['phone'] = phoneController.text;
    data['country_id'] = _countryController!['id'];
    data['birthday'] = dateController.text;
    if(widget._user == null){
      data['password'] = passwordController.text;
      data['password_confirmation'] = passwordConfirmationController.text;
    } else {
      data['firebase_uuid'] = widget._user!.uid;
    }

    return data;

  }

  @override
  void initState() {
    super.initState();
    this.getCountries();

    if(widget._user != null) this.emailController.text = widget._user!.email!;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterBloc(authRepository: AuthRepository()),
        child: SafeArea(
          child: Column(
            children: [
              AllquAppBar(),
              Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Padding(
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
                                    child: BlocListener<RegisterBloc, RegisterState>(
                                      listener: (context, state) {
                                        if(state is RegisterFailed){
                                          Flushbar(
                                            title:  "Uups! no pudimos Registrarte",
                                            message:  state.message,
                                            duration:  Duration(seconds: 3),
                                            margin: EdgeInsets.all(8),
                                            borderRadius: BorderRadius.circular(8),
                                            flushbarPosition: FlushbarPosition.BOTTOM,
                                            icon: Icon(
                                              Icons.info_outline,
                                              size: 28.0,
                                              color: Colors.white,
                                            ),
                                            backgroundColor: Colors.red[500]!,

                                          )..show(context);
                                        } else if (state is RegisterSucceded) {
                                          BlocProvider.of<AuthenticationBloc>(context).add(UserLoggedIn());
                                          Navigator.pop(context);
                                          Flushbar(
                                            title:  "Bienvenido!!",
                                            message:  "Te has registrado correctamente",
                                            duration:  Duration(seconds: 3),
                                            margin: EdgeInsets.all(8),
                                            borderRadius: BorderRadius.circular(8),
                                            flushbarPosition: FlushbarPosition.BOTTOM,
                                            icon: Icon(
                                              Icons.check_circle_outline_rounded,
                                              size: 28.0,
                                              color: Colors.white,
                                            ),
                                            backgroundColor: Colors.green[500]!,

                                          )..show(context);
                                        }
                                      },
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: TextFormField(
                                                      controller: nameController,
                                                      textCapitalization: TextCapitalization.words,
                                                      decoration: InputDecoration(
                                                        hintText: 'Nombre',
                                                        border: OutlineInputBorder(),
                                                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8)
                                                      ),
                                                      validator: (name) => isTextValid(name!) ? null : 'Nombre inválido',
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.0,),
                                                  Flexible(
                                                    child: TextFormField(
                                                      controller: lastnameController,
                                                      textCapitalization: TextCapitalization.words,
                                                      decoration: InputDecoration(
                                                        hintText: 'Apellido',
                                                        border: OutlineInputBorder(),
                                                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8)
                                                      ),
                                                      validator: (text) => isTextValid(text!) ? null : 'Apellido inválido',
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: TextFormField(
                                                controller: emailController,
                                                enabled: widget._user == null,
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
                                              child: DropdownButtonFormField(
                                                items: _countries.map((e) {
                                                  return DropdownMenuItem(
                                                    value: e,
                                                    child: Container(
                                                      child: Row(
                                                        children: [
                                                          Image.network(e['flag_url'],
                                                            scale: 10.0,
                                                          ),
                                                          SizedBox(width: 8.0,),
                                                          Text(e['name']!),
                                                        ],
                                                      )
                                                    ),
                                                  );
                                                }).toList(),
                                                decoration: InputDecoration(
                                                  hintText: 'País',
                                                  border: OutlineInputBorder(),
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8)
                                                ),
                                                value: _countryController,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _countryController = value! as Map<String, dynamic>;
                                                  });
                                                },
                                                validator: (country) => country != null ? null : 'Selecciona un País',
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    flex: 7,
                                                    child: TextFormField(
                                                      controller: phoneController,
                                                      decoration: InputDecoration(
                                                        prefixIcon: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                            decoration: BoxDecoration(
                                                              color: Colors.grey.shade300,
                                                              borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            width: 85,
                                                            child: Row(
                                                              children: [
                                                                if(_countryController != null) Image.network(_countryController!['flag_url'],
                                                                  scale: 12.0,
                                                                ),
                                                                SizedBox(width: 4),
                                                                Text(_countryController != null ? '+'+_countryController!['calling_code'] : '')
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        hintText: 'Teléfono',
                                                        border: OutlineInputBorder(),
                                                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8)
                                                      ),
                                                      keyboardType: TextInputType.phone,
                                                      validator: (phone) => isPhoneValid(phone!) ? null : 'Teléfono inválido',
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.0,),
                                                  Flexible(
                                                    flex: 5,
                                                    child: TextFormField(
                                                      controller: dateController,
                                                      decoration: InputDecoration(
                                                        hintText: 'Nacimiento',
                                                        border: OutlineInputBorder(),
                                                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8)
                                                      ),
                                                      validator: (date) => isTextValid(date!) ? null : 'Fecha inválida',
                                                      onTap: () async {
                                                        FocusScope.of(context).requestFocus(FocusNode());
                                                        DateTime? date = await showDatePicker(
                                                          context: context, 
                                                          initialDate:_selectedDate!,
                                                          firstDate:DateTime(1900),
                                                          lastDate: DateTime.now()
                                                        );
                                                        if(date != null) _selectedDate = date;
                                                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                                                        dateController.text = _selectedDate != null ? formatter.format(_selectedDate!) : '';
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            if(widget._user == null) Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: TextFormField(
                                                controller: passwordController,
                                                obscureText: true,
                                                enableSuggestions: false,
                                                autocorrect: false,
                                                decoration: InputDecoration(
                                                  hintText: 'Contraseña',
                                                  border: OutlineInputBorder(),
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8)
                                                ),
                                                validator: (password) => isPasswordValid(password!)! ? null : 'Contraseña inválida',
                                                keyboardType: TextInputType.visiblePassword,
                                              ),
                                            ),
                                            if(widget._user == null) Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: TextFormField(
                                                controller: passwordConfirmationController,
                                                obscureText: true,
                                                enableSuggestions: false,
                                                autocorrect: false,
                                                decoration: InputDecoration(
                                                  hintText: 'Confirmar contraseña',
                                                  border: OutlineInputBorder(),
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8)
                                                ),
                                                validator: (password) => doPasswordsMatch(passwordController.text, password!) ? null : 'Las contraseñas no coinciden',
                                                keyboardType: TextInputType.visiblePassword,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                                              child: BlocBuilder<RegisterBloc, RegisterState>(
                                                builder: (context, state) {
                                                                      
                                                  return state is RegisterAttempted
                                                  ? CircularProgressIndicator()
                                                  : ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        minimumSize: Size.fromHeight(60.0),
                                                        shadowColor: Colors.black,
                                                        elevation: 12.0
                                                      ),
                                                      onPressed: () => {
                                                        if(_formKey.currentState!.validate()){
                                                          context.read<RegisterBloc>().add(RegisterUserSelected(userdata: mapData()))
                                                        }
                                                      },
                                                      child: Text('Registrarme')
                                                    );
                                                }
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                
                               ],
                             ),
                           ),
                                         ),
                                   ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}