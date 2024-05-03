import 'package:fl_wework_movies/domain/i_movie_repository.dart';
import 'package:fl_wework_movies/domain/tmdb_movie_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_event.dart';

part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final IMovieRepository movieRepository;

  NowPlayingBloc(this.movieRepository)
      : super(NowPlayingInitial(
            nowPlayingLoading: false,
            allNowPlayingList: [],
            filterNowPlayingList: [],
            nowPlayingError: false)) {
    on<OnNowPlayingInit>(onNowPlayingInit);
    on<OnSearchMovieTextChange>(onSearchMovieTextChange);
  }

  onNowPlayingInit(
      OnNowPlayingInit event, Emitter<NowPlayingState> emit) async {
    try {
      emit(NowPlayingLoading(
          nowPlayingLoading: true,
          filterNowPlayingList: [],
          allNowPlayingList: [],
          nowPlayingError: false));

      var result = await movieRepository.fetchNowPlayingMovies(event.refresh);
      result.fold((l) {
        emit(NowPlayingError(
            errorMessage: l,
            nowPlayingLoading: false,
            allNowPlayingList: [],
            filterNowPlayingList: [],
            nowPlayingError: true));
      }, (r) {
        emit(NowPlayingSuccess(
            nowPlayingLoading: false,
            filterNowPlayingList: r,
            allNowPlayingList: r,
            nowPlayingError: false));
      });
    } catch (e) {
      emit(NowPlayingError(
          errorMessage: e.toString(),
          nowPlayingLoading: false,
          allNowPlayingList: [],
          filterNowPlayingList: [],
          nowPlayingError: true));
    }
  }

  onSearchMovieTextChange(
      OnSearchMovieTextChange event, Emitter<NowPlayingState> emit) async {
    String text = event.text;
    List<NowPlaying> nowPlaying = List.empty(growable: true);
    if (text.isEmpty) {
      nowPlaying = state.allNowPlayingList;
    } else {
      nowPlaying = state.allNowPlayingList
          .where((element) =>
              element.title.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    emit(NowPlayingSuccess(
        allNowPlayingList: state.allNowPlayingList,
        filterNowPlayingList: nowPlaying,
        nowPlayingError: false,
        nowPlayingLoading: false));
  }
}
