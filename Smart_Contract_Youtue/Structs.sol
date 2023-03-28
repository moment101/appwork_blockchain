// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Structs {
    struct Car {
        string model;
        uint year;
        address owner;
    }

    Car public car;
    Car[] public cars;
    mapping(address => Car[]) public carsByOwner;

    function examples() external {
        Car memory toyota = Car("Toyota", 1990, msg.sender);
        Car memory lambo = Car({
            year: 1980,
            model: "Lamboghini",
            owner: msg.sender
        });
        Car memory tesla;
        tesla.model = "Tesla";
        tesla.year = 2010;
        tesla.owner = msg.sender;

        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);

        cars.push(Car("Ferrari", 2020, msg.sender));

        Car storage _car = cars[0];
        _car.year = 1999;
        delete _car.owner;
        delete cars[1];
    }
}

// cars[0]
// string: model Toyota
// uint256: year 1999
// address: owner 0x0000000000000000000000000000000000000000

// cars[1]
// string: model
// uint256: year 0
// address: owner 0x0000000000000000000000000000000000000000

// cars[2]
// string: model Tesla
// uint256: year 2010
// address: owner 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

// cars[3]
// string: model Ferrari
// uint256: year 2020
// address: owner 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
