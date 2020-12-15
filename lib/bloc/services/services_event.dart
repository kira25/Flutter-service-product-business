part of 'services_bloc.dart';

abstract class ServicesEvent extends Equatable {
  const ServicesEvent();

  @override
  List<Object> get props => [];
}

class OnServiceNameChange extends ServicesEvent {
  final String name;

  OnServiceNameChange(this.name);
}

class OnServiceDescriptionChange extends ServicesEvent {
  final String description;

  OnServiceDescriptionChange(this.description);
}

class OnServiceDeliveryTime extends ServicesEvent {
  final String deliveryTime;

  OnServiceDeliveryTime(this.deliveryTime);
}

class OnAttentionHours extends ServicesEvent {
  final String attentionHours;

  OnAttentionHours(this.attentionHours);
}

class OnAvailableType extends ServicesEvent {
  final AvailableType availableType;

  OnAvailableType(this.availableType);
}

class OnDepartmentType extends ServicesEvent {
  final DepartmentType departmentType;

  OnDepartmentType(this.departmentType);
}

class OnProvinceType extends ServicesEvent {
  final ProvinceType provinceType;

  OnProvinceType(this.provinceType);
}

class OnDistrictType extends ServicesEvent {
  final DistrictType districtType;

  OnDistrictType(this.districtType);
}

class OnAddressChange extends ServicesEvent {
  final String address;

  OnAddressChange(this.address);
}

class OnDistrictAvailable extends ServicesEvent {
  final List<DistrictType> list;

  OnDistrictAvailable(this.list);
}

class OnPriceType extends ServicesEvent {
  final PriceType priceType;

  OnPriceType(this.priceType);
}

class OnNormalPriceChange extends ServicesEvent {
  final String normalPrice;

  OnNormalPriceChange(this.normalPrice);
}

class OnOfferPriceChange extends ServicesEvent {
  final String offerPrice;

  OnOfferPriceChange(this.offerPrice);
}

class OnCleanServiceData extends ServicesEvent {}

class OnHandleServiceCreate extends ServicesEvent {}

class OnDeleteServiceImage extends ServicesEvent {
  final int index;

  OnDeleteServiceImage(this.index);
}

class OnAddServiceImage extends ServicesEvent {}

class OnLoadShopServices extends ServicesEvent {}

class OnDeleteService extends ServicesEvent{
  final String id;

  OnDeleteService(this.id);
}

class OnLoadServiceToEdit extends ServicesEvent{

}

class OnUpdateSerice extends ServicesEvent{
  final String id;

  OnUpdateSerice(this.id);


}