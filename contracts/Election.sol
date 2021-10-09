pragma solidity ^0.5.2;

contract Election {
	//Model a Candidate
	struct Candidate{
		uint id;
		string name;
		uint voteCount;
	}

	//Store accounts that have voted
	mapping(address => bool) public voters;

	//Store Candidate
	//Fetch Candidate
	mapping(uint=>Candidate) public candidates;
	//Store Candidate count
	uint public candidatesCount;

	// voted event
    event votedEvent (
        uint indexed _candidateId
    );

	//Constructor 
	constructor() public {
		addCandidate("Candidate 1");
		addCandidate("Candidate 2");
	}

	function addCandidate(string memory _name) private {
		candidatesCount++;
		candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
	}

	function vote(uint _candidateId) public {
		// check candidate has not voted before
		require(!voters[msg.sender]);

		// require valide candidate
		require(_candidateId > 0 && _candidateId <= candidatesCount);

		// record that user has voted
		voters[msg.sender] = true;

		// update candidate vote count
		candidates[_candidateId].voteCount ++;

		emit votedEvent(_candidateId);
	}

}