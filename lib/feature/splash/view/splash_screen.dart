import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/splash/bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(AppStarted()),
      child: BlocConsumer<SplashBloc, SplashState>(
          listener: (context, state){},
          builder: (context, state){
            if(state is SplashInitial || state is SplashLoading){
              return Scaffold(
                body: Container(
                  child: Center(
                    child: Text("Loading"),
                  ),
                ),
              );
            }else if(state is SplashSuccess){
              return Scaffold(
                body: Container(
                  child: Center(
                    child: Text("Loaded Success!"),
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