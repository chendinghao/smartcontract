/*
智能合约实现对数组的增删改查
*/
pragma solidity 0.4.9;
contract DemoTypes303{
    string[] strArr;
    function add(string str)    //增
    {
        strArr.push(str);
    }

    function getStrAt(uint n) constant returns (string s)   //查
    {
        string tmp = strArr[n];
        return tmp;
    }

    function updateStrAr(uint n, string str)        //改
    {
        strArr[n] = str;
    }

    function deleteStrAr(uint index)
    {
        uint len = strArr.length;
        if (len<index)  return;

        for(uint i=0; i<len-1; i++)
            strArr[i] = strArr[i+1];
        
        delete strArr[len-1];
        strArr.length--;
    }
}
