import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kujitoon/feature/search/bloc/search_event.dart';
import 'package:kujitoon/feature/search/bloc/search_state.dart';
import 'package:kujitoon/feature/search/data/repositories/search_repository_impl.dart';
import 'package:kujitoon/feature/search/domain/entities/result_search.dart';
import 'package:kujitoon/feature/search/domain/repositories/search_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState>{
  SearchBloc() : super(SearchLoadingState()){
    on<FeatchDataSearchEvent>(_onSearch);
  }

  Future<void> _onSearch(FeatchDataSearchEvent event, Emitter emit) async {
    SearchRepository searchRepository = SearchRepositoryImpl();
    ResultSearch resultSearch = await searchRepository.search(event.keyword, page: event.page);
    
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userParagram = sharedPreferences.getString('user') ?? "";

    emit(SearchLoadedState(resultSearch: resultSearch, keyword: event.keyword, userParagram: userParagram));
  }
}