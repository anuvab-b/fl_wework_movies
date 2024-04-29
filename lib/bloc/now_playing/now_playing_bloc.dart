import 'package:fl_wework_movies/domain/i_movie_repository.dart';
import 'package:fl_wework_movies/domain/tmdb_movie_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final IMovieRepository movieRepository;

  NowPlayingBloc(this.movieRepository)
      : super(NowPlayingInitial(
      nowPlayingLoading: false, nowPlayingList: [], nowPlayingError: false)) {
    on<OnNowPlayingInit>(onNowPlayingInit);
  }

  onNowPlayingInit(OnNowPlayingInit event, Emitter<NowPlayingState> emit) async {
    try {
      emit(NowPlayingLoading(
          nowPlayingLoading: true, nowPlayingList: [], nowPlayingError: false));

      var result = await movieRepository.fetchNowPlayingMovies();
      result.fold((l) {
        emit(NowPlayingError(
            errorMessage: l,
            nowPlayingLoading: false,
            nowPlayingList: [],
            nowPlayingError: true));
      }, (r) {
        emit(NowPlayingSuccess(
            nowPlayingLoading: false,
            nowPlayingList: r,
            nowPlayingError: false));
      });
    } catch (e) {
      emit(NowPlayingError(
          errorMessage: e.toString(),
          nowPlayingLoading: false,
          nowPlayingList: [],
          nowPlayingError: true));
    }
  }
}