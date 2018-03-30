package common.util;

import java.util.HashMap;
import java.util.Hashtable;

import ksnetlib.java.KSNetMain;

/**
 * OCB Net Util
 * 
 * @author Administrator
 *
 */
public class OCBNetUtil {
	
	// TEST ip
	//private static final String IP = "210.181.28.116";
	// REAL ip
	private static final String IP = "210.181.28.137";
	private static final int PORT = 9562;
	// 테스트 단말기번호
	public static final String TERMINAL = "DPT0000199";			//1호점
	//public static final String TERMINAL = "DPT0000199";			//1호점
	//public static final String TERMINAL = "DPT0Q06628";			//3호점
	// 실제 단말기번호
	//private static final String TERMINAL = "DPT0TEST03";
	
	/**
	 * OCB Send
	 * 
	 * @param hm
	 * @return
	 * @throws Exception
	 */
	public static Hashtable<String, String> send(HashMap<String, String> hm) throws Exception {
		KSNetMain m_KSNetMain	= new KSNetMain();
		
		// 승인 요청
		Hashtable<String, String> m_hash = new Hashtable<String, String>();			

		try {
			System.out.println( "IP =[" + IP + "]" );
			System.out.println( "PORT =[" + PORT + "]" );
			System.out.println( "TERMINAL =[" + TERMINAL + "]" );
			System.out.println( "[SEND=================================================================]" );			
			System.out.println( "[" + hm.get( "02" ) + "]" );
			System.out.println( "[" + hm.get( "04" ) + "]" );
			System.out.println( "[" + hm.get( "05" ) + "]" );
			System.out.println( "[" + hm.get( "06" ) + "]" );
			System.out.println( "[" + hm.get( "07" ) + "]" );
			System.out.println( "[" + hm.get( "09" ) + "]" );
			System.out.println( "[" + hm.get( "10" ) + "]" );
			System.out.println( "[" + hm.get( "11" ) + "]" );
			System.out.println( "[" + hm.get( "12" ) + "]" );
			System.out.println( "[" + hm.get( "13" ) + "]" );
			System.out.println( "[" + hm.get( "14" ) + "]" );
			System.out.println( "[" + hm.get( "15" ) + "]" );
			System.out.println( "[" + hm.get( "16" ) + "]" );
			System.out.println( "[" + hm.get( "17" ) + "]" );
			System.out.println( "[" + hm.get( "18" ) + "]" );
			System.out.println( "[" + hm.get( "19" ) + "]" );
			System.out.println( "[" + hm.get( "20" ) + "]" );
			System.out.println( "[" + hm.get( "21" ) + "]" );
			System.out.println( "[" + hm.get( "22" ) + "]" );
			System.out.println( "[" + hm.get( "23" ) + "]" );
			System.out.println( "[" + hm.get( "24" ) + "]" );
			System.out.println( "[" + hm.get( "25" ) + "]" );
			System.out.println( "[" + hm.get( "26" ) + "]" );
			System.out.println( "[" + hm.get( "27" ) + "]" );
			System.out.println( "[" + hm.get( "A0" ) + "]" );
			System.out.println( "[" + hm.get( "28" ) + "]" );
			System.out.println( "[" + hm.get( "A1" ) + "]" );
			System.out.println( "[" + hm.get( "A2" ) + "]" );
			System.out.println( "[" + hm.get( "A3" ) + "]" );
			System.out.println( "[" + hm.get( "A4" ) + "]" );
			
			m_hash = m_KSNetMain.requestApproval(
					IP,                                                 // IP
					PORT,                                               // Port
					hm.get("02"),                                       // 거래구분자
					TERMINAL,                                           // 단말기 번호
					hm.get("04"),                                       // 업체정보
					hm.get("05"),                                       // 전문번호
					hm.get("06"),                                       // POS Entry Mode
					hm.get("07"),                                       // Track II
					hm.get("09"),                                       // 할부개월/거래자구분/판매구분
					hm.get("10"),                                       // 총금액
					hm.get("11"),                                       // 봉사료
					hm.get("12"),                                       // 세금(부가세)
					hm.get("13"),                                       // 공급금액
					hm.get("14"),                                       // Working Key Index
					hm.get("15"),                                       // 비밀번호
					hm.get("16"),                                       // 원거래 승인 번호
					hm.get("17"),                                       // 원거래 승인 일자
					hm.get("18"),                                       // 사용자 정보
					hm.get("19"),                                       // 가맹점 ID
					hm.get("20"),                                       // 가맹점 사용필드
					hm.get("21"),                                       // 포인트구분
					hm.get("22"),                                       // KSNet Reserved
					hm.get("23"),                                       // 동글 구분
					hm.get("24"),                                       // 매체 구분
					hm.get("25"),                                       // 이통사 구분
					hm.get("26"),                                       // 신용카드 종류
					hm.get("27"),                                       // 거래 형태
					hm.get("A0"),                                       // 거래형태에 의한 Data
					hm.get("28"),                                       // 전자서명 유무
					hm.get("A1"),                                       // 전자서명 암호화 Key Index
					hm.get("A2"),                                       // 제품코드 및 버전
					hm.get("A3"),                                       // 전자 서명 길이
					hm.get("A4")                                        // 전자 서명 데이터
				);
			
			if( m_hash == null ) {
				System.out.println("승인실패\n");
				
			} else {
				System.out.println( "[RECEIVE==============================================================]" );			
				System.out.println( "[" + m_hash.get( "Classification" ) + "]" );	// Classification:	거래구분
				System.out.println( "[" + m_hash.get( "UniqNum" ) + "]" );			// UniqNum:			전문일련번호
				System.out.println( "[" + m_hash.get( "Status" ) + "]" );			// Status:			상태(성공,실패)
				System.out.println( "[" + m_hash.get( "Authdate" ) + "]" );			// Auth date:		승인일자
				System.out.println( "[" + m_hash.get( "Cardtype" ) + "]" );			// Card type:		카드타입
				System.out.println( "[" + m_hash.get( "Message1" ) + "]" );			// Message1:		메제지1
				System.out.println( "[" + m_hash.get( "Message2" ) + "]" );			// Message2:		메세지2
				System.out.println( "[" + m_hash.get( "AuthNum" ) + "]" );			// AuthNum:			승인번호
				System.out.println( "[" + m_hash.get( "FranchiseID" ) + "]" );		// FranchiseID:		가맹점번호
				System.out.println( "[" + m_hash.get( "Code1" ) + "]" );			// Code1:			발급사코드
				System.out.println( "[" + m_hash.get( "CardName" ) + "]" );			// CardName:		카드종류명
				System.out.println( "[" + m_hash.get( "Code2" ) + "]" );			// Code2:			매입사코드
				System.out.println( "[" + m_hash.get( "CompName" ) + "]" );			// CompName:		매입사명
				System.out.println( "[" + m_hash.get( "Balance" ) + "]" );			// Balance:			잔액
				System.out.println( "[" + m_hash.get( "point1" ) + "]" );			// point1:			발생포인트
				System.out.println( "[" + m_hash.get( "point2" ) + "]" );			// point2:			가용포인트
				System.out.println( "[" + m_hash.get( "point3" ) + "]" );			// point3:			누적포인트
				System.out.println( "[" + m_hash.get( "Notice1" ) + "]" );			// Notice1:			Notice1
				System.out.println( "[" + m_hash.get( "Notice2" ) + "]" );			// Notice2:			Notice2
				System.out.println( "[" + m_hash.get( "IC_Flag" ) + "]" );			// IC_Falg:			거래형태
				System.out.println( "[" + m_hash.get( "EMV_Data" ) + "]" );			// EMV_Data:		거래형태 데이타
				System.out.println( "[" + m_hash.get( "Reserved" ) + "]" );			// Reserved:			예약 필드
				System.out.println( "[" + m_hash.get( "KSNET_Reserved" ) + "]" );	// KSNET_Reserved: KSNet 예약필드
			}

		} catch (Exception e) {
			throw e;
		} finally {
			//
		}
		
		return m_hash;
	}

    /**
     * OCBNet 전송을 위한 맵핑
     * 
     * @param tradeFlag 거래구분자
     * @param fullTxtNo 전문번호
     * @param cardNo 카드번호
     * @param vaildNo 카드유효기간
     * @param saleAmt 금액
     * @param pwdNo 비밀번호
     * @param apprNo 원거래승인번호
     * @param apprDt 원거래승인일자
     * @param encryptedSign 전자서명
     * @return
     */
	public static HashMap<String, String> makeForm(String tranFlag, String tranNo, String cardNo, String vaildNo,
			String saleAmt, String pwdNo, String apprNo, String apprDt, String encryptedSign) {

		HashMap<String, String> hm = new HashMap<String, String>();

    	//
    	// Key Name은 전문 LAYOUT의 순번 (A? 시작 Key Name은 전문LAYOUT에 없어 임의로 붙임) 
    	// KSNET_대형점_SI240 전문.xls 파일 참조
    	hm.put("02", tranFlag);												// 거래구분자
    	hm.put("04", "MARO");												// 업체정보
    	hm.put("05", tranNo); 												// 전문번호
    	hm.put("06", "K");													// POS Entry Mode
    	hm.put("07", cardNo + "=" + vaildNo);								// Track II
    	hm.put("09", "00");													// 할부개월/거래자구분/판매구분
    	hm.put("10", saleAmt);											    // 총금액 - 조회시 금액 0
    	hm.put("11", "0");													// 봉사료
    	hm.put("12", "0");													// 세금(부가세)
    	hm.put("13", "0");													// 공급금액
    	hm.put("14", "AA");													// Working Key Index
    	hm.put("15", pwdNo);									            // 비밀번호
    	hm.put("16", apprNo);												// 원거래 승인번호
    	hm.put("17", apprDt);												// 원거래 승인일자
    	hm.put("18", "");													// 사용자정보
    	hm.put("19", "");													// 가맹점ID
    	hm.put("20", "");													// 가맹점 사용필드
    	hm.put("21", "OCB");												// 포인트구분
    	hm.put("22", "");													// KSNet Reserved
    	hm.put("23", "");													// 동글 구분
    	hm.put("24", "");													// 매체 구분
    	hm.put("25", "");													// 이통사 구분
    	hm.put("26", "");													// 신용카드 종류
    	hm.put("27", "N");													// 거래형태
    	hm.put("A0", "");													// 거래형태에 의한 Data
    	hm.put("28", "N");													// 전자서명 유무
    	hm.put("A1", "83");													// 전자서명 암호화 Key Index
    	hm.put("A2", "");													// 제품코드 및 버전
    	hm.put("A3", String.format("%d",encryptedSign.length()));			// 전자 서명 길이
    	hm.put("A4", encryptedSign);										// 전자 서명 데이터

		return hm;
	}
	
}
