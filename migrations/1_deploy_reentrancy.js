const { deployProxy } = require("@openzeppelin/truffle-upgrades");
const Reentrancy = artifacts.require("ReEntrancy.sol");
const Attack = artifacts.require("Attack.sol");

module.exports = async function (deployer) {
  const reentrancyInstance = await deployProxy(Reentrancy, { deployer });
  console.log("Re-Entrancy deployed!", reentrancyInstance.address);
  const attackInstance = await deployer.deploy(
    Attack,
    reentrancyInstance.address
  );
  console.log("Attack deployed!", attackInstance.address);
};
