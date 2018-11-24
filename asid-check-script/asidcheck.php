<?php
if(count($argv) !== 4)
{
  echo("Usage:\n" .
    "php asidcheck.php <APP_SECRET> <HASH_FILE> <INPUT_FILE>\n" .
    "  * APP_SECRET is the app secret shown in the Settings\n" .
    "    for your app on developers.facebook.com\n" .
    "  * HASH_FILE is local path to the Facebook-provided file containing\n" .
    "    the encrypted hashes of your ASIDs\n" .
    "  * INPUT_FILE is local path a newline-delimited list of ASIDs you\n" .
    "    wish to check against the hash file\n" .
    "\n" .
    "When called successfully, this script will emit a list of ASIDs to stdout.");
    exit(1);
}

$app_secret = $argv[1];
$fb_provided_hashes = file($argv[2], FILE_IGNORE_NEW_LINES);

$handle = fopen($argv[3], "r");
if ($handle) {
    while (($reading_asid = fgets($handle)) !== false) {
      if(in_array(transformAsid(trim($reading_asid), $app_secret), $fb_provided_hashes))
      {
        echo($reading_asid);
      }
  }

    fclose($handle);
} else {
    echo("error opening file");
    exit(1);
}

function transformAsid($asid, $appsecret) {
    $appsecret_bits = hex2bin($appsecret);
    $hmac_key = hash('sha256', $appsecret_bits, true);
    $raw_hmac = hash_hmac('sha256', $asid, $hmac_key, true);
    $truncated_hmac = substr($raw_hmac, 0, 8);

    return base64_encode($truncated_hmac);
}
?>
