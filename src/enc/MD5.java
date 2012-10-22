package enc;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.math.*;

public class MD5 
{
	public static String hash(String input)
	{
		String encryption = input;
	    MessageDigest digest;
		try {
			digest = MessageDigest.getInstance("MD5");
		    digest.update(encryption.getBytes(), 0, encryption.length());
		    encryption = new BigInteger(1, digest.digest()).toString(16);
		} catch (NoSuchAlgorithmException e) {
		}
	    return encryption;
	}
}
