# Blockchain_and_Image_Encryption

This study covers image encryption and recording the encrypted image to the blockchain with the Hyperledger Fabric chaincode smart contract.

1. Set the image encryption key (secret). (type of Shamir's Secret Sharing Scheme - SSS)
2. Divide the secret into n parts using the SSS and distribute it to n stakeholders.
3. Perform chaotic system-based image encryption with key (secret).
4. Calculate the hash of the encrypted image with SHA256.
5. Sign the hash of the encrypted image separately with n stakeholders.
6. Store encrypted images on a public/private cloud platform for use in verification processes.
(In addition, additional information such as the unit and person performing the transaction is added and stored in the blockchain.)
