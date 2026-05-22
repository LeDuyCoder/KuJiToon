import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/search/bloc/search_bloc.dart';
import 'package:kujitoon/feature/search/bloc/search_state.dart';
import 'package:kujitoon/feature/search/view/website/pages/web/mobile_search_page.dart';
import 'package:kujitoon/feature/search/view/website/pages/web/web_search_page.dart';

import '../../../../../core/utils/responsive.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage>{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        if(state is SearchLoadedState){
          return Scaffold(
            body: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: Responsive.isDesktop(context)
                    ? WebSearchPage(resultSearch: state.resultSearch, keyword: state.keyword, userParagram: state.userParagram,)
                    : MobileSearchPage(resultSearch: state.resultSearch, keyword: state.keyword, userParagram: state.userParagram,)
            ),
          );
        }

        return Container();
      },
      listener: (BuildContext context, SearchState state) {  },

    );
  }

}