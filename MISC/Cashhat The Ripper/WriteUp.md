## Cashhat The Ripper

### Question:
If only there was a way to crack password-protected zip files...

Author: glendoodle

### Solution:
First download the file
Eventually you will get a zip folder which is password protected
Using zip2john zip, transfering the zip folder to be read as a hash.
```
zip2john challenge.zip > zip.txt
```
Now you just use john zip.hashes
```
john --wordlist=/usr/share/wordlists/rockyou.txt zip.txt
```
Wait for decoding.
Then you get the password as '123mango'
Key it in to get flag: 
```
flag{W34k_P4ssw0rds_St4Nd_n0_Ch4nc3}
```
