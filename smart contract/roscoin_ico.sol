pragma solidity ^0.4.11;

contract SimpleStorage {
    uint public max_roscoins = 69000000;

    uint public usd_to_roscoins = 6900;

    uint public total_roscoins_bought = 0;

    mapping (address => uint) equity_roscoins;
    mapping (address => uint) equity_usd;

    modifier can_buy_roscoins(uint usd_invested) {
        require(usd_invested*usd_to_roscoins + total_roscoins_bought <= max_roscoins);
        _;
    }

    function equity_in_roscoins(address investor) external constant returns (uint) {
        return equity_roscoins[investor];
    }

    function equity_in_usd(address investor) external constant returns (uint) {
        return equity_usd[investor];
    }

    function buy_roscoins(address investor, uint usd_invested) external
    can_buy_roscoins(usd_invested) {
        uint roscoins_bought = usd_invested * usd_to_roscoins;
        equity_roscoins[investor] += roscoins_bought;
        equity_usd[investor] = equity_roscoins[investor]/6900;
        total_roscoins_bought += roscoins_bought;
    }

    function sell_roscoins(address investor, uint roscoins_sold) external {
        equity_roscoins[investor] -= roscoins_sold;
        equity_usd[investor] = equity_roscoins[investor]/6900;
        total_roscoins_bought -= roscoins_sold;
    }
}