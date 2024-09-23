import 'dart:convert';

class Restaurant {
  String? id;
  String? name;
  String? aboutUs;
  List<int>? cuisine;
  String? address;
  String? phone;
  Schedule? schedule;
  String? ownerId;
  List<String>? thumbnail;
  String? restaurantThumbnail;
  String? aboutUsThumbnail;
  double? deliveryCharge;
  int? maximumTimeToDeliver;
  List<String>? gallery;
  double? latitude;
  double? longitude;
  String? seoTags;
  String? seoDescription;
  String? status;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? website;
  String? theme;
  double? rating;
  bool? supportPickupOrder;
  bool? showSlider;
  String? sectionId;
  String? videoFeature;
  String? sliderBgImage;
  String? reservationBgImage;
  bool? supportDelivery;
  bool? supportReservation;
  String? restaurantNameColor;
  bool? supportTookan;
  String? ownerName;
  String? ownerEmail;
  String? ownerPhone;

  Restaurant({
    this.id,
    this.name,
    this.aboutUs,
    this.cuisine,
    this.address,
    this.phone,
    this.schedule,
    this.ownerId,
    this.thumbnail,
    this.restaurantThumbnail,
    this.aboutUsThumbnail,
    this.deliveryCharge,
    this.maximumTimeToDeliver,
    this.gallery,
    this.latitude,
    this.longitude,
    this.seoTags,
    this.seoDescription,
    this.status,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.website,
    this.theme,
    this.rating,
    this.supportPickupOrder,
    this.showSlider,
    this.sectionId,
    this.videoFeature,
    this.sliderBgImage,
    this.reservationBgImage,
    this.supportDelivery,
    this.supportReservation,
    this.restaurantNameColor,
    this.supportTookan,
    this.ownerName,
    this.ownerEmail,
    this.ownerPhone,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      aboutUs: json['about_us'],
      cuisine: jsonDecode(json['cuisine']).cast<int>(),
      address: json['address'],
      phone: json['phone'],
      schedule: Schedule.fromJson(jsonDecode(json['schedule'])),
      ownerId: json['owner_id'],
      thumbnail: jsonDecode(json['thumbnail']).cast<String>(),
      restaurantThumbnail: json['restaurant_thumbnail'],
      aboutUsThumbnail: json['about_us_thumbnail'],
      deliveryCharge: json['delivery_charge'] != null
          ? double.tryParse(json['delivery_charge'])
          : null,
      maximumTimeToDeliver: json['maximum_time_to_deliver'] != null
          ? int.tryParse(json['maximum_time_to_deliver'])
          : null,
      gallery: jsonDecode(json['gallery']).cast<String>(),
      latitude: double.tryParse(json['latitude']),
      longitude: double.tryParse(json['longitude']),
      seoTags: json['seo_tags'],
      seoDescription: json['seo_description'],
      status: json['status'],
      slug: json['slug'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          int.parse(json['created_at']) * 1000),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
          int.parse(json['updated_at']) * 1000),
      website: json['website'],
      theme: json['theme'],
      rating: double.tryParse(json['rating']),
      supportPickupOrder: json['support_pickup_order'] == "1",
      showSlider: json['show_slider'] == "1",
      sectionId: json['section_id'],
      videoFeature: json['video_fature'],
      sliderBgImage: json['slider_bg_image'],
      reservationBgImage: json['reservation_bg_image'],
      supportDelivery: json['support_delivery'] == "1",
      supportReservation: json['support_reservation'] == "1",
      restaurantNameColor: json['restaurantname_color'],
      supportTookan: json['support_tookan'] == "1",
      ownerName: json['owner_name'],
      ownerEmail: json['owner_email'],
      ownerPhone: json['owner_phone'],
    );
  }
}

class Schedule {
  String? saturdayOpening;
  String? saturdayClosing;
  String? sundayOpening;
  String? sundayClosing;
  String? mondayOpening;
  String? mondayClosing;
  String? tuesdayOpening;
  String? tuesdayClosing;
  String? wednesdayOpening;
  String? wednesdayClosing;
  String? thursdayOpening;
  String? thursdayClosing;
  String? fridayOpening;
  String? fridayClosing;

  Schedule({
    this.saturdayOpening,
    this.saturdayClosing,
    this.sundayOpening,
    this.sundayClosing,
    this.mondayOpening,
    this.mondayClosing,
    this.tuesdayOpening,
    this.tuesdayClosing,
    this.wednesdayOpening,
    this.wednesdayClosing,
    this.thursdayOpening,
    this.thursdayClosing,
    this.fridayOpening,
    this.fridayClosing,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      saturdayOpening: json['saturday_opening'],
      saturdayClosing: json['saturday_closing'],
      sundayOpening: json['sunday_opening'],
      sundayClosing: json['sunday_closing'],
      mondayOpening: json['monday_opening'],
      mondayClosing: json['monday_closing'],
      tuesdayOpening: json['tuesday_opening'],
      tuesdayClosing: json['tuesday_closing'],
      wednesdayOpening: json['wednesday_opening'],
      wednesdayClosing: json['wednesday_closing'],
      thursdayOpening: json['thursday_opening'],
      thursdayClosing: json['thursday_closing'],
      fridayOpening: json['friday_opening'],
      fridayClosing: json['friday_closing'],
    );
  }
}
