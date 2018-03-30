/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.util.List;
import java.util.Map;

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
 * 사은품 지급등록(제휴카드)
 * </p>
 * 
 * @created on 1.0, 2011/05/27
 * @created by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MCae431DAO extends AbstractDAO {
	
	/**
	 * 카드 정보 콤보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getCardCombo(ActionForm form) throws Exception {

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
		
		
		strQuery = svc.getQuery("SEL_CARD_COMBO") + "\n";

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
		String strPrsntDt = String2.nvl(form.getParam("strPrsntDt"));
		String strCardComp = String2.nvl(form.getParam("strCardComp"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPrsntDt);
		sql.setString(i++, strCardComp);
		strQuery = svc.getQuery("SEL_EVENT_INFO") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 카드사 콤보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getCardComp(ActionForm form) throws Exception {

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
		strQuery = svc.getQuery("SEL_CARD_COMP") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 영수증 정보 조회 <= 영수증번호사용
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
		String strCardComp = String2.nvl(form.getParam("strCardComp"));
		String strRecpStrCd = String2.nvl(form.getParam("strRecpStrCd"));
		String strAllBrand = "";
		
		connect("pot");
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		sql.close();
		sql.put(svc.getQuery("SEL_CHK_ALLBRAND"));
		sql.setString(1, strStrCd);
		//sql.setString(1, strRecpStrCd);
		sql.setString(2, strEventCd);
		Map map = (Map) selectMap(sql);
		strAllBrand = map.get("PUMBUN_CD").toString();
		
		sql.close();
		
		if(strAllBrand.equals("") || Integer.parseInt(strAllBrand) > 0){
			sql.put(svc.getQuery("SEL_SALE_INFO"));
		}else if(strAllBrand.equals("0")){
			sql.put(svc.getQuery("SEL_SALE_INFO_ALL"));
		}
		// KSH 20120727 
		sql.setString(i++, strStrCd);
		sql.setString(i++, strRecpStrCd);
		sql.setString(i++, strEventCd);

		sql.setString(i++, strStrCd);
		//sql.setString(i++, strRecpStrCd);
		sql.setString(i++, strSaleDt);
		sql.setString(i++, strPosNo);
		sql.setString(i++, strTranNo);
		sql.setString(i++, strCardComp);

		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		
		if(!strAllBrand.equals("0")){
			sql.setString(i++, strStrCd);
			sql.setString(i++, strEventCd);
		}
		
		sql.setString(i++, strStrCd);
		//sql.setString(i++, strRecpStrCd);
		sql.setString(i++, strSaleDt);
		sql.setString(i++, strPosNo);
		sql.setString(i++, strTranNo);

		sql.setString(i++, strStrCd);
		//sql.setString(i++, strRecpStrCd);
		sql.setString(i++, strSaleDt);
		sql.setString(i++, strPosNo);
		sql.setString(i++, strTranNo);
		sql.setString(i++, strCardComp);
		
		sql.setString(i++, strEventCd);  //20141104_강연식 추가 복수행사 가능
		sql.setString(i++, strStrCd);
		sql.setString(i++, strRecpStrCd);
		sql.setString(i++, strSaleDt);
		sql.setString(i++, strPosNo);
		sql.setString(i++, strTranNo);
		
		ret[0] = select2List(sql);
		
		sql.close();
		i = 1;
		sql.put(svc.getQuery("SEL_SALECHK"));
		sql.setString(i++, strStrCd);
		//sql.setString(i++, strRecpStrCd);
		sql.setString(i++, strSaleDt);
		sql.setString(i++, strPosNo);
		sql.setString(i++, strTranNo);
		
		ret[1] = select2List(sql);
		
		return ret;
	}

	/**
	 * 영수증 정보 조회 <= 카드번호사용
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getSaleInfo3(ActionForm form) throws Exception {
	
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strEventCd = String2.nvl(form.getParam("strEventCd"));
		String strCardComp = String2.nvl(form.getParam("strCardComp"));
		String strCardData = String2.nvl(form.getParam("strCardData"));
		String strRecpStrCd = String2.nvl(form.getParam("strRecpStrCd"));
		String strPrsntDt = String2.nvl(form.getParam("strPrsntDt"));
		String strDiffStrCd = String2.nvl(form.getParam("strDiffStrCd"));
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
			sql.put(svc.getQuery("SEL_SALE_INFO_ALL3"));
		} else {
			sql.put(svc.getQuery("SEL_SALE_INFO3"));
		}
		
		//KSH 20120727
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDiffStrCd);
		sql.setString(i++, strEventCd);
		sql.setString(i++, strCardData);
		sql.setString(i++, strPrsntDt);
		sql.setString(i++, strPrsntDt);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		
		if (!strAllBrand.equals("0")) {
			sql.setString(i++, strStrCd);
			sql.setString(i++, strEventCd);
		}
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDiffStrCd);
		sql.setString(i++, strPrsntDt);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDiffStrCd);
		sql.setString(i++, strPrsntDt);
		sql.setString(i++, strCardComp);
		sql.setString(i++, strCardData);

		sql.setString(i++, strEventCd);  //20141104_강연식 추가 복수행사 가능
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDiffStrCd);
		sql.setString(i++, strPrsntDt);
		
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
	public String getCardInfo(ActionForm form) throws Exception {
		String ret = "";
		ProcedureWrapper psql = null;
		int i = 1;
		connect("pot");
		psql = new ProcedureWrapper();
		ProcedureResultSet prs = null;

		psql.close();
		psql.put("MSS.PR_MCDCARDCHECK", 4);
		psql.setString(1, form.getParam("strStrCd"));
		psql.setString(2, form.getParam("strCardCustId"));
		psql.registerOutParameter(3, DataTypes.VARCHAR); // return value(에러
															// normalYn)
		psql.registerOutParameter(4, DataTypes.VARCHAR);

		prs = selectProcedure(psql);
		ret = prs.getString(3);
		return ret;
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
			sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); // 지급일
			sql.setString(i++, mi[0].getString("STR_CD")); // 점코드
			sql.setString(i++, strPrsntNo); // 지급번호
			sql.setString(i++, mi[0].getString("EVENT_CD")); // 행사코드
			if (String2.nvl(form.getParam("strPrsntFlag")).equals("false")) {
				sql.setString(i++, "1"); // 지급구분 1:정상, 2:예외
				sql.setString(i++, mi[2].getString("SKU_CD")); // 단품코드
				sql.setString(i++, mi[2].getString("TRG_CD")); // 대상범위코드
				sql.setString(i++, mi[2].getString("BUY_COST_PRC")); // 지급금액(매입원가)
				sql.setString(i++, ""); // 예외지급담당자
				sql.setString(i++, ""); // 예외지급 사유
			} else {
				sql.setString(i++, "2"); // 지급구분 1:정상, 2:예외
				sql.setString(i++, String2.nvl(form.getParam("strSkuCd"))); // 단품코드
				sql.setString(i++, String2.nvl(form.getParam("strTrgCd"))); // 대상범위코드
				sql.setString(i++, String2.nvl(form.getParam("strBuyCostPrc"))); // 지급금액
				sql.setString(i++, String2.nvl(form.getParam("strExcpConfId"))); // 예외지급담당자
				sql.setString(i++, String2.nvl(form.getParam("strExcpPrsntRsn"))); // 예외지급
			}
			sql.setString(i++, "1"); // 지급 수량
			sql.setString(i++, String2.nvl(form.getParam("strCardCustId"))); // 카드회원번호
			sql.setString(i++, String2.nvl(form.getParam("strSaleAmtSum"))); // 총인정매출금액
			sql.setString(i++, "1"); // 취소구분 1: 정상, 2:취소
			sql.setString(i++, userId); // 등록자
			sql.setString(i++, userId); // 등록자
			sql.setString(i++, String2.nvl(form.getParam("strCardData")));
			sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));		// 지급일
			sql.setString(i++, mi[0].getString("STR_CD"));						// 점코드
			sql.setString(i++, mi[0].getString("EVENT_CD"));					// 행사코드
			
			sql.setString(i++, String2.nvl(form.getParam("strCardCustId"))); // 카드회원번호
			sql.setString(i++, String2.nvl(form.getParam("strCardCustId"))); // 카드회원번호
			
			res = update(sql);
			if (res != 1) {
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			
			while (mi[1].next()) {
				if (mi[1].getString("CHK").equals("T")) {
					i = 1;
					sql.close();
					// 사은품 지급 영수증 등록
					sql.put(svc.getQuery("INS_PRSNTRECP"));
					sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); // 지급일
					sql.setString(i++, mi[0].getString("STR_CD")); // 점코드
					sql.setString(i++, strPrsntNo); // 지급번호
					sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); // 지급일
					sql.setString(i++, mi[0].getString("STR_CD")); // 점코드
					sql.setString(i++, strPrsntNo); // 지급번호
					sql.setString(i++, mi[1].getString("SALE_DT")); // 매출일자
					sql.setString(i++, mi[1].getString("POS_NO")); // 포스번호
					sql.setString(i++, mi[1].getString("TRAN_NO")); // 거래번호
					sql.setString(i++, String2.nvl(form.getParam("strCardComp"))); // 카드사 정보
					sql.setString(i++, mi[1].getString("SALE_AMT")); // 인정매출금액
					sql.setString(i++, mi[1].getString("DIV_AMT")); // 지분안분금액
					sql.setString(i++, userId); // 등록자
					sql.setString(i++, userId); // 수정자
					res = update(sql);

					if (res != 1) {
						throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
				}
				ret += res;
			}
			sql.close();
			i = 1;
			// 사은품 지급 브랜드집계 데이터 생성
			sql.put(svc.getQuery("INS_PRSNTPBN"));
			sql.setString(i++, userId); // 등록자
			sql.setString(i++, userId); // 등록자
			sql.setString(i++, mi[0].getString("STR_CD")); // 점코드
			sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); // 지급일
			sql.setString(i++, strPrsntNo); // 지급번호
			res = update(sql);
			if (res == 0) {
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
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
