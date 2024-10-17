part of 'movie_bloc.dart';

final class MovieInitial extends MovieState {
  MovieInitial() : super(isLoading: true, movieModel: null, cartMovies: []);
}

class MovieState {
  bool isLoading;
  final List<Movie?>? cartMovies;
  MovieModel? movieModel;
  MovieState({required this.isLoading, this.movieModel, this.cartMovies});
}
