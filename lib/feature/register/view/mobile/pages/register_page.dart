import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/utils/app_snackbar.dart';
import 'package:kujitoon/core/utils/check_strong_password.dart';
import 'package:kujitoon/feature/register/bloc/register_bloc.dart';
import 'package:kujitoon/feature/register/view/mobile/widgets/form_widget.dart';
import 'package:kujitoon/feature/register/view/mobile/widgets/header_widget.dart';

import '../../../../../main.dart';

class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _RegisterPage();

}

class _RegisterPage extends State<RegisterPage>{
  final TextEditingController emailEditting = TextEditingController();
  final TextEditingController passEditting = TextEditingController();
  final TextEditingController userNameEditting = TextEditingController();

  String? errorMesage;
  bool agreePolicy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterBloc, RegisterState>
        (
          builder: (context, state){
            return Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    children: [
                      HeaderWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      FormWidget(emailTextEditing: emailEditting, passwordTextEditing: passEditting, msgError: errorMesage, userNameTextEditing: userNameEditting,),
                      SizedBox(height: 10,),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: agreePolicy,
                                onChanged: (value){
                                  setState(() {
                                    agreePolicy = value??false;
                                  });
                                }),
                            Container(
                              width: MediaQuery.sizeOf(context).width*0.8,
                              child: Text("Tôi đồng ý với Điều khoản sử dụng và Chính sách bảo mật", style: TextStyle(fontFamily: "EncodeSans", color: Colors.black.withAlpha(150), fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis,), maxLines: 1, softWrap: true,),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        onTap: (){
                          if(state is RegisterHandling){
                            return;
                          }

                          String email = emailEditting.text;
                          String password = passEditting.text;
                          String userName = userNameEditting.text;

                          if(email.isEmpty || password.isEmpty || userName.isEmpty){
                            setState(() {
                              errorMesage = "Thông tin không được để trống";
                            });
                            return;
                          }

                          if(CheckStrongPassword.check(password) < 0.5){
                            AppSnackBar.error(context, "Mật khẩu quá yếu");
                            return;
                          }

                          if(!agreePolicy){
                            AppSnackBar.error(context, "Bạn chưa đồng ý điều khoảng");
                            return;
                          }

                          context.read<RegisterBloc>().add(RegisterEvent(email: email, password: password, userName: userName));

                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width*0.9,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: state is RegisterHandling
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
                          Text("Đã có tài khoảng?"),
                          SizedBox(width: 5,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacementNamed(context, '/loginMobile');
                            },
                            child: Text("Đăng Nhập", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state){
            if(state is RegisterSucessed){
              AppSnackBar.success(context, "Đăng kí thành công");
            }else if(state is RegisterFailed){
              AppSnackBar.error(context, "Tài khoản đã tồn tại kiểm tra lại");
            }
          }
      ),

    );
  }

}