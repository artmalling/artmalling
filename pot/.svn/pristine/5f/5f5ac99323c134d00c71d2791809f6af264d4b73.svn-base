/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
package common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.base.BaseProperty;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import common.vo.SessionInfo;

/**
 * 한국후지쯔 통합정보 시스템에서 사용되는 public 변수나 공유 메소드를 정의합니다.
 * 
 * @created on 1.0, 2010/12/18
 * @created by 정지인(FUJITSU KOREA LTD.)
 * @modified
 * @modified
 * @caused
 */
public class Util {
	// UTF-8
	public static final String CLSID_BIND = "CLSID:2F98EA90-EAE1-4AB5-AE89-DA073D824589";
	public static final String CLSID_CODECOMBO = "CLSID:AF2C0475-2F32-4976-B588-7BC7D42EDB03";
	public static final String CLSID_CHART = "CLSID:4F57AF1B-5470-47EE-A5AA-D1EA4B3C42A6";
	public static final String CLSID_DATASET = "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190";
	public static final String CLSID_EMEDIT = "CLSID:D7779973-9954-464E-9708-DA774CA50E13";
	public static final String CLSID_GRID = "CLSID:71E7ACA0-EF63-4055-9894-229B056E9C31";
	public static final String CLSID_IMGDATASET = "CLSID:9F0AA341-1D10-4B18-B70B-6AA49CE7F5D6";
	public static final String CLSID_INPUTFILE = "CLSID:5C32688E-CEBE-419D-9C63-0704A2331EEC";
	public static final String CLSID_MENU = "CLSID:31538FAB-8051-4CFA-ACA4-B2668718B6F8";
	public static final String CLSID_REPORT = "CLSID:9683681E-FAD6-45F1-86B3-FD60C7101BC9";
	public static final String CLSID_RADIO = "CLSID:F73C0958-D8FE-43A5-9BB0-0F651C5A2BCC";
	public static final String CLSID_TAB = "CLSID:90CAA259-71ED-42CB-BEB8-95281CCF9E58";
	public static final String CLSID_TEXTAREA = "CLSID:1455BE02-C41B-4115-B21C-32380507DC8F";
	public static final String CLSID_TRANSACTION = "CLSID:223216F6-B9FE-406D-9ED6-143FCE3A07B8";
	public static final String CLSID_TREEVIEW = "CLSID:C1781C5C-0C32-40F2-8927-46FE4BCB5B87";
	public static final String CLSID_LUXECOMBO = "CLSID:BB4533A0-85E0-4657-9BF2-E8E7B100D47E";
	public static final String CLSID_MGRID = "CLSID:B1405FE9-DEF8-4679-A3BC-C05F1330CDDD";
	public static final String CLSID_PDA = "CLSID:2E85EC0F-3B6D-41B8-89ED-0AFFCB2C3C70";
	public static final String CLSID_POTENTIAL = "CLSID:1C18220D-EC23-48C8-B35E-857ADE9D1465";
	//public static final String CLSID_SHIFTCHART  = "CLSID:6D566CE5-853F-451E-BDCA-F2FC49FFA429";
	public static final String CLSID_SHIFTCHART  = "CLSID:6EEA2C54-4492-44fd-AF4B-4D67ECD2B266";
	
	// 2013.03.23 암호화 모듈 변경
	private static com.cubeone.CubeOneAPI coc;

	/**
	 * 사용자 ID 가지고 옴
	 * 
	 * @param HttpServletRequest
	 * @return String
	 */
	public static String getUsrCd(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) (session
				.getAttribute("sessionInfo"));
		return sessionInfo.getUSER_ID();
	}

	public static String getUserNm(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session
				.getAttribute("sessionInfo");
		return sessionInfo.getUSER_NAME();
	}

	public static String getViewLevel(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session
				.getAttribute("sessionInfo"); 
		return sessionInfo.getVIEW_LEVEL();
	}	
	
	public static String getPId(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session
				.getAttribute("sessionInfo");
		return sessionInfo.getPGM_ID();
	}
	
	public static String getDeptNm(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session
				.getAttribute("sessionInfo"); 
		return sessionInfo.getPART_NM();
	}
	
	public static String getTelNo(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session
				.getAttribute("sessionInfo"); 
		return sessionInfo.getPHONE1_NO() + "-" + sessionInfo.getPHONE2_NO()+ "-" + sessionInfo.getPHONE3_NO();
	}

	public static String getTelNo1(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session
				.getAttribute("sessionInfo"); 
		return sessionInfo.getPHONE1_NO();
	}

	public static String getTelNo2(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session
				.getAttribute("sessionInfo"); 
		return sessionInfo.getPHONE2_NO();
	}

	public static String getTelNo3(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session
				.getAttribute("sessionInfo"); 
		return sessionInfo.getPHONE3_NO();
	}

	public static String getHpNo(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session
				.getAttribute("sessionInfo"); 
		return          sessionInfo.getHP1_NO() 
				+ "-" + sessionInfo.getHP2_NO() 
				+ "-" + sessionInfo.getHP3_NO();
	}
	
	public static String getHpNo1(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session
				.getAttribute("sessionInfo"); 
		return sessionInfo.getHP1_NO();
	}
	 
	public static String getHpNo2(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session
				.getAttribute("sessionInfo"); 
		return sessionInfo.getHP2_NO();
	}
	 
	public static String getHpNo3(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session
				.getAttribute("sessionInfo"); 
		return sessionInfo.getHP3_NO();
	}
	
	public static String getEMail(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session
				.getAttribute("sessionInfo"); 
		return sessionInfo.getE_MAIL();
	}
	public static String getMultiLogin(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session
				.getAttribute("sessionInfo"); 
		return sessionInfo.getMULTI_LOGIN();
	}
	
	public static String getOrgCd(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session
				.getAttribute("sessionInfo"); 
		if (sessionInfo == null){
			return "";
		} else {
		return sessionInfo.getORG_CD();
		}
	}

	/**
	 * 
	 * 특정문자열에서 주어진 분리기준문자열(separator) 이전까지의 문자열을 리턴한다. 분리기준문자열(separator)은 포함하지
	 * 않는다. 문자열이 null인 경우 null을 리턴한다. 문자열이 empty("")인 경우 empty("")를 리턴한다.
	 * 분리기준문자열(separator)이 null인 경우 문자열 전체를 리턴한다.
	 * 
	 * <pre>
	 * 
	 * 
	 *     String2.substringBefore(null, *)      = null
	 *     String2.substringBefore(&quot;&quot;, *)        = &quot;&quot;
	 *     String2.substringBefore(&quot;abc&quot;, &quot;a&quot;)   = &quot;&quot;
	 *     String2.substringBefore(&quot;abcba&quot;, &quot;b&quot;) = &quot;a&quot;
	 *     String2.substringBefore(&quot;abc&quot;, &quot;c&quot;)   = &quot;ab&quot;
	 *     String2.substringBefore(&quot;abc&quot;, &quot;d&quot;)   = &quot;abc&quot;
	 *     String2.substringBefore(&quot;abc&quot;, &quot;&quot;)    = &quot;&quot;
	 *     String2.substringBefore(&quot;abc&quot;, null)  = &quot;abc&quot;
	 * 
	 * 
	 * </pre>
	 * 
	 * @param str
	 * @param separator
	 * @return String
	 */

	public static String substringBefore(String str, String separator) {
		if (str == null || separator == null || str.length() == 0) {
			return str;
		}
		if (separator.length() == 0) {
			return "";
		}
		int pos = str.indexOf(separator);
		if (pos == -1) {
			return str;
		}
		return str.substring(0, pos);
	}

	/**
	 * String Parsing
	 * 
	 * @param str
	 *            : 문자열
	 * @param d
	 *            : 토큰할 문자
	 * @param parse
	 * @return String
	 * @author songreen
	 */
	public static String parse_str(String str, String d, String parse) {
		String result = "";
		String std = "";
		StringTokenizer parser = new StringTokenizer(str, d);

		try {
			while (parser.hasMoreTokens()) {
				result = parser.nextToken();
				std = std + result + parse;
			}
		} catch (NoSuchElementException e) {
			// LOG.error(e);
			// ApplicationErrorMgr.getInstance(ResourceMngServer.class).error(e);
		}
		return std;
	}

	/** isas.properties에 저장되어 있는 Isas에 관련되 Properties를 얻어온다. */
	public static Properties getFujitsudeptProperties() throws Exception {

		String path = BaseProperty.get("fujitsudept.config.Properti");
		try {
			InputStream is = (InputStream) new FileInputStream(new File(path));

			Properties fujitsudeptProps = new Properties();
			fujitsudeptProps.load(is);
			return fujitsudeptProps;
		} catch (Exception e) {
			throw e;
		}
	}

	/**
	 * obj에 strChars가 있는지를 검사.
	 * 
	 * @param obj
	 * @param strChars
	 * @return
	 */
	public static boolean containsCharsOnly(String obj, String strChars) {
		for (int i = 0, n = obj.length(); i < n; i++) {
			if (strChars.indexOf(obj.charAt(i)) == -1) {
				return false;
			}
		}
		return true;
	}

	/**
	 * 알파벳이 있는지를 검사.
	 * 
	 * @param obj
	 * @return
	 */
	public static boolean isAlphabet(String obj) {
		String strChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
		return containsCharsOnly(obj, strChars);
	}

	/**
	 * 숫자가 있는지를 검사
	 * 
	 * @param obj
	 * @return
	 */
	public boolean isNumber(String obj) {
		String strChars = "0123456789";
		return containsCharsOnly(obj, strChars);
	}

	// Round keys for encryption or decryption
	private static int pdwRoundKey[] = new int[32];
	// User secret key
	private static byte pbUserKey[] = BaseProperty.get("projectname").getBytes();

	/**
	 * 암호화 함수 암호화 암호화 대상 : 주민등록번호, 계좌정보, 카드번호, 전화번호, 이메일
	 * 
	 * @param obj
	 * @return
	 * @throws Exception
	 */
	public String encryptedStr_old(String obj) throws Exception {

		String key = null;
		String ret = null;
		String strenc = null;
		String encrypted = null;

		try {
			strenc = Base64.encode(obj.getBytes());

			// byte 수 채우기
			int max = 0;

			if (strenc.getBytes().length % 16 != 0)
				max = 16 - (strenc.getBytes().length % 16);

			for (int i = 0; i < max; i++)
				strenc += " ";

			int size = strenc.getBytes().length;

			// input plaintext to be encrypted
			byte pbData[] = strenc.getBytes();
			byte pbCipher[] = new byte[16];
			byte reData[][] = new byte[size / 16][16];
			byte reCipher[] = new byte[size];

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
			encrypted = Base64.encode(reCipher);
		} catch (Exception e) {
			throw e;
		}
		return encrypted;
	}
	
	public String encryptedStr(String obj) throws Exception {		
		String encrypted = null;
		try {
			encrypted = coc.jcoencrypt(obj);
		} catch (Exception e) {
			throw e;
		}
		return encrypted;
	}

	/**
	 * 복호화 함수
	 * 
	 * @param obj
	 * @return
	 */
	public List decryptedStr(List obj, int idx) throws Exception {

		try {

			for (int j = 0; j < obj.size(); j++) {
				List tmplist = (List) obj.get(j);
				System.out.println("tmplist.get(idx) : [" + tmplist.get(idx).toString() + "]");
				System.out.println("tmplist.get(idx).toString().length() : [" + tmplist.get(idx).toString().length() + "]");
				if (tmplist.get(idx).toString().length() > 0) {
					if(tmplist.get(idx).toString() != null && tmplist.get(idx).toString().length() >= 24) {
						tmplist.set(idx, decoding(tmplist.get(idx).toString()));
					}
				}
				 System.out.println(tmplist.get(idx).toString());
				obj.set(j, tmplist);
			}
		} catch (Exception e) {
			throw e;
		}
		return obj;
	}

	/**
	 * 
	 * @param encoded
	 * @return
	 * @throws Exception
	 */
	private static String decoding_old(String encoded) throws Exception {
		String strResult = null;
		byte[] reCipher = null;

		try {
			reCipher = Base64.decode(encoded);
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

			byte[] basedec = Base64.decode(strdec);
			
			//복호화 된 값이 null 인 경우가 있어서 확인 로직 넣음
			//@2012.04.16 sbcho
			if(basedec == null || basedec.equals("null")) {
				strResult = "";
			} else {
				strResult = new String(basedec);
			}
			
		} catch (Exception e) {
			throw e;
		}
		return strResult;
	}
	
	private static String decoding(String encoded) throws Exception {
		String strResult = null;
		try {
			strResult = coc.jcodecrypt(encoded);
		} catch (Exception e) {
			throw e;
		}
		return strResult;
	}

	/**
	 * 일방향 암호화 대상 : 비밀번호
	 * 
	 * @param text
	 * @return
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 */
	public static String encryptedPasswd(String text)
			throws NoSuchAlgorithmException, UnsupportedEncodingException {
		MessageDigest md;
		md = MessageDigest.getInstance("SHA-1");
		byte[] sha1hash = new byte[40];
		// md.update(text.getBytes("UFT-8"), 0, text.length());
		md.update(text.getBytes("iso-8859-1"), 0, text.length());
		sha1hash = md.digest();
		return convertToHex(sha1hash);
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
	 * 작업 디렉토리 가지고 옴
	 * 
	 * @param String
	 * @return String
	 */
	public static String getPropertyDir(String strDir) throws Exception {
		BaseProperty property = BaseProperty.getInstance();
		return property.get(strDir);
	}

	public static String makeOZXML(List list, String[] filter) throws Exception {
		Map map = null;
		StringBuffer xml = new StringBuffer();
		xml.append("<?xml version=\"1.0\" encoding=\"euc-kr\" ?>\n");
		xml.append("<DATASET>\n");
		try {
			for (int i = 0; i < list.size(); i++) {
				map = (Map) list.get(i);
				filter(map, filter);
				xml.append("<RECORD>\n");
				Iterator iter = map.keySet().iterator();
				while (iter.hasNext()) {
					String key = (String) iter.next();
					Object v = (Object) map.get(key);
					if (String[][].class == v.getClass()) { // pass grid data.
						continue;
					}
					String value = (String) v;
					key = key.toUpperCase().trim();
					xml.append("<" + key + "><![CDATA[" + value.trim()
							+ "]]></" + key + ">\n");
				}
				xml.append("</RECORD>\n");
			}
			xml.append("</DATASET>\n");
		} catch (Exception e) {
			throw e;
		}
		return xml.toString();
	}

	public static void filter(Map m, String[] filter) throws Exception {
		if (filter == null)
			return;

		for (int i = 0; i < filter.length; i++) {
			String value = (String) m.get(filter[i]);
			if (value != null && !"".equals(value)) {
				m.put(filter[i], decoding(value));
			}
		}
	}

	public static void forwardXML(HttpServletResponse response,
			String data) throws IOException {
		response.setContentType("text/xml");
		response.setCharacterEncoding("EUC-KR");
		PrintWriter out = response.getWriter();
		out.println(data);
	}
}
