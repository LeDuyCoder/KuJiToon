import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kujitoon/core/routes/fade_route.dart';
import 'package:kujitoon/feature/register/bloc/register_bloc.dart';
import 'package:kujitoon/feature/register/view/mobile/widgets/strong_password_widget.dart';
import 'package:kujitoon/router.dart';
import 'package:url_launcher/url_launcher.dart';

class FormWidget extends StatefulWidget{

  final TextEditingController emailTextEditing;
  final TextEditingController passwordTextEditing;
  final TextEditingController userNameTextEditing;
  final RegisterState state;
  final String? errorMesage;
  final Function(bool agreePolicy) funcLogin;

  FormWidget({super.key, required this.emailTextEditing, required this.passwordTextEditing, required this.funcLogin, required this.userNameTextEditing, required this.errorMesage, required this.state});

  @override
  State<StatefulWidget> createState() => _FormWidget();

}

class _FormWidget extends State<FormWidget>{

  bool agreePolicy = false;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              children: [
                Text("KUJITOON", style: TextStyle(fontFamily: "IrishGrover-Regular", fontSize: 40, color: Colors.blue),),
                Text("Đăng Kí", style: TextStyle(fontFamily: "EncodeSans", fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),),
                Text("Nhập thông tin tài khoảng của bạn", style: TextStyle(fontFamily: "EncodeSans", fontWeight: FontWeight.bold, color: Colors.black.withAlpha(150), fontSize: 15),),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Text("Email hoặc tên đăng nhập", style: TextStyle(fontFamily: "EncodeSans", fontWeight: FontWeight.bold, color: Colors.black.withAlpha(150)),),
          SizedBox(height: 5,),
          TextFormField(
            controller: widget.emailTextEditing,
            decoration: InputDecoration(
              labelText: "Nhập Email",
              errorText: widget.errorMesage,
              labelStyle: TextStyle(color: Colors.black.withAlpha(100)),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              prefixIcon: Icon(Icons.person, color: Colors.black,),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.black.withAlpha(150),
                  width: 1,
                ),
              ),
              // Border khi *focus* vào
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.black.withAlpha(150),
                  width: 1,
                ),
              ),

              // Border khi lỗi validate
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
              ),

              // Border khi focus mà có lỗi
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                ),
              ),
            ),
            style: TextStyle(color: Colors.black),
          ),

          SizedBox(height: 10,),

          Text("Mật Khẩu", style: TextStyle(fontFamily: "EncodeSans", fontWeight: FontWeight.bold, color: Colors.black.withAlpha(150)),),
          SizedBox(height: 5,),
          TextFormField(
            controller: widget.passwordTextEditing,
            obscureText: !showPassword,
            onChanged: (value){
              setState(() {

              });
            },
            decoration: InputDecoration(
              labelText: "Nhập Mật Khẩu",
              errorText: widget.errorMesage,
              labelStyle: TextStyle(color: Colors.black.withAlpha(100)),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              prefixIcon: Icon(Icons.lock_rounded, color: Colors.black),
              suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(showPassword == true ? Icons.visibility : Icons.visibility_off)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.black.withAlpha(150),
                  width: 1,
                ),
              ),

              // Border khi *focus* vào
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.black.withAlpha(150),
                  width: 1,
                ),
              ),

              // Border khi lỗi validate
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
              ),

              // Border khi focus mà có lỗi
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                ),
              ),
            ),
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 5,),
          StrongPasswordWidget(password: widget.passwordTextEditing.text),

          SizedBox(height: 15,),

          Text("Tên Tài Khoảng", style: TextStyle(fontFamily: "EncodeSans", fontWeight: FontWeight.bold, color: Colors.black.withAlpha(150)),),
          SizedBox(height: 5,),
          TextFormField(
            controller: widget.userNameTextEditing,
            decoration: InputDecoration(
              labelText: "Nhập Tên Tài Khoảng Của Bạn",
              errorText: widget.errorMesage,
              labelStyle: TextStyle(color: Colors.black.withAlpha(100)),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              prefixIcon: Icon(Icons.alternate_email, color: Colors.black),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.black.withAlpha(150),
                  width: 1,
                ),
              ),

              // Border khi *focus* vào
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.black.withAlpha(150),
                  width: 1,
                ),
              ),

              // Border khi lỗi validate
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
              ),

              // Border khi focus mà có lỗi
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                ),
              ),
            ),
            style: TextStyle(color: Colors.black),
          ),

          SizedBox(height: 10,),
          Container(
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          activeColor: Colors.blue,
                          value: agreePolicy,
                          onChanged: (value){
                            setState(() {
                              agreePolicy = value??false;
                            });
                          }),
                      Text("Tôi đồng ý với Điều khoản", style: TextStyle(fontFamily: "EncodeSans", color: Colors.black.withAlpha(150), fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis,), maxLines: 1, softWrap: true,),
                    ],
                  ),
                ],
              )
          ),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              if(widget.state is RegisterHandling){
                return;
              }
              widget.funcLogin(agreePolicy);
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width*0.9,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: widget.state is RegisterHandling
                    ? Container(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(color: Colors.white,),
                )
                    : Text("Đăng Kí", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Đã có tài khoảng?"),
              SizedBox(width: 5,),
              GestureDetector(
                onTap: () async {
                  Navigator.pushReplacement(
                    context,
                    FadeRoute(
                      settings: const RouteSettings(name: '/login'),
                      builder: routes['/login']!,
                    ),
                  );
                },
                child: Text("Đăng Nhập", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
              )
            ],
          )
        ],
      ),
    );
  }
}