import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking/logic/bloc/movie_bloc.dart';
import 'package:movie_booking/model/movie_model.dart';
import 'package:movie_booking/screens/widgets/cart_icon.dart';
import 'package:movie_booking/screens/widgets/text_widget.dart';
import 'package:movie_booking/utils/screen_utils.dart';

class DetailsScreen extends StatelessWidget {
  final Movie? movie;
  const DetailsScreen({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: movie?.title ?? ""),
        actions: const [CartIcon()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: size.height / 3,
              child: Row(
                children: [
                  SizedBox(
                    height: size.height / 3,
                    child: Image(
                      alignment: Alignment.centerLeft,
                      image: NetworkImage(movie?.image?.imageUrl ?? ""),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                            child: TextWidget(text: "Title : ${movie?.title}")),
                        Flexible(
                            child: TextWidget(
                                text:
                                    "Category : ${movie?.category ?? "N/A"}")),
                        Flexible(
                            child: TextWidget(text: "Rank : ${movie?.rank}")),
                        Flexible(
                            child:
                                TextWidget(text: "Staring  : ${movie?.cast}")),
                        Flexible(
                            child: TextWidget(
                                text: "Year : ${movie?.year ?? "N/A"}")),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextWidget(
                text: movie?.title ?? "",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextWidget(
              text:
                  "${movie?.title} is a ${movie?.category ?? "Category N/A"} film featuring an impressive cast that includes ${movie?.cast ?? "Cast N/A"}. It holds a ranking of ${movie?.rank ?? "N/A"}, reflecting its popularity and audience reception. Released in the year ${movie?.year ?? "N/A"}, this movie promises to deliver an engaging experience.",
              fontSize: 20,
              color: Colors.black.withOpacity(0.6),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          final isCartItem = (state.cartMovies?.contains(movie) ?? false);

          return SizedBox(
            width: size.width / 1.2,
            child: FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: isCartItem ? Colors.red : Colors.green,
                onPressed: () {
                  context.read<MovieBloc>().add(AddToCart(movie: movie));
                },
                label: TextWidget(
                  text: isCartItem ? "Remove From Cart" : "Add To Cart",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          );
        },
      ),
    );
  }
}
