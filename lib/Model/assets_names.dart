
class R {

  static const String _ASSETS = "assets/";
  static const String _IMAGES = "images/";
  static const String _ICONS = "icons";
  static const String _ASSETS_IMAGES = _ASSETS + _IMAGES;
  static const String _ASSETS_ICONS = _ASSETS + _ICONS;

  static String ic_person = _ASSETS_IMAGES + "ic_person.png";
  static String ic_play = _ASSETS_IMAGES + "ic_play2.png";
  static String _image_base_url_highQ = "https://image.tmdb.org/t/p/original";
  static String _image_base_url_lowQ = "https://image.tmdb.org/t/p/w185";


  static String getNetworkImagePath(String subPath, {bool highQuality = false}){
    return highQuality ? "${_image_base_url_highQ + subPath}": "${_image_base_url_lowQ + subPath}";
  }

  static String getAssetImagePath(String assetName){
    return "$_ASSETS_IMAGES$assetName";
  }
}
