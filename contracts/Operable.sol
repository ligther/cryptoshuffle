pragma solidity ^0.4.0;
import "./Ownable.sol";


contract Operable is Ownable {
  address public operator;
  event NewOperator(address newOperator);

  modifier justOperator() {
    require(msg.sender == operator);
    _;
  }

  function setOperator(address newOperator) public restricted {
    require(newOperator != address(0));
    operator = newOperator;
  }
}
