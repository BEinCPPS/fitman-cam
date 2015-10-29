package it.eng.liferay.cas.integration;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.io.UnsupportedEncodingException;

import org.jasig.cas.authentication.handler.PasswordEncoder;

public final class LiferayPasswordEncoder implements PasswordEncoder {

	public String encode(final String password) {
		MessageDigest digester = null;

		try{
			digester = MessageDigest.getInstance("SHA");
			digester.update(password.getBytes("UTF-8"));
		}
		catch (NoSuchAlgorithmException nsae) {
			System.out.println("LiferayPasswordEncoder - error algoritmo SHA no encontrado");
			nsae.printStackTrace();
		}
		catch (UnsupportedEncodingException uee) {
			System.out.println("LiferayPasswordEncoder - error codificando texto");
			uee.printStackTrace();
		}

		byte[] bytes = digester.digest();

		return encodeBase64(bytes);
	}


	private static char getChar(int sixbit) {
		if (sixbit >= 0 && sixbit <= 25) {
			return (char)(65 + sixbit);
		}

		if (sixbit >= 26 && sixbit <= 51) {
			return (char)(97 + (sixbit - 26));
		}

		if (sixbit >= 52 && sixbit <= 61) {
			return (char)(48 + (sixbit - 52));
		}

		if (sixbit == 62) {
			return '+';
		}

		return sixbit != 63 ? '?' : '/';
	}


	private static String encodeBase64(byte raw[]) {
		StringBuilder encoded = new StringBuilder();

		for (int i = 0; i < raw.length; i += 3) {
			encoded.append(encodeBlock(raw, i));
		}

		return encoded.toString();
	}

	private static char[] encodeBlock(byte raw[], int offset) {
		int block = 0;
		int slack = raw.length - offset - 1;
		int end = slack < 2 ? slack : 2;

		for (int i = 0; i <= end; i++) {
			byte b = raw[offset + i];

			int neuter = b >= 0 ? ((int) (b)) : b + 256;
			block += neuter << 8 * (2 - i);
		}

		char base64[] = new char[4];

		for (int i = 0; i < 4; i++) {
			int sixbit = block >>> 6 * (3 - i) & 0x3f;
			base64[ i ] = getChar(sixbit);
		}

		if (slack < 1) {
			base64[2] = '=';
		}

		if (slack < 2) {
			base64[3] = '=';
		}

		return base64;
	}

	/*public static void main(String[] args) {
		String passwordCryp = "admin";
		
		System.out.println(encode(passwordCryp));
		System.out.println("0DPiKuNIrrVmD8IUCuw1hQxNqZc=");
	}*/
	
}