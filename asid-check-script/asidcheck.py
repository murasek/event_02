#! /usr/bin/env python

# written with Python 2.7.10

import sys
import hashlib
import binascii
import base64
import hmac


if len(sys.argv) != 4:
	print "App-scoped ID check script"
	print "Usage:"
	print "asidcheck.py <APP_SECRET> <HASH_FILE> <INPUT_FILE>"
	print "  * APP_SECRET is the app secret shown in the Settings"
	print "    for your app on developers.facebook.com"
	print "  * HASH_FILE is local path to the Facebook-provided file containing"
	print "    the encrypted hashes of your ASIDs"
	print "  * INPUT_FILE is local path a newline-delimited list of ASIDs you"
	print "    wish to check against the hash file"
	print ""
	print "When called successfully, this script will emit a list of matching"
	print "ASIDs to stdout."
	sys.exit(-1)


app_secret = sys.argv[1]
fbhash_file_name = sys.argv[2]
asids_file_name = sys.argv[3]


# set up our HMAC key
app_secret_bytes = bytearray.fromhex(app_secret)
sha256 = hashlib.sha256()
sha256.update(app_secret_bytes)
key = sha256.digest()


# read in our test values
test_values = set()
with open(fbhash_file_name) as fp:
    for line in fp:
		line = line.strip()
		test_values.add(base64.b64decode(line))

### GOOD TO HERE
# read in and check your ASIDs
with open(asids_file_name) as fp:
	for asid in fp:
		asid = asid.strip() # remove newline
		hmac_asid = hmac.new(key, asid, hashlib.sha256) # hmac digest of ASID
		truncated_hmac_asid = hmac_asid.digest()[0:8] # high 8 bits of digest
		if truncated_hmac_asid in test_values:
			print asid # output if match




