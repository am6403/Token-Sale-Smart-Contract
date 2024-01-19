# Token-Sale-Smart-Contract

Token Sale Smart Contract, to facilitate the orderly and secure distribution of project tokens during a fundraising event. This contract is programmed with specific rules governing different phases of the token sale, such as a presale and public sale, where participants can contribute Ether and receive project tokens in return. The contract enforces a maximum cap on Ether contributions, minimum and maximum contribution limits per participant, and provides mechanisms for the distribution of tokens and refunds based on predefined conditions. Through smart contract functions, the Token Sale Smart Contract automates the entire process, ensuring transparency, trust, and efficiency.


Steps:-

1)Deploy the Contract: Deploy the TokenSale contract by providing values for presaleCap, publicSaleCap, minContribution, and maxContribution.
Ensure the deployment is done with the desired parameters.

2)Start Presale: As the owner, initiate the presale phase by calling the startPresale function.
Confirm the transaction.

3)Contribute During Presale: Participants can contribute Ether during the presale phase using the contribute function.
Specify an amount within the allowed limits (minContribution and maxContribution).
Confirm the transaction.

4)End Presale: After a certain period or when the presale cap is reached, end the presale phase by calling the endPresale function.
Confirm the transaction.

5)Start Public Sale: The owner initiates the public sale phase by calling the endPresale function..

6)Contribute During Public Sale: Participants can contribute Ether during the public sale using the contribute function.
Specify an amount within the allowed limits (minContribution and maxContribution).

7)End Token Sale: After a certain period or when the public sale cap is reached, end the token sale by calling the endSale function.

8)Distribute Remaining Tokens: Automatically or manually distribute the remaining tokens to those who contributed during the presale.

Post-Token Sale Steps:-

9)Refund Process: If the minimum cap is not reached during either the presale or public sale, contributors can claim a refund.
Participants call the claimRefund function to retrieve their contributions.
Confirm the transaction.

10)Purchase at Regular Price: Use the remaining funds to buy the remaining tokens at the regular price from participants who contributed during the presale.
Confirm the transactions.
