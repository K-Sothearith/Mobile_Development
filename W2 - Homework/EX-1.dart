enum Skill { FLUTTER, DART, OTHER }

class Address {
  final String _street;
  final String _city;
  final String _zipCode;

  const Address(this._street, this._city, this._zipCode);

  String get street => _street;
  String get city => _city;
  String get zipCode => _zipCode;

  @override
  String toString() => '$_street, $_city, $_zipCode';
}

class Employee {
  final String _name;
  final double _baseSalary;
  final List<Skill> _skills;
  final Address _address;
  final int _yearsOfExperience;

  Employee(this._name, this._baseSalary, this._skills, this._address, this._yearsOfExperience);

  Employee.mobileDeveloper(String name, double baseSalary, Address address, int yearsOfExperience) : 
  _name = name,
  _baseSalary = baseSalary,
  _skills = [Skill.FLUTTER, Skill.DART],
  _address = address, 
  _yearsOfExperience = yearsOfExperience;
  
  String get name => _name;
  double get baseSalary => _baseSalary;
  List<Skill> get skills => _skills;
  Address get address => _address;
  int get yearsOfExperience => _yearsOfExperience;

  double computeSalary() {
    double total = _baseSalary;

    // Each year of experience adds $2,000
    total += _yearsOfExperience * 2000;

    // Each skill adds a different bonus:
    for (var skill in _skills) {
      switch (skill) {
        // FLUTTER: adds $5000  
        case Skill.FLUTTER:
          total += 5000;
          break;
        // DART: adds $3000
        case Skill.DART:
          total += 3000;
          break;
        // OTHER: adds $1000
        case Skill.OTHER:
          total += 1000;
          break;
      }
    }

    // Having more 2 or more skills adds $5000
    if (_skills.length >= 2) total += 5000;

    return total;
  }

  void printDetails() {
    print('Employee: $name, Base Salary: \$${baseSalary}, Total Salary: \$${computeSalary()}');
    print('Experience: $_yearsOfExperience year(s)');
    print('Skills: ${_skills.map((s) => s.name).join(', ')}');
    print('Address: ${_address}');
  }
}

void main() {
  var emp1 = Employee('Sokea', 40000, [Skill.OTHER], Address('NR6', 'Phnom Penh', '12100'), 3);
  emp1.printDetails();

  var emp2 = Employee.mobileDeveloper('Ronan', 45000, Address('NR6', 'Phnom Penh', '12100'), 10);
  emp2.printDetails();
}