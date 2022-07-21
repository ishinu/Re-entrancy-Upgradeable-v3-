const { upgradeProxy } = require("@openzeppelin/truffle-upgrades");
const Reentrancyv2 = artifacts.require("ReEntrancyv2.sol");

const Implementationv1 = "0x62528eC7F68D9aE54439DbB17301F42d369468A5";

module.exports = async (deployer) => {
  console.log(
    "Existing Reentrancy Address === 0x62528eC7F68D9aE54439DbB17301F42d369468A5"
  );

  const instance = await upgradeProxy(Implementationv1, Reentrancyv2, {
    deployer,
  });
  console.log("Implementation contract upgraded!", instance.address);
};
