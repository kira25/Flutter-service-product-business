import 'package:service_products_business/helpers/enums.dart';


String handleIntToAvailableType ( int type){
    switch (type) {
    case 0:
      return 'A domicilio';
      break;
    case 1:
      return 'En tienda';
      break;
    case 2:
      return 'Tienda / Domicilio';
      break;
    default:
      return 'En tienda';
  }
}


String handleAvailableType(AvailableType availableType) {
  switch (availableType) {
    case AvailableType.HOME:
      return 'A domicilio';
      break;
    case AvailableType.SHOP:
      return 'En tienda';
      break;
    case AvailableType.SHOP_HOME:
      return 'Tienda / Domicilio';
      break;
    default:
      return 'En tienda';
  }
}

String handleDepartmentType(DepartmentType departmentType) {
  switch (departmentType) {
    case DepartmentType.LIMA:
      return 'Lima';
      break;
    case DepartmentType.ICA:
      return 'Ica';
      break;
    case DepartmentType.AREQUIPA:
      return 'Arequipa';
      break;
    case DepartmentType.LAMBAYEQUE:
      return 'Lambayeque';
      break;
    default:
      return 'Departamento';
  }
}

String handleProvinceType(ProvinceType provinceType) {
  switch (provinceType) {
    case ProvinceType.LIMA:
      return 'Lima';
      break;
    case ProvinceType.CHICLAYO:
      return 'Ica';
      break;
    case ProvinceType.NAZCA:
      return 'Nzca';
      break;
    case ProvinceType.AREQUIPA:
      return 'Arequipa';
      break;
    default:
      return 'Provincia';
  }
}

String handleDistrictType(DistrictType districtType) {
  switch (districtType) {
    case DistrictType.SANBORJA:
      return 'San Borja';
      break;
    case DistrictType.SANISIDRO:
      return 'San Isidro';
      break;
    case DistrictType.SURQUILLO:
      return 'Surquillo';
      break;
    case DistrictType.SURCO:
      return 'Surco';
      break;
    case DistrictType.MOLINA:
      return 'Molina';
      break;
    case DistrictType.LINCE:
      return 'Lince';
      break;
    case DistrictType.JESUSMARIA:
      return 'Jesus Maria';
      break;
    case DistrictType.LIMA:
      return 'Lima';
      break;
    case DistrictType.ANCON:
      return 'Ancon';
      break;
    case DistrictType.ATE:
      return 'Ate';
      break;
    case DistrictType.BARRANCO:
      return 'Barranco';
      break;
    case DistrictType.BRENA:
      return 'Breña';
      break;
    case DistrictType.CARABAYLLO:
      return 'Carabayllo';
      break;
    case DistrictType.COMAS:
      return 'Comas';
      break;
    case DistrictType.OLIVOS:
      return 'Los Olivos';
      break;
    case DistrictType.LURIGANCHO:
      return 'Lurigancho';
      break;
    default:
      return 'Distrito';
  }
}
