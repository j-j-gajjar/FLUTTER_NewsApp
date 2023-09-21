import '../model/category_model.dart';

enum ListType { country, category, channel }

const List<SelectableItem> countries = [
  SelectableItem(name: 'INDIA', code: 'in', type: ListType.country),
  SelectableItem(name: 'USA', code: 'us', type: ListType.country),
  SelectableItem(name: 'MEXICO', code: 'mx', type: ListType.country),
  SelectableItem(name: 'United Arab Emirates', code: 'ae', type: ListType.country),
  SelectableItem(name: 'New Zealand', code: 'nz', type: ListType.country),
  SelectableItem(name: 'Israel', code: 'il', type: ListType.country),
  SelectableItem(name: 'Indonesia', code: 'id', type: ListType.country),
];

const List<SelectableItem> categories = [
  SelectableItem(name: 'science', code: 'science', type: ListType.category),
  SelectableItem(name: 'business', code: 'business', type: ListType.category),
  SelectableItem(name: 'technology', code: 'technology', type: ListType.category),
  SelectableItem(name: 'sports', code: 'sports', type: ListType.category),
  SelectableItem(name: 'health', code: 'health', type: ListType.category),
  SelectableItem(name: 'general', code: 'general', type: ListType.category),
  SelectableItem(name: 'entertainment', code: 'entertainment', type: ListType.category),
  SelectableItem(name: 'ALL', code: 'all', type: ListType.category),
];

const List<SelectableItem> newsChannels = [
  SelectableItem(name: 'BBC News', code: 'bbc-news', type: ListType.channel),
  SelectableItem(name: 'The Times of India', code: 'the-times-of-india', type: ListType.channel),
  SelectableItem(name: 'politico', code: 'politico', type: ListType.channel),
  SelectableItem(name: 'The Washington Post', code: 'the-washington-post', type: ListType.channel),
  SelectableItem(name: 'reuters', code: 'reuters', type: ListType.channel),
  SelectableItem(name: 'cnn', code: 'cnn', type: ListType.channel),
  SelectableItem(name: 'nbc news', code: 'nbc-news', type: ListType.channel),
  SelectableItem(name: 'The Hill', code: 'the-hill', type: ListType.channel),
  SelectableItem(name: 'Fox News', code: 'fox-news', type: ListType.channel),
  SelectableItem(name: 'Fox News', code: 'fox-news', type: ListType.channel),
];
