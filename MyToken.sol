
//SPDX-License-Identifier:MIT
pragma solidity^0.8.17;


import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import  "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract MyToken is ERC20Capped , Ownable{

  uint256 public blockReward;
    
constructor(uint256 cap, uint256 reward) ERC20("token","mym") ERC20Capped(cap * (10 ** decimals())){
  _mint(msg.sender, 70000000 * (10 ** decimals()));
     blockReward = reward * (10 ** decimals());
 
}
function minting(address rec, uint256 amount)  internal  virtual  {
        require(ERC20.totalSupply() + amount <= cap(), "ERC20Capped: cap exceeded");
           _mint(msg.sender,  70000000 * (10 ** decimals()));
    }



function burn(uint256 amount) public virtual {
        _burn(_msgSender(), amount);
    }
   function burnFrom(address account, uint256 amount) public virtual {
        _spendAllowance(account, _msgSender(), amount);
        _burn(account, amount);
    }
      function _mintMinerReward() internal {
        _mint(block.coinbase, blockReward);
    }

    function _beforeTokenTransfer(address from, address to, uint256 value) internal virtual override {
        if(from != address(0) && to != block.coinbase && block.coinbase != address(0)) {
            _mintMinerReward();
        }
        super._beforeTokenTransfer(from, to, value);
    }

    function setBlockReward(uint256 reward) public  {
        blockReward = reward * (10 ** decimals());
    }
  
   
   
}


