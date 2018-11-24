This package of files provides a set of command line scripts for checking
whether any of your Facebook-enabled app's users (identified by their
app-scoped IDs, or ASIDs) are among those compromised in the recent session
token theft. In this package, you should find:

* A test data file named TEST.asid_check_file
* A test data file named TEST.my_asids
* Scripts in Python, Ruby, Java, JavaScript (Node), and PHP, C# and Powershell

The scripts take three inputs:
* Your app's app secret (available in app settings at developers.facebook.com)
* The local path to a file that Facebook provided you, which contains hashes
  of ASIDs for users of your app who may be affected.
* The local path to a file that you create, which is a newline-delimited list
  of ASIDs you wish to check.

Given those inputs, the scripts output a list of impacted ASIDs whose sessions
you should invalidate.

You may test the scripts with the provided test data. When used as described
below, all scripts should give the following three lines of output:

90500276471969
90970265033214
90500276473585



PLEASE NOTE:

Do not be surprised to find that only a small number of ASIDs are affected.
It is also possible that you have no affected users. If you run the scripts
and get no output, check the following:

* Run the scripts against test data according to the instructions below.
* Double check that you are using the correct app secret for the app you want
  to check.
* Double check that the app-scoped IDs (ASIDs) you are using are associated
  with the same app ID as the app secret you're using.

If everything checks out and you get no matches, none of the users you checked
were affected.



USAGE:

All of these command line invocations assume that all files are in the same
directory, that they are readable by the current user, and (where applicable)
that the script file is executable by the current user.

The JavaScript implementation assumes Node is installed.


Python - testing:
./asidcheck.py bf59c7e03e77fd8ca375a0782ac7c898 TEST.asid_check_file TEST.my_asids

Python - checking live ASIDs:
./asidcheck.py <YOUR APP SECRET> <FB-PROVIDED ASID HASH FILE> <YOUR ASID LIST>


Ruby - testing:
./asidcheck.rb bf59c7e03e77fd8ca375a0782ac7c898 TEST.asid_check_file TEST.my_asids

Ruby - checking live ASIDs:
./asidcheck.rb <YOUR APP SECRET> <FB-PROVIDED ASID HASH FILE> <YOUR ASID LIST>


Java - testing:
javac AsidCheck.java
java AsidCheck bf59c7e03e77fd8ca375a0782ac7c898 TEST.asid_check_file TEST.my_asids

Java - checking live ASIDs:
javac AsidCheck.java
java AsidCheck <YOUR APP SECRET> <FB-PROVIDED ASID HASH FILE> <YOUR ASID LIST>


JavaScript - testing:
./asidcheck.js bf59c7e03e77fd8ca375a0782ac7c898 TEST.asid_check_file TEST.my_asids

JavaScript - checking live ASIDs:
./asidcheck.js <YOUR APP SECRET> <FB-PROVIDED ASID HASH FILE> <YOUR ASID LIST>


PHP - testing:
php asidcheck.php bf59c7e03e77fd8ca375a0782ac7c898 TEST.asid_check_file TEST.my_asids

PHP - checking live ASIDs:
php asidcheck.php <YOUR APP SECRET> <FB-PROVIDED ASID HASH FILE> <YOUR ASID LIST>


Powershell - testing:
./asidcheck.ps1 bf59c7e03e77fd8ca375a0782ac7c898 TEST.asid_check_file TEST.my_asids

Powershell - checking live ASIDs:
./asidcheck.ps1 <YOUR APP SECRET> <FB-PROVIDED ASID HASH FILE> <YOUR ASID LIST>


C# - testing:
csc AsidCheck.cs
AsidCheck.exe bf59c7e03e77fd8ca375a0782ac7c898 TEST.asid_check_file TEST.my_asids

C# - checking live ASIDs:
csc AsidCheck.cs
AsidCheck.exe <YOUR APP SECRET> <FB-PROVIDED ASID HASH FILE> <YOUR ASID LIST>

