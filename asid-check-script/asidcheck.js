#!/usr/bin/env node
const crypto = require('crypto');
const fs = require('fs');
const lr = require('readline');

const args = process.argv.slice(2)

if (args.length != 3) {
    console.log(
            "Usage:\n" +
                    "./asidcheck.js <APP_SECRET> <HASH_FILE> <INPUT_FILE>\n" +
                    "  * APP_SECRET is the app secret shown in the Settings\n" +
                    "    for your app on developers.facebook.com\n" +
                    "  * HASH_FILE is local path to the Facebook-provided file containing\n" +
                    "    the encrypted hashes of your ASIDs\n" +
                    "  * INPUT_FILE is local path a newline-delimited list of ASIDs you\n" +
                    "    wish to check against the hash file\n" +
                    "\n" +
                    "When called successfully, this script will emit a list of ASIDs to stdout.");
    return;
}

var appSecret = args[0];
var fbProvidedHashes = new Set(fs.readFileSync(args[1]).toString().split("\n"));
var rd = lr.createInterface({
    input: fs.createReadStream(args[2]),
    output: null,
    console: false,
});

rd.on('line', function(asid) {
    if (fbProvidedHashes.has(transformAsid(asid, appSecret)))
    {
        console.log(asid);
    }
});

function transformAsid(asid, appSecret)
{
    var appSecretBits = new Buffer(appSecret, 'hex');
    var hmacKey = crypto.createHash('sha256').update(appSecretBits).digest();
    var rawHmac = crypto.createHmac('sha256', hmacKey).update(asid).digest();
    return rawHmac.slice(0, 8).toString('base64');
}
