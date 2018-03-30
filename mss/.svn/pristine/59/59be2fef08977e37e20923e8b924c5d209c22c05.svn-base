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
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>
 * 사은품 지급 취소
 * </p>
 * 
 * @created on 1.0, 2011/03/10
 * @created by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MCae402DAO extends AbstractDAO {
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
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strSaleDt")));
		sql.setString(i++, String2.nvl(form.getParam("strPosNo")));
		sql.setString(i++, String2.nvl(form.getParam("strTranNo")));

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
	 * 사은품 지급 취소 : 사은품 지급 내용 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getPrsntInfo(ActionForm form) throws Exception {

		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		connect("pot");
		if(form.getParam("strEventType").equals("02")){
			sql.put(svc.getQuery("SEL_PRSNT_INFO_CARD"));
			sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
			sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));
			sql.setString(i++, String2.nvl(form.getParam("strPrsntNo")));
			sql.setString(i++, String2.nvl(form.getParam("strEventCd")));
			sql.setString(i++, String2.nvl(form.getParam("strCardComp")));
		}else{
			sql.put(svc.getQuery("SEL_PRSNT_INFO"));
			sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
			sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));
			sql.setString(i++, String2.nvl(form.getParam("strPrsntNo")));
			sql.setString(i++, String2.nvl(form.getParam("strEventCd")));
		}
		ret[0] = select2List(sql);
		
		i = 1;
		sql.close();
		sql.put(svc.getQuery("SEL_PRSNTRECP_INFO"));
		sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));
		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strPrsntNo")));
		ret[1] = select2List(sql);

		return ret;
	}

	/**
	 * 사은품 지급 취소 내역을 등록 한다.
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

			// 사은품 지급 원전표 취소 UPDATE
			sql.close();
			i = 1;
			sql.put(svc.getQuery("UPD_EVTSKUPRSNT"));
			sql.setString(i++, userId); // 수정자
			sql.setString(i++, mi[0].getString("PRSNT_DT")); // 지급일
			sql.setString(i++, mi[0].getString("STR_CD")); // 점코드
			sql.setString(i++, mi[0].getString("PRSNT_NO")); // 지급번호
			res = update(sql);
			if (res != 1) {
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			
			// 브랜드집계 데이터 생성 테이블 취소 구분 update
			sql.close();
			i = 1;
			sql.put(svc.getQuery("UPD_PRSNTPBN"));
			sql.setString(i++, userId); // 수정자
			sql.setString(i++, mi[0].getString("PRSNT_DT")); // 지급일
			sql.setString(i++, mi[0].getString("STR_CD")); // 점코드
			sql.setString(i++, mi[0].getString("PRSNT_NO")); // 지급번호
			res = update(sql);
			if (res == 0) {
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			
			// 취소 사은품 지급 지급번호 발번
			sql.close();
			sql.put(svc.getQuery("SEL_PRSNT_NO"));
			Map map = (Map) selectMap(sql);
			strPrsntNo = map.get("PRSNT_NO").toString();
			if (strPrsntNo.equals("")) {
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}

			// 사은품 지급 취소 등록
			sql.close();
			i = 1;
			sql.put(svc.getQuery("INS_EVTSKUPRSNT"));
			sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); // 지급취소일
			sql.setString(i++, mi[2].getString("STR_CD")); // 점코드
			sql.setString(i++, strPrsntNo); // 지급번호
			sql.setString(i++, mi[2].getString("EVENT_CD")); // 행사코드
			if(form.getParam("strPrsntFlag").equals("1")){
				sql.setString(i++, "4"); // 지급구분 1:정상, 2:예외, 4:지급취소, 7:예외지급취소
			}else if(form.getParam("strPrsntFlag").equals("2")){
				sql.setString(i++, "7"); // 지급구분 1:정상, 2:예외, 4:지급취소, 7:예외지급취소
			}
			sql.setString(i++, mi[2].getString("SKU_CD")); // 단품코드
			sql.setString(i++, mi[2].getString("TRG_CD")); // 대상범위코드
			sql.setString(i++, mi[2].getString("PRSNT_AMT")); // 지급금액
			sql.setString(i++, mi[2].getString("EXCP_CONF_ID")); // 예외지급담당자
			sql.setString(i++, mi[2].getString("EXCP_PRSNT_RSN")); // 예외지급 사유
			sql.setString(i++, "1"); // 지급 수량
			sql.setString(i++, 
					mi[2].getString("PRSNT_DT") + mi[2].getString("STR_CD")
							+ mi[2].getString("PRSNT_NO")); // 원전표 번호
			sql.setString(i++, mi[2].getString("CARD_CUST_ID")); // 카드회원번호
			sql.setString(i++, mi[2].getString("TOT_SALE_AMT")); // 총인정매출금액
			sql.setString(i++, "1"); // 취소구분 1: 정상, 2: 취소
			sql.setString(i++, userId); // 수정자
			sql.setString(i++, userId); // 등록자

			sql.setString(i++,mi[2].getString("PRSNT_NO")); // 원전표 번호
			sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); // 지급취소일
			sql.setString(i++, mi[2].getString("STR_CD")); // 점코드
			sql.setString(i++,mi[2].getString("PRSNT_NO")); // 원전표 번호
			sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); // 지급취소일
			sql.setString(i++, mi[2].getString("STR_CD")); // 점코드
			sql.setString(i++,mi[2].getString("PRSNT_NO")); // 원전표 번호
			sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); // 지급취소일
			sql.setString(i++, mi[2].getString("STR_CD")); // 점코드
			sql.setString(i++,mi[2].getString("PRSNT_NO")); // 원전표 번호
			sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); // 지급취소일
			sql.setString(i++, mi[2].getString("STR_CD")); // 점코드
			
			res = update(sql);
			if (res != 1) {
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			mi[1].next();
			i = 1;
			sql.close();
			// 사은품 지급 영수증 등록
			sql.put(svc.getQuery("INS_PRSNTRECP"));
			sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); // 지급
																			// 취소일
			sql.setString(i++, strPrsntNo); // 지급번호
			sql.setString(i++, userId); // 수정자
			sql.setString(i++, userId); // 등록자
			sql.setString(i++, mi[1].getString("PRSNT_DT")); // 지급일
			sql.setString(i++, mi[1].getString("STR_CD")); // 점코드
			sql.setString(i++, mi[1].getString("PRSNT_NO")); // 지급번호
			res = update(sql);
			if (res == 0) {
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
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
