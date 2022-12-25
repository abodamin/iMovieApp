import 'package:i_movie_app/app/imports.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getMediaHeight(context),
      child: Center(
        child: Text(
          "Ops, something went wrong check your connection and try again :/",
          style: getTextTheme(context).titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
