/*
 * Copyright (c) 2010 占쎈성占쏙옙큐占쏙옙. All rights reserved.
 *
 * This software is the confidential and proprietary information of 占쎈성占쏙옙큐占쏙옙.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 占쎈성占쏙옙큐占쏙옙
 */
package ecom.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.base.BaseProperty;
import kr.fujitsu.ffw.control.ActionForm;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import common.util.seedx;

import ecom.vo.SessionInfo2;

/**
 * 占쎈성占쏙옙큐占쏙옙 占쏙옙占쏙옙d占쏙옙 占시쏙옙占쌜울옙占쏙옙 占쏙옙占실댐옙 public 占쏙옙占쏙옙 占쏙옙/ 占쌨소드를 d占쏙옙占쌌니댐옙.
 * 
 * @created on 1.0, 2010/12/18
 * @created by d占쏙옙占쏙옙(FUJITSU KOREA LTD.)
 * @modified
 * @modified
 * @caused
 */
public class Util {
//UTF-8
	public static final String CLSID_BIND        = "CLSID:2F98EA90-EAE1-4AB5-AE89-DA073D824589";
	public static final String CLSID_CODECOMBO   = "CLSID:AF2C0475-2F32-4976-B588-7BC7D42EDB03";
	public static final String CLSID_CHART       = "CLSID:4F57AF1B-5470-47EE-A5AA-D1EA4B3C42A6";
	public static final String CLSID_DATASET     = "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190";
	public static final String CLSID_EMEDIT      = "CLSID:D7779973-9954-464E-9708-DA774CA50E13";
	public static final String CLSID_GRID        = "CLSID:71E7ACA0-EF63-4055-9894-229B056E9C31";
	public static final String CLSID_IMGDATASET  = "CLSID:9F0AA341-1D10-4B18-B70B-6AA49CE7F5D6";
	public static final String CLSID_INPUTFILE   = "CLSID:5C32688E-CEBE-419D-9C63-0704A2331EEC";
	public static final String CLSID_MENU        = "CLSID:31538FAB-8051-4CFA-ACA4-B2668718B6F8";
	public static final String CLSID_REPORT      = "CLSID:9683681E-FAD6-45F1-86B3-FD60C7101BC9";
	public static final String CLSID_RADIO       = "CLSID:F73C0958-D8FE-43A5-9BB0-0F651C5A2BCC";
	public static final String CLSID_TAB         = "CLSID:90CAA259-71ED-42CB-BEB8-95281CCF9E58";
	public static final String CLSID_TEXTAREA    = "CLSID:1455BE02-C41B-4115-B21C-32380507DC8F";
	public static final String CLSID_TRANSACTION = "CLSID:223216F6-B9FE-406D-9ED6-143FCE3A07B8";
	public static final String CLSID_TREEVIEW    = "CLSID:C1781C5C-0C32-40F2-8927-46FE4BCB5B87";
	public static final String CLSID_LUXECOMBO   = "CLSID:BB4533A0-85E0-4657-9BF2-E8E7B100D47E";
	public static final String CLSID_MGRID       = "CLSID:B1405FE9-DEF8-4679-A3BC-C05F1330CDDD";
	public static final String CLSID_PDA         = "CLSID:2E85EC0F-3B6D-41B8-89ED-0AFFCB2C3C70";
	public static final String CLSID_POTENTIAL   = "CLSID:1C18220D-EC23-48C8-B35E-857ADE9D1465";
	//public static final String CLSID_SHIFTCHART  = "CLSID:6D566CE5-853F-451E-BDCA-F2FC49FFA429";
	public static final String CLSID_SHIFTCHART  = "CLSID:6EEA2C54-4492-44fd-AF4B-4D67ECD2B266";
	
//EUC-KR	
//	public static final String CLSID_BIND = "CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9";
//	public static final String CLSID_CODECOMBO = "CLSID:AF2C0475-2F32-4976-B588-7BC7D42EDB03";
//	public static final String CLSID_CHART = "CLSID:2A99B1B3-E263-4A00-A167-C1B967716DE2";
//	public static final String CLSID_DATASET = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
//	public static final String CLSID_EMEDIT = "CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F";
//	public static final String CLSID_GRID = "CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B";
//	public static final String CLSID_IMGDATASET = "CLSID:2B0B1D8B-CAAA-4E06-BD9A-A09A916BD67A";
//	public static final String CLSID_INPUTFILE = "CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE";
//	public static final String CLSID_MEDIT = "CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F";
//	public static final String CLSID_MENU = "CLSID:216FC5D2-962D-4DD6-A000-02754CF91231";
//	public static final String CLSID_REPORT = "CLSID:CC26E2A9-760B-4EA6-8DDF-DB423FD24089";
//	public static final String CLSID_RADIO = "CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0";
//	public static final String CLSID_TAB = "CLSID:6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C";
//	public static final String CLSID_TEXTAREA = "CLSID:2F5DF8D9-F63C-460E-B5CB-399E816B0274";
//	public static final String CLSID_TRANSACTION = "CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5";
//	public static final String CLSID_TREEVIEW = "CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2";
//	public static final String CLSID_LUXECOMBO = "CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197";
//	public static final String CLSID_MGRID = "CLSID:8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08";
	
	// 2013.03.23 암호화 모듈 변경
	private static com.cubeone.CubeOneAPI coc;

	/**
	 * 占쏙옙占쏙옙占?ID 占쏙옙占쏙옙占?占쏙옙
	 * 
	 * @param HttpServletRequest
	 * @return String
	 */
	public static String getUsrCd(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo2 sessionInfo = (SessionInfo2) (session
				.getAttribute("sessionInfo2"));
		return sessionInfo.getUSER_ID();
	}

	/**
	 * 
	 * 특d占쏙옙占쌘울옙占쏙옙占쏙옙 占쌍억옙占쏙옙 占싻몌옙占쏙옙占쌔뱄옙占쌘울옙(separator) 占쏙옙占쏙옙占쏙옙占쏙옙占?占쏙옙占쌘울옙; 占쏙옙占쏙옙占싼댐옙. 占싻몌옙占쏙옙占쌔뱄옙占쌘울옙(separator): 占쏙옙占쏙옙占쏙옙占쏙옙
	 * 占십는댐옙. 占쏙옙占쌘울옙占쏙옙 null占쏙옙 占쏙옙占?null; 占쏙옙占쏙옙占싼댐옙. 占쏙옙占쌘울옙占쏙옙 empty("")占쏙옙 占쏙옙占?empty("")占쏙옙 占쏙옙占쏙옙占싼댐옙.
	 * 占싻몌옙占쏙옙占쌔뱄옙占쌘울옙(separator)占쏙옙 null占쏙옙 占쏙옙占?占쏙옙占쌘울옙 占쏙옙체占쏙옙 占쏙옙占쏙옙占싼댐옙.
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
	 *            : 占쏙옙占쌘울옙
	 * @param d
	 *            : 占쏙옙큰占쏙옙 占쏙옙占쏙옙
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

	/** isas.properties占쏙옙 占쏙옙占쏙옙퓸占?占쌍댐옙 Isas占쏙옙 占쏙옙천占?Properties占쏙옙 占쏙옙占승댐옙. */
	public static Properties getFujitsudeptProperties() throws Exception {

		String path = BaseProperty.get("fujitsu.config.Properti");
		try {
			InputStream is = (InputStream) new FileInputStream(new File(path));

			Properties fujitsuDeptProps = new Properties();
			fujitsuDeptProps.load(is);
			return fujitsuDeptProps;
		} catch (Exception e) {
			throw e;
		}
	}

	/**
	 * obj占쏙옙 strChars占쏙옙 占쌍댐옙占쏙옙 占싯삼옙.
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
	 * 占쏙옙占식븝옙占쏙옙 占쌍댐옙占쏙옙 占싯삼옙.
	 * 
	 * @param obj
	 * @return
	 */
	public boolean isAlphabet(String obj) {
		String strChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
		return containsCharsOnly(obj, strChars);
	}

	/**
	 * 占쏙옙占쌘곤옙 占쌍댐옙占쏙옙 占싯삼옙
	 * 
	 * @param obj
	 * @return
	 */
	public static boolean isNumber(String obj) {
		String strChars = "0123456789";
		return containsCharsOnly(obj, strChars);
	}

	// Round keys for encryption or decryption
	private static int pdwRoundKey[] = new int[32];
	// User secret key
	private static byte pbUserKey[] = BaseProperty.get("projectname").getBytes();

	/**
	 * 占쏙옙호화 占쌉쇽옙 占쏙옙호화 占쏙옙호화 占쏙옙占?: 占쌍민듸옙球占싫? 占쏙옙占쏙옙d占쏙옙, 카占쏙옙占싫? 占쏙옙화占쏙옙호, 占싱몌옙占쏙옙
	 * 
	 * @param obj
	 * @return
	 * @throws Exception
	 */
	public String encryptedStr_old(String obj) throws Exception {

		//String key = null;
		//String ret = null;
		String strenc = null;
		String encrypted = null;

		try {
			strenc = Base64.encode(obj.getBytes());

			// byte 占쏙옙 채占쏙옙占?
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
	 * 占쏙옙호화 占쌉쇽옙
	 * 
	 * @param obj
	 * @return
	 */
	public List decryptedStr(List obj, int idx) throws Exception {

		try {

			for (int j = 0; j < obj.size(); j++) {
				List tmplist = (List) obj.get(j);
				if (tmplist.get(idx).toString().length() > 0) {
					tmplist.set(idx, decoding(tmplist.get(idx).toString()));
				}
				
				obj.set(j, tmplist);
			}
		} catch (Exception e) {
			throw e;
		}
		return obj;
	}
	
	/**
	 * 占쏙옙호화 占쌉쇽옙
	 * 
	 * @param obj
	 * @return
	 */
	public List decryptedStrByMap(List obj, String key) throws Exception {

		try {

			for (int j = 0; j < obj.size(); j++) {
				Map tmpmap = (Map) obj.get(j);
				if (tmpmap.get(key).toString().length() > 0) {
					tmpmap.put(key, decoding(tmpmap.get(key).toString()));
				}
				
				obj.set(j, tmpmap);
			}
		} catch (Exception e) {
			throw e;
		}
		return obj;
	}
	
	/**
	 * 占쏙옙호화 占쌉쇽옙
	 * 
	 * @param obj
	 * @return
	 */	
    public String decryptedStr(String encrypted) throws Exception {
        String decrypted = "";
        try {
            decrypted = decoding(encrypted) ;
        } catch (Exception e) {
            throw e;
        }
        return decrypted;
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
	 * 占싹뱄옙占쏙옙 占쏙옙호화
	 * 占쏙옙占?: 占쏙옙橘占싫?
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
		//md.update(text.getBytes("UFT-8"), 0, text.length());
		md.update(text.getBytes("iso-8859-1"), 0, text.length());
		sha1hash = md.digest();
		return convertToHex(sha1hash);
	}
	
	public static String getUserNm(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
		return sessionInfo.getUSER_NAME();
	}
	
	public static String getUserId(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
		return sessionInfo.getUSER_ID();
	}
	
	
	/**
     * Action 占쏙옙 占쌤쇽옙 占식띰옙占쏙옙拷占?占쏙옙占쏙옙占싼댐옙. jinjung.kim
     * Action占쌤울옙占쏙옙 특d 占쏙옙(占쏙옙占쏙옙d占쏙옙 占쏙옙); DAO占쌤울옙 占쏙옙占쏙옙求占?占쎈도占쏙옙 占쏙옙占쏙옙磯占?
     * usage : form = setParam(form, "PASS", "1234");
     * @param ActionForm, String, String
     * @return ActionForm
     */
    public static ActionForm setParam(ActionForm form, String paramName, String paramValue) {
        String[] paramValues = { paramValue };
        form.setParam(paramName, paramValues);
        return form;
    }    
    
    
    /**
     * select2List占쏙옙 占쏙옙占싹울옙 占쏙옙占싹듸옙 list占쏙옙 특d row, 특d 占십듸옙占쏙옙 占쏙옙; 占쏙옙n占쏙옙. jinjung.kim
     * 占쏙옙占쎌스占쏙옙占쏙옙占싶쇽옙占쏙옙 占시뤄옙占쏙옙; 활占쏙옙占싹댐옙 占쏙옙占?
     * usage : String value = getString(list, dSet, 1, "CARD_NO"); //첫占쏙옙째 row占쏙옙占쏙옙 CARD_NO占십듸옙占쏙옙 占쏙옙; 占쏙옙n占쏙옙.
     *         row 占쏙옙 1占쏙옙占쏙옙 占쏙옙占쏙옙;
     * @param List, GauceDataSet, int, String
     * @return String
     */
    
    /*
    public static String getString(List list,GauceDataSet dSet, int row, String columnName) {
        String value = null;
        for (int i = 0 ; i < list.size(); i++) {
            if (i == (row - 1)) {
                List tmplist = (List) list.get(i);
                value = tmplist.get(dSet.indexOfColumn(columnName)).toString();
                break;
            }
        }
        return value;
    }
    */
    
    
    /**
     * select2List占쏙옙 占쏙옙占싹울옙 占쏙옙占싹듸옙 list占쏙옙 특d row, 특d 占십듸옙占쏙옙 占쏙옙; 占쏙옙占쏙옙占쏙옙. jinjung.kim
     * 占쏙옙占쎌스占쏙옙占쏙옙占싶쇽옙占쏙옙 占시뤄옙占쏙옙; 활占쏙옙占싹댐옙 占쏙옙占?
     * usage : list = setString(list, dSet, 1, "CARD_NO", "0000-0000-0000-0000"); //첫占쏙옙째 row占쏙옙 카占쏙옙占싫ｏ옙茄占?占쏙옙; "0000-0000-0000-0000"8占쏙옙 占쏙옙占쏙옙.
     *         row占쏙옙 1占쏙옙占쏙옙 占쏙옙占쏙옙;
     * @param List, GauceDataSet, int, String, String
     * @return List
     */
    
    /*
    public static List setString(List list,GauceDataSet dSet, int row, String columnName, String value) {
        for (int i = 0 ; i < list.size(); i++) {
            if (i == (row - 1)) {
                List tmplist = (List) list.get(i);
                tmplist.set(dSet.indexOfColumn(columnName), value );
                list.set(i, tmplist);
            }
        }
        return list;
    }
    */
    
    /**
     * select2List占쏙옙 占쏙옙占싹울옙 占쏙옙占싹듸옙 list占쏙옙 특d row, 특d 占십듸옙占쏙옙 占쏙옙; 占쏙옙n占쏙옙. jinjung.kim
     * 占시뤄옙占싸듸옙占쏙옙占쏙옙 활占쏙옙占싹댐옙 占쏙옙占?
     * usage : String value = getString(list, 1, 1); //첫占쏙옙째 row占쏙옙占쏙옙 첫占쏙옙째 占십듸옙占쏙옙 占쏙옙; 占쏙옙n占쏙옙.
     *         row占쏙옙 colindex占쏙옙 1占쏙옙占쏙옙 占쏙옙占쏙옙;
     * @param List, int, int
     * @return String
     */
    public static String getString(List list, int row, int colindex) {
        String value = null;
        for (int i = 0 ; i < list.size(); i++) {
            if (i == (row - 1)) {
                List tmplist = (List) list.get(i);
                value = tmplist.get((colindex - 1)).toString();
                break;
            }
        }
        return value;
    }
    
    /**
	 * @param list
	 * @param colName
	 * @return String : jsonObject
	 * @throws Exception
	 * @占쏙옙占쏙옙   List타占쏙옙; Json占쏙옙체占쏙옙 占쏙옙환占싼댐옙.
	 *         colName: 占쌥듸옙占?Sql占쏙옙 占쏙옙占쏙옙 占쌉력되억옙占?占싹몌옙 v회占쏙옙 占시뤄옙占쏙옙큼 占쌉뤄옙占쌔억옙 占싼댐옙.
	 */
    @SuppressWarnings("rawtypes")
	public String listToJsonOBJ(List list, String colName) throws Exception {
    	String rtJsonObj = "";
    	try{
    		if (list.size() == 0) {
    			rtJsonObj = "";
    		/*
    		} else if (list.size() == 1) {// v회占쏙옙 ROW占쏙옙 1占쏙옙占싹쏙옙
    			rtJsonObj +=  "{";
				for (int k = 0; k < cols.length; k++) {
					rtJsonObj +=  "\""+cols[k]+"\":\""+((List) list.get(0)).get(k)+"\"";
					if ((k+1) < cols.length) {
						rtJsonObj +=  ",";
					}
				}
				rtJsonObj +=  "}";
			*/
    		} else { // 占쏙옙占쏙옙占쏙옙 v회
        		//占시뤄옙占쏙옙 占썼열占쏙옙
        		String[] cols = colName.split(","); 
    			
    			rtJsonObj +=  "[";
    			// json占쏙옙체占쏙옙 占쏙옙환
    			for (int j = 0; j < list.size(); j++) {
    				rtJsonObj +=  "{";
    				for (int k = 0; k < cols.length; k++) {
    					rtJsonObj +=  "\""+cols[k]+"\":\""+((List) list.get(j)).get(k)+"\"";
    					if ((k+1) < cols.length) {
    						rtJsonObj +=  ",";
    					}
    				}
    				rtJsonObj +=  "}";
					if ((j+1) < list.size()) {
						rtJsonObj +=  ",";
					}
    			}
    			rtJsonObj +=  "]";
    		}

    	}catch(Exception e){
    		throw e;
    	}
    	
    	return rtJsonObj;
    }
    
    /**
     * @param ResultSet rs
     * @param colName
     * @return String : jsonObject
     * @throws Exception
     * @占쏙옙占쏙옙   ResultSet 타占쏙옙; Json占쏙옙체占쏙옙 占쏙옙환占싼댐옙.
     */
    public String rsToJsonOBJ(ResultSet rs) throws Exception {
    	String rtJsonObj = "";
    	try{
    		if (rs.getRow() == 0) {
    			rtJsonObj = "";
    		} else { // 占쏙옙占쏙옙占쏙옙 v회
    			int colcnt = 0;
    			int rowCnt = 1;
    			
    			rtJsonObj +=  "[";
    			// json占쏙옙체占쏙옙 占쏙옙환
    			while (rs.next()) {
    				rtJsonObj +=  "{";
    				ResultSetMetaData mrs = rs.getMetaData();
    				colcnt = mrs.getColumnCount();
    				
					for (int i = 1; i <= colcnt; i++) {
    					rtJsonObj +=  "\""+(mrs.getColumnName(i)).toUpperCase()+"\":\""+rs.getString(i)+"\"";
    					if (i < colcnt) {
    						rtJsonObj +=  ",";
    					}
					}
					rtJsonObj +=  "}";
					
    				if (rowCnt < rs.getRow()) {
    					rtJsonObj +=  ",";
    				}
    				rowCnt++;
    			}
    			
    			rtJsonObj +=  "]";
    		}
    		
    	}catch(Exception e){
    		throw e;
    	}
    	
    	return rtJsonObj;
    }
    
    
    /**
     * select2List占쏙옙 占쏙옙占싹울옙 占쏙옙占싹듸옙 list占쏙옙 특d row, 특d 占십듸옙占쏙옙 占쏙옙; 占쏙옙占쏙옙占쏙옙. jinjung.kim
     * 占시뤄옙占싸듸옙占쏙옙占쏙옙 활占쏙옙占싹댐옙 占쏙옙占?
     * usage : list = setString(list, 1, 1, "0000-0000-0000-0000"); //첫占쏙옙째 row占쏙옙 첫占쏙옙째 占십듸옙 占쏙옙; "0000-0000-0000-0000"8占쏙옙 占쏙옙占쏙옙.
     *         row占쏙옙 colindex占쏙옙 1占쏙옙占쏙옙 占쏙옙占쏙옙;
     * @param List, int, int, String
     * @return List
     */
    public static List setString(List list, int row, int colindex, String value) {
        for (int i = 0 ; i < list.size(); i++) {
            if (i == (row - 1)) {
                List tmplist = (List) list.get(i);
                tmplist.set((colindex - 1), value );
                list.set(i, tmplist);
            }
        }
        return list;
    }
    
    public static String getUserid(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
		return sessionInfo.getUSER_ID();
	}
}
