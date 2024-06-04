import 'dart:convert';

import 'package:fp_fe_reservasihotel_guest/core/routes/api_routes.dart';
import 'package:http/http.dart' as http;

class BookingService {
  Future<void> postBooking(Map<String, Object> bookingData) async {
    final url =
        Uri.parse('${ApiRoutesRepo.baseUrl}${ApiRoutesRepo.postBooking}');
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bookingData));

    print(jsonEncode(bookingData));
    if (response.statusCode == 200) {
      return;
    } else {
      print(response.statusCode);
      print(jsonDecode(response.body));
      throw Exception('Error code ${response.statusCode}');
    }
  }
}
