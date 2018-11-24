$Source = @"
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace Facebook
{
    public class AsidCheck
    {
        public static void Main(string[] args)
        {
            if (args.Length != 3)
            {
                Console.Write(
                    "Usage:\n" +
                    "./asidcheck <APP_SECRET> <HASH_FILE> <INPUT_FILE>\n" +
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
            var fbProvidedHashes = new HashSet<string>(File.ReadAllLines(args[1]));
            foreach (var asid in File.ReadLines(args[2]))
            {
                if (fbProvidedHashes.Contains(TransformAsid(asid, appSecret)))
                {
                    Console.WriteLine(asid);
                }
            }
        }

        public static string TransformAsid(string asid, string appSecret)
        {
            var appSecretBits = Enumerable.Range(0, appSecret.Length / 2).Select(i => Convert.ToByte(appSecret.Substring(i * 2, 2), 16)).ToArray();
            using (var sha256Hash = SHA256.Create())
            {
                var hmacKey = sha256Hash.ComputeHash(appSecretBits);
                var hmacSha = new HMACSHA256(hmacKey);
                var computerHash = hmacSha.ComputeHash(Encoding.UTF8.GetBytes(asid));
                return Convert.ToBase64String(computerHash.Take(8).ToArray());
            }
        }
    }
}
"@

Add-Type -ReferencedAssemblies $Assem -TypeDefinition $Source -Language CSharp

[Facebook.AsidCheck]::Main($args);