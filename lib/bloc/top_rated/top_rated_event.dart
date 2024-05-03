part of 'top_rated_bloc.dart';

class TopRatedEvent {}

class OnTopRatedInit extends TopRatedEvent {
  final bool refresh;
  OnTopRatedInit({required this.refresh});
}

class OnSearchMovieTextChange extends TopRatedEvent {
  final String text;

  OnSearchMovieTextChange({required this.text});
}
