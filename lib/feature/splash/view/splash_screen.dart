import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/splash/bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2)
    );

    _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(AppStarted()),
      child: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state){
          if(state is SplashLoading){
            _controller.forward();
          }

          if(state is SplashSuccess){
            Navigator.pushReplacementNamed(context, '/loginMobile');
          }
        },
        builder: (context, state){
          if(state is SplashInitial || state is SplashLoading){
            return Scaffold(
              body: Container(
                child: Center(
                  child: FadeTransition(
                    opacity: _animation,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset("assets/img/icon.png",
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

}