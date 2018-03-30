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
 * <p>타임아웃관리  </p>
 * 
 * @created  on 1.0, 2010/07/05
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCodA01DAO extends AbstractDAO {

	/**
	 * 마스터 을 조회한다.
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
	    
		String strStrCd          = String2.nvl(form.getParam("strStrCd"));
		String strCloseTaskFlag  = String2.nvl(form.getParam("strCloseTaskFlag"));
		String strCloseFlag      = String2.nvl(form.getParam("strCloseFlag"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_TIMEOUT") + "\n";
		sql.setString(i++, strStrCd);

		if( !strCloseTaskFlag.equals("%")){
			sql.setString(i++, strCloseTaskFlag);
			strQuery += svc.getQuery("SEL_TIMEOUT_WHERE_CLOSE_TASK_FLAG") + "\n";
			
		}
		if( !strCloseFlag.equals("%")){
			sql.setString(i++, strCloseFlag);
			strQuery += svc.getQuery("SEL_TIMEOUT_WHERE_CLOSE_FLAG") + "\n";
			
		}
		
		strQuery += svc.getQuery("SEL_TIMEOUT_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 타임아웃
	 * 저장, 수정  처리한다.
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
			String flag = "";
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				sql.close();				
				if ( mi.IS_INSERT()) {
					flag = "I";
					sql.put(svc.getQuery("SEL_STR_CLOSE_UNIT_FLAG_CNT"));							
					sql.setString(1,  mi.getString("STR_CD"));										
					sql.setString(2,  mi.getString("CLOSE_UNIT_FLAG"));						
					map = selectMap( sql );							
					String cnt = String2.nvl((String)map.get("CNT"));
					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"[ "+ mi.getString("CLOSE_UNIT_FLAG")+"] 이미 등록된 마감단위업무 입니다.");
					}
					sql.close();
					i = 0;
					sql.put(svc.getQuery("INS_TIMEOUT"));
					sql.setString( ++i, mi.getString("STR_CD"         ));
					sql.setString( ++i, mi.getString("CLOSE_TASK_FLAG"));
					sql.setString( ++i, mi.getString("CLOSE_UNIT_FLAG"));
					sql.setString( ++i, mi.getString("CLOSE_UNIT_NAME"));
					sql.setString( ++i, mi.getString("CLOSE_FLAG"     ));
					sql.setString( ++i, mi.getString("SAP_CLOSE_FLAG" ));
					sql.setString( ++i, mi.getString("MCLOSE_PROC_YN" ));
					sql.setString( ++i, mi.getString("E_DAY"          ));
					sql.setString( ++i, mi.getString("E_TIME"         ));
					sql.setString( ++i, mi.getString("REMARK"         ));
					sql.setString( ++i, strID);
					sql.setString( ++i, strID);
					
				} else if (mi.IS_UPDATE()){
					flag = "U";
					i = 0;						
					sql.put(svc.getQuery("UPD_TIMEOUT"));
					sql.setString( ++i, mi.getString("CLOSE_UNIT_NAME" ));
					sql.setString( ++i, mi.getString("CLOSE_FLAG"      ));
					sql.setString( ++i, mi.getString("SAP_CLOSE_FLAG"  ));
					sql.setString( ++i, mi.getString("MCLOSE_PROC_YN" ));
					sql.setString( ++i, mi.getString("E_DAY"           ));
					sql.setString( ++i, mi.getString("E_TIME"          ));
					sql.setString( ++i, mi.getString("REMARK"          ));
					sql.setString( ++i, strID);
					sql.setString( ++i, mi.getString("STR_CD"          ));
					sql.setString( ++i, mi.getString("CLOSE_TASK_FLAG" ));
					sql.setString( ++i, mi.getString("CLOSE_UNIT_FLAG" ));
				} else {
					continue;
				}
				
				res = update(sql);

				if (res != 1) {
					String tmpMsg = "데이터 입력을 하지 못했습니다.";
					if(flag.equals("D"))
						tmpMsg = "데이터 삭제를 하지 못했습니다.";
						
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ tmpMsg);
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
