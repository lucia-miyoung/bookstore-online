package common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Cipher;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;
import sun.misc.BASE64Encoder;
import sun.misc.BASE64Decoder;

public class EncryptUtil {

	
	public static String encryptAes(String input, String key) {
		byte[] crypted = null;
		
		try {
			Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
			
			SecretKeySpec skey = new SecretKeySpec(key.getBytes(), "AES");
			cipher.init(Cipher.ENCRYPT_MODE, skey);
			crypted = cipher.doFinal(input.getBytes());
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println(e.toString());
		}
		
		BASE64Encoder encoder = new BASE64Encoder();
		
		String str = encoder.encode(crypted);
		
		return new String(str);
		
	}
	
	
	public static String decryptAes(String input, String key) {
        byte[] output = null;
        try {
            BASE64Decoder decoder = new BASE64Decoder();

            SecretKeySpec skey = new SecretKeySpec(key.getBytes(), "AES");

            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE, skey);
            output = cipher.doFinal(decoder.decodeBuffer(input));

        } catch(Exception e) {
            System.out.println(e.toString());
        }
        return new String(output);
    }
	
	
	public static String encryptSha256(String admin_pw) throws Exception {
		String pw = admin_pw;
		byte[] b_pw = pw.getBytes();
		byte[] encrypt_b_pw = MessageDigest.getInstance("SHA-256").digest(b_pw);
		String encrypt_pw = ByteUtils.toHexString(encrypt_b_pw);
		return encrypt_pw;
	}
	

}
