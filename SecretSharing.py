import hashlib
import json
import os.path
import random
from decimal import Decimal

FIELD_SIZE = 10 ** 5


def reconstruct_secret(shares):
    """
    Combines individual shares (points on graph)
    using Lagranges interpolation.

    `shares` is a list of points (x, y) belonging to a
    polynomial with a constant of our key.
    """
    sums = 0
    prod_arr = []

    for j, share_j in enumerate(shares):
        xj, yj = share_j
        prod = Decimal(1)

        for i, share_i in enumerate(shares):
            xi, _ = share_i
            if i != j:
                prod *= Decimal(Decimal(xi) / (xi - xj))

        prod *= yj
        sums += Decimal(prod)

    return int(round(Decimal(sums), 0))


def polynom(x, coefficients):
    """
    This generates a single point on the graph of given polynomial
    in `x`. The polynomial is given by the list of `coefficients`.
    """
    point = 0
    # Loop through reversed list, so that indices from enumerate match the
    # actual coefficient indices
    for coefficient_index, coefficient_value in enumerate(coefficients[::-1]):
        point += x ** coefficient_index * coefficient_value
    return point


def coeff(t, secret):
    """
    Randomly generate a list of coefficients for a polynomial with
    degree of `t` - 1, whose constant is `secret`.

    For example with a 3rd degree coefficient like this:
        3x^3 + 4x^2 + 18x + 554

        554 is the secret, and the polynomial degree + 1 is
        how many points are needed to recover this secret.
        (in this case it's 4 points).
    """
    coeff = [random.randrange(0, int(FIELD_SIZE)) for _ in range(int(t) - 1)]
    coeff.append(secret)
    return coeff


def generate_shares(n, m, secret):
    """
    Split given `secret` into `n` shares with minimum threshold
    of `m` shares to recover this `secret`, using SSS algorithm.
    """
    coefficients = coeff(m, secret)
    shares = []

    for i in range(1, int(n) + 1):
        x = random.randrange(1, FIELD_SIZE)
        shares.append((x, polynom(x, coefficients)))

    return shares


def deploy_shares(imageFile='encrypted_image.bmp', t=3, n=5, secret=4234):
    # imageFile: encrypted image path
    # t: threshold value
    # n: shared key number
    # secret: original secret
    # t, n = 2, 4
    # secret = 1234

    with open(imageFile, "rb") as f:
        image_hash = hashlib.sha256(f.read()).hexdigest()

    # Phase I: Generation of shares
    shares = generate_shares(n, t, secret)
    # print(f'Shares: {", ".join(str(share) for share in shares)}')

    # Json files open, read and write data
    with open('person.json', ) as f:
        json_data = json.load(f)

    ids = []
    for i in range(0, int(n)):
        rnd = random.randint(0, 6)
        ids.append(json_data['Kisilerim'][rnd]["id"])

    listObj = {"id": ids,
               "shares": shares,
               "image": image_hash
               }

    with open('shares_key.json', 'ab+') as f:
        f.seek(0, 2)  # Go to the end of file
        if f.tell() == 0:  # Check if file is empty
            f.write(json.dumps([listObj]).encode())  # If empty, write an array
        else:
            f.seek(-1, 2)
            f.truncate()  # Remove the last character, open the array
            f.write(' , '.encode())  # Write the separator
            f.write('\n'.encode())
            f.write(json.dumps(listObj).encode())  # Dump the dictionary
            f.write(']'.encode())  # Close the array
    return listObj


def unify_secret(imageFile='encrypted_image.bmp'):
    with open(imageFile, "rb") as f:
        image_hash = hashlib.sha256(f.read()).hexdigest()

    with open('shares_key.json', 'r') as f:
        data = json.load(f)
        for i in range(0, len(data)):
            if(data[i]['image']) == image_hash:
                shares = data[i]['shares']

    return reconstruct_secret(shares)


if __name__ == "__main__":
    #print(deploy_shares())
    print(unify_secret())
