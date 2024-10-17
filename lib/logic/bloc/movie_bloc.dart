import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_booking/model/movie_model.dart';
import 'package:movie_booking/repository/movie_repo.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    MovieModel? movieModel;

    List<Movie?> cartMovies = [];

    on<MovieEvent>((event, emit) async {
      if (event is GetMovies) {
        emit(MovieState(
            isLoading: true, movieModel: movieModel, cartMovies: cartMovies));
        movieModel = await MovieRepo.getMovies();

        emit(MovieState(
            isLoading: false, movieModel: movieModel, cartMovies: cartMovies));
      }

      if (event is AddToCart) {
        if (cartMovies.contains(event.movie)) {
          cartMovies.remove(event.movie);
          emit(MovieState(
              isLoading: false,
              movieModel: movieModel,
              cartMovies: cartMovies));
        } else {
          cartMovies.add(event.movie);
          emit(MovieState(
              isLoading: false,
              movieModel: movieModel,
              cartMovies: cartMovies));
        }
      }
    });
  }
}
