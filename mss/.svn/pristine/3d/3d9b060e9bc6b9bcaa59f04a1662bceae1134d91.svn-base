/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>
 * 사은품 지급등록
 * </p>
 * 
 * @created on 1.0, 2011/03/03
 * @created by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MCae416DAO extends AbstractDAO {
	
	/**
	 * 사은행사 정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getEventCombo(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strPrsntDt = String2.nvl(form.getParam("strPrsntDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPrsntDt);

		strQuery = svc.getQuery("SEL_EVENT_COMBO") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	
	/**
	 * 사은행사 정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getEventInfo(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strEventCd = String2.nvl(form.getParam("strEventCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);

		strQuery = svc.getQuery("SEL_EVENT_INFO") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 영수증 정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getSaleInfo(ActionForm form) throws Exception {

		List ret[] = new List[2];
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strEventCd = String2.nvl(form.getParam("strEventCd"));
		String strSaleDt = String2.nvl(form.getParam("strSaleDt"));
		String strPosNo = String2.nvl(form.getParam("strPosNo"));
		String strTranNo = String2.nvl(form.getParam("strTranNo"));
		String strAllBrand = "";

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");

		sql.close();
		sql.put(svc.getQuery("SEL_CHK_ALLBRAND"));
		sql.setString(1, strStrCd);
		sql.setString(2, strEventCd);
		Map map = (Map) selectMap(sql);
		strAllBrand = map.get("PUMBUN_CD").toString();

		sql.close();

		if (strAllBrand.equals("") || strAllBrand.equals("0")) {
			sql.put(svc.getQuery("SEL_SALE_INFO_ALL"));
		} else {
			sql.put(svc.getQuery("SEL_SALE_INFO"));
		}

		if (!strAllBrand.equals("0")) {
			sql.setString(i++, strStrCd);
			sql.setString(i++, strEventCd);
		}
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDt);
		sql.setString(i++, strPosNo);
		sql.setString(i++, strTranNo);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDt);
		sql.setString(i++, strPosNo);
		sql.setString(i++, strTranNo);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		
		ret[0] = select2List(sql);
		
		sql.close();
		i = 1;
		sql.put(svc.getQuery("SEL_SALECHK"));
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDt);
		sql.setString(i++, strPosNo);
		sql.setString(i++, strTranNo);
		
		ret[1] = select2List(sql);
		return ret;
	}
	
	/**
	 * 영수증 정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getSaleInfo2(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strEventCd = String2.nvl(form.getParam("strEventCd"));
		String strCustId = String2.nvl(form.getParam("strCustId"));
		String strAllBrand = "";

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");

		sql.close();
		sql.put(svc.getQuery("SEL_CHK_ALLBRAND"));
		sql.setString(1, strStrCd);
		sql.setString(2, strEventCd);
		Map map = (Map) selectMap(sql);
		strAllBrand = map.get("PUMBUN_CD").toString();

		sql.close();

		if (strAllBrand.equals("") || strAllBrand.equals("0")) {
			sql.put(svc.getQuery("SEL_SALE_INFO_ALL2"));
		} else {
			sql.put(svc.getQuery("SEL_SALE_INFO2"));
		}

		if (!strAllBrand.equals("0")) {
			sql.setString(i++, strStrCd);
			sql.setString(i++, strEventCd);
		}
		sql.setString(i++, strStrCd);
		sql.setString(i++, strCustId);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strCustId);

		ret = select2List(sql);
		return ret;
	}

	/**
	 * 지급품 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getSkuList(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strEventCd")));
		sql.setString(i++, String2.nvl(form.getParam("strSaleAmtSum")));
		sql.setString(i++, String2.nvl(form.getParam("strSaleAmtSum")));

		strQuery = svc.getQuery("SEL_SKU_LIST") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	public List chkGiftCardNo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 0;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_CHECK_GIFTCARD_NO") + "\n";
		
		sql.put(strQuery);
		String strGiftCardNo = String2.nvl(form.getParam("strGiftCardNo"));	//상품권번호
		sql.setString(++i, strGiftCardNo); 
		ret = select2List(sql);
		return ret;
	}

    public List getGiftCardNo(ActionForm form) throws Exception {

        List		ret = null;
        SqlWrapper	sql = null;
        Service		svc = null;
		String strQuery = "";
		int i = 1;

        connect("pot");
        svc  = (Service)form.getService();
        sql  = new SqlWrapper();

        //화면(JSP)에서 입력된 (조회)파라미터(Paramater)
        strQuery = svc.getQuery("SEL_GIFTCARD_NO") + "\n";
        sql.put(strQuery);
                     
             
        ret = select2List(sql);

        return ret;
    }
	
	/**
	 * 지급품 정보(원가, 대상코드)조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getSkuInfo(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strEventCd")));
		sql.setString(i++, String2.nvl(form.getParam("strSkuCd")));

		strQuery = svc.getQuery("SEL_SKU_INFO") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 고객카드 정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getCardInfo(ActionForm form, String userId) throws Exception {
		List<String> ret = new ArrayList<String>(); 
		ProcedureWrapper psql = null;
		Util util = new Util();
		int i = 1;
		connect("pot");
		psql = new ProcedureWrapper();
		ProcedureResultSet prs = null;
		ArrayList<List> list 	= new ArrayList<List>();
		psql.put("DCS.PR_CUST_QUERY", 57);
		psql.setString(i++, "C"); // P_IN_FLAG 1
		psql.setString(i++, util.encryptedStr(form.getParam("strCardCustId"))); // , P_IN_PARA 2
		psql.setString(i++, userId); // , P_USER_ID 3
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_CUST_NAME 회원성명
															// 4
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_SS_NO 주민번호 5
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_ALIEN_YN 외국인여부  6
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_I_PIN I-PIN 번호  7
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_ZIP_CD1   자택우편번호1 8
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_ZIP_CD2 9
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_ADDR1   자택주소1 10
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_ADDR2 11
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_PH1  자택전화번호 12
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_PH2 13
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_PH3 14
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_MOBILE_PH1  이동전화번호 15
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_MOBILE_PH2 16
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_MOBILE_PH3 17
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_NM 직장명 18
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_ZIP_CD1    직장우편번호1 19
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_ZIP_CD2
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_ADDR1  직장주소1  21
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_ADDR2 22
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_PH1 직장전화번호 23
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_PH2 24
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_PH3  25
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_BIRTH_DT 26
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_LUNAR_FLAG 27
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_CUST_ID 회원ID  28
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_EMAIL_YN  이메일수신동의 29
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_EMAIL_AGREE_DT  이메일수신동의일자   30
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_SMS_YN  SMS수신동의 31
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_SMS_AGREE_DT  SMS수신동의일자  32
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_ENTR_DT  가입일자  33
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_SCED_YN 회원탈퇴여부 34
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_SCED_PROC_DT 회원탈퇴일시 35
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_EMAIL1 이메일주소  36
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_EMAIL2  37
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_WED_YN  38
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_WED_DT  39
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_NOCLS_REQ_YN 이메일주소 1 40
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_CLS_YN 41
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_CLS_YN 42
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HNEW_ZIP_CD1 43
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HNEW_ZIP_CD2 44
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HNEW_ADDR1  45
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HNEW_ADDR2 46
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_NEW_YN 47
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_ONEW_ZIP_CD1  48
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_ONEW_ZIP_CD2 49
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_ONEW_ADDR1 50
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_ONEW_ADDR2  51
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_NEW_YN 52
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_POST_RCV_CD  53
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_CUST_GRADE 54
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_SEX_CD   55
		psql.registerOutParameter(i++, DataTypes.INTEGER); // , O_RETURN 0: 정상   ELSE 오류 56
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , O_MESSAGE 57
		prs = selectProcedure(psql);
		
		ret.add(prs.getString(34));
		ret.add(prs.getString(56));
		ret.add(prs.getString(57));
		ret.add(prs.getString(28));
		list.add(0, ret);
		return list;
	}

	/**
	 * 사은품 지급 내역을 등록 한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	
	public int save(ActionForm form, MultiInput[] mi, String userId)
			throws Exception {
		int ret = 0;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		String strPrsntNo = "";
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			mi[0].next();
			mi[2].next();
			

			sql.close();
			sql.put(svc.getQuery("SEL_PRSNT_NO"));
			Map map = (Map) selectMap(sql);
			strPrsntNo = map.get("PRSNT_NO").toString();
			sql.close();
			// 사은품 지급 등록
			sql.put(svc.getQuery("INS_EVTSKUPRSNT"));
			sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); 		// 지급일
			sql.setString(i++, mi[0].getString("STR_CD")); 						// 점코드
			sql.setString(i++, strPrsntNo); 									// 지급번호
			sql.setString(i++, mi[0].getString("EVENT_CD"));					// 행사코드
			if (String2.nvl(form.getParam("strPrsntFlag")).equals("false")) {
				sql.setString(i++, "1"); 										// 지급구분 1:정상, 2:예외
				sql.setString(i++, mi[2].getString("SKU_CD")); 					// 단품코드
				sql.setString(i++, mi[2].getString("TRG_CD")); 					// 대상범위코드
				sql.setString(i++, mi[2].getString("BUY_COST_PRC")); 			// 지급금액(매입원가)
				sql.setString(i++, ""); 										// 예외지급담당자
				sql.setString(i++, ""); 										// 예외지급 사유
			} else {
				sql.setString(i++, "2"); 										// 지급구분 1:정상, 2:예외
				sql.setString(i++, String2.nvl(form.getParam("strSkuCd"))); 	// 단품코드
				sql.setString(i++, String2.nvl(form.getParam("strTrgCd"))); 	// 대상범위코드
				sql.setString(i++, String2.nvl(form.getParam("strBuyCostPrc"))); // 지급금액
				sql.setString(i++, String2.nvl(form.getParam("strExcpConfId"))); // 예외지급담당자
				sql.setString(i++, String2.nvl(form.getParam("strExcpPrsntRsn"))); // 예외지급
			}
			sql.setString(i++, "1"); 											// 지급 수량
			sql.setString(i++, String2.nvl(form.getParam("strCardCustId"))); 	// 카드회원번호
			sql.setString(i++, String2.nvl(form.getParam("strSaleAmtSum"))); 	// 총인정매출금액
			sql.setString(i++, "1"); 											// 취소구분 1: 정상, 2:취소
			sql.setString(i++, userId); 										// 등록자
			sql.setString(i++, userId); 										// 등록자
			sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));		// 지급일
			sql.setString(i++, mi[0].getString("STR_CD"));						// 점코드
			sql.setString(i++, mi[0].getString("EVENT_CD"));					// 행사코드
			
			res = update(sql);
			if (res != 1) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}

			while (mi[1].next()) {
				if (mi[1].getString("CHK").equals("T")) {
					i = 1;
					sql.close();
					// 사은품 지급 영수증 등록
					sql.put(svc.getQuery("INS_PRSNTRECP"));
					sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); // 지급일
					sql.setString(i++, mi[0].getString("STR_CD")); 				// 점코드
					sql.setString(i++, strPrsntNo); 							// 지급번호
					sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); // 지급일
					sql.setString(i++, mi[0].getString("STR_CD")); 				// 점코드
					sql.setString(i++, strPrsntNo); 							// 지급번호
					sql.setString(i++, mi[1].getString("SALE_DT")); 			// 매출일자
					sql.setString(i++, mi[1].getString("POS_NO")); 				// 포스번호
					sql.setString(i++, mi[1].getString("TRAN_NO"));				// 거래번호
					sql.setString(i++, mi[1].getString("SALE_AMT"));			// 인정매출금액
					sql.setString(i++, mi[1].getString("DIV_AMT")); 			// 지분안분금액
					sql.setString(i++, userId); 								// 등록자
					sql.setString(i++, userId); 								// 수정자
					
					res = update(sql);

					if (res != 1) {
						throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
				}
				ret += res;
			}
			sql.close();
			i = 1;
			// 사은품 지급 브랜드집계 데이터 생성
			sql.put(svc.getQuery("INS_PRSNTPBN"));
			sql.setString(i++, userId); 										// 등록자
			sql.setString(i++, userId); 										// 등록자
			sql.setString(i++, mi[0].getString("STR_CD")); 						// 점코드
			sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); 		// 지급일
			sql.setString(i++, strPrsntNo); 									// 지급번호
			
			res = update(sql);
			if (res == 0) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			sql.close();
			
			while (mi[3].next()) {
				i = 1;
				sql.close();
				// 사은품 지급 영수증 등록
				sql.put(svc.getQuery("INS_EVTSKUGIFTPRSNT"));
				sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));	// 지급일
				sql.setString(i++, mi[0].getString("STR_CD"));					// 점코드
				sql.setString(i++, strPrsntNo);									// 지급번호
				sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));	// 지급일
				sql.setString(i++, mi[0].getString("STR_CD"));					// 점코드
				sql.setString(i++, strPrsntNo);									// 지급번호
				sql.setString(i++, mi[3].getString("GIFTCARD_NO"));				// 상품권번호
				sql.setString(i++, mi[0].getString("EVENT_CD"));				// 행사코드
				sql.setString(i++, mi[2].getString("SKU_CD"));					// 단품코드
				sql.setString(i++, userId);										// 등록자
				sql.setString(i++, userId);										// 수정자
				sql.setString(i++, mi[3].getString("GIFTCERT_AMT"));			// 상품권금액

				res = update(sql);
	
				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
			}
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}	
}
