part of 'services_bloc.dart';

enum IsServiceCreated { UNDEFINED, SUCCESS, FAIL, LOADING }
enum IsServiceDeleted { UNDEFINED, SUCCESS, FAIL }
enum IsServiceEdited { UNDEFINED, SUCCESS, FAIL }

class ServicesState {
  final IsServiceCreated isServiceCreated;
  final IsServiceDeleted isServiceDeleted;
  final IsServiceEdited isServiceEdited;
  final String serviceName;
  final String description;
  final String deliveryTime;
  final String attentionHours;
  final AvailableType availableType;
  final DepartmentType departmentType;
  final ProvinceType provinceType;
  final DistrictType districtType;
  final String address;
  final bool isServices;

  final List<DistrictType> districtAvailable;
  final PriceType priceType;
  final String normalPrice;
  final String offerPrice;
  final List<File> filesService;
  final ServiceResponse serviceResponse;

  const ServicesState(
      {this.isServices,
      this.serviceResponse,
      this.isServiceCreated = IsServiceCreated.UNDEFINED,
      this.isServiceDeleted = IsServiceDeleted.UNDEFINED,
      this.isServiceEdited = IsServiceEdited.UNDEFINED,
      this.filesService = const [],
      this.departmentType,
      this.provinceType,
      this.districtType,
      this.address,
      this.districtAvailable = const [],
      this.normalPrice,
      this.offerPrice,
      this.priceType = PriceType.NORMAL,
      this.deliveryTime,
      this.attentionHours,
      this.availableType = AvailableType.SHOP,
      this.serviceName,
      this.description});

  ServicesState copyWith({
    bool isServices,
    ServiceResponse serviceResponse,
    IsServiceCreated isServiceCreated,
    IsServiceDeleted isServiceDeleted,
    IsServiceEdited isServiceEdited,
    List<File> filesService,
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
        isServices: isServices ?? this.isServices,
        serviceResponse: serviceResponse ?? this.serviceResponse,
        isServiceCreated: isServiceCreated ?? this.isServiceCreated,
        isServiceDeleted: isServiceDeleted ?? this.isServiceDeleted,
        isServiceEdited: isServiceEdited ?? this.isServiceEdited,
        filesService: filesService ?? this.filesService,
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
