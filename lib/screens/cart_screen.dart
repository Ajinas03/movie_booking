import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking/logic/bloc/movie_bloc.dart';
import 'package:movie_booking/screens/widgets/movie_card.dart';
import 'package:movie_booking/screens/widgets/text_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
          text: "Movie Cart",
          fontWeight: FontWeight.bold,
        ),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          final items = state.cartMovies;
          return state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (items?.isEmpty ?? true)
                  ? const Center(child: TextWidget(text: "Your cart is Empty"))
                  : GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.54,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: items?.length,
                      itemBuilder: (context, index) {
                        return MovieCard(
                          movie: items?[index],
                          isCartItem: true,
                        );
                      },
                    );
        },
      ),
    );
  }
}
