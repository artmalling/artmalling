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
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCae304DAO extends AbstractDAO {
	/**
	 * 사은 행사  정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getEvtInfo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strEventSDt = String2.nvl(form.getParam("strEventSDt"));
		String strEventEDt = String2.nvl(form.getParam("strEventEDt"));
		String strEventCd = String2.nvl(form.getParam("strEventCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_EVTINFO") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventSDt);
		sql.setString(i++, strEventSDt);
		sql.setString(i++, strEventEDt);
		sql.setString(i++, strEventEDt);
		sql.setString(i++, strEventSDt);
		sql.setString(i++, strEventEDt);
		sql.setString(i++, strEventSDt);
		sql.setString(i++, strEventEDt);
		sql.setString(i++, strEventCd);
		
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	
	/**
	 * 사은 행사 상품권 불출내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftInoutList(ActionForm form) throws Exception {
		
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
		strQuery = svc.getQuery("SEL_GIFTINOUTINFO") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 사은 행사 상품권 불출 상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftInoutMst(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		sql.put(svc.getQuery("SEL_MASTER"));
		sql.setString(i++, String2.nvl(form.getParam("strInOutDt")));
		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strSlipNo")));
		sql.setString(i++, String2.nvl(form.getParam("strInoutFlag")));
		sql.setString(i++, String2.nvl(form.getParam("strEventCd")));
		sql.setString(i++, String2.nvl(form.getParam("strEventCd")));
		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strInOutDt")));
		sql.setString(i++, String2.nvl(form.getParam("strSlipNo")));
		sql.setString(i++, String2.nvl(form.getParam("strEventCd")));
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 사은 행사 상품권 불출 상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftInoutDtl(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;
		
		String strSlipNo = String2.nvl(form.getParam("strSlipNo"));
		String strInoutDt = String2.nvl(form.getParam("strInoutDt"));
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strEventCd = String2.nvl(form.getParam("strEventCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		
		sql.put(svc.getQuery("SEL_DETAIL"));
		sql.setString(i++, strSlipNo);
		sql.setString(i++, strInoutDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 사은행사 상품권 불출 / 반납 등록
	 * @param svc 
	 * @param mi 
	 * @param userId 
	 * 
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput[] mi, String userId)
			throws Exception {
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		String strSlipNo = "";
		
		try {
			connect("pot");
			begin();
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			mi[0].next();
			if(mi[0].getString("SLIP_NO").equals("")){ // 전표번호가 없는경우  신규 전표번호 조회 해옴
				
				sql.put(svc.getQuery("SEL_SLIP_NO"));
				sql.setString(i++, mi[0].getString("INOUT_DT"));
				sql.setString(i++, mi[0].getString("STR_CD"));
				Map map = (Map)selectMap(sql);
				strSlipNo = map.get("SLIP_NO").toString();
				sql.close();
			}else{
				strSlipNo = mi[0].getString("SLIP_NO");
			}
			while(mi[1].next()){  
				sql.close();
				i = 1;
				
					if(mi[1].getString("SEQ_NO").equals("")){ // 순번이 없는 경우 insert
						if(mi[1].getString("QTY").equals("") || mi[1].getString("QTY").equals("0")) continue;
							sql.put(svc.getQuery("INS_GIFTINOUT")); 
							sql.setString(i++, mi[0].getString("INOUT_DT"));
							sql.setString(i++, mi[0].getString("STR_CD"));
							sql.setString(i++, strSlipNo);
							sql.setString(i++, mi[0].getString("INOUT_DT"));
							sql.setString(i++, mi[0].getString("STR_CD"));
							sql.setString(i++, strSlipNo);
							sql.setString(i++, mi[0].getString("EVENT_CD"));
							sql.setString(i++, mi[0].getString("INOUT_FLAG"));
							sql.setString(i++, mi[1].getString("SKU_CD"));
							sql.setString(i++, mi[0].getString("DESK_CHAR_ID"));
							sql.setString(i++, mi[1].getString("BUY_COST_PRC"));
							sql.setString(i++, mi[1].getString("QTY"));
							sql.setString(i++, userId);
							sql.setString(i++, userId);
					}else{ // 순번이 있는경우 update
						sql.put(svc.getQuery("UPD_GIFTINOUT")); 
						sql.setString(i++, mi[0].getString("DESK_CHAR_ID"));
						sql.setString(i++, mi[1].getString("QTY"));
						sql.setString(i++, userId);
						sql.setString(i++, mi[0].getString("INOUT_DT"));
						sql.setString(i++, mi[0].getString("STR_CD"));
						sql.setString(i++, mi[0].getString("SLIP_NO"));
						sql.setString(i++, mi[1].getString("SEQ_NO"));
					}
					res = update(sql);
					if (res != 1) {
						throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
			}
		} catch (Exception e) {
			rollback();
			throw e;
		}finally {
			end();
		}
		return res;
	}

}
