## Poly Playground

### Question:
 Magicians love to create things out of thin air. This time our secret wizards have created a playground. Test out your wizardry here!

Author: jloh02

nc challs.nusgreyhats.org 31113

### Explanation:
- The provided Python script connects to the server and receives data, which contains roots of polynomials.
- It then calculates the coefficients of the polynomial using the received roots.
- After calculating the coefficients, it sends the results back to the server.
- The script continuously receives new roots from the server, calculates the coefficients, and sends the results back in an infinite loop.

### Conclusion:
With this solution, you can interact with the wizard's playground challenge and test your wizardry skills by manipulating polynomials based on the provided roots.


### Solution:
```python
import socket
import re

HOST = "challs.nusgreyhats.org"
PORT = 31113
PATTERN = "Roots:\s*((?:-?\d+,?\s*)+)"

def polynomial_from_roots(roots):
    # For a single root, the polynomial is (x - root), hence coefficients [1, -root]
    # Coefficients of the resulting polynomial, starting as 1 (for x^0)
    coeffs = [1]

    for root in roots:
        # Current root to process, start with x - root = (1)x + (-root)
        current = [1, -root]
        # Temporary new coefficients, initialized to zero and length of (len(coeffs) + len(current) - 1)
        new_coeffs = [0] * (len(coeffs) + 1)

        # Multiply out the polynomials using the distributive property (convolution)
        for i in range(len(coeffs)):
            for j in range(len(current)):
                new_coeffs[i + j] += coeffs[i] * current[j]

        # Update coeffs to new_coeffs
        coeffs = new_coeffs

    return coeffs

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect((HOST, PORT))
    data = s.recv(4096)
    data = data.decode().strip()
    match = re.search(PATTERN, data)
    roots = [int(match.group(1))]
    print("Roots:", roots)
    results = polynomial_from_roots(roots)
    results = [str(result) for result in results]
    print("Results:", ",".join(results))
    s.sendall(str(",".join(results)).encode())
    s.sendall(b"\n")

    while True:
        data = s.recv(4096)
        print(data.decode())
        data = data.decode().strip()
        match = re.search(PATTERN, data)
        roots = str(match.group(1)).split(",")
        roots = [int(root) for root in roots]
        print("Roots:", roots)
        results = polynomial_from_roots(roots)
        results = [str(result) for result in results]
        print("Results:", ",".join(results))
        s.sendall(str(",".join(results)).encode())
        s.sendall(b"\n")
