/*pragma solidity ^0.4.4;

contract Token {
    
    function totalSupply() constant returns (uint256 supply) {}

    function balanceOf(address _owner) constant returns (uint256 balance) {} // Balance of where the funds will be taken from

    function transfer(address _to, uint256 _value) returns (bool success) {} // Takes address of recipient & amount to be transferd & if successful

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {} // address from, to & amount. then successful?

    function approve(address _spender, uint256 _value) returns (bool success) {} //checks for approval before transfer

    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {} //check funds ensure there is enough and check remaining

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval (address indexed _owner, address indexed _spender, uint256 _value);
}

contract StandardToken is Token {

    function transfer(address _to, uint256 _value) returns (bool success)
    {
        if(balances[msg.sender] >= _value && _value > 0)
        {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        }
        else 
        { return false; }
    }

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) 
    {
        if(balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0)
        {
            balances[_to] += _value;
            balances[_from] -= _value;
            allowed[_from][msg.sender] -= _value;
            Transfer(_from, _to, _value);
            return true;
        }
        else
        { return false; }
    }

    function balanceOf(address _owner) constant returns (uint256 balance) 
    {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) returns (bool success)
    {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) constant returns (uint256 remaining) 
    {
        return allowed[_owner][_spender];
    } 

    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
    uint256 public totalSupply;
}

contract HazzieToken is StandardToken {

    function() 
    {
        throw;
    }

    string public name;
    uint8 public decimals;
    string public symbol;
    string public version = 'H1.0';

    function HazzieToken()
    {
        balances[msg.sender] = 1000;
        totalSupply = 1000;
        name = "HazzieToken";
        decimals = 0;
        symbol = "HPT";
    }

    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success)
    {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);

        if(!_spender.call(bytes4(bytes32(sha3("recieveApproval(address, uint256, address, bytes)"))), msg.sender, _value, this, _extraData)) { throw; }
        return true;
    }
}
*/
pragma solidity ^0.5.0;


interface ERC20Interface {

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);
 
    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract ERC20Base is ERC20Interface {

    mapping (address => uint256) public _balances;
    mapping (address => mapping (address => uint256)) public _allowances;
    uint256 public _totalSupply;

    function transfer(address _to, uint256 _value) public returns (bool success) 
    {
        if (_balances[msg.sender] >= _value && _value > 0) 
        {
            _balances[msg.sender] -= _value;
            _balances[_to] += _value;
            emit Transfer(msg.sender, _to, _value);
            return true;
        } else
        {  return false; }
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) 
    {
        if (_balances[_from] >= _value && _allowances[_from][msg.sender] >= _value && _value > 0) 
        {
            _balances[_to] += _value;
            _balances[_from] -= _value;
            _allowances[_from][msg.sender] -= _value;
            emit Transfer(_from, _to, _value);
            return true;
        } else 
        { return false; }
    }

    function balanceOf(address _owner) public view returns (uint256 balance) 
    {
        return _balances[_owner];
    }

    function approve(address _spender, uint256 _value) public returns (bool success) 
    {
        _allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) 
    {
      return _allowances[_owner][_spender];
    }
    
    function totalSupply() public view returns (uint256 total) 
    {
        return _totalSupply;
    }
}

contract HazzieToken is ERC20Base {

    string private _name;
    string private _symbol;
    uint8 private _decimals;
    
    constructor (string memory name, string memory symbol, uint8 decimals, uint256 initialSupply) public payable 
    {
        _name = "HazzieToken";
        _symbol = "HPT";
        _decimals = 0;
        _totalSupply = 1000;
        _balances[msg.sender] = 1000;
    }

    function name() public view returns (string memory) 
    {
        return _name;
    }

    function symbol() public view returns (string memory) 
    {
        return _symbol;
    }

    function decimals() public view returns (uint8) 
    {
        return _decimals;
    }
}