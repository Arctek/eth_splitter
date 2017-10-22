pragma solidity ^0.4.4;

// TODO: Everything

contract Splitter {
	mapping(address => uint) public recipientBalances;

	event LogSplit(address sender, address recipient1, address receipient2, bool hasRemainder);
	event LogWithdraw(address recipient, uint withdrawAmount);

	function split(address recipient1, address recipient2) 
		isNotPaused
		isNotKilled
		payable
		public
		returns(bool success)
	{
		uint quotient;
		uint remainder;
		bool hasRemainder;

		require(recipient1 != address(0));
		require(recipient2 != address(0));
		require(recipient1 != recipient2);
		require(msg.value > 0);

		quotient  = msg.value / 2;
        remainder = msg.value - 2 * quotient;

        require(quotient > 0);

        if (remainder > 0) {
        	hasRemainder = true;
        }

        LogSplit(msg.sender, recipient1, recipient2)

        recipientBalances[recipient1] += quotient;
        recipientBalances[recipient2] += quotient;

        if (hasRemainder) {
        	recipientBalances[msg.sender] += remainder;
        }

        return true;
	}

	function withdraw(uint withdrawAmount)
		isNotPaused
		isNotKilled
		public
		returns(bool success)
	{

	}
}
