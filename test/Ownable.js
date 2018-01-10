var Ownable = artifacts.require('Ownable');

contract('Ownable', function (accounts) {
  it('allows ownership change by owner', function () {
    var account0 = accounts[0],
        account1 = accounts[1],
        account2 = accounts[2],
        _ownable;
    return Ownable
      .deployed()
      .then(function (instance) {
        _ownable = instance;

        return _ownable.setOwner(account1, { from: account0 });
      })
      .then(function (results) {
        return _ownable.owner();
      })
      .then(function (owner) {
        assert.equal(account1, owner);
      });
  });

  it('prevents ownership change by non-owner', function () {
    var account0 = accounts[0],
        account1 = accounts[1],
        account2 = accounts[2],
        account3 = accounts[3],
        _ownable;
    return Ownable
      .deployed()
      .then(function (instance) {
        _ownable = instance;
        return _ownable.owner.call({from: account3});
      })
      .then(function (owner) {
        assert.equal(account1, owner);
        return _ownable.setOwner(account3, { from: account3 });
      })
      .then(function (results) {
        console.log(arguments);
        return _ownable.owner.call({from: account2 });
      })
      .then(function (owner) {
        assert.equal(account1, owner);
      });
  });
});
