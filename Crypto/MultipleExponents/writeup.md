```
mul = int(pow(e1, -1, e2))
e2_mul = (e1*mul - 1)//int(e2)

bytes.fromhex(hex(pow(c1, mul, n)*pow(pow(c2,e2_mul,n), -1, n))[2:])
```
The challenge can be solved by making use of the fact that both e1 and e2 are coprime. We can juggle the numbers, making use of the modular inverse, to get `c^x % n` and `c^(x+1) % n`. From there we don't need to know x to recover c. We can simply do division by once again making use of the modular inverse.
