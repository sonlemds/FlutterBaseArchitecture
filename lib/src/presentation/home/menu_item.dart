import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

enum MenuItem { home, favorite, settings }

extension MenuItemIcon on MenuItem {
  Widget get icon {
    switch (this) {
      case MenuItem.home:
        return const Icon(Iconsax.home);
      case MenuItem.favorite:
        return const Icon(Iconsax.gallery_favorite);
      case MenuItem.settings:
        return const Icon(Iconsax.setting);
    }
  }
}
