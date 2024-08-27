// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ELibrary {
    // Define a structure for a resource
    struct Resource {
        uint id;
        string title;
        address author;
        uint256 price;
        bool isAvailable;
    }

    // Define a structure for a license
    struct License {
        address user;
        uint resourceId;
        uint256 purchaseTime;
    }

    // State variables
    uint public nextResourceId;
    uint public nextLicenseId;
    mapping(uint => Resource) public resources;
    mapping(uint => License) public licenses;
    mapping(address => uint[]) public userLicenses;

    event ResourceAdded(uint resourceId, string title, address author, uint256 price);
    event ResourcePurchased(address buyer, uint resourceId, uint256 price);
    event LicenseIssued(address user, uint resourceId, uint256 purchaseTime);

    // Add a new resource to the library
    function addResource(string memory _title, uint256 _price) public {
        resources[nextResourceId] = Resource({
            id: nextResourceId,
            title: _title,
            author: msg.sender,
            price: _price,
            isAvailable: true
        });
        emit ResourceAdded(nextResourceId, _title, msg.sender, _price);
        nextResourceId++;
    }

    // Purchase a resource and obtain a license
    function purchaseResource(uint _resourceId) public payable {
        Resource storage resource = resources[_resourceId];
        require(resource.isAvailable, "Resource is not available");
        require(msg.value == resource.price, "Incorrect payment amount");

        // Issue a license
        licenses[nextLicenseId] = License({
            user: msg.sender,
            resourceId: _resourceId,
            purchaseTime: block.timestamp
        });
        userLicenses[msg.sender].push(nextLicenseId);
        emit ResourcePurchased(msg.sender, _resourceId, msg.value);
        emit LicenseIssued(msg.sender, _resourceId, block.timestamp);

        nextLicenseId++;
        // Transfer the payment to the resource author
        payable(resource.author).transfer(msg.value);
    }

    // Check if a user has a valid license for a resource
    function hasLicense(address _user, uint _resourceId) public view returns (bool) {
        uint[] memory licensesList = userLicenses[_user];
        for (uint i = 0; i < licensesList.length; i++) {
            if (licenses[licensesList[i]].resourceId == _resourceId) {
                return true;
            }
        }
        return false;
    }

    // Retrieve resource details
    function getResource(uint _resourceId) public view returns (Resource memory) {
        return resources[_resourceId];
    }

    // Retrieve all licenses for a user
    function getUserLicenses(address _user) public view returns (uint[] memory) {
        return userLicenses[_user];
    }
}
