This is my first attempt at creating an ERC20 Token that is verified by Etherscan.io. I built the token twice within the same file. The initial version had compile time errors, in which much of the code has been deprecated. I want to use a more up to date compiler as Remix has also been updated lots. The first attempt has all been commented out if you want to see what it was like. There are also more comments in the first version as I didn’t want to have to write them twice when the code does the same thing in both versions. 

The token is fully functional on the test Ropsten network, I may look into getting it on the main network at a later date but for now it is fully functional with verification and I have been able to swap it between accounts and also send it to other people on the test network.

The biggest roadblock I had was actually getting faucet ETH into the test metamask account. I had a few small hiccups learning how to use Remix and understanding some of the Solidity syntax as it can be a bit messy and it feels like a weird mix between C++ and JS.

I will include some screenshots below of the Verification and the Token transactions. 

![Initial transaction](HazzieToken\images\InitialTransaction.png)
![Verfication](images\HazzieTokenVerification.png)
![transaction after verified](images\TransactionAfterVerified.png)
