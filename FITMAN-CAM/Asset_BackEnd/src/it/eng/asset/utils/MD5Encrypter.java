package it.eng.asset.utils;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Encrypter {

//	private static final Logger log = LoggerFactory
//			.getLogger(MD5Encrypter.class);

	public static String encryptData(String data) {
		MessageDigest mdEnc = null;
		String dataEncrypt = new String();
		try {
			mdEnc = MessageDigest.getInstance("MD5");
			mdEnc.update(data.getBytes(), 0, data.length());
			dataEncrypt = new BigInteger(1, mdEnc.digest()).toString(16);
		} catch (NoSuchAlgorithmException ex) {
//			log.error(ex.getMessage());
		}
		return dataEncrypt;
	}

}
