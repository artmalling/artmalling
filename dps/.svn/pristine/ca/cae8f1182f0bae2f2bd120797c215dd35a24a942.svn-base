/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.util.List;
import java.util.Map;


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>점별행사단품관리</p>
 * 
 * @created  on 1.0, 2010/04/28
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod706DAO extends AbstractDAO {


	/**
	 * 행사를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchEvtmst(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strEventCd    = String2.nvl(form.getParam("strEventCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_EVTMST") + "\n";	
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 점별행사단품을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String strID, String orgFlag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strEventCd     = String2.nvl(form.getParam("strEventCd"));
		String strPumbunCd    = String2.nvl(form.getParam("strPumbunCd"));


		connect("pot");
		
		strQuery = svc.getQuery("SEL_STREVTSKU")+ "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		
		
		if(("").equals(strPumbunCd)){
			sql.setString(i++, "%");
		} else {
			sql.setString(i++, strPumbunCd);
		}
		
		sql.setString(i++, strID);
		sql.setString(i++, orgFlag);

		strQuery += svc.getQuery("SEL_STREVTSKU_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}	
	/**
	 * 점별행사단품을 복사 내용을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCopyData(ActionForm form, String strID, String orgFlag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strEventCd     = String2.nvl(form.getParam("strEventCd"));
		String strPumbunCd    = String2.nvl(form.getParam("strPumbunCd"));
		String strSkuType     = String2.nvl(form.getParam("strSkuType"));
		String strBizType     = String2.nvl(form.getParam("strBizType"));
		String strFromStrCd   = String2.nvl(form.getParam("strFromStrCd"));
		String strFromEventCd = String2.nvl(form.getParam("strFromEventCd"));


		connect("pot");
		
		strQuery = svc.getQuery("SEL_STREVTSKU_COPY");
		sql.setString(i++, strFromStrCd);
		sql.setString(i++, strFromEventCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		if(!strPumbunCd.equals("")) { 
			sql.setString(i++, strPumbunCd);
		} else {
			sql.setString(i++, "%");
		}
		sql.setString(i++, strID);
		sql.setString(i++, orgFlag);

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}	
	/**
	 * 점별행사단품, 점별단품가격마스터
	 * 저장, 수정, 삭제  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strID)
			throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		Map map = null;
		int i;
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strEventCd    = String2.nvl(form.getParam("strEventCd"));
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));
		String strEventSDt   = String2.nvl(form.getParam("strEventSDt"));
		String strEventEDt   = String2.nvl(form.getParam("strEventEDt"));
		
		String eventSDt      = "";
		String pumbunCd     = "";
		try {
			connect("pot");
			begin();
			String flag;
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			// 점별행사품번
			while (mi[0].next()) {
				sql.close();
				if ( mi[0].IS_INSERT()) {	
					
					i = 1;
					sql.put(svc.getQuery("SEL_STREVTPBN_CHECK"));				
					sql.setString(i++, strStrCd);
					sql.setString(i++, mi[0].getString("PUMBUN_CD"));
					sql.setString(i++, strEventCd);
					sql.setString(i++, strEventSDt);
					map = selectMap( sql );		
					String pumbunCnt = String2.nvl((String)map.get("CNT"));
					
					System.out.println(pumbunCnt);
					
					if(!pumbunCnt.equals("1")) {
						sql.close();
						i = 1;
						sql.put(svc.getQuery("INS_STREVTPBN"));	
						sql.setString(i++, strStrCd);
	                    sql.setString(i++, mi[0].getString("PUMBUN_CD"));
	                    sql.setString(i++, strEventCd);
	                    sql.setString(i++, strEventSDt);
	                    sql.setString(i++, strEventEDt);
	                    sql.setString(i++, strEventEDt);            // MOD_E_DT
	                    sql.setString(i++, strID);
	                    sql.setString(i++, strID);
	                    // 점별행사품번 등록
	    				res = update(sql);
					} else {
						continue;
					}
				}else{
					continue;						
				}

				
				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다." );
				}
				
				ret += res;
			}
			// 점별행사단품, 점별단품가격마스터 
			while (mi[1].next()) {
				sql.close();
				if ( mi[1].IS_INSERT()) {	
					flag = "I";
					i = 1;
					sql.put(svc.getQuery("SEL_STREVTSKU_DUP_CNT"));					
					sql.setString(i++, mi[1].getString("STR_CD"));
					sql.setString(i++, mi[1].getString("SKU_CD"));
					sql.setString(i++, mi[1].getString("APP_S_DT"));
					sql.setString(i++, mi[1].getString("APP_E_DT"));	
					map = selectMap( sql );		
					String regCnt = String2.nvl((String)map.get("CNT"));
					if( !regCnt.equals("0")) {
						throw new Exception("[USER]"+" [ "+ mi[1].getString("SKU_CD") + " ]의 중복되는 기간이 존재합니다.");
					}
					sql.close();
					
					
					// 마진율 유효성체크  MARIO OUTLET START 2011-08-11
					// 점품번이 특정인 경우에만 해당
					if(mi[1].getString("BIZ_TYPE").equals("2")) {
						i = 1;
						sql.put(svc.getQuery("SEL_PC_MARGINMST_CHECK"));	

						sql.setString(i++, mi[1].getString("STR_CD"));	
						sql.setString(i++, mi[1].getString("SKU_CD"));
						sql.setString(i++, mi[1].getString("EVENT_MG_RATE"));	
						sql.setString(i++, mi[1].getString("APP_S_DT"));
						sql.setString(i++, mi[1].getString("APP_E_DT"));

						Map map1 = selectMap( sql );							
						String mgRateCnt = String2.nvl((String)map1.get("CNT"));
						if( mgRateCnt.equals("0")) {
							throw new Exception("[USER]"+mi[1].getString("EVENT_MG_RATE") + "% 마진율이 적합하지 않습니다.");
						}
						sql.close();
					}
					// 마진율 유효성체크  MARIO OUTLET END
					
					i = 1;			
					sql.put(svc.getQuery("INS_STREVTSKU"));	
					sql.setString(i++, mi[1].getString("STR_CD"));
                    sql.setString(i++, mi[1].getString("SKU_CD"));
                    sql.setString(i++, mi[1].getString("EVENT_CD"));
                    sql.setString(i++, mi[1].getString("APP_S_DT"));
                    sql.setString(i++, mi[1].getString("APP_E_DT"));
                    sql.setString(i++, mi[1].getString("APP_E_DT"));             // MOD_E_DT
                    sql.setString(i++, mi[1].getString("REDU_RATE"));        
                    sql.setString(i++, mi[1].getString("NORM_COST_PRC"));
                    sql.setString(i++, mi[1].getString("NORM_SALE_PRC"));
                    sql.setString(i++, mi[1].getString("NORM_MG_RATE"));
                    sql.setString(i++, mi[1].getString("EVENT_COST_PRC"));
                    sql.setString(i++, mi[1].getString("EVENT_PRICE"));
                    sql.setString(i++, mi[1].getString("EVENT_MG_RATE"));
                    sql.setString(i++, mi[1].getString("LIMIT_SALE_QTY"));
                    sql.setString(i++, mi[1].getString("DC_DIV_RATE"));
                    sql.setString(i++, mi[1].getString("CPN_ISSUE_QTY"));
                    sql.setString(i++, mi[1].getString("CPN_BARCODE"));
                    sql.setString(i++, "");                                   // EVENT_PLACE_CD
                    sql.setString(i++, "1");                                  // CONF_FLAG
                    sql.setString(i++, "");                                   // CONF_DATE
                    sql.setString(i++, "");                                   // CONF_ID
                    sql.setString(i++, "");                                   // REMARK
                    sql.setString(i++, "");                                   // PROC_FLAG
                    sql.setString(i++, strID);
                    sql.setString(i++, strID);
                    
                    // 점별행사단품 등록
    				res = update(sql);
    				

                    
				}else if ( mi[1].IS_UPDATE()) {	
					flag = "U";
					i = 1;
					sql.put(svc.getQuery("SEL_STREVTSKU_DUP_CNT"));				
					sql.setString(i++, mi[1].getString("STR_CD"));
					sql.setString(i++, mi[1].getString("SKU_CD"));
					sql.setString(i++, mi[1].getString("APP_S_DT"));
					sql.setString(i++, mi[1].getString("APP_E_DT"));	
					map = selectMap( sql );		
					String regCnt = String2.nvl((String)map.get("CNT"));
					if( !regCnt.equals("1")) {
						throw new Exception("[USER]"+" [ "+ mi[1].getString("SKU_CD") + " ]의 중복되는 기간이 존재합니다.");
					}
					sql.close();
					i = 1;
					sql.put(svc.getQuery("SEL_STREVTSKU_CONF_YN"));				
					sql.setString(i++, mi[1].getString("STR_CD"));
					sql.setString(i++, mi[1].getString("SKU_CD"));
					sql.setString(i++, mi[1].getString("EVENT_CD"));
					sql.setString(i++, mi[1].getString("APP_S_DT"));
					map = selectMap( sql );		
					String confFlag = String2.nvl((String)map.get("CONF_FLAG"));
					if( !confFlag.equals("1")) {
						throw new Exception("[USER]"+" [ "+ mi[1].getString("SKU_CD") + " ] 이미 확정된 데이터 입니다.");
					}
					sql.close();
					i = 1;			
					sql.put(svc.getQuery("UPD_STREVTSKU"));	
                    sql.setString(i++, mi[1].getString("APP_E_DT"));
                    sql.setString(i++, mi[1].getString("REDU_RATE"));        
                    sql.setString(i++, mi[1].getString("NORM_COST_PRC"));
                    sql.setString(i++, mi[1].getString("NORM_SALE_PRC"));
                    sql.setString(i++, mi[1].getString("NORM_MG_RATE"));
                    sql.setString(i++, mi[1].getString("EVENT_COST_PRC"));
                    sql.setString(i++, mi[1].getString("EVENT_PRICE"));
                    sql.setString(i++, mi[1].getString("EVENT_MG_RATE"));
                    sql.setString(i++, mi[1].getString("LIMIT_SALE_QTY"));
                    sql.setString(i++, mi[1].getString("DC_DIV_RATE"));
                    sql.setString(i++, mi[1].getString("CPN_ISSUE_QTY"));
                    sql.setString(i++, mi[1].getString("CPN_BARCODE"));
                    sql.setString(i++, strID);
					sql.setString(i++, mi[1].getString("STR_CD"));
                    sql.setString(i++, mi[1].getString("SKU_CD"));
                    sql.setString(i++, mi[1].getString("EVENT_CD"));
                    sql.setString(i++, mi[1].getString("APP_S_DT"));
                    // 점별행사단품 수정
    				res = update(sql);
    				

				}else if ( mi[1].IS_DELETE()) {	
					flag = "D";
					i = 1;
					sql.put(svc.getQuery("SEL_STREVTSKU_CONF_YN"));				
					sql.setString(i++, mi[1].getString("STR_CD"));
					sql.setString(i++, mi[1].getString("SKU_CD"));
					sql.setString(i++, mi[1].getString("EVENT_CD"));
					sql.setString(i++, mi[1].getString("APP_S_DT"));
					map = selectMap( sql );		
					String confFlag = String2.nvl((String)map.get("CONF_FLAG"));
					if( !confFlag.equals("1")) {
						throw new Exception("[USER]"+" [ "+ mi[1].getString("SKU_CD") + " ] 이미 확정된 데이터 입니다.");
					}
					sql.close();
					i = 1;			
					sql.put(svc.getQuery("DEL_STREVTSKU"));
					sql.setString(i++, mi[1].getString("STR_CD"));
                    sql.setString(i++, mi[1].getString("SKU_CD"));
                    sql.setString(i++, mi[1].getString("EVENT_CD"));
                    sql.setString(i++, mi[1].getString("APP_S_DT"));
                    // 점별행사단품 삭제
					res = update(sql);
    				
                    eventSDt =  mi[1].getString("APP_S_DT");
                    pumbunCd =  mi[1].getString("PUMBUN_CD");
                    
					
				} else {
					continue;	
				}

				if (res != 1) {
					String msg = "데이터 입력을 하지 못했습니다.";
					if( flag.equals("D")){
						msg = "데이터 삭제을 하지 못했습니다.";
					}
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ msg );
				}
				
				ret += res;
			}

			// 단품이 삭제되서거나 행사계획의 값이 변경되었을 때 실행 
			// 단품이 존재하지 않고 행사계획매출액 과 이익액이 0원일 경우 삭제
			if(!eventSDt.equals("")){
				sql.close();
				i = 1;			
				sql.put(svc.getQuery("SEL_STREVTPBN_DEL_YN"));					
				sql.setString(i++, strStrCd);
				sql.setString(i++, pumbunCd);
				sql.setString(i++, strEventCd);
				sql.setString(i++, eventSDt);	
				sql.setString(i++, strStrCd);
				sql.setString(i++, pumbunCd);
				sql.setString(i++, strEventCd);
				sql.setString(i++, eventSDt);	
				map = selectMap( sql );		
				String delYn = String2.nvl((String)map.get("DEL_YN"));
				if( delYn.equals("Y")) {
					sql.close();
					i = 1;			
					sql.put(svc.getQuery("DEL_STREVTPBN"));		
					sql.setString(i++, strStrCd);
					sql.setString(i++, pumbunCd);
					sql.setString(i++, strEventCd);
					sql.setString(i++, eventSDt);	
                    // 점별품번마스터 삭제
    				update(sql);
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
