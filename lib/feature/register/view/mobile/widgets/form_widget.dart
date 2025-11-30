import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kujitoon/feature/register/view/mobile/widgets/strong_password_widget.dart';

class FormWidget extends StatefulWidget{
  final TextEditingController emailTextEditing;
  final TextEditingController passwordTextEditing;
  final TextEditingController userNameTextEditing;
  final String? msgError;

  const FormWidget({super.key, required this.emailTextEditing, required this.passwordTextEditing, required this.userNameTextEditing, this.msgError});

  @override
  State<StatefulWidget> createState() => _FormWidget();
}

class _FormWidget extends State<FormWidget>{

  bool showPassword = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width*0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Email hoặc tên đăng nhập", style: TextStyle(fontFamily: "EncodeSans", fontWeight: FontWeight.bold, color: Colors.black.withAlpha(150)),),
          SizedBox(height: 10,),
          TextFormField(
            controller: widget.emailTextEditing,
            decoration: InputDecoration(
              labelText: "Nhập Email",
              labelStyle: TextStyle(color: Colors.black.withAlpha(100)),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              errorText: widget.msgError,
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

          SizedBox(height: 20,),

          Text("Mật Khẩu", style: TextStyle(fontFamily: "EncodeSans", fontWeight: FontWeight.bold, color: Colors.black.withAlpha(150)),),
          SizedBox(height: 10,),
          TextFormField(
            controller: widget.passwordTextEditing,
            obscureText: !showPassword,
            onChanged: (value){
              setState(() {});
            },
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: (){
                  setState(() {
                    showPassword = !showPassword;
                  });
                  print(showPassword);
                },
                child: Icon(showPassword == true ? Icons.visibility : Icons.visibility_off),
              ),
              labelText: "Nhập Mật Khẩu",
              labelStyle: TextStyle(color: Colors.black.withAlpha(100)),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              errorText: widget.msgError,
              prefixIcon: Icon(Icons.lock_rounded, color: Colors.black),
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

          SizedBox(height: 20,),
          Text("Tên Tài Khoảng", style: TextStyle(fontFamily: "EncodeSans", fontWeight: FontWeight.bold, color: Colors.black.withAlpha(150)),),
          SizedBox(height: 10,),
          TextFormField(
            controller: widget.userNameTextEditing,
            decoration: InputDecoration(
              labelText: "Nhập Tên Tài Khoảng Của Bạn",
              labelStyle: TextStyle(color: Colors.black.withAlpha(100)),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              errorText: widget.msgError,
              prefixIcon: Icon(Icons.alternate_email, color: Colors.black,),
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
        ],
      ),
    );
  }

}