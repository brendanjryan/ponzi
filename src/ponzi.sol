pragma solidity ^0.4.11;


// Ponzi is a simple ponzi scheme contract.
contract Ponzi {

  // the address of the last depositor on the chain.
  address lastDepositor;

  // currentAmount represents the amount of ether that needs to be
  // sent to the contract in order to buy in to the scheme.
  uint public currentAmount;

  // Ponzi initializes the smart contract
  function Ponzi(uint _startingAmount) public {
    // the contract creator only gets paid out what they put in.
    currentAmount = _startingAmount;
  }

  // pay is called by an external party who wants to enter the scheme.
  // if the appropriate amount of ether is supplied to enter the contract,
  // the previous entrant will be paid and the payer will be recorded.
  function pay() public payable {
    require(msg.value == currentAmount);

    // send money to the previous payer
    lastDepositor.transfer(msg.value);
    lastDepositor = msg.sender;

    // update the current amount for the next round.
    currentAmount = nextAmount(currentAmount);
  }

  function nextAmount(uint amount) private pure returns (uint) {
    return amount * 2;
  }
}
