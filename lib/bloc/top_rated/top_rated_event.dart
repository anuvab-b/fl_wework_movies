part of 'top_rated_bloc.dart';

class TopRatedEvent {}

class OnTopRatedInit extends TopRatedEvent {}

class OnSearchMovieTextChange extends TopRatedEvent {
  final String text;

  OnSearchMovieTextChange({required this.text});
}
