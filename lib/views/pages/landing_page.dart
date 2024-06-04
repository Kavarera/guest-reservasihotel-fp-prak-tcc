import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fp_fe_reservasihotel_guest/controllers/booking_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../models/roomtype/room_type.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});
  final BookingController rt = Get.put(BookingController());
  @override
  Widget build(BuildContext context) {
    List<String> _roomName = [
      "Suite Room",
      "Deluxe Room",
      "Family Suite Room",
      "Standar Room"
    ];
    List<String> _imageUrl = [
      "https://storage.googleapis.com/e-02-415004.appspot.com/images/7ngue2_nWTmszBX6.jpg",
      "https://storage.googleapis.com/e-02-415004.appspot.com/images/wApo3E0EHBxzjsuE.jpg",
      "https://storage.googleapis.com/e-02-415004.appspot.com/images/PtnTS8leTZmkeMDD.jpg",
      "https://storage.googleapis.com/e-02-415004.appspot.com/images/hoYZI6CJ6v6MYS7G.jpg"
    ];
    List<String> _roomPrice = ["IDR 1.2B", "IDR 1.3B", "IDR 1B", "IDR 3B"];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: const BorderSide(color: Colors.white, width: 0.5),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            'Tinggal-in',
            style: GoogleFonts.firaSans(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: InkWell(
                onTap: () {
                  _showBookingDialog(context);
                },
                child: Text(
                  'Book Now',
                  style: GoogleFonts.firaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3),
                                BlendMode.multiply),
                            child: Image.network(
                              "https://storage.googleapis.com/e-02-415004.appspot.com/images/hoYZI6CJ6v6MYS7G.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 2),
                      child: Center(
                        child: Text(
                          'GRAND YOGYA HOTEL',
                          style: GoogleFonts.firaSans(
                              fontSize: 60,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Flexible(
                  child: CarouselSlider(
                    options: CarouselOptions(
                        height: MediaQuery.of(context).size.width / 2.9,
                        autoPlay: true,
                        enableInfiniteScroll: true),
                    items: [0, 1, 2, 3].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return RoomCardWidget(
                            roomName: _roomName[i],
                            roomPrice: _roomPrice[i],
                            imageUrl: _imageUrl[i],
                            controller: rt,
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showBookingDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nikController = TextEditingController();
    final _fullnameController = TextEditingController();
    final _phoneController = TextEditingController();
    final _emailController = TextEditingController();
    final _checkinController = TextEditingController();
    final _daysController = TextEditingController();
    final _roomIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Form'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nikController,
                    decoration: InputDecoration(labelText: 'NIK'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter NIK';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _fullnameController,
                    decoration: InputDecoration(labelText: 'Full Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _checkinController,
                    decoration: InputDecoration(labelText: 'Check-in Date'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter check-in date';
                      }
                      if (!_isValidDate(value)) {
                        return 'Please enter a valid date (MM-DD-YYYY)';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _daysController,
                    decoration: InputDecoration(labelText: 'Days'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter number of days';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  Obx(
                    () => DropdownButton<RoomTypeData>(
                      value: rt.selectedRoomTypes.value,
                      items:
                          rt.roomTypes.value?.data.map((RoomTypeData roomType) {
                                return DropdownMenuItem<RoomTypeData>(
                                  value: roomType,
                                  child: Text(roomType.name),
                                );
                              }).toList() ??
                              [],
                      onChanged: (RoomTypeData? e) {
                        if (e != null) {
                          rt.setSelectedRoomTypes(e);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  final bookingData = {
                    "nik": _nikController.text,
                    "fullname": _fullnameController.text,
                    "phone": _phoneController.text,
                    "email": _emailController.text,
                    "checkin": _checkinController.text,
                    "days": int.parse(_daysController.text),
                    "RoomTypeId": rt.selectedRoomTypes.value!.id,
                  };
                  rt.postBooking(bookingData);
                  Navigator.of(context).pop();
                  // You can use bookingData for further processing.
                  print(bookingData);
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  bool _isValidDate(String date) {
    try {
      final parsedDate = DateFormat('MM-dd-yyyy').parseStrict(date);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class RoomCardWidget extends StatelessWidget {
  final String roomName;
  final String roomPrice;
  final String imageUrl;
  final BookingController controller;
  const RoomCardWidget(
      {super.key,
      required this.roomName,
      required this.roomPrice,
      required this.imageUrl,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 40,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Image.network(imageUrl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      roomName,
                      style: GoogleFonts.firaSans(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          color: Colors.black),
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      roomPrice,
                      style: GoogleFonts.firaSans(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          color: Colors.black),
                      overflow: TextOverflow.clip,
                    )
                  ],
                ),
                Text(
                  'Lorem Ipsum Dolorsit Amrit La Rokoe NYangNYung SukWeng Duk We Rasmain Wel Gal MarSulok Perlo Ruasgk Egnas Vang Yeruan Kilau TurAs merlo Wanguugab persik ler sa vcuzhe lsfegia hrmradglra rkhakerata heianha,elqnag',
                  style: GoogleFonts.firaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: Colors.black),
                  overflow: TextOverflow.clip,
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showBookingDialog(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    child: Text(
                      'Booking Now',
                      style: GoogleFonts.firaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _showBookingDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nikController = TextEditingController();
    final _fullnameController = TextEditingController();
    final _phoneController = TextEditingController();
    final _emailController = TextEditingController();
    final _checkinController = TextEditingController();
    final _daysController = TextEditingController();
    final _roomIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Form'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nikController,
                    decoration: InputDecoration(labelText: 'NIK'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter NIK';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _fullnameController,
                    decoration: InputDecoration(labelText: 'Full Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _checkinController,
                    decoration: InputDecoration(labelText: 'Check-in Date'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter check-in date';
                      }
                      if (!_isValidDate(value)) {
                        return 'Please enter a valid date (MM-DD-YYYY)';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _daysController,
                    decoration: InputDecoration(labelText: 'Days'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter number of days';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  Obx(
                    () => DropdownButton<RoomTypeData>(
                      value: controller.selectedRoomTypes.value,
                      items: controller.roomTypes.value?.data
                              .map((RoomTypeData roomType) {
                            return DropdownMenuItem<RoomTypeData>(
                              value: roomType,
                              child: Text(roomType.name),
                            );
                          }).toList() ??
                          [],
                      onChanged: (RoomTypeData? e) {
                        if (e != null) {
                          controller.setSelectedRoomTypes(e);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  final bookingData = {
                    "nik": _nikController.text,
                    "fullname": _fullnameController.text,
                    "phone": _phoneController.text,
                    "email": _emailController.text,
                    "checkin": _checkinController.text,
                    "days": int.parse(_daysController.text),
                    "RoomTypeId": controller.selectedRoomTypes.value!.id,
                  };
                  controller.postBooking(bookingData);
                  Navigator.of(context).pop();
                  // You can use bookingData for further processing.
                  print(bookingData);
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  bool _isValidDate(String date) {
    try {
      final parsedDate = DateFormat('MM-dd-yyyy').parseStrict(date);
      return true;
    } catch (e) {
      return false;
    }
  }
}
