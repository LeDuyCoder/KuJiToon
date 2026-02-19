import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/core/utils/responsive.dart';
import 'package:kujitoon/feature/shared_header/bloc/header_bloc.dart';
import 'package:kujitoon/feature/shared_header/bloc/header_event.dart';
import 'package:kujitoon/feature/shared_header/bloc/header_state.dart';
import 'package:kujitoon/feature/shared_header/data/datasource/header_datasource.dart';
import 'package:kujitoon/feature/shared_header/data/repositories/header_repository_impl.dart';
import 'package:kujitoon/feature/shared_header/domain/usecase/header_usecase.dart';
import 'package:kujitoon/feature/shared_header/view/widgets/mobile/mobile_header_widget.dart';
import 'package:kujitoon/feature/shared_header/view/widgets/website/website_header_widget.dart';

class HeaderWidget extends StatefulWidget {
  bool isOpeneMenu;
  void Function(bool opened) openMenu;

  HeaderWidget({super.key, this.isOpeneMenu = false, this.openMenu = _emptyCallback,});

  @override
  State<StatefulWidget> createState() => _HeaderWidget();

  static void _emptyCallback(bool _) {}
}

class _HeaderWidget extends State<HeaderWidget>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HeaderBloc(
        headerUsecase: HeaderUsecase(
          repository: HeaderRepositoryImpl(datasource: HeaderDatasource()),
        ),
      )..add(LoadDataEvent()),
      child: BlocConsumer<HeaderBloc, HeaderState>(
          builder: (context, state){
            if(state is LoadedHeaderState){
              return Responsive.isDesktop(context)
                  ? WebsiteHeaderWidget(userEntity: state.userEntity)
                  : MobileHeaderWidget(userEntity: state.userEntity,);
            }

            return Container();
          },
          listener: (context, state){}
      ),
    );
  }
}
