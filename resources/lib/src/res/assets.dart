enum Assets {
  add,
  bgAuth,
  loadingPurple,
  loadingWhite,
  google,
  facebook,
  apple
}

extension AssetsExtension on Assets {
  String get svgIconPath {
    return 'assets/images/ic_${name.toString().replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}').toLowerCase()}.svg';
  }

  String get pngIconPath {
    return 'assets/images/ic_${name.toString().replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}').toLowerCase()}.png';
  }

  String get jpegIconPath {
    return 'assets/images/ic_${name.toString().replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}').toLowerCase()}.jpeg';
  }

  String get jpegImgPath {
    return 'assets/images/img_${name.toString().replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}').toLowerCase()}.jpeg';
  }

  String get gifAssetPath {
    return 'assets/images/ic_${name.toString().replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}').toLowerCase()}.gif';
  }

  String get riveIconAssetPath {
    return 'assets/rive/ic_${name.toString().replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}').toLowerCase()}.riv';
  }

  String get lottieAssetPath {
    return 'assets/lottie/anim_${name.toString().replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}').toLowerCase()}.json';
  }
}
