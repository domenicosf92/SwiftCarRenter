import UIKit

class Car{
    private var code: String;
    private var dailyPrice: Double;
    private var reserved: Bool = false;
    private var rentDays: Int = 0;
    private var availabilityDays: Int = 30;
    
    init(_ cod: String, _ dailyPrice: Double) {
        self.code = cod;
        self.dailyPrice = dailyPrice;
    }
    
    // get-set
    var cpCode: String {
        get {
            return self.code
        }
        set(code) {
            self.code = code;
        }
    }
    
    // get-set
    var cpReserved: Bool {
        get {
            return self.reserved;
        }
        set(reserved) {
            self.reserved = reserved;
        }
    }
    
    var cpAvailabilityDays: Int {
        get {
            return self.availabilityDays;
        }
        set(availabilityDays) {
            self.availabilityDays = availabilityDays;
        }
    }
    
    // get-set
    var cpRentDays: Int {
        get {
            return self.rentDays;
        }
        set(rentDays) {
            self.rentDays = rentDays;
        }
    }
    
    // get-set
    var cpPrice: Double {
        get {
            return self.dailyPrice;
        }
        set(dailyPrice) {
            self.dailyPrice = dailyPrice;
        }
    }
    
    func toString() -> String {
        return "Code: \(self.code) \nDaily price: \(self.dailyPrice) \nReserved: \(self.reserved) \nRentDays: \(self.rentDays) \nAvailable days: \(self.availabilityDays)\n";
    }
}

class Customer{
    private var name: String;
    private var surname: String;
    private var credit: Double;
    
    init(_ name: String, _ surname: String, _ credit: Double) {
        self.name = name;
        self.surname = surname;
        self.credit = credit;
    }
    
    // get-set
    var cpName: String {
        get {
            return self.name;
        }
        set(name) {
            self.name = name;
        }
    }
    
    // get-set
    var cpCredit: Double {
        get {
            return self.credit;
        }
        set(credit) {
            self.credit = credit;
        }
    }
    
    func toString() -> String {
        return "Name: \(self.name) \(self.surname) \nCredit: \(self.credit)\n";
    }
}

class CarRental{
    private var cars: [Car] = [];
    private var customers: [Customer] = [];
    private var name: String;
    private var credit: Double;
    
    init(_ name: String, _ credit: Double) {
        self.name = name;
        self.credit = credit;
    }
    
    // get-set
    var cpName: String {
        get {
            return self.name;
        }
        set(name) {
            self.name = name;
        }
    }
    
    // get-set
    var cpCredit: Double {
        get {
            return self.credit;
        }
        set(credit) {
            self.credit = credit;
        }
    }
    
    func addCar(car: Car) {
        self.cars.append(car);
    }
    
    private func addCustomer(customer: Customer) {
        self.customers.append(customer);
    }
    
    private func changeCarStatus(_ days: Int) {
        for car in self.cars {
            if car.cpReserved == false {
                car.cpReserved = true;
                car.cpRentDays = days;
            } else {
                car.cpReserved = false;
                car.cpRentDays = 0;
            }
        }
    }
    
    func notRentedCars() -> Int {
        var count: Int = 0;
        for car in self.cars {
            if car.cpReserved == false {
                count += 1;
            }
        }
        return count;
    }
    
    func rentCar(customer: Customer, car: String, days: Int) -> String{
        for item in self.cars {
            if car == item.cpCode {
                if item.cpReserved == false && days < item.cpAvailabilityDays {
                    if customer.cpCredit >= (item.cpPrice * Double(days)) {
                        self.customers.append(customer);
                        self.changeCarStatus(days);
                        self.credit += (item.cpPrice * Double(days));
                        customer.cpCredit -= (item.cpPrice * Double(days));
                    } else {
                        return "To less credit";
                    }
                } else if item.cpRentDays > 0 {
                    return "Car rented for more days"
                } else {
                    return "All car are reserved";
                }
            } else {
                return "Car not present...";
            }
        }
        return "Done";
    }
    
    func rentCarAfterDays(customer: Customer, car: String, afterNumberOfDays: Int, days: Int) -> String {
        for item in self.cars {
            if car == item.cpCode {
                if item.cpReserved == false || item.cpRentDays < afterNumberOfDays {
                    if customer.cpCredit >= (item.cpPrice * Double(days)) {
                        self.customers.append(customer);
                        self.credit += (item.cpPrice * Double(days));
                        item.cpAvailabilityDays = afterNumberOfDays;
                        customer.cpCredit -= (item.cpPrice + Double(days));
                    } else {
                        return "To less credit";
                    }
                } else {
                    return "Car not available";
                }
            } else {
                return "Car not present..."
            }
        }
        return "Done";
    }
    private func carDetails() -> String{
        var string: String = "";
        for car in self.cars {
            string = string + car.toString() + "\n";
        }
        return string;
    }
    
    func toString() -> String {
        return "\nName: \(self.name) \nCredit: \(self.credit)€ \n\nCars present: \(self.carDetails())\n";
    }
}

var matteo = Customer("Matteo", "Annaro", 500);
var domenico = Customer("Domenico", "Signore Fiore", 600);
var cinquecento = Car("001", 3.5);
var fiesta = Car("002", 5);
var panda = Car("003", 4);
var uniCar = CarRental("Unicar", 10000);
uniCar.addCar(car: cinquecento);
uniCar.addCar(car: fiesta);
uniCar.addCar(car: panda);
print("Available cars: \(uniCar.notRentedCars())");
print(uniCar.toString())
print(uniCar.rentCar(customer: matteo, car: "002", days: 3));


