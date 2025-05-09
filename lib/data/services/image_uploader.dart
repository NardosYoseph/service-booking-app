import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:service_booking_app/core/util/constants.dart';

class ImgurUploader {
  static String clientId = AppConstants.imgurClientId; 
  static final Dio _dio = Dio();

  static Future<String?> uploadImage(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await _dio.post(
        'https://api.imgur.com/3/image',
        options: Options(
          headers: {
            'Authorization': 'Client-ID $clientId',
          },
        ),
        data: {
          'image': base64Image,
          'type': 'base64',
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data['data']['link'];
      } else {
        print('Upload failed: ${response.data}');
        return null;
      }
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }
}
