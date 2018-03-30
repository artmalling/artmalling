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
import java.util.List;
import java.util.Map;


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>행사확정 </p>
 * 
 * @created  on 1.0, 2010/05/09
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod709DAO extends AbstractDAO {


	/**
	 * 행사를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strEventCd    = String2.nvl(form.getParam("strEventCd"));
		String strPumbunCd    = String2.nvl(form.getParam("strPumbunCd"));
		String strEventPluFlag    = String2.nvl(form.getParam("strEventPluFlag"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		if(strEventPluFlag.equals("1")){
			
			strQuery = svc.getQuery("SEL_EVTMST_PBN") + "\n";	
			sql.setString(i++, strStrCd);
			sql.setString(i++, strEventCd);
			sql.put(strQuery);
			
		}else if(strEventPluFlag.equals("2")){

			strQuery = svc.getQuery("SEL_EVTMST_SKU") + "\n";	
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strEventCd);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strEventCd);
			sql.put(strQuery);
		}

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
	public List searchStrSkuEvt(ActionForm form, String strID, String orgFlag) throws Exception {
		
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
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strID);
		sql.setString(i++, orgFlag);

		strQuery += svc.getQuery("SEL_STREVTSKU_ORDER");
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
	public List searchStrPbnEvt(ActionForm form, String strID, String orgFlag) throws Exception {
		
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
	 * 행사확정 한다.
	 * 
	 * @param form
	 * @param mi 
	 * @return
	 */	
	public int conf( ActionForm form, MultiInput paramMi[], String strID) throws Exception{
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		MultiInput mi = null;
		int i;
		try {
			connect("pot");
			begin();

			String strStrCd           = String2.nvl(form.getParam("strStrCd"));
			String strEventCd         = String2.nvl(form.getParam("strEventCd"));
			String strPumbunCd        = String2.nvl(form.getParam("strPumbunCd"));
			String strEventPluFlag    = String2.nvl(form.getParam("strEventPluFlag"));
			String strEventSDt        = String2.nvl(form.getParam("strEventSDt"));
			String strConfFlag        = String2.nvl(form.getParam("strConfFlag"));

			if(strEventPluFlag.equals("1")){
				mi = paramMi[0];
			}else if(strEventPluFlag.equals("2")){
				mi = paramMi[1];				
			}else{
				throw new Exception("[USER]"+"단품행사 또는 품번행사가 아닙니다.");
			}
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi.next()) {
				sql.close();
				if ( mi.IS_UPDATE()) {
					i = 0;
					
					// 품번 행사
					if(strEventPluFlag.equals("1")){
						
						if(mi.getString("CONF_YN").equals("T")){
							sql.put(svc.getQuery("INS_MARGINMST"));	
							sql.setString(++i, mi.getString("STR_CD"));
							sql.setString(++i, mi.getString("PUMBUN_CD"));
		                    sql.setString(++i, "********");                           // PUMMOK_CD
							sql.setString(++i, mi.getString("EVENT_CD"));
							sql.setString(++i, mi.getString("EVENT_FLAG"));
							sql.setString(++i, mi.getString("EVENT_RATE"));
							sql.setString(++i, mi.getString("APP_S_DT"));
							sql.setString(++i, mi.getString("APP_E_DT"));
		                    sql.setString(++i, mi.getString("EVENT_RATE"));           // REDU_RATE
							sql.setString(++i, mi.getString("NORM_MG_RATE"));
							sql.setString(++i, mi.getString("EVENT_MG_RATE"));
							sql.setString(++i, mi.getString("MG_FLAG"));      
		                    sql.setString(++i, "");                                   // PROC_FLAG
		                    sql.setString(++i, strID);
		                    sql.setString(++i, strID);
		                    // 마진마스터 등록
		    				update(sql);							
						}else{	
							sql.put(svc.getQuery("DEL_MARGINMST"));
							sql.setString(++i, mi.getString("STR_CD"));
							sql.setString(++i, mi.getString("PUMBUN_CD"));
							sql.setString(++i, mi.getString("EVENT_CD"));
							sql.setString(++i, mi.getString("EVENT_FLAG"));
							sql.setString(++i, mi.getString("EVENT_RATE"));
							sql.setString(++i, mi.getString("APP_S_DT"));
		                    // 마진마스터 삭제
		    				update(sql);
						}
						sql.close();
						i = 0;			
						String conFlag = mi.getString("CONF_YN").equals("T")?"2":"1";  // 확정(2),미확정(1) Flag 값 
						sql.put(svc.getQuery("UPD_STREVTPBN"));
						sql.setString(++i, conFlag);        
						// 확정일 
						sql.setString(++i, conFlag);        
						// 확정자
						sql.setString(++i, conFlag);        
						sql.setString(++i, strID);        // 확정한 유저 ID
						
						sql.setString(++i, strID);
						sql.setString(++i, mi.getString("STR_CD"));					
						sql.setString(++i, mi.getString("PUMBUN_CD"));					
						sql.setString(++i, mi.getString("EVENT_CD"));					
						sql.setString(++i, mi.getString("EVENT_FLAG"));					
						sql.setString(++i, mi.getString("EVENT_RATE"));				
						sql.setString(++i, mi.getString("APP_S_DT"));
						
					// 단품행사
					}else if(strEventPluFlag.equals("2")){
						
						
						// 마진율 유효성체크  MARIO OUTLET START 2011-08-11
						// 점품번이 특정인 경우에만 해당(임대추가2011-09-07)
						if(mi.getString("BIZ_TYPE").equals("2") || mi.getString("BIZ_TYPE").equals("3")) {
							i = 0;
							sql.put(svc.getQuery("SEL_PC_MARGINMST_CHECK"));	

							sql.setString(++i, mi.getString("STR_CD"));	
							sql.setString(++i, mi.getString("SKU_CD"));
							sql.setString(++i, mi.getString("EVENT_MG_RATE"));	
							sql.setString(++i, mi.getString("APP_S_DT"));
							sql.setString(++i, mi.getString("APP_E_DT"));

							Map map1 = selectMap( sql );							
							String mgRateCnt = String2.nvl((String)map1.get("CNT"));
							if( mgRateCnt.equals("0")) {
								throw new Exception("[USER]"+mi.getString("EVENT_MG_RATE") + "% 마진율이 적합하지 않습니다.");
							}
							sql.close();
						}
						// 마진율 유효성체크  MARIO OUTLET END
						
						i = 0;
						if(mi.getString("CONF_YN").equals("T")){
							sql.put(svc.getQuery("INS_STRSKUPRCMST"));	
							sql.setString(++i, mi.getString("STR_CD"));
							sql.setString(++i, mi.getString("SKU_CD"));
							sql.setString(++i, mi.getString("EVENT_CD"));
							sql.setString(++i, mi.getString("APP_S_DT"));
							sql.setString(++i, mi.getString("APP_E_DT"));      
		                    sql.setString(++i, mi.getString("NORM_COST_PRC"));
		                    sql.setString(++i, mi.getString("NORM_SALE_PRC"));
		                    sql.setString(++i, mi.getString("NORM_MG_RATE"));
		                    sql.setString(++i, mi.getString("EVENT_COST_PRC"));
		                    sql.setString(++i, mi.getString("EVENT_PRICE"));
		                    sql.setString(++i, mi.getString("EVENT_MG_RATE"));
		                    sql.setString(++i, mi.getString("REDU_RATE"));          
		                    sql.setString(++i, "");                                   // PROC_FLAG
		                    sql.setString(++i, "");                                   // ISSUE_FLAG
		                    sql.setString(++i, strID);
		                    sql.setString(++i, strID);
		                    // 점별단품가격마스터 등록
		    				update(sql);						
						}else{	
							sql.put(svc.getQuery("DEL_STRSKUPRCMST"));
							sql.setString(++i, mi.getString("STR_CD"));
		                    sql.setString(++i, mi.getString("SKU_CD"));
		                    sql.setString(++i, mi.getString("EVENT_CD"));
		                    sql.setString(++i, mi.getString("APP_S_DT"));
		                    // 점별단품가격마스터 삭제
		    				update(sql);
						}
						sql.close();
						i = 0;			
						String conFlag = mi.getString("CONF_YN").equals("T")?"2":"1";  // 확정(2),미확정(1) Flag 값 
						sql.put(svc.getQuery("UPD_STREVTSKU"));
						sql.setString(++i, conFlag);        
						// 확정일 
						sql.setString(++i, conFlag);        
						// 확정자
						sql.setString(++i, conFlag);        
						sql.setString(++i, strID);        // 확정한 유저 ID
						
						sql.setString(++i, strID);
						sql.setString(++i, mi.getString("STR_CD"));					
						sql.setString(++i, mi.getString("SKU_CD"));					
						sql.setString(++i, mi.getString("EVENT_CD"));					
						sql.setString(++i, mi.getString("APP_S_DT"));	
					}				
					
				} else {
					continue;
				}
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}

				ret += res;
			}
			
			// 단품 행사일 경우 품번행사의 행사계획을 확정
			if(strEventPluFlag.equals("2")){
				sql.close();
				i = 0;
				// 단품의 확정된 수 조회
				sql.put(svc.getQuery("SEL_STREVTSKU_CONF_CNT"));							
				sql.setString(++i, strStrCd);					
				sql.setString(++i, strPumbunCd);					
				sql.setString(++i, strEventCd);					
				sql.setString(++i, strEventSDt);	
				Map map = selectMap( sql );							
				String confCnt = String2.nvl((String)map.get("CNT"));

				boolean updateYn = false;
				// 품번행사가 확정 되었는데 단품이 모두 미확정 일 경우 미확정
				// 품번행사가 확정 되지 않았는데 단품이 1개 이상 확정 되었을 경우 확정
				if( (strConfFlag.equals("Y")&&confCnt.equals("0"))
						||(strConfFlag.equals("N")&&!confCnt.equals("0"))){
					updateYn = true;
				}
				
				if(updateYn){
					sql.close();
					i = 0;

					String conFlag = mi.getString("CONF_YN").equals("T")?"2":"1";  // 확정(2),미확정(1) Flag 값 
					sql.put(svc.getQuery("UPD_STREVTPBN"));
					sql.setString(++i, conFlag);        
					// 확정일 
					sql.setString(++i, conFlag);        
					// 확정자
					sql.setString(++i, conFlag);        
					sql.setString(++i, strID);        // 확정한 유저 ID
					
					sql.setString(++i, strID);						
					sql.setString(++i, strStrCd);					
					sql.setString(++i, strPumbunCd);					
					sql.setString(++i, strEventCd);					
					sql.setString(++i, "00");					
					sql.setString(++i, "00");					
					sql.setString(++i, strEventSDt);
					
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
