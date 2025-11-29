import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/utils/app_snackbar.dart';
import 'package:kujitoon/core/utils/responsive.dart';
import 'package:kujitoon/core/utils/web_toast.dart';
import 'package:kujitoon/feature/auth/bloc/auth_bloc.dart';
import 'package:kujitoon/feature/auth/view/web/widget/form_widget.dart';
import 'package:kujitoon/feature/auth/view/web/widget/header_widget.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginPage();

}

class _LoginPage extends State<LoginPage> {

  TextEditingController emailTextEditing = TextEditingController();
  TextEditingController passwordTextEditing = TextEditingController();
  String? messageError;

  Future<void> login() async {

    var email = emailTextEditing.text;
    var password = passwordTextEditing.text;
    print(email);
    print(password);
    if(email.isEmpty || password.isEmpty){
      messageError = "Mail và mật khẩu không được để trống";
    }else{
      context.read<AuthBloc>().add(LoginEvent(email: email, password: password));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AuthSucessed) {
            WebToast.showSuccess("Đăng nhập thành công");
          }else if(state is AuthFailed){
            setState(() {
              messageError = state.msg;
            });
          }
        },
        builder: (context, state){
          return Container(
            color: Colors.black.withAlpha(20),
            width: screenWidth,
            height: screenHeight,
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  width: screenWidth * 0.65, // box chính
                  constraints: BoxConstraints(
                    maxWidth: 880
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(50),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final boxWidth = constraints.maxWidth;

                      // Desktop: Row, Mobile: Column
                      return Responsive.isDesktop(context)
                          ? Row(
                        children: [
                          Container(
                            width: boxWidth * 0.5,
                            height: 500,
                            child: HeaderWidget(borderRadiusGeometry: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),),
                          ),
                          Container(
                            width: boxWidth * 0.5,
                            height: 500,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: FormWidget(
                                  emailTextEditing: emailTextEditing,
                                  passwordTextEditing: passwordTextEditing,
                                  errorMesage: messageError,
                                  funcLogin: (){
                                    login();
                                  }
                              ),
                            ),
                          ),
                        ],
                      )
                          : Column(
                        children: [
                          Container(
                            width: boxWidth,
                            height: 250,
                            child: HeaderWidget(borderRadiusGeometry: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),),
                          ),
                          Container(
                            width: boxWidth,
                            height: 550,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: FormWidget(
                                  emailTextEditing: emailTextEditing,
                                  passwordTextEditing: passwordTextEditing,
                                  errorMesage: messageError,
                                  funcLogin: (){
                                    login();
                                  }
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}

