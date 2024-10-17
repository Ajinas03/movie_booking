import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking/logic/bloc/movie_bloc.dart';
import 'package:movie_booking/model/movie_model.dart';
import 'package:movie_booking/screens/details_screen.dart';
import 'package:movie_booking/screens/widgets/text_widget.dart';
import 'package:movie_booking/utils/screen_utils.dart';

class MovieCard extends StatelessWidget {
  final Movie? movie;
  final bool isCartItem;
  const MovieCard({super.key, required this.movie, required this.isCartItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            InkWell(
              onTap: () {
                pushScreen(
                    context,
                    DetailsScreen(
                      movie: movie,
                    ));
              },
              child: Image(
                image: NetworkImage(movie?.image?.imageUrl ?? ""),
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              right: 5,
              top: 10,
              child: InkWell(
                onTap: () {},
                child: SizedBox(
                  height: 40,
                  child: FloatingActionButton.extended(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        context.read<MovieBloc>().add(AddToCart(movie: movie));
                      },
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(isCartItem
                              ? Icons.remove_shopping_cart_outlined
                              : Icons.add_shopping_cart_sharp),
                          const SizedBox(
                            width: 10,
                          ),
                          TextWidget(text: isCartItem ? "Remove" : "Add"),
                        ],
                      )),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Row(
              children: [
                const Icon(
                  Icons.star,
                  size: 15,
                  color: Colors.orange,
                ),
                TextWidget(text: "Rank ${movie?.rank}"),
              ],
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextWidget(
                textAlign: TextAlign.start,
                text: movie?.title ?? "",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
