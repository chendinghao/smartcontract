pragma solidity 0.4.9;
contract Token{
    mapping (address => uint) public balancesOf;
    
    /*
    创建owner保存合约初始者的地址
    */
    
    address public owner;      

    /*
    author: cdh
    content:    mapping(_KeyType => uint)
                            ^         ^
            _KeyType can be almost any type except for a mapping
            _ValueType can actually be any type, including mappings.
    */

    function Token()
    {
        owner = msg.sender;                 //将合约初始者的地址保存
        balancesOf[msg.sender] = 10000;     //创建该合约的地址赋予一个初始值
    }

    function transfer(address _to, uint _value)
    {
        if (balancesOf[msg.sender] < _value) throw;             //判断是否有足够的钱
        if (balancesOf[_to] + _value <balancesOf[_to]) throw;   //不懂
        
        balancesOf[msg.sender] -= _value;
        balancesOf[_to] += _value;
    }

    function mint(uint _amount)             //简单的挖矿
    {
        balancesOf[owner] += _amount;
    }
}