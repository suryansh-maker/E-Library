
# ELibrary Smart Contract

## Vision

The ELibrary smart contract aims to create a decentralized digital library where users can purchase and access digital resources. This system leverages blockchain technology to ensure transparent and secure transactions, giving authors a direct way to earn from their work while providing users with a trustworthy platform to acquire and manage digital content.

## Features

1. **Resource Management**:
   - Authors can add new resources (e.g., eBooks, articles) to the library with a title, price, and availability status.
   
2. **Resource Purchase**:
   - Users can purchase resources by sending the exact amount of Ether required. Upon purchase, a license is issued to the user.
   
3. **License Tracking**:
   - Licenses are tracked for each user, and a user can have multiple licenses for different resources.
   
4. **Resource Availability**:
   - Resources can be queried for their details including availability, price, and author information.
   
5. **License Validation**:
   - Users can verify if they own a valid license for a particular resource.
   
6. **Event Logging**:
   - Key actions such as adding a resource, purchasing a resource, and issuing a license are logged through events for easy tracking and verification.

## Diagram

```plaintext
+-------------------+
|      ELibrary     |
+-------------------+
| + addResource()   |
| + purchaseResource() |
| + hasLicense()   |
| + getResource()  |
| + getUserLicenses() |
+-------------------+
         |
         |
+-------------------+
|   Resource        |
+-------------------+
| - id              |
| - title           |
| - author          |
| - price           |
| - isAvailable     |
+-------------------+
         |
         |
+-------------------+
|    License        |
+-------------------+
| - user            |
| - resourceId      |
| - purchaseTime    |
+-------------------+
```

## Deployment

To deploy the ELibrary smart contract to an Ethereum network (e.g., Rinkeby, Mainnet), follow these steps:

1. **Setup Environment**:
   - Install [Node.js](https://nodejs.org/) and [npm](https://www.npmjs.com/).
   - Install [Truffle](https://www.trufflesuite.com/truffle) or [Hardhat](https://hardhat.org/) for deployment.

2. **Compile the Contract**:
   - Using Truffle: `truffle compile`
   - Using Hardhat: `npx hardhat compile`

3. **Deploy the Contract**:
   - Create a deployment script in the `migrations` folder (for Truffle) or the `scripts` folder (for Hardhat).
   - Truffle deployment example:
     ```javascript
     const ELibrary = artifacts.require("ELibrary");
     
     module.exports = function(deployer) {
       deployer.deploy(ELibrary);
     };
     ```
   - Hardhat deployment example:
     ```javascript
     async function main() {
       const ELibrary = await ethers.getContractFactory("ELibrary");
       const eLibrary = await ELibrary.deploy();
       console.log("ELibrary deployed to:", eLibrary.address);
     }
     
     main().catch((error) => {
       console.error(error);
       process.exitCode = 1;
     });
     ```

4. **Configure Network Settings**:
   - Ensure you have a configured `truffle-config.js` or `hardhat.config.js` file with the network settings for your desired Ethereum network.

5. **Deploy to Network**:
   - Using Truffle: `truffle migrate --network <network_name>`
   - Using Hardhat: `npx hardhat run scripts/deploy.js --network <network_name>`

.

Deployment :

Contract Address: 0x4c36d9bbcf74c3b3c9813731e4d67037cf00f3a6

![image](https://github.com/user-attachments/assets/b1081401-fb08-461d-b272-f9653aa7581e)

Thank You

