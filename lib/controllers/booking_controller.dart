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
      bs.postBooking(bookingData);
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }
}
