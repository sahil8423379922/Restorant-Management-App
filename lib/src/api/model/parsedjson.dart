class Restaurant {
  final String? id;
  final String? name;
  final String? aboutUs;
  final List<dynamic>? cuisine;
  final String? address;
  final String? phone;
  final String? schedule;
  final String? ownerId;
  final String? thumbnail;
  final String? restaurantThumbnail;
  final String? aboutUsThumbnail;
  final double? deliveryCharge;
  final String? maximumTimeToDeliver;
  final String? gallery;
  final double? latitude;
  final double? longitude;
  final String? seoTags;
  final String? seoDescription;
  final String? status;
  final String? slug;
  final int? createdAt;
  final int? updatedAt;
  final String? website;
  final String? theme;
  final double? rating;
  final bool? supportPickupOrder;
  final bool? supportDelivery;
  final bool? supportReservation;

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
    this.supportDelivery,
    this.supportReservation,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id']?.toString(),
      name: json['name'],
      aboutUs: json['about_us'],
      // cuisine:
      //     json['cuisine'] != null ? List<dynamic>.from(json['cuisine']) : [],
      address: json['address'],
      phone: json['phone'],
      schedule: json['schedule'], // Nullable
      ownerId: json['owner_id']?.toString(),
      thumbnail: json['thumbnail'],
      restaurantThumbnail: json['restaurant_thumbnail'],
      aboutUsThumbnail: json['about_us_thumbnail'], // Nullable
      // deliveryCharge: json['delivery_charge'] != null
      //     ? (json['delivery_charge'] as num).toDouble()
      //     : 0.0,
      // maximumTimeToDeliver: json['maximum_time_to_deliver'],
      // gallery: json['gallery'], // Nullable
      // latitude:
      //     json['latitude'] != null ? (json['latitude'] as num).toDouble() : 0.0,
      // longitude: json['longitude'] != null
      //     ? (json['longitude'] as num).toDouble()
      //     : 0.0,
      // seoTags: json['seo_tags'], // Nullable
      // seoDescription: json['seo_description'], // Nullable
      // status: json['status']?.toString(),
      // slug: json['slug'],
      // createdAt:
      //     json['created_at'] != null ? (json['created_at'] as num).toInt() : 0,
      // updatedAt:
      //     json['updated_at'] != null ? (json['updated_at'] as num).toInt() : 0,
      // website: json['website'],
      // theme: json['theme'], // Nullable
      // rating: json['rating'] != null ? (json['rating'] as num).toDouble() : 0.0,
      // supportPickupOrder: json['support_pickup_order'] == 1,
      // supportDelivery: json['support_delivery'] == 1,
      // supportReservation: json['support_reservation'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'about_us': aboutUs,
      'cuisine': cuisine,
      'address': address,
      'phone': phone,
      'schedule': schedule,
      'owner_id': ownerId,
      'thumbnail': thumbnail,
      'restaurant_thumbnail': restaurantThumbnail,
      'about_us_thumbnail': aboutUsThumbnail,
      'delivery_charge': deliveryCharge,
      'maximum_time_to_deliver': maximumTimeToDeliver,
      'gallery': gallery,
      'latitude': latitude,
      'longitude': longitude,
      'seo_tags': seoTags,
      'seo_description': seoDescription,
      'status': status,
      'slug': slug,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'website': website,
      'theme': theme,
      'rating': rating,
      'support_pickup_order': supportPickupOrder,
      'support_delivery': supportDelivery,
      'support_reservation': supportReservation,
    };
  }
}
