/**************
copy partly from CSDN Blogs
**************/

pragma solidity 0.4.9;

contract HelloWorld
{
    //string greeting = "HelloWorld";    //可以直接进行初始化
    string greeting;
    address owner;                       //用于记录初始者的地址
    function HelloWorld(string _greeting) public
    {
        owner = msg.sender;
        greeting = _greeting; 
    }

    function greet()  returns(string)
    {
        return greeting;
    }

    function setGreeting(string _newgreeting)
    {
        greeting = _newgreeting;
    }

    /*******************
    Standard kill(): function to recover funds
    *******************/
    function kill()
    {
        if(msg.sender == owner)
            suicide(owner);
            // kills this contract and sends remaining funds back to creator.
    }
}