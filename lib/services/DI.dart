//dependency Injection

class Car {
  Wheel _wheel = Wheel();

  drive() {
    _wheel.spin();
  }
}

class DIcar {
  final Wheel _wheel;
  DIcar(this._wheel);
  drive() {
    _wheel.spin();
  }
}

class Wheel {
  void spin() {
    print("drivig");
  }
}
