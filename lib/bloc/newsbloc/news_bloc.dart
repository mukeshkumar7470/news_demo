import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/api_model.dart';
import '../../services/news_repository.dart';
import 'news_events.dart';
import 'news_states.dart';

class NewsBloc extends Bloc<NewsEvents, NewsStates> {
  NewsRepository newsRepositoty;

  NewsBloc({required NewsStates initialState, required this.newsRepositoty})
      : super(NewsLoadingState()) {
    on<NewsEvents>((event, emit) async {
      await _getMonks(emit);
    });

    add(StartEvent());
  }

  Future<void> _getMonks(Emitter<NewsStates> emit) async {
    emit(NewsLoadingState());
    try {
      List<Articles> _articleList = [];
      _articleList = await newsRepositoty.fetchNews();
      emit(NewsLoadedState(articleList: _articleList));
    } catch (e) {
      emit(NewsErrorState(errorMessage: e.toString()));
    }
  }
}

//bloc completed

// let's deploy this bloc in ui
