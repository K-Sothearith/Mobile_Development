enum Skill { FLUTTER, DART, OTHER }

class Employee {
  String name;
  double baseSalary;

  Employee(this.name, this.baseSalary);

  void printDetails() {
    print('Employee: $name, Base Salary: \$${baseSalary}');
  }
}

void main() {
  var emp1 = Employee('Sokea', 40000);
  emp1.printDetails();

  var emp2 = Employee('Ronan', 45000);
  emp2.printDetails();
}