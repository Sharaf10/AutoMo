class Vehicle {
  late String _model;
  late String _manufactureYear;
  late String _engineCapacity;
  late String _mileage;
  late String _grade;
  late String _fuelType;
  late String _transmissionType;

  Vehicle(this._model, this._manufactureYear, this._engineCapacity,
      this._mileage, this._grade, this._fuelType, this._transmissionType);

  Vehicle.empty();

  String get transmissionType => _transmissionType;

  set transmissionType(String value) {
    _transmissionType = value;
  }

  String get fuelType => _fuelType;

  set fuelType(String value) {
    _fuelType = value;
  }

  String get grade => _grade;

  set grade(String value) {
    _grade = value;
  }

  String get mileage => _mileage;

  set mileage(String value) {
    _mileage = value;
  }

  String get engineCapacity => _engineCapacity;

  set engineCapacity(String value) {
    _engineCapacity = value;
  }

  String get manufactureYear => _manufactureYear;

  set manufactureYear(String value) {
    _manufactureYear = value;
  }

  String get model => _model;

  set model(String value) {
    _model = value;
  }
}
