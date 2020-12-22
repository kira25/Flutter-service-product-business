import 'package:service_products_business/helpers/enums.dart';

AvailableType handleAvailableTypeResponse(int available) {
  switch (available) {
    case 0:
      return AvailableType.SHOP;
      break;
    case 1:
      return AvailableType.HOME;
      break;
    case 2:
      return AvailableType.SHOP_HOME;
      break;
    default:
      return AvailableType.UNDEFINED;
  }
}

String handleIntToAvailableType(int type) {
  switch (type) {
    case 0:
      return 'En tienda';
      break;
    case 1:
      return 'A domicilio';
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


DepartmentType handleDepartmentTypeResponse(int departmentType) {
  switch (departmentType) {
    case 0:
      return DepartmentType.LIMA;
      break;
    case 1:
      return DepartmentType.ICA;
      break;
    case 2:
      return DepartmentType.AREQUIPA;
      break;
    case 3:
      return DepartmentType.LAMBAYEQUE;
      break;
    default:
      return DepartmentType.UNDEFINED;
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


ProvinceType handleProvinceTypeResponse(int provinceType) {
  switch (provinceType) {
    case 0:
      return ProvinceType.LIMA;
      break;
    case 1:
      return ProvinceType.CHICLAYO;
      break;
    case 2:
      return ProvinceType.NAZCA;
      break;
    case 3:
      return ProvinceType.AREQUIPA;
      break;
    default:
      return ProvinceType.UNDEFINED;
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
      return 'Nazca';
      break;
    case ProvinceType.AREQUIPA:
      return 'Arequipa';
      break;
    default:
      return 'Provincia';
  }
}

DistrictType handleDistrictTypeResponse(int districtType) {
  switch (districtType) {
    case 0:
      return DistrictType.SANBORJA;
      break;
    case 1:
      return DistrictType.SANISIDRO;
      break;
    case 2:
      return DistrictType.SURQUILLO;
      break;
    case 3:
      return DistrictType.SURCO;
      break;
    case 4:
      return DistrictType.MOLINA;
      break;
    case 5:
      return DistrictType.LINCE;
      break;
    case 6:
      return DistrictType.JESUSMARIA;
      break;
    case 7:
      return DistrictType.LIMA;
      break;
    case 8:
      return DistrictType.ANCON;
      break;
    case 9:
      return DistrictType.ATE;
      break;
    case 10:
      return DistrictType.BARRANCO;
      break;
    case 11:
      return DistrictType.BRENA;
      break;
    case 12:
      return DistrictType.CARABAYLLO;
      break;
    case 13:
      return DistrictType.COMAS;
      break;
    case 14:
      return DistrictType.OLIVOS;
      break;
    case 15:
      return DistrictType.LURIGANCHO;
      break;
    default:
      return DistrictType.UNDEFINED;
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
