import 'package:fl_wework_movies/domain/i_movie_repository.dart';
import 'package:fl_wework_movies/domain/tmdb_movie_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_event.dart';

part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final IMovieRepository movieRepository;

  TopRatedBloc(this.movieRepository)
      : super(TopRatedInitial(
            topRatedLoading: false, topRatedList: [], topRatedError: false)) {
    on<OnTopRatedInit>(onTopRatedInit);
  }

  onTopRatedInit(OnTopRatedInit event, Emitter<TopRatedState> emit) async {
    try {
      emit(TopRatedLoading(
          topRatedLoading: true, topRatedList: [], topRatedError: false));

      var result = await movieRepository.fetchTopRatedMovies();
      result.fold((l) {
        emit(TopRatedError(
            errorMessage: l,
            topRatedLoading: false,
            topRatedList: [],
            topRatedError: true));
      }, (r) {
        emit(TopRatedSuccess(
            topRatedLoading: false,
            topRatedList: r,
            topRatedError: false));
      });
    } catch (e) {
      emit(TopRatedError(
          errorMessage: e.toString(),
          topRatedLoading: false,
          topRatedList: [],
          topRatedError: true));
    }
  }
}
