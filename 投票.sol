pragma solidity 0.4.9;

// title Voting with delegation.
// title 授权投票

contract Ballot
{
    struct Voter
    {
        uint weight;        //投票比重
        bool voted;         //是否投票
        address delegate;   //委托的股票代表
        uint vote;          //
    }

    struct Proposal
    {
        bytes32 name;       //提案名称
        uint voteCount;     //累计获得的票数
    }

    mapping(address => Voter) public voters;
    Proposal[] public proposals;
    address chairMan;       //主席地址

    //初始化
    function Ballot(bytes32[] proposalNames)
    {
        chairMan = msg.sender;  //记录主席地址
        voters[chairMan].weight = 1;

        //对提供的每一个提案名称，创建一个新的提案
        //对象添加到数组末尾
        for(uint i=0; i<proposalNames.length; i++)
            proposals.push(Proposal({
                name:proposalNames[i],
                voteCount:0
            }));
    }   

    //赋予投票权利
    function giveRightToVote(address voter)
    {
        if (msg.sender != chairMan || voters[voter].voted)
        //如果不是主席，或者已经投票
        throw;

        voters[voter].weight = 1;
    }

    //在这个合约中可以委托别人投票
    function delegate(address to)
    {
        Voter sender = voters[msg.sender];
        if(sender.voted)
            throw;
        
        while (voters[to].delegate != address(0) &&
                voters[to].delegate != msg.sender)
                to = voters[to].delegate;
        
        //当最终投票代表等于调用者，是不被允许的
        if (to == msg.sender)
            throw;
        
        sender.voted = true;
        sender.delegate = to;
        Voter delegate = voters[to];

        if(delegate.voted)
            proposals[delegate.vote].voteCount += sender.weight;
        else
            delegate.weight += sender.weight;
    }

    //投出你的选票，包括别人委托给你的选票
    function vote(uint proposal)
    {
        Voter sender = voters[msg.sender];
        if (sender.voted)       //如果已经投票，则抛出
            throw;

        sender.voted = true;
        sender.vote = proposal; //选择该方案

        proposals[proposal].voteCount += sender.weight;
    }

    //计算胜选方案
    function winningProposal() constant
        returns (uint winningProposal)
        {
            uint winningVoteCount = 0;
             for (uint p = 0; p < proposals.length; p++)
            {
                if (proposals[p].voteCount > winningVoteCount)
                {
                    winningVoteCount = proposals[p].voteCount;
                    winningProposal = p;
                }
            }
        }
}
