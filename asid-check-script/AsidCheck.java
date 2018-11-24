import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Base64;
import java.util.HashSet;
import java.util.Set;

public class AsidCheck {

    public static void main(String[] args) {
        try {
            if (args.length != 3) {
                System.out.println(
                        "Usage:\n" +
                                "java AsidCheck <APP_SECRET> <HASH_FILE> <INPUT_FILE>\n" +
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

            String appSecret = args[0];
            Set < String > fbProvidedHashes = new HashSet < String > (Files.readAllLines(Paths.get(args[1])));
            try (BufferedReader br = new BufferedReader(new FileReader(args[2]))) {
                String asid;
                while ((asid = br.readLine()) != null) {
                    if (fbProvidedHashes.contains(AsidCheck.TransformAsid(asid, appSecret))) {
                        System.out.println(asid);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Unexpected error occurred: " + e.getLocalizedMessage());
        }
    }

    public static String TransformAsid(String asid, String appsecret)
            throws InvalidKeyException, UnsupportedEncodingException, NoSuchAlgorithmException {

        byte[] appSecretBits = DatatypeConverter.parseHexBinary(appsecret);
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hmacKey = digest.digest(appSecretBits);

        Mac sha256Hmac = Mac.getInstance("HmacSHA256");
        SecretKeySpec secret_key = new SecretKeySpec(hmacKey, "HmacSHA256");
        sha256Hmac.init(secret_key);

        byte[] truncatedHmac = Arrays.copyOfRange(sha256Hmac.doFinal(asid.getBytes("UTF-8")), 0, 8);
        return Base64.getEncoder().encodeToString(truncatedHmac);
    }
}