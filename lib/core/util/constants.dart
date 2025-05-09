// lib/core/util/constants.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static final baseUrl = dotenv.env['BASE_URL']!;
  static final imgurClientId = dotenv.env['IMGUR_CLIENT_ID']!;
  static final imgurClientSecret = dotenv.env['IMGUR_CLIENT_SECRET']!;
}
