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
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

import kr.fujitsu.ffw.base.BaseProperty;
import kr.fujitsu.ffw.model.SqlWrapper;

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
	
//HISTRORY 공통 컬럼 정의 ( 순번, 등록일자, REG_ID)
	public static final String HIST_MOD_SEQ           = "MOD_SEQ";
	public static final String HIST_REG_DATE          = "REG_DATE";
	public static final String HIST_REG_ID            = "REG_ID";
	
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
	public static boolean isNumber(String obj) {
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
				if (tmplist.get(idx).toString().length() > 0) {
					tmplist.set(idx, decoding(tmplist.get(idx).toString()));
				}
				// System.out.println(tmplist.get(idx).toString());
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
	 * 일방향 암호화
	 * 대상 : 비밀번호
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
	
	/**
	 * 단품코드 CheckSum 값을 검증한다.
	 * 
	 * @param obj
	 * @return
	 */
	public static boolean isSkuCdCheckSum(String skuCd) {
		if (skuCd == null)
			return false;
		if (skuCd.length() != 13 || !isNumber(skuCd))
			return false;
		String checkSum = getSkuCdCheckSum(skuCd.substring(0, 12));
		return checkSum.equals(skuCd.substring(12));
	}

	/**
	 * 단품코드 CheckSum 값 생성한다.
	 * 
	 * @param obj
	 * @return
	 */
	public static String getSkuCdCheckSum(String skuCd) {
		if (skuCd == null)
			return null;
		if (skuCd.length() != 12 || !isNumber(skuCd))
			return null;

		int oddNumSum = 0; // 홀수번째 숫자 합
		int evenNumSum = 0; // 짝수번째의 숫자 합

		for (int i = 0; i < 12; i++) {
			if ((i + 1) % 2 == 1)
				oddNumSum += Integer.parseInt(String.valueOf(skuCd.charAt(i)));
			else
				evenNumSum += Integer.parseInt(String.valueOf(skuCd.charAt(i)));
		}
		// 짝수번째의 숫자 합 * 3
		int tmpEvenNum = evenNumSum * 3;

		// (짝수번째의 숫자 합 * 3 ) + 홀수번째 숫자 합
		int tmpSum = oddNumSum + tmpEvenNum;

		// 결과에 10의 배수가 되도록 더해진 최소수치 (0이상의 양수)
		int returnVal = tmpSum % 10 == 0 ? 0 : (10 - (tmpSum % 10));

		return String.valueOf(returnVal);
	}
	
	/**
	 * histtory table 컬럼을 조회한다.
	 * @param tableName
	 * @return
	 */
	public static List getHistoryTabelColumn( String tableName){
		/* 
		 * History 컬럼 정보 가져오는 쿼리
		 * 
		 * SELECT TABLE_NAME, SUBSTR( MAX( SYS_CONNECT_BY_PATH( COLNAME, ',')), 2) AS COL
		 *   FROM (
		 *         SELECT TABLE_NAME , '"'||COLUMN_NAME||'"' AS COLNAME, COLUMN_ID
		 *           FROM ALL_TAB_COLUMNS
		 *          WHERE OWNER = 'DPS' AND TABLE_NAME LIKE '%_HIST'
		 *        )
		 *  START WITH COLUMN_ID = 1
		 * CONNECT BY PRIOR COLUMN_ID = COLUMN_ID-1 AND PRIOR TABLE_NAME = TABLE_NAME
		 * GROUP BY TABLE_NAME
		 */
		List list = new ArrayList();
		
		//바이어조직변경이력
		if( tableName.equals("PC_BUYERORGHIST")){ 
			list=Arrays.asList("BUYER_CD","MOD_SEQ","APP_S_DT","STR_CD","TEAM_CD","APP_E_DT","EMP_NO","PC_ORG_CD","USE_YN","REG_DATE","REG_ID");
		//품번변경이력
		}else if( tableName.equals("PC_PBNHIST")){ 
			list=Arrays.asList("PUMBUN_CD","MOD_SEQ","PUMBUN_NAME","RECP_NAME","VEN_CD","BIZ_TYPE","BIZ_FLAG","REP_PUMBUN_CD","TAX_FLAG","PUMBUN_FLAG","PUMBUN_TYPE","SKU_FLAG","SKU_TYPE","STYLE_TYPE","ITG_ORD_FLAG","BRAND_CD","APP_S_DT","APP_E_DT","USE_YN","REG_DATE","REG_ID");
		//점별품번변경이력
		}else if( tableName.equals("PC_STRPBNHIST")){ 
			list=Arrays.asList("STR_CD","PUMBUN_CD","MOD_SEQ","PUMBUN_NAME","RECP_NAME","VEN_CD","BIZ_TYPE","BIZ_FLAG","PUMBUN_TYPE","SKU_FLAG","SKU_TYPE","STYLE_TYPE","POS_CAL_FLAG","CHAR_BUYER_CD","BUY_ORG_CD","CHAR_SM_CD","SALE_ORG_CD","SALE_BUY_FLAG","CHK_YN","COST_CAL_WAY","ADV_ORD_YN","LOW_MG_RATE","ADD_POINT_YN","EVALU_YN","AREA_SIZE","E_CNTR_NO","APP_S_DT","APP_E_DT","USE_YN","REG_DATE","REG_ID","EDI_YN","RENTB_MGAPP_FLAG","SORT_NO","FLOR_CD");
		//협력사변경이력
		}else if( tableName.equals("PC_VENHIST")){ 
			list=Arrays.asList("VEN_CD","MOD_SEQ","VEN_NAME","VEN_SHORT_NAME","BUY_SALE_FLAG","BIZ_TYPE","BIZ_FLAG","REP_VEN_CD","BUY_ACC_VEN_CD","SALE_ACC_VEN_CD","COMP_FLAG","ETAX_ISSUE_FLAG","RVS_ISSUE_FLAG","OCOMP_TAX_ID","EDI_YN","COMP_NO","CORP_NO","COMP_NAME","BIZ_STAT","BIZ_CAT","REP_NAME","POST_NO","POST_SEQ","ADDR","DTL_ADDR","PHONE1_NO","PHONE2_NO","PHONE3_NO","FAX1_NO","FAX2_NO","FAX3_NO","BIZ_S_DT","BIZ_E_DT","USE_YN","REG_DATE","REG_ID","SAP_DEL_FLAG","SAP_IF_DATE","SBNS_CAL_RATE");
		//단품변경이력
		}else if( tableName.equals("PC_SKUHIST")){ 
			list=Arrays.asList("SKU_CD","MOD_SEQ","SKU_NAME","RECP_NAME","PUMBUN_TYPE","PUMBUN_CD","PUMMOK_CD","SKU_TYPE","STYLE_TYPE","PLU_FLAG","INPUT_PLU_CD","MODEL_NO","SALE_UNIT_CD","BAS_SPEC_CD","BAS_SPEC_UNIT","CMP_SPEC_CD","CMP_SPEC_UNIT","ORIGIN_AREA_CD","MAKER_CD","SET_YN","GIFT_FLAG","GIFT_AMT_TYPE","REMARK","STYLE_CD","COLOR_CD","SIZE_CD","BOTTLE_CD","USE_YN","REG_DATE","REG_ID","GIFT_TYPE_CD");
		//점별협력사변경이력
		}else if( tableName.equals("PC_STRVENHIST")){ 
			list=Arrays.asList("STR_CD","VEN_CD","MOD_SEQ","VEN_NAME","VEN_SHORT_NAME","BIZ_TYPE","BIZ_FLAG","EDI_YN","PAY_CYC","PAY_DT_FLAG","PAY_WAY","POS_CAL_FLAG","TAX_ITG_ISSUE_FLAG","RUND_FLAG","PAY_HOLI_FLAG","BANK_ACC_NO","BANK_CD","ACC_NO_OWN","BIZ_S_DT","BIZ_E_DT","USE_YN","REG_DATE","REG_ID","MNTN_CHRG_FLAG","CARD_FEE_CHRG","POS_DEPOSIT_1","POS_USEFEE_1","POS_USEQTY_1","POS_DEPOSIT_2","POS_USEFEE_2","POS_USEQTY_2","POS_DEPOSIT_3","POS_USEFEE_3","POS_USEQTY_3","POS_DEPOSIT_4","POS_USEFEE_4","POS_USEQTY_4","POS_DEPOSIT_5","POS_USEFEE_5","POS_USEQTY_5");
		//조직변경이력
		}else if( tableName.equals("PC_ORGHIST")){ 
			list=Arrays.asList("ORG_CD","MOD_SEQ","ORG_NAME","ORG_SHORT_NAME","ORG_FLAG","ORG_LEVEL","STR_CD","DEPT_CD","TEAM_CD","PC_CD","CORNER_CD","P_ORG_CD","FRST_ORG_CD","SAP_ORG_CD","BF_ORG_CD","MNG_ORG_YN","EMP_CNT","AREA_SIZE","APP_S_DT","APP_E_DT","USE_YN","REG_DATE","REG_ID","KOSTL_CD");
		//점별단품변경이력
		}else if( tableName.equals("PC_STRSKUHIST")){ 
			list=Arrays.asList("STR_CD","SKU_CD","MOD_SEQ","SKU_NAME","RECP_NAME","PUMBUN_TYPE","PUMBUN_CD","SKU_TYPE","STYLE_TYPE","STYLE_CD","COLOR_CD","SIZE_CD","BOTTLE_CD","UNIT_SALE_PRC","SAL_COST_PRC","SALE_PRC","SALE_MG_RATE","BUY_COST_PRC","BUY_SALE_PRC","LOW_ORD_QTY","OTM_STK_QTY","LEAD_TIME","SAFE_STK_DAY","SALE_S_DT","SALE_E_DT","BUY_S_DT","BUY_E_DT","USE_YN","PROC_FLAG","REG_DATE","REG_ID","ADV_ORD_YN","VEN_CD");
		//스타일변경이력
		}else if( tableName.equals("PC_STYLEHIST")){ 
			list=Arrays.asList("PUMBUN_CD","STYLE_CD","MOD_SEQ","STYLE_NAME","RECP_NAME","PUMMOK_CD","BRAND_CD","SUB_BRD_CD","PLAN_YEAR","SEASON_CD","ITEM_CD","SEQ_NO","SIZE_TYPE","MNG_CD1","MNG_CD2","MNG_CD3","MNG_CD4","MNG_CD5","MAKER_CD","SEX_CD","CURRENCY_CD","ORIGIN_AREA_CD","VEN_STYLE_CD","STYLE_TYPE","SALE_UNIT_CD","BAS_SPEC_CD","BAS_SPEC_UNIT","CMP_SPEC_CD","CMP_SPEC_UNIT","REMARK","IMAGE1","IMAGE2","USE_YN","REG_DATE","REG_ID");
		}
		return list;
	}
	
	/**
	 * History 저장 쿼리를 생성하여 리턴한다.
	 * 
	 *  순번            - MOD_SEQ
	 *  등록일자  - REG_DATE
	 *  등록자       - REG_ID
	 * @param tableNm
	 * @param hisTableNm
	 * @param owner
	 * @param keys
	 * @param seqCol
	 * @param strID
	 * @return SqlWrapper
	 * @throws Exception
	 */
	public static SqlWrapper getHistorySQL( String tableNm, String hisTableNm, String owner, Map keys, String seqCol, String strID )
	    throws Exception {
		SqlWrapper sql = new SqlWrapper();
		StringBuffer insertSb = new StringBuffer();
		StringBuffer selectSb = new StringBuffer();
		StringBuffer whereSb = new StringBuffer();
		StringBuffer subWhereSb = new StringBuffer();
		boolean hasKeys = keys != null;
		boolean hasSeqCol = seqCol != null;
		sql = new SqlWrapper();
		tableNm = tableNm.toUpperCase();
		owner = owner.toUpperCase();
		List colList = getHistoryTabelColumn(hisTableNm);
		if( colList.size() < 1)
			throw new Exception( "[History] "+ owner + "." + hisTableNm +" 은/는 존재하지 않는 테이블 입니다.");
		
		insertSb.append("INSERT INTO ")
		        .append(owner).append(".").append(hisTableNm).append("\n")
		        .append("           (");
		selectSb.append("     SELECT ");
		whereSb.append("      WHERE ");
		subWhereSb.append(" WHERE ");
		
		//순번 증가를 위한 where 조건
		if(hasSeqCol){
			String[] seqColist = seqCol.split(",");
			for( int j = 0 ; j < seqColist.length; j++){
				if( j != 0 )
					subWhereSb.append(" AND ");
				
				subWhereSb.append("HS.").append(seqColist[j]).append(" = RL.").append(seqColist[j]);
			}
		}
		
		if( hasKeys ){
			int whereIdx = 0;
			Iterator it1 = keys.keySet().iterator();
			while( it1.hasNext()){
				String keyColNm = (String)it1.next();

				if( whereIdx != 0 )
					whereSb.append("\n").append("        AND ");
				
				whereSb.append("RL.").append(keyColNm).append(" = ? ");
				sql.setString(++whereIdx, keys.get(keyColNm).toString());
			}
		}
		
		for(int idx = 0 ; idx < colList.size() ; idx++){
			String colNm =  (String)colList.get(idx);
			if( idx != 0 ){
				insertSb.append("\n").append("          , ");		
				selectSb.append("\n").append("          , ");
			}				
			insertSb.append( colNm );
			
			//공통컬럼에 대하여 값 변경
			//순번
			if( colNm.equals(HIST_MOD_SEQ)){
				selectSb.append( "( SELECT NVL( MAX( HS.MOD_SEQ ) + 1, 1) FROM ")
				        .append(owner).append(".").append(hisTableNm).append(" HS ");
				if( hasKeys ){
					selectSb.append( subWhereSb.toString() );
				}
				selectSb.append(" ) AS MOD_SEQ" );
			//등록일자
			}else if( colNm.equals(HIST_REG_DATE)){
				selectSb.append( "SYSDATE  AS REG_DATE" );
			//등록자
			}else if( colNm.equals(HIST_REG_ID)){
				selectSb.append("'").append( strID ).append("' AS REG_ID");
			}else {
				selectSb.append("RL.").append( colNm );					
			}
		}
		insertSb.append("\n").append("           ) ");
		selectSb.append("\n").append("       FROM ").append(owner).append(".").append(tableNm).append(" RL");
		
		sql.put( insertSb.toString() );
		sql.put( selectSb.toString() );
		if( hasKeys )
			sql.put( whereSb.toString() );

		return sql;
	}

	/**
	 * 날자를 추가한다.
	 * @param date
	 * @param day
	 * @return
	 * @throws Exception
	 */
    public static String addDay(String date, int day) throws Exception {
    	
        Calendar cal = Calendar.getInstance();
        cal.setTime((new SimpleDateFormat("yyyyMMdd")).parse(date));
        cal.add(5, day);
        return (new SimpleDateFormat("yyyyMMdd")).format(cal.getTime());
    }

    /**
     * 월을 추가한다.
     * @param date
     * @param month
     * @return
     * @throws Exception
     */
    public static String addMonth(String date, int month) throws Exception {
        Calendar cal = Calendar.getInstance();
        cal.setTime((new SimpleDateFormat("yyyyMMdd")).parse(date));
        cal.add(2, month);
        return (new SimpleDateFormat("yyyyMMdd")).format(cal.getTime());
    }
    
    public static String getUserNm(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		return sessionInfo.getUSER_NAME();
	}
    
    public static String getUserId(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		return sessionInfo.getUSER_ID();
	}

	public static String getPId(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session
				.getAttribute("sessionInfo");
		return sessionInfo.getPGM_ID();
	}
	
	public static String getToday( String format ){
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}

}
