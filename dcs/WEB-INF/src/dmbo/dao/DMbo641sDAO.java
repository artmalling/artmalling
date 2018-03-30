/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.dao;

import java.util.HashMap;
import java.util.Hashtable;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.Date2;

import common.util.OCBNetUtil;

/**
 * <p>OKCASHBAG상품권 교환</p>
 * 
 * @created  on 1.0, 2010/03/02
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DMbo641sDAO extends AbstractDAO {

	/**
	 * 상품권 전문 정보를 저장 처리한다.
	 * 
	 * @param form
	 * @param hmbf
	 * @param hmaf
	 * @throws Exception
	 */
	public void insOCBData(ActionForm form, HashMap<String, String> bf, Hashtable<String, String> af)
			throws Exception {

    	SqlWrapper sql   = null;
        Service    svc   = null;
        
        try {
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();

			connect("pot");
			begin();
			
			String strAuthdate = Date2.YYMMDD();
			String strUniqNum = bf.get("05");
			
			if (af != null && af.get("Authdate") != null)
				strAuthdate = af.get("Authdate").substring(0, 6);
			if (af != null && af.get("UniqNum") != null)
				strUniqNum = af.get("UniqNum");
            
			int i=1;
			sql.put(svc.getQuery("INS_GIFTCD_LOG"));
			
            // 전문 송신
			sql.setString(i++, strAuthdate);			
            sql.setString(i++, strUniqNum);										// 전문번호

            sql.setString(i++, strAuthdate);			
            sql.setString(i++, strUniqNum);										// 전문번호
            
            sql.setString(i++, bf.get("02"));									// 거래구분자
            sql.setString(i++, OCBNetUtil.TERMINAL);							// 단말기번호
            sql.setString(i++, bf.get("04"));									// 업체정보
            sql.setString(i++, bf.get("06"));									// POS Entry Mode
            sql.setString(i++, bf.get("07"));									// Track II
            sql.setString(i++, "");												// FS
            sql.setString(i++, bf.get("09"));									// 할부개월/거래자구분/판매구분
            sql.setString(i++, bf.get("10"));									// 총금액 - 조회시 금액 0
            sql.setString(i++, bf.get("11"));									// 봉사료
            sql.setString(i++, bf.get("12"));									// 세금(부가세)
            sql.setString(i++, bf.get("13"));									// 공급금액
            sql.setString(i++, bf.get("14"));									// Working Key Index
            sql.setString(i++, bf.get("15"));									// 비밀번호
            sql.setString(i++, bf.get("16"));									// 원거래 승인번호
            sql.setString(i++, bf.get("17"));									// 원거래 승인일자
            sql.setString(i++, bf.get("18"));									// 사용자정보
            sql.setString(i++, bf.get("19"));									// 가맹점ID
            sql.setString(i++, "");												// 가맹점번호
            sql.setString(i++, bf.get("20"));									// 가맹점 사용필드
            sql.setString(i++, bf.get("21"));									// 포인트구분
            sql.setString(i++, bf.get("22"));									// KSNet Reserved
            sql.setString(i++, bf.get("23"));									// 동글 구분
            sql.setString(i++, bf.get("24"));									// 매체 구분
            sql.setString(i++, bf.get("25"));									// 이통사 구분
            sql.setString(i++, bf.get("26"));									// 신용카드 종류
            sql.setString(i++, bf.get("27"));									// 거래형태
            sql.setString(i++, bf.get("28"));									// 전자서명 유무

            sql.setString(i++, "");												// Status
            sql.setString(i++, "");												// 카드 Type
            sql.setString(i++, "");												// Message1
            sql.setString(i++, "");												// Message2
            sql.setString(i++, "");												// 승인번호
            sql.setString(i++, "");												// 발급사코드
            sql.setString(i++, "");												// 카드종류명
            sql.setString(i++, "");												// 매입사코드
            sql.setString(i++, "");												// 매입사명
            sql.setString(i++, "");												// Working Key
            sql.setDouble(i++, 0);												// 예비 포인트
            sql.setDouble(i++, 0);												// 발생 포인트
            sql.setDouble(i++, 0);												// 가용 포인트
            sql.setDouble(i++, 0);												// 누적 포인트
            sql.setString(i++, "");												// Notice1
            sql.setString(i++, "");												// Notice2
            sql.setString(i++, "");												// Reserved

	    	update(sql);

		} catch (Exception e) {
			e.printStackTrace();
			//rollback();
			//throw e;
		} finally {
			end();
		}
	}	

	/**
	 * 상품권 전문 정보를 저장 처리한다.
	 * 
	 * @param form
	 * @param hmbf
	 * @param hmaf
	 * @throws Exception
	 */
	public void updOCBData(ActionForm form, HashMap<String, String> bf, Hashtable<String, String> af)
			throws Exception {
		
		SqlWrapper sql   = null;
		Service    svc   = null;
		
		try {
			svc  = (Service)form.getService();
			sql  = new SqlWrapper();
			
			connect("pot");
			begin();
			
			
			int i=1;
			sql  = new SqlWrapper();
			sql.put(svc.getQuery("UPD_GIFTCD_LOG"));
			
			// 전문 수신
			sql.setString(i++, af.get("Classification")); 						// 거래구분자
			sql.setString(i++, af.get("FranchiseID"));							// 가맹점번호
			
			sql.setString(i++, af.get("Status"));								// Status
			sql.setString(i++, af.get("Cardtype"));								// 카드 Type
			sql.setString(i++, af.get("Message1"));								// Message1
			sql.setString(i++, af.get("Message2"));								// Message2
			sql.setString(i++, af.get("AuthNum"));								// 승인번호
			sql.setString(i++, af.get("Code1"));								// 발급사코드
			sql.setString(i++, af.get("CardName"));								// 카드종류명
			sql.setString(i++, af.get("Code2"));								// 매입사코드
			sql.setString(i++, af.get("CompName"));								// 매입사명
			sql.setString(i++, "");												// Working Key
			sql.setDouble(i++, Double.parseDouble(af.get("Balance")));			// 예비 포인트
			sql.setDouble(i++, Double.parseDouble(af.get("point1")));			// 발생 포인트
			sql.setDouble(i++, Double.parseDouble(af.get("point2")));			// 가용 포인트
			sql.setDouble(i++, Double.parseDouble(af.get("point3")));			// 누적 포인트
			sql.setString(i++, af.get("Notice1"));								// Notice1
			sql.setString(i++, af.get("Notice2"));								// Notice2
			sql.setString(i++, af.get("Reserved"));								// Reserved
			
			sql.setString(i++, af.get("Authdate").substring(0,6));			
			sql.setString(i++, af.get("UniqNum"));								// 전문번호

			sql.setString(i++, af.get("Authdate").substring(0,6));			
			sql.setString(i++, af.get("UniqNum"));								// 전문번호
			
			update(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
			//rollback();
			//throw e;
		} finally {
			end();
		}
	}	

}
