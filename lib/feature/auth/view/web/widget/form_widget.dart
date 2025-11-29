import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget{

  final TextEditingController emailTextEditing;
  final TextEditingController passwordTextEditing;
  final String? errorMesage;
  final Function() funcLogin;

  const FormWidget({super.key, required this.emailTextEditing, required this.passwordTextEditing, required this.funcLogin, required this.errorMesage});

  @override
  State<StatefulWidget> createState() => _FormWidget();

}

class _FormWidget extends State<FormWidget>{

  bool rememberPassword = false;

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
                Text("Đăng Nhập", style: TextStyle(fontFamily: "EncodeSans", fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),),
                Text("Nhập thông tin đăng nhập của bạn", style: TextStyle(fontFamily: "EncodeSans", fontWeight: FontWeight.bold, color: Colors.black.withAlpha(150), fontSize: 15),),
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
              suffixIcon: Icon(Icons.person, color: Colors.black,),
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
            decoration: InputDecoration(
              labelText: "Nhập Mật Khẩu",
              errorText: widget.errorMesage,
              labelStyle: TextStyle(color: Colors.black.withAlpha(100)),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              suffixIcon: Icon(Icons.lock_rounded, color: Colors.black),
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
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
              widget.funcLogin();
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width*0.9,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Text("Đăng Nhập", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
              ),
            ),
          )
        ],
      ),
    );
  }
}