
class R {

  static const String _ASSETS = "assets/";
  static const String _IMAGES = "images/";
  static const String _ICONS = "icons";
  static const String _ASSETS_IMAGES = _ASSETS + _IMAGES;
  static const String _ASSETS_ICONS = _ASSETS + _ICONS;

  static String ic_person = _ASSETS_IMAGES + "ic_person.png";
  static String ic_play = _ASSETS_IMAGES + "ic_play2.png";
  static String image_base_url = "https://image.tmdb.org/t/p/w185";

  static String tag_movei_poster = "tag_movei_poster";


  static String getNetworkImagePath(String subPath){
    return "${image_base_url + subPath}";
  }
}
