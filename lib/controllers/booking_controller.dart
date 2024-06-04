import 'package:flutter/material.dart';
import 'package:fp_fe_reservasihotel_guest/models/roomtype/room_type.dart';
import 'package:fp_fe_reservasihotel_guest/services/booking_service.dart';
import 'package:get/get.dart';

import '../services/room_type_service.dart';

class BookingController extends GetxController {
  var roomTypes = Rxn<RoomType>();
  var selectedRoomTypes = Rxn<RoomTypeData>();
  RoomTypeService rts = RoomTypeService();

  void setSelectedRoomTypes(RoomTypeData rt) {
    selectedRoomTypes.value = rt;
  }

  void _getRoomTypes() async {
    try {
      final result = await rts.getRoomType();
      roomTypes.value = result;
      selectedRoomTypes.value = result.data.first;
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    _getRoomTypes();
  }

  void postBooking(Map<String, Object> bookingData) async {
    BookingService bs = BookingService();
    try {
      final res = await bs.postBooking(bookingData);
      final bookingCode = res['data']['booking']['kode_booking'];
      showBookingCode(bookingCode);
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  void showBookingCode(String bookingCode) {
    Get.dialog(
      AlertDialog(
        title: const Text('Kode Booking Anda'),
        content: Column(
          children: [
            Center(
              child: Text(
                bookingCode,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Center(
              child: Text('Simpan Kode Dengan Baik'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Menutup AlertDialog
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
