
import 'package:flutter/foundation.dart';
import 'package:zero/model/favourite_list_models.dart';

class FavoritePageModel extends ChangeNotifier {
  late FavoriteListModel _favoritelist;

  final List<int> _itemIds = [];

  FavoriteListModel get favoritelist => _favoritelist;

  set favoritelist(FavoriteListModel newList) {
    _favoritelist = newList;
    notifyListeners();
  }

  List<Item> get items =>
    _itemIds.map((id) => 
    _favoritelist.getById(id)).toList();

  void add(Item item) {
    _itemIds.add(item.id);
    notifyListeners();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
    notifyListeners();
  }
}
