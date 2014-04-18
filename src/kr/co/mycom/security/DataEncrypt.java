package kr.co.mycom.security;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * 사용자 비밀번호를 MD5/SHA-224 방식으로 암호화
 */
public class DataEncrypt {
	MessageDigest md;
	String strSRCData = "";
	String strENCData = "";

	public DataEncrypt() {
	}

	public String encrypt(String strData) { // 암호화 시킬 데이터
		try {
			strSRCData = strData;
			// MessageDigest md = MessageDigest.getInstance("MD5"); // "MD5 형식으로 암호화"
			MessageDigest md = MessageDigest.getInstance("SHA-256"); // "SHA-256 형식으로 암호화"
			byte[] bytData = strData.getBytes();
			md.update(bytData);
			byte[] digest = md.digest(); // 배열로 저장을 한다.
			for (int i = 0; i < digest.length; i++) {
				strENCData = strENCData
						+ Integer.toHexString(digest[i] & 0xFF).toUpperCase();
			}
		} catch (NoSuchAlgorithmException e) {
			System.out.print("암호화 에러" + e.toString());
		}
		return strENCData; // 암호화된 데이터를 리턴
	}
} // end class

	
