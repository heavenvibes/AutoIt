PwnedPwd stand for "Pwned Password ?"


This script was written to share the ability to safely check if your password(s) have been leaked.

It was also written to add it to the scripts (bash, php and python) written by yrougy (https://github.com/yrougy/CheckPasswordLeak) with the same goal.

I autorise him to publish my script on his GitHub repository.

To use it, you will need to install a copy of curl.exe in the script directory, or modify the $CURL var to the location of curl.exe.

When executed, you will be prompted to enter your password in an inputbox. The password you type isn't displayed at all.

It is directly encrypted to SHA1 hash, and then splitted into 2 parts, 5 first chars and 35 last chars.

Only the 5 chars part is sent to https://api.pwnedpasswords.com/range/***** which responds with a list of partial 35 chars hashes.

This list is compared to the 35 chars hash part from your password, and if it is found in the list, then it means that your password have been leaked.

The list contains also a number, which means the number of times your password has been leaked.

If the partial 35 chars hash from your password hasn't been found, then your password hasn't been leaked ! Congatulations !
