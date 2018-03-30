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
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>긴급매가가격확정</p>
 * 
 * @created  on 1.0, 2010/04/19
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod607DAO extends AbstractDAO {
	
	/**
	 * 긴급매가가격을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, MultiInput mi, String userId, String orgFlag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		mi.next();		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, mi.getString("STR_CD"));		
		sql.setString(i++, mi.getString("PUMBUN_CD"));		
		sql.setString(i++, mi.getString("APP_DT"));		
		
		if(!mi.getString("CONF_YN").equals("%")){			
			strQuery += svc.getQuery("SEL_MASTER_WHERE_CONF_" + mi.getString("CONF_YN") ) + "\n";
		}
		
		if( !mi.getString("SKU_CD").equals("")){			
			sql.setString(i++, mi.getString("SKU_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SKU_CD") + "\n";
		}
		
		if( !mi.getString("SKU_NAME").equals("")){			
			sql.setString(i++, mi.getString("SKU_NAME"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SKU_NAME") + "\n";
		}		
		
		if( !mi.getString("EVENT_CD").equals("")){			
			sql.setString(i++, mi.getString("EVENT_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_EVENT_CD") + "\n";
		}
		
		if( !mi.getString("EVENT_NAME").equals("")){			
			sql.setString(i++, mi.getString("EVENT_NAME"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_EVENT_NAME") + "\n";
		}		
		strQuery += svc.getQuery("SEL_MASTER_ORDER");
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}

	/**
	 * 긴급 단가를 확정한다.
	 * @param form
	 * @param mi
	 * @return
	 */	
	public int conf( ActionForm form, MultiInput mi, String strID) throws Exception{
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int resp = 0;//프로시저 리턴값
		ProcedureWrapper psql = null;	//프로시저 사용위함
		int i;
		try {
			connect("pot");
			begin();
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			
			while (mi.next()) {
				sql.close();
				if ( mi.IS_UPDATE()) {
					
					i = 0;
					// 마진율 유효성체크  MARIO OUTLET START 2011-08-10
				    // 점품번이 특정인 경우에만 해당(임대추가2011-09-07)
					if(mi.getString("BIZ_TYPE").equals("2") || mi.getString("BIZ_TYPE").equals("3")) {
						
						if(mi.getString("EVENT_CD").equals("00000000000")) {
							sql.put(svc.getQuery("SEL_PC_MARGINMST_CHECK"));							
						} else {
							sql.put(svc.getQuery("SEL_PC_MARGINMST_CHECK_HANGSA"));
						}
						
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, mi.getString("SKU_CD"));
						sql.setString(++i, mi.getString("EMG_MG_RATE"));	
						sql.setString(++i, mi.getString("APP_S_DT"));
						
						if(!mi.getString("EVENT_CD").equals("00000000000")) {
							sql.setString(++i, mi.getString("APP_E_DT"));
						}
						
						Map map1 = selectMap( sql );							
						String mgRateCnt = String2.nvl((String)map1.get("CNT"));
						if( mgRateCnt.equals("0")) {
							throw new Exception("[USER]"+"마진율이 적합하지 않습니다.");
						}
					 }
					 // 마진율 유효성체크  MARIO OUTLET END
					sql.close();
					
					i = 0;
					sql.put(svc.getQuery("SEL_EMG_CONF_FLAG"));							
					sql.setString(++i, mi.getString("STR_CD"));					
					sql.setString(++i, mi.getString("SKU_CD"));					
					sql.setString(++i, mi.getString("EVENT_CD"));					
					sql.setString(++i, mi.getString("APP_S_DT"));				
					sql.setString(++i, mi.getString("SEQ_NO"));
					Map map = selectMap( sql );							
					String confFlag = String2.nvl((String)map.get("CONF_FLAG"));
					if( !confFlag.equals("1")) {
						throw new Exception("[USER]"+"("+mi.getString("SKU_CD")+")<br>["+mi.getString("SKU_NAME")+"]<br>확정되어 긴급매가를 확정 할 수 없습니다.");
					}
					sql.close();
					
					i = 0;
					sql.put(svc.getQuery("UPD_EMGPRICE"));
					sql.setString(++i, "2");          // 확정 Flag 값 
					sql.setString(++i, strID);        // 확정한 유저 ID
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("STR_CD"));					
					sql.setString(++i, mi.getString("SKU_CD"));					
					sql.setString(++i, mi.getString("EVENT_CD"));					
					sql.setString(++i, mi.getString("APP_S_DT"));				
					sql.setString(++i, mi.getString("SEQ_NO"));
					
					
				} else {
						
				}
				

				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}

				// POS IFS
				psql.put("DPS.PR_PCEMGPRCPOS_IFS", 8);          // 긴급매가
				
	            psql.setString(1, mi.getString("STR_CD"));      // 점코드
	            psql.setString(2, mi.getString("SKU_CD"));      // 단품코드
	            psql.setString(3, mi.getString("EVENT_CD"));    // 행사코드		            
	            psql.setString(4, mi.getString("APP_S_DT"));    // 적용시작일          
	            psql.setString(5, mi.getString("SEQ_NO"));      // 순번
	            psql.setString(6, strID);                       // 작업자ID
	            psql.registerOutParameter(7, DataTypes.INTEGER);// RETURN결과
	            psql.registerOutParameter(8, DataTypes.VARCHAR);// RETURN메시지
	            
	            prs = updateProcedure(psql);
	            		            
	            resp = prs.getInt(7);
	            if( resp != 0 ){
	            	throw new Exception("[USER]" + prs.getString(8));
	            }

				System.out.println("PR_PCEMGPRCPOS_IFS=============:" + res);
	            
				ret += res;
			}

			res = 0;
			
			System.out.println("INS_ITF_DATA=============:" );
			sql.close();
			i = 0;
			sql.put(svc.getQuery("INS_ITF_DATA"));
			sql.setString(++i, "Z_EVENT");								
			sql.setString(++i, "Z_EVENT");	
			res =+ update(sql);
			System.out.println("INS_ITF_DATA=============:" );
			
			System.out.println("INS_ITF_HEAD=============:" );
			sql.close();
			i = 0;
			sql.put(svc.getQuery("INS_ITF_HEAD"));
			sql.setString(++i, mi.getString("STR_CD"));					
			sql.setString(++i, "Z_EVENT");								
			sql.setString(++i, "Z_EVENT");	

			res =+ update(sql);
			System.out.println("INS_ITF_HEAD=============:" );
			
			if (res != 1) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
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
