import 'dart:convert';

import 'package:fp_fe_reservasihotel_guest/core/routes/api_routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/roomtype/room_type.dart';

class RoomTypeService {
  Future<RoomType> getRoomType() async {
    final url = Uri.parse('${ApiRoutesRepo.baseUrl}${ApiRoutesRepo.roomTypes}');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return RoomType.fromJson(data);
    } else {
      throw Exception('Failed to get booking data: ${response.statusCode}');
    }
  }
}
