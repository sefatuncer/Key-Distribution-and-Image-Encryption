from Crypto.PublicKey import RSA
from Crypto.Signature.pkcs1_15 import PKCS115_SigScheme
from Crypto.Hash import SHA256
import binascii


def SignRSA(msg):
    # Generate 1024-bit RSA key pair (private + public key)
    keyPair = RSA.generate(bits=1024)

    print(keyPair)
    # Sign the message using the PKCS#1 v1.5 signature scheme (RSASP1)
    pubKey = keyPair.publickey()
    # msg = b'Message for RSA signing'
    hash = SHA256.new(msg)
    signer = PKCS115_SigScheme(keyPair)
    signature = signer.sign(hash)
    print("Signature:", binascii.hexlify(signature))
    return signature
    # Verify valid PKCS#1 v1.5 signature (RSAVP1)
    # msg = b'Message for RSA signing'
    # hash = SHA256.new(msg)
    # verifier = PKCS115_SigScheme(pubKey)
    # try:
    #    verifier.verify(hash, signature)
    #    print("Signature is valid.")
    # except:
    #    print("Signature is invalid.")
    # Verify invalid PKCS#1 v1.5 signature (RSAVP1)
    # msg = b'A tampered message'
    # hash = SHA256.new(msg)
    # verifier = PKCS115_SigScheme(pubKey)
    # try:
    #    verifier.verify(hash, signature)
    #    print("Signature is valid.")
    # except:
    #    print("Signature is invalid.")
