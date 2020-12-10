part of 'services_bloc.dart';

class ServicesState {
  final String serviceName;
  final String description;
  final String deliveryTime;
  final String attentionHours;
  final AvailableType availableType;
  final DepartmentType departmentType;
  final ProvinceType provinceType;
  final DistrictType districtType;
  final String address;

  final List<DistrictType> districtAvailable;
  final PriceType priceType;
  final String normalPrice;
  final String offerPrice;

  const ServicesState(
      {this.departmentType,
      this.provinceType,
      this.districtType,
      this.address,
      this.districtAvailable = const [],
      this.normalPrice,
      this.offerPrice,
      this.priceType = PriceType.NORMAL,
      this.deliveryTime,
      this.attentionHours,
      this.availableType,
      this.serviceName,
      this.description});

  ServicesState copyWith({
    String serviceName,
    String description,
    String deliveryTime,
    String attentionHours,
    AvailableType availableType,
    DepartmentType departmentType,
    ProvinceType provinceType,
    DistrictType districtType,
    String address,
    List<DistrictType> districtAvailable,
    PriceType priceType,
    String normalPrice,
    String offerPrice,
  }) {
    return ServicesState(
        address: address ?? this.address,
        attentionHours: attentionHours ?? this.attentionHours,
        availableType: availableType ?? this.availableType,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        departmentType: departmentType ?? this.departmentType,
        districtAvailable: districtAvailable ?? this.districtAvailable,
        districtType: districtType ?? this.districtType,
        normalPrice: normalPrice ?? this.normalPrice,
        offerPrice: offerPrice ?? this.offerPrice,
        priceType: priceType ?? this.priceType,
        provinceType: provinceType ?? this.provinceType,
        serviceName: serviceName ?? this.serviceName,
        description: description ?? this.description);
  }
}
