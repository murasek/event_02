#!/usr/bin/env ruby

# written with Ruby 2.5.1

require 'digest'
require 'openssl'
require 'base64'


if ARGV.length != 3
	puts "App-scoped ID check script"
	puts "Usage:"
	puts "asidcheck.rb <APP_SECRET> <HASH_FILE> <INPUT_FILE>"
	puts "  * APP_SECRET is the app secret shown in the Settings"
	puts "    for your app on developers.facebook.com"
	puts "  * HASH_FILE is local path to the Facebook-provided file containing"
	puts "    the encrypted hashes of your ASIDs"
	puts "  * INPUT_FILE is local path a newline-delimited list of ASIDs you"
	puts "    wish to check against the hash file"
	puts ""
	puts "When called successfully, this script will emit a list of matching"
	puts "ASIDs to stdout."
	exit -1
end


app_secret = ARGV[0] # the app secret from your developers.facebook.com console
fbhash_file_name = ARGV[1] # the file provided by facebok
asids_file_name = ARGV[2] # newline-delimited list of ASIDs you want to check


# set up our HMAC key
app_secret_bytes = [app_secret].pack('H*').bytes.pack('c*') # string to bits
key = OpenSSL::Digest.new('sha256').digest(app_secret_bytes) # HMAC key


# read in our test values
test_values = Hash.new
fbhash_file = open fbhash_file_name
while (test_value = fbhash_file.gets)
   test_values[Base64.decode64(test_value.strip!)] = nil
end
fbhash_file.close


# read in and check your ASIDs
asids_file = open asids_file_name
while (asid = asids_file.gets)
	asid.strip! # ruby unhelpfully includes the newline
	hmac = OpenSSL::HMAC.digest('sha256', key, asid) # hmac digest of ASID
	truncated_hmac = hmac.slice(0, 8) # high 8 bits of digest
	puts asid if test_values.has_key?(truncated_hmac) # output if match
end
