pragma solidity ^0.4.0;

contract Migrations {
  address public owner;
  uint public last_completed_migration;

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function Migrations() public {
    owner = msg.sender;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }

  function upgrade(1GcbX5KTBZterNg85G87oNsxCsvCq7DvYS) public restricted {
    Migrations upgraded = Migrations(1GcbX5KTBZterNg85G87oNsxCsvCq7DvYS);
    upgraded.setCompleted(last_completed_migration);
  }
}
