import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:i_movie_app/app/imports.dart';

class MovieRateBar extends StatelessWidget {
  final double voteAverage;

  const MovieRateBar({Key? key, required this.voteAverage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      // width: get120Size(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("$voteAverage"),
          mWidth(10),
          Container(
            child: RatingBar.builder(
              initialRating: voteAverage / 2,
              itemSize: 15,
              minRating: 0,
              maxRating: 5,
              ignoreGestures: true,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
        ],
      ),
    );
  }
}
