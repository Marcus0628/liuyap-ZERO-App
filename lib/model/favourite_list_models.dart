class FavoriteListModel {
  static List<String> itemNames = [
    'Tomorrowland Belgium 2023',
    'EDC 2023',
    'Siam Songkran 2023'
  ];

  static List<String> itemsSubtitle = [
    'Europe, Noodles, Burges, Desserts, Halal',
    'Asian, Bread, Pudding, Crossiant',
    'Asian, Cake, Bread, Sandwich'
  ];

  static List<String> itemImages = [
    'assets/tmrland.png',
    'assets/edc.png',
    'assets/siam.png'
  ];

  Item getById(int id) => Item(
      id,
      itemNames[id % itemNames.length],
      itemsSubtitle[id % itemsSubtitle.length],
      itemImages[id % itemImages.length]);

  Item getByPosition(int position) {
    return getById(position);
  }
}

class Item {
  final int id;
  final String name;
  final String subtitle;
  final String image;

  const Item(this.id, this.name, this.subtitle, this.image);

  @override
  int get hasCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
