import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking/logic/bloc/movie_bloc.dart';
import 'package:movie_booking/screens/cart_screen.dart';
import 'package:movie_booking/screens/widgets/text_widget.dart';
import 'package:movie_booking/utils/screen_utils.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        return Badge(
          isLabelVisible: (state.cartMovies?.isNotEmpty ?? false),
          label: TextWidget(text: (state.cartMovies?.length.toString()) ?? "0"),
          offset: const Offset(-5, -2),
          child: IconButton(
              onPressed: () {
                pushScreen(context, const CartScreen());
              },
              icon: const Icon(Icons.shopping_cart_outlined)),
        );
      },
    );
  }
}
