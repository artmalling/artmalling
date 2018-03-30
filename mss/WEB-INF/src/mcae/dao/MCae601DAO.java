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
 * <p>사은품 지급 정산</p>
 * 
 * @created  on 1.0, 2011/03/15
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCae601DAO extends AbstractDAO {
	/**
	 * 사은행사 정산 정보 조회
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
		sql.setString(i++, String2.nvl(form.getParam("strEventCd")));

		strQuery = svc.getQuery("SEL_EVENTINFO") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 제휴카드사 정산내역, 물품  정산내역
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getCalInfo(ActionForm form) throws Exception {

		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		connect("pot");
		sql.put(svc.getQuery("SEL_CARDCAL"));
		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strEventCd")));
		ret[0] = select2List(sql);
		i = 1;
		sql.close();
		sql.put(svc.getQuery("SEL_PRSNTCAL"));
		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strEventCd")));
		ret[1] = select2List(sql);

		return ret;
	}
	/**
	 * 정산 재생성
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput[] mi, String userId)
			throws Exception {
		int retP = 0;
		int retG = 0;
		int ret = 0;
		try {
			connect("pot");
			begin();
			// 물품 정산내역
			retP = saveSku(form, mi[0], userId);
    		// 제휴카드사 정산내역
			retG = saveCard(form, mi[1], userId);
			ret = retP + retG;
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	/**
	 * 물품 정산  저장/ 수정
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveSku(ActionForm form, MultiInput mi, String userId)
			throws Exception {
		int ret = 0;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while(mi.next()){
				if(mi.getString("CONF_FLAG").equals("")){ // 확정구분이 없는경우 등록
					sql.close();
					i = 1;
					sql.put(svc.getQuery("INS_EVTSKUCAL"));
					sql.setString(i++, userId); 						// 등록자
					sql.setString(i++, userId); 						// 수정자
					sql.setString(i++, mi.getString("STR_CD")); 		// 점코드
					sql.setString(i++, mi.getString("EVENT_CD")); 		// 행사코드
					sql.setString(i++, mi.getString("VEN_CD")); 		// 협력사 코드
					res = update(sql);
					if (res == 0) {
						throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
				}else if(mi.getString("CONF_FLAG").equals("0")){ // 확정구분이 0 인경우 수정
					sql.close();
					i = 1;
					sql.put(svc.getQuery("UPD_EVTSKUCAL"));
					sql.setString(i++, mi.getString("STR_CD")); 		// 점코드
					sql.setString(i++, mi.getString("EVENT_CD")); 		// 행사코드
					sql.setString(i++, mi.getString("VEN_CD")); 		// 협력사 코드
					sql.setString(i++, userId); 						// 수정자
					sql.setString(i++, mi.getString("STR_CD")); 		// 점코드
					sql.setString(i++, mi.getString("EVENT_CD")); 		// 행사코드
					sql.setString(i++, mi.getString("VEN_CD")); 		// 협력사 코드
					res = update(sql);
					if (res == 0) {
						throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
				}
				ret += res;
			}
		} catch (Exception e) {
			throw e;
		} 
		return ret;
	}
	
	/**
	 * 제휴카드 정산 저장/수정
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveCard(ActionForm form, MultiInput mi, String userId)
			throws Exception {
		int ret = 0;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while(mi.next()){
				if(mi.getString("CONF_FLAG").equals("")){ // 확정구분이 없는경우 등록
					sql.close();
					i = 1;
					sql.put(svc.getQuery("INS_EVTSKUCARDCAL"));
					sql.setString(i++, mi.getString("STR_CD")); 		// 점코드
					sql.setString(i++, mi.getString("EVENT_CD")); 		// 행사코드
					sql.setString(i++, mi.getString("VEN_CD")); 		// 협력사 코드
					sql.setString(i++, mi.getString("CARD_COMP")); 		// 카드사 코드
					sql.setString(i++, mi.getString("PRSNT_PRD_AMT")); 		// 물품정산금액
					sql.setString(i++, mi.getString("PRSNT_GIFT_AMT")); 		// 상품권정산금액
					sql.setString(i++, userId); 						// 등록자
					sql.setString(i++, userId); 						// 수정자
					res = update(sql);
					if (res == 0) {
						throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
				}else if(mi.getString("CONF_FLAG").equals("0")){ // 확정구분이 0 인경우 수정
					sql.close();
					i = 1;
					sql.put(svc.getQuery("UPD_EVTSKUCARDCAL"));
					sql.setString(i++, mi.getString("PRSNT_PRD_AMT")); 		// 물품정산금액
					sql.setString(i++, mi.getString("PRSNT_GIFT_AMT")); 		// 상품권정산금액
					sql.setString(i++, userId); 						// 수정자
					sql.setString(i++, mi.getString("STR_CD")); 		// 점코드
					sql.setString(i++, mi.getString("EVENT_CD")); 		// 행사코드
					sql.setString(i++, mi.getString("VEN_CD")); 		// 협력사 코드
					res = update(sql);
					if (res == 0) {
						throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
				}
				
				ret += res;
			}
		} catch (Exception e) {
			throw e;
		} 
		return ret;
	}
	
	
	/**
	 * 사은행사 정산관리 상세 pop-up
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getEvtSkuStock(ActionForm form) throws Exception {

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
		sql.setString(i++, String2.nvl(form.getParam("strVenCd")));
		
		strQuery = svc.getQuery("SEL_EVTSKUSTOCK") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}

}
