/*
 * Copyright (c) 2012 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 * 암호화/복호화 모듈입니다.(오라클 함수 등록용)
 * 
 * @created on 1.0, 2012/05/03
 * @created by sbcho
 * @modified
 * @modified
 * @caused
 */
public class EncryptionUtil {
	// Round keys for encryption or decryption
	private static int pdwRoundKey[] = new int[32];
	// User secret key
	// private static byte pbUserKey[] = "central_square_system".getBytes();
	private static byte pbUserKey[] = "mario_outlet_system".getBytes();

	/**
	 * 암호화 함수 암호화 암호화 대상 : 주민등록번호, 계좌정보, 카드번호, 전화번호, 이메일
	 * 
	 * @param str
	 * @return
	 */
	public static String encryptedStr(String str) {

		String strenc = "";
		String encrypted = "";

		BASE64Encoder encoder = new BASE64Encoder();

		if (str != null && !str.equals("")) {
			strenc = encoder.encode(str.getBytes()).trim();

			// byte 수 채우기
			int max = 0;
			if ((strenc.getBytes().length - 1) % 16 != 0)
				max = 16 - ((strenc.getBytes().length - 1) % 16);
			for (int i = 0; i < max; i++)
				strenc += " ";
			int size = strenc.getBytes().length - 1;

			// input plaintext to be encrypted
			byte pbData[] = strenc.getBytes();
			byte pbCipher[] = new byte[16];
			byte reData[][] = new byte[size / 16][16];
			byte reCipher[] = new byte[size];
			// pbData[24] = 32;

			// Derive roundkeys from user secret key
			seedx.SeedRoundKey(pdwRoundKey, pbUserKey);

			// Encryption
			int b1 = 0, b2 = 0;
			for (int i = 0; i < size; i++) {
				b1 = (i / 16);
				b2 = (i % 16);
				reData[b1][b2] = pbData[i];
			}

			int rf = 0;
			for (int i = 0; i < reData.length; i++) {
				seedx.SeedEncrypt(reData[i], pdwRoundKey, pbCipher);
				for (int j = 0; j < pbCipher.length; j++)
					reCipher[rf++] = pbCipher[j];
			}
			encrypted = encoder.encode(reCipher);
		}

		return encrypted;
	}

	/**
	 * 일방향 암호화 대상 : 비밀번호
	 * 
	 * @param text
	 * @return
	 */
	public static String encryptedPasswd(String str) {
		MessageDigest md;
		byte[] sha1hash = new byte[40];
		String rtnStr = "";

		if (str != null && !str.equals("")) {
			try {
				md = MessageDigest.getInstance("SHA-1");
				// md.update(text.getBytes("UFT-8"), 0, text.length());
				md.update(str.getBytes("iso-8859-1"), 0, str.length());
				sha1hash = md.digest();
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			rtnStr = convertToHex(sha1hash);
		}

		return rtnStr;
	}

	/**
	 * convertToHex
	 * 
	 * @param data
	 * @return
	 */
	private static String convertToHex(byte[] data) {
		StringBuffer buf = new StringBuffer();
		for (int i = 0; i < data.length; i++) {
			int halfbyte = (data[i] >>> 4) & 0x0F;
			int two_halfs = 0;
			do {
				if ((0 <= halfbyte) && (halfbyte <= 9))
					buf.append((char) ('0' + halfbyte));
				else
					buf.append((char) ('a' + (halfbyte - 10)));
				halfbyte = data[i] & 0x0F;
			} while (two_halfs++ < 1);
		}
		return buf.toString();
	}

	/**
	 * 복호화
	 * 
	 * @param str
	 * @return
	 */
	public static String decryptedStr(String str) {
		String strResult = "";

		byte[] reCipher = null;

		if (str != null && !str.equals("")) {
			BASE64Decoder decoder = new BASE64Decoder();
			try {
				reCipher = decoder.decodeBuffer(str.trim());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			int size = reCipher.length;

			byte pbPlain[] = new byte[16];
			byte reData[][] = new byte[size / 16][16];
			byte rePlain[] = new byte[size];

			// Derive roundkeys from user secret key
			seedx.SeedRoundKey(pdwRoundKey, pbUserKey);

			// Decryption
			int b1 = 0, b2 = 0;
			for (int i = 0; i < size; i++) {
				b1 = (i / 16);
				b2 = (i % 16);
				reData[b1][b2] = reCipher[i];
			}
			int rf = 0;
			for (int i = 0; i < reData.length; i++) {
				seedx.SeedDecrypt(reData[i], pdwRoundKey, pbPlain);
				for (int j = 0; j < pbPlain.length; j++)
					rePlain[rf++] = pbPlain[j];
			}
			String strdec = new String(rePlain);

			byte[] basedec = null;
			try {
				basedec = decoder.decodeBuffer(strdec.trim());
			} catch (IOException e) {
				e.printStackTrace();
			}

			if (basedec == null || basedec.equals("null")) {
				strResult = "";
			} else {
				strResult = new String(basedec);
			}
		}

		return strResult;
	}

	/**
	 * 테스트용 Main 클레스
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println("encryptedPasswd : " + encryptedPasswd("1"));
		System.out.println("encryptedStr : " + encryptedStr("1"));
		System.out.println("decryptedStr : " + decryptedStr("sx7HUUGBRYJQz7tU9dbkkA=="));
	}
}
