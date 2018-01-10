var GameBase = artifacts.require("./GameBase.sol");

module.exports = function(deployer) {
  deployer.deploy(GameBase);
};
