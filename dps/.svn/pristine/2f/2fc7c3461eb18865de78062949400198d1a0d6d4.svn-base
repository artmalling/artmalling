/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
//import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>점별행사품번관리</p>
 * 
 * @created  on 1.0, 2010/04/27
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod705DAO extends AbstractDAO {


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
	 * 점별행사품번을 조회한다.
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
		String strPumbunName  = URLDecoder.decode(String2.nvl(form.getParam("strPumbunName")), "UTF-8");


		connect("pot");
		
		strQuery = svc.getQuery("SEL_STREVTPBN")+ "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		sql.setString(i++, strID);
		sql.setString(i++, orgFlag);
		
		
		if( !strPumbunCd.equals("")){
			sql.setString(i++, strPumbunCd);
			strQuery += svc.getQuery("SEL_STREVTPBN_WHERE_PUMBUN_CD") + "\n";
		}

		if( !strPumbunName.equals("")){
			sql.setString(i++, strPumbunName);
			strQuery += svc.getQuery("SEL_STREVTPBN_WHERE_PUMBUN_NAME") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_STREVTPBN_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}	
	/**
	 * 점별행사품번, 마진마스터
	 * 저장, 수정, 삭제  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		Map map = null;
		int i;
		try {
			connect("pot");
			begin();
			String flag;
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				sql.close();
				if ( mi.IS_INSERT()) {	
					flag = "I";
					i = 1;
					sql.put(svc.getQuery("SEL_STREVTPBN_DUP_CNT"));					
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("PUMBUN_CD"));
					sql.setString(i++, mi.getString("EVENT_FLAG"));
					sql.setString(i++, mi.getString("EVENT_RATE"));
					sql.setString(i++, mi.getString("APP_S_DT"));
					sql.setString(i++, mi.getString("APP_E_DT"));	
					map = selectMap( sql );		
					String regCnt = String2.nvl((String)map.get("CNT"));
					if( !regCnt.equals("0")) {
						throw new Exception("[USER]"+" [ "+ mi.getString("PUMBUN_CD") + " ]의 중복되는 기간이 존재합니다.");
					}
					sql.close();
					i = 1;			
					sql.put(svc.getQuery("INS_STREVTPBN"));	
					sql.setString(i++, mi.getString("STR_CD"));
                    sql.setString(i++, mi.getString("PUMBUN_CD"));
                    sql.setString(i++, "********");                           // PUMMOK_CD
                    sql.setString(i++, mi.getString("EVENT_CD"));
                    sql.setString(i++, mi.getString("EVENT_FLAG"));
                    sql.setString(i++, mi.getString("EVENT_RATE"));
                    sql.setString(i++, mi.getString("APP_S_DT"));
                    sql.setString(i++, mi.getString("APP_E_DT"));
                    sql.setString(i++, mi.getString("APP_E_DT"));             // MOD_E_DT
                    sql.setString(i++, mi.getString("EVENT_RATE"));           // REDU_RATE
                    sql.setString(i++, mi.getString("NORM_MG_RATE"));
                    sql.setString(i++, mi.getString("EVENT_MG_RATE"));
                    sql.setString(i++, mi.getString("SKU_FLAG"));
                    sql.setString(i++, mi.getString("GOAL_SALE_AMT"));
                    sql.setString(i++, mi.getString("GOAL_PROF_AMT"));
                    sql.setString(i++, mi.getString("LIMIT_SALE_QTY"));
                    sql.setString(i++, mi.getString("DC_DIV_RATE"));
                    sql.setString(i++, mi.getString("CPN_ISSUE_QTY"));
                    sql.setString(i++, mi.getString("CPN_BARCODE"));
                    sql.setString(i++, "");                                   // EVENT_PLACE_CD
                    sql.setString(i++, "1");                                  // CONF_FLAG
                    sql.setString(i++, "");                                   // CONF_DATE
                    sql.setString(i++, "");                                   // CONF_ID
                    sql.setString(i++, "");                                   // PROC_FLAG
                    sql.setString(i++, strID);
                    sql.setString(i++, strID);
                    // 점별행사품번 등록
    				res = update(sql);

                    
				}else if ( mi.IS_UPDATE()) {	
					flag = "U";
					i = 1;
					sql.put(svc.getQuery("SEL_STREVTPBN_DUP_CNT"));				
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("PUMBUN_CD"));
					sql.setString(i++, mi.getString("EVENT_FLAG"));
					sql.setString(i++, mi.getString("EVENT_RATE"));
					sql.setString(i++, mi.getString("APP_S_DT"));
					sql.setString(i++, mi.getString("APP_E_DT"));	
					map = selectMap( sql );		
					String regCnt = String2.nvl((String)map.get("CNT"));
					if( !regCnt.equals("1")) {
						throw new Exception("[USER]"+" [ "+ mi.getString("PUMBUN_CD") + " ]의 중복되는 기간이 존재합니다.");
					}
					sql.close();
					i = 1;
					sql.put(svc.getQuery("SEL_STREVTPBN_CONF_YN"));				
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("PUMBUN_CD"));
					sql.setString(i++, mi.getString("EVENT_CD"));
					sql.setString(i++, mi.getString("EVENT_FLAG"));
					sql.setString(i++, mi.getString("EVENT_RATE"));
					sql.setString(i++, mi.getString("APP_S_DT"));
					map = selectMap( sql );		
					String confFlag = String2.nvl((String)map.get("CONF_FLAG"));
					if( !confFlag.equals("1")) {
						throw new Exception("[USER]"+" [ "+ mi.getString("PUMBUN_CD") + " ] 이미 확정된 데이터 입니다.");
					}
					sql.close();
					i = 1;			
					sql.put(svc.getQuery("UPD_STREVTPBN"));	
                    sql.setString(i++, mi.getString("APP_E_DT"));
                    sql.setString(i++, mi.getString("NORM_MG_RATE"));
                    sql.setString(i++, mi.getString("EVENT_MG_RATE"));
                    sql.setString(i++, mi.getString("GOAL_SALE_AMT"));
                    sql.setString(i++, mi.getString("GOAL_PROF_AMT"));
                    sql.setString(i++, mi.getString("LIMIT_SALE_QTY"));
                    sql.setString(i++, mi.getString("DC_DIV_RATE"));
                    sql.setString(i++, mi.getString("CPN_ISSUE_QTY"));
                    sql.setString(i++, mi.getString("CPN_BARCODE"));
                    sql.setString(i++, strID);
					sql.setString(i++, mi.getString("STR_CD"));
                    sql.setString(i++, mi.getString("PUMBUN_CD"));
                    sql.setString(i++, mi.getString("EVENT_CD"));
                    sql.setString(i++, mi.getString("EVENT_FLAG"));
                    sql.setString(i++, mi.getString("EVENT_RATE"));
                    sql.setString(i++, mi.getString("APP_S_DT"));
                    // 점별행사품번 수정
    				res = update(sql);
    				

				}else if ( mi.IS_DELETE()) {	
					flag = "D";
					i = 1;
					sql.put(svc.getQuery("SEL_STREVTPBN_CONF_YN"));				
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("PUMBUN_CD"));
					sql.setString(i++, mi.getString("EVENT_CD"));
					sql.setString(i++, mi.getString("EVENT_FLAG"));
					sql.setString(i++, mi.getString("EVENT_RATE"));
					sql.setString(i++, mi.getString("APP_S_DT"));
					map = selectMap( sql );		
					String confFlag = String2.nvl((String)map.get("CONF_FLAG"));
					if( !confFlag.equals("1")) {
						throw new Exception("[USER]"+" [ "+ mi.getString("PUMBUN_CD") + " ] 이미 확정된 데이터 입니다.");
					}
					sql.close();
					i = 1;			
					sql.put(svc.getQuery("DEL_STREVTPBN"));
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("PUMBUN_CD"));
					sql.setString(i++, mi.getString("EVENT_CD"));
					sql.setString(i++, mi.getString("EVENT_FLAG"));
					sql.setString(i++, mi.getString("EVENT_RATE"));
					sql.setString(i++, mi.getString("APP_S_DT"));
                    // 점별행사품번 삭제
					res = update(sql);
    				
					
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
			

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}		
		return ret;
	}
}
