class Friend {
  const Friend({
    required this.id,
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.nextBirthday,
    required this.wishlist,
    required this.pastGifts,
  });

  final String id;
  final String name;
  final String username;
  final String avatarUrl;
  final DateTime nextBirthday;
  final List<WishlistItem> wishlist;
  final List<PastGift> pastGifts;
}

class WishlistItem {
  const WishlistItem({
    required this.title,
    required this.subtitle,
    required this.priceRange,
    this.imageUrl,
  });

  final String title;
  final String subtitle;
  final String priceRange;
  final String? imageUrl;
}

class PastGift {
  const PastGift({
    required this.title,
    required this.occasion,
    required this.year,
  });

  final String title;
  final String occasion;
  final int year;
}
