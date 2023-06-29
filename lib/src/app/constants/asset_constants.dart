mixin Assets {
  static AssetImages get images => AssetImages();
  static AssetLotties get lotties => AssetLotties();
}

class AssetLotties {
  String location = 'assets/lotties';
  // String get success => '$location/success.json';
}

class AssetImages {
  String location = 'assets/images';

  String get logo => '$location/logo.png';
}
