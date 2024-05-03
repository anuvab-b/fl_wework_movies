import 'package:fl_wework_movies/domain/i_movie_repository.dart';
import 'package:fl_wework_movies/domain/tmdb_movie_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_event.dart';

part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final IMovieRepository movieRepository;

  TopRatedBloc(this.movieRepository)
      : super(TopRatedInitial(
            topRatedLoading: false,
            filterTopRatedList: [],
            allTopRatedList: [],
            topRatedError: false)) {
    on<OnTopRatedInit>(onTopRatedInit);
    on<OnSearchMovieTextChange>(onSearchMovieTextChange);
  }

  onTopRatedInit(OnTopRatedInit event, Emitter<TopRatedState> emit) async {
    try {
      emit(TopRatedLoading(
          topRatedLoading: true,
          allTopRatedList: [],
          filterTopRatedList: [],
          topRatedError: false));

      var result = await movieRepository.fetchTopRatedMovies(event.refresh);
      result.fold((l) {
        emit(TopRatedError(
            errorMessage: l,
            topRatedLoading: false,
            filterTopRatedList: [],
            allTopRatedList: [],
            topRatedError: true));
      }, (r) {
        emit(TopRatedSuccess(
            topRatedLoading: false,
            allTopRatedList: r,
            filterTopRatedList: r,
            topRatedError: false));
      });
    } catch (e) {
      emit(TopRatedError(
          errorMessage: e.toString(),
          topRatedLoading: false,
          filterTopRatedList: [],
          allTopRatedList: [],
          topRatedError: true));
    }
  }

  onSearchMovieTextChange(
      OnSearchMovieTextChange event, Emitter<TopRatedState> emit) async {
    String text = event.text;
    List<TopRated> topRated = List.empty(growable: true);
    if (text.isEmpty) {
      topRated = state.allTopRatedList;
    } else {
      topRated = state.allTopRatedList
          .where((element) =>
              element.title.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    emit(TopRatedSuccess(
        allTopRatedList: state.allTopRatedList,
        filterTopRatedList: topRated,
        topRatedError: false,
        topRatedLoading: false));
  }
}
