import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/utils/app_snackbar.dart';
import 'package:kujitoon/feature/auth/bloc/auth_bloc.dart';
import 'package:kujitoon/feature/auth/domain/usecases/login_usecase.dart';
import 'package:kujitoon/feature/auth/view/mobile/widget/form_widget.dart';
import 'package:kujitoon/feature/auth/view/mobile/widget/header_widget.dart';
import 'package:kujitoon/main.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: _LoginPageContent(),
    );
  }
}

// Widget con giữ StatefulWidget UI
class _LoginPageContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<_LoginPageContent> {
  TextEditingController emailTextEditing = TextEditingController();
  TextEditingController passwordTextEditing = TextEditingController();
  bool rememberPassword = false;
  String? messageError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AuthSucessed) {
            AppSnackBar.success(context, "Đăng nhập thành công");
          }else if(state is AuthFailed){
            setState(() {
              messageError = state.msg;
            });
          }
        },
        builder: (context, state) {
          return SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  HeaderWidget(),
                  SizedBox(height: 30,),
                  Text("Đăng Nhập", style: TextStyle(fontFamily: "EncodeSans", fontWeight: FontWeight.bold, fontSize: 25),),
                  Text("Nhập thông tin tài khoản của bạn", style: TextStyle(fontFamily: "EncodeSans", color: Colors.black.withAlpha(150), fontSize: 18),),
                  SizedBox(height: 40,),
                  FormWidget(emailTextEditing: emailTextEditing, passwordTextEditing: passwordTextEditing, msgError: messageError,),
                  Container(
                      width: MediaQuery.sizeOf(context).width,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  activeColor: Colors.blue,
                                  value: rememberPassword,
                                  onChanged: (value){
                                    setState(() {
                                      rememberPassword = value??false;
                                    });
                                  }),
                              Text("Ghi Nhớ Đăng Nhập")
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){},
                                child: Text("Quên Mật Khẩu", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                              ),
                              SizedBox(width: 10,)
                            ],
                          ),
                        ],
                      )
                  ),
                  SizedBox(height: 40,),
                  GestureDetector(
                    onTap: (){
                      if(state is AuthHandling){
                        return;
                      }

                      var email = emailTextEditing.text;
                      var password = passwordTextEditing.text;
                      if(email.isEmpty || password.isEmpty){
                        messageError = "Mail và mật khẩu không được để trống";
                      }else{
                        context.read<AuthBloc>().add(LoginEvent(email: email, password: password));
                      }
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width*0.9,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: state is AuthHandling
                            ? Container(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(color: Colors.white,),
                        )
                            : Text("Đăng Kí", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Chưa có tài khoảng?"),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, '/registerMobile');
                        },
                        child: Text("Đăng Kí", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
