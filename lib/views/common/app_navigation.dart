


import 'package:flutter/material.dart';
import 'package:i_movie_app/views/details/details_page.dart';
import 'package:i_movie_app/views/favorite/favorite_movies_page.dart';
import 'package:i_movie_app/views/home/home_page.dart';
import 'package:i_movie_app/views/search/search_result_page.dart';

///
/// App navigation system
///
class AppNav {

  static Future _navigateTo(context, page) async {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static Future<void> navigateToOff(context, page, {dynamic arguments}) async {
    Navigator.pushAndRemoveUntil(context, page, (route) => false);
  }

  // --------------

  static navigateToHomePage(context) async {
    return await _navigateTo(context, HomePage());
  }

  static navigateToDetailsPage(context, String id) async {
    return await _navigateTo(context, DetailsPage(id: id,));
  }

  static navigateToSearchPage(context) async {
    return await _navigateTo(context, SearchPage());
  }

  static navigateToFavoriteMoviesPage(context) async {
    return await _navigateTo(context, FavoriteMoviesPage());
  }

}