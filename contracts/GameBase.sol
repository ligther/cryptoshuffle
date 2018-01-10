pragma solidity ^0.4.0;

import "./Operable.sol";

contract GameBase is Operable {
  /*** Events ***/
  event NewGame     (uint256 gameId, address player0);
  event ResultSet   (uint256 gameId);
  event PasswordSet (uint256 gameId);

  /*** Data Types ***/
  struct Game {
    /// The timestamp from the block when this game began
    uint64      startTime;
    uint256      pledge;
    address[5]  players;
    bytes       result;
    bytes32     password;
    mapping (address => uint256) pledges;
  }

  mapping (uint256 => Game) games;
  uint256 public            newGameId = 0;

  function createGame () public payable returns (uint256) {
    require(msg.value > 0);
    require(msg.sender != address(0));
    address[5] memory players = [msg.sender, address(0), address(0), address(0), address(0)];
    bytes memory result = new bytes(0);

    games[newGameId] = Game({
      startTime: uint64(now),
      pledge:    msg.value,
      players: players,
      result: result,
      password: 0
    });

    games[newGameId].pledges[msg.sender] = msg.value;

    NewGame(newGameId, msg.sender);
    
    return newGameId++;
  }

  function setResult (uint256 gameId, bytes result) public justOperator {
    Game storage game = games[gameId];
    require(game.result.length == 0);
    game.result = result;
    
    ResultSet(gameId);
  }

  function setPassword (uint256 gameId, bytes32 password) public justOperator {
    Game storage game = games[gameId];
    require(game.result.length > 0);
    require(game.password.length > 0);

    game.password = password;

    PasswordSet(gameId);
  }
}


