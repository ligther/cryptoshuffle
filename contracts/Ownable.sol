pragma solidity ^0.4.0;

contract Ownable {
  address public owner;
  // @dev Keeps track of whether the contract is paused. When that is true, most actions are blocked
  bool public paused = false;
  event NewOwner(address newOwner);

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function Ownable() public {
    owner = msg.sender;
  }

  function setOwner(address newOwner) external restricted {
    require(newOwner != address(0));
    owner = newOwner;
    NewOwner(newOwner);
  }

  modifier whenNotPaused() {
    require(!paused);
    _;
  }

  modifier whenPaused {
    require(paused);
    _;
  }

  function pause() external restricted whenNotPaused {
    paused = true;
  }

  function unpause() external restricted whenPaused {
    paused = false;
  }
}
