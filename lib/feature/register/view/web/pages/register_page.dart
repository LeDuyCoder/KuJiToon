import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/routes/fade_route.dart';
import 'package:kujitoon/core/utils/check_strong_password.dart';
import 'package:kujitoon/core/utils/responsive.dart';
import 'package:kujitoon/core/utils/web_toast.dart';
import 'package:kujitoon/feature/register/bloc/register_bloc.dart';
import 'package:kujitoon/feature/register/view/web/widgets/header_widget.dart';
import 'package:kujitoon/feature/register/view/web/widgets/form_widget.dart';

import '../../../../../main.dart';
import '../../../../auth/view/web/pages/login_page.dart';

class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage>{
  final TextEditingController emailEditing = TextEditingController();
  final TextEditingController passwordEditing = TextEditingController();
  final TextEditingController userNameEditing = TextEditingController();

  String? messageError;
  bool agreePolicy = false;

  Future<void> register(bool agreePolicy, RegisterState state) async {
    if(state is RegisterHandling){
      return;
    }

    String email = emailEditing.text;
    String password = passwordEditing.text;
    String userName = userNameEditing.text;

    if(email.isEmpty || password.isEmpty || userName.isEmpty){
      setState(() {
        messageError = "Thông tin không được để trống";
      });
      return;
    }

    if(CheckStrongPassword.check(password) < 0.5){
      WebToast.showWarning("Mật khẩu quá yếu");
      return;
    }

    if(!agreePolicy){
      WebToast.showError("Bạn chưa đồng ý điều khoảng");
      return;
    }

    context.read<RegisterBloc>().add(RegisterEvent(email: email, password: password, userName: userName));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return BlocProvider(
      create: (_) => sl<RegisterBloc>(),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state){
          if(state is RegisterSucessed){
            WebToast.showSuccess("Đăng kí thành công");
          }else if(state is RegisterFailed){
            WebToast.showError("Tài khoản đã tồn tại kiểm tra lại");
          }
        },
        builder: (context, state){
          return Scaffold(
            backgroundColor: Colors.black.withAlpha(20),
            body: Container(
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
                              height: 700,
                              child: HeaderWidget(borderRadiusGeometry: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),),
                            ),
                            Container(
                              width: boxWidth * 0.5,
                              height: 700,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: FormWidget(
                                    emailTextEditing: emailEditing,
                                    passwordTextEditing: passwordEditing,
                                    userNameTextEditing: userNameEditing,
                                    errorMesage: messageError,
                                    funcLogin: (agreePolicy){
                                      register(agreePolicy, state);
                                    },
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
                              height: 600,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: FormWidget(
                                  emailTextEditing: emailEditing,
                                  passwordTextEditing: passwordEditing,
                                  userNameTextEditing: userNameEditing,
                                  errorMesage: messageError,
                                  funcLogin: (agreePolicy){
                                    register(agreePolicy, state);
                                  },
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
            ),
          );
        }
      ),
    );
  }

}