part of 'movie_bloc.dart';

class AddToCart extends MovieEvent {
  final Movie? movie;

  AddToCart({required this.movie});
}

class GetMovies extends MovieEvent {}

@immutable
abstract class MovieEvent {}
