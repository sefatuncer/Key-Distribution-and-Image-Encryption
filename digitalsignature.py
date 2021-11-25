import hashlib
from Crypto.PublicKey import RSA
from Crypto.Signature.pkcs1_15 import PKCS115_SigScheme
from Crypto.Hash import SHA256
import binascii
import json


# This function for create signatures and return
def sign_data(ids, image_hash, verify=False):
    person_hash = []
    signatures = []
    with open('person.json', 'r') as f:
        data = json.load(f)
        for i in range(0, len(ids)):
            for j in range(0, len(data['Kisilerim'])):
                if data['Kisilerim'][j]['id'] == ids[i]:
                    person_hash.append(hashlib.sha256((data['Kisilerim'][j]['name']).encode('utf-8')).hexdigest())
                    n = data['Kisilerim'][j]['publicKey'][0]
                    e = data['Kisilerim'][j]['publicKey'][1]
                    d = data['Kisilerim'][j]['privateKey'][1]
                    p = data['Kisilerim'][j]['pqu'][0]
                    q = data['Kisilerim'][j]['pqu'][1]
                    u = data['Kisilerim'][j]['pqu'][2]
                    # Generate 1024-bit RSA key pair (private + public key)
                    keyPair = RSA.generate(bits=1024)
                    keyPair.allKeysDef(n, e, d, p, q, u)
                    person_image = person_hash[i] + image_hash
                    # print("Person image:", person_image)
                    _hash = SHA256.new(person_image.encode('utf-8'))
                    signer = PKCS115_SigScheme(keyPair)
                    signature = signer.sign(_hash)
                    signatures.append(binascii.hexlify(signature).decode('utf-8'))
                    if verify:  # if need verify
                        pubKey = keyPair.publickey()
                        verifier = PKCS115_SigScheme(pubKey)
                        try:
                            verifier.verify(_hash, signature)
                            print("Signature is valid.")
                        except:
                            print("Signature is invalid.")
                    print("Signature:", binascii.hexlify(signature).decode('utf-8'))
                    print('**********************************************')
    return signatures


# This function for sign image and create a list of signatures
def digital_sign_list():
    with open('shares_key.json', 'r') as f:
        data = json.load(f)
        ids = data[len(data) - 1]['id']
        image_hash = data[len(data) - 1]['image']

    signatures = sign_data(data, image_hash)

    listSign = {
        "image": image_hash,
        "signature": signatures
    }
    # print(listSign)

    return listSign


# This function for write data to "blockchain_data.json" file
def sign_write_blockchain():
    listSign = digital_sign_list()
    print(listSign)
    with open('blockchain_data.json', 'ab+') as f:
        f.seek(0, 2)  # Go to the end of file
        if f.tell() == 0:  # Check if file is empty
            f.write('['.encode())
            f.write(json.dumps(listSign).encode())  # If empty, write an array
        else:
            f.seek(-1, 2)
            f.truncate()  # Remove the last character, open the array
            f.write(' , '.encode())  # Write the separator
            f.write('\n'.encode())
            f.write(json.dumps(listSign).encode())  # Dump the dictionary
            f.write(']'.encode())  # Close the array

    # print(f"Public key:  (n={hex(keyPair.n)}, e={hex(keyPair.e)})")
    # print(f"Private key: (n={hex(keyPair.n)}, d={hex(keyPair.d)})")
    # Sign the message using the PKCS#1 v1.5 signature scheme (RSASP1)


# This function for verify signatures and image
def verify_signer(imageFile='encrypted_image.bmp'):
    with open(imageFile, "rb") as f:
        image_hash = hashlib.sha256(f.read()).hexdigest()

    with open('shares_key.json', 'r') as f:
        data = json.load(f)
        for i in range(0, len(data)):
            if data[i]['image'] == image_hash:
                ids = data[i]['id']

    with open('blockchain_data.json', 'r') as f:
        data = json.load(f)
        for i in range(0, len(data)):
            if data[i]['image'] == image_hash:
                signs = data[i]['signature']
    sign_data(ids, image_hash, True)


if __name__ == '__main__':
    # sign_write_blockchain()
    verify_signer()
    # Verify invalid PKCS#1 v1.5 signature (RSAVP1)
    # msg = b'A tampered message'
    # hash = SHA256.new(msg)
    # verifier = PKCS115_SigScheme(pubKey)
    # try:
    #    verifier.verify(hash, signature)
    #    print("Signature is valid.")
    # except:
    #    print("Signature is invalid.")

    # with open(imageFile, "rb") as f2:
    # image_hash = hashlib.sha256(f2.read()).hexdigest()
