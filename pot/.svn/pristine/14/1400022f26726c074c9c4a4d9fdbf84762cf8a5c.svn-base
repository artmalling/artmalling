/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>실시간로그인현황</p>
 *  
 * @created  on 1.0, 2010/06/23
 * @created  by HSEON(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class TCom304DAO extends AbstractDAO { 

	/**
	 *  실시간로그인현황을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectList(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	 

        try { 
 
			String strOrgFlag = String2.nvl(form.getParam("strOrgFlag"));	//조직코드
			String strStrCd   = String2.nvl(form.getParam("strStrCd"));		//점코드 	
			String strDeptCd  = String2.nvl(form.getParam("strDeptCd"));	//부문코드
			String strTeamCd  = String2.nvl(form.getParam("strTeamCd"));	//팀코드
			String strPcCd    = String2.nvl(form.getParam("strPcCd"));		//PC코드 
			/*
			System.out.println( "--------------------------strOrgFlag  ===> " + strOrgFlag );
			System.out.println( "--------------------------strStrCd    ===> " + strStrCd   );
			System.out.println( "--------------------------strDeptCd   ===> " + strDeptCd  );
			System.out.println( "--------------------------strTeamCd   ===> " + strTeamCd  );
			System.out.println( "--------------------------strPcCd     ===> " + strPcCd    );
			*/
			sql = new SqlWrapper();
			svc = (Service) form.getService();
	
			connect("pot");
			
			strQuery = svc.getQuery("SEL_USER_LIST") + "\n";

			if( !strOrgFlag.equals("%")){
				sql.setString(i++, strOrgFlag);
				strQuery += svc.getQuery("SEL_USER_WHERE_ORG_FLAG") + "\n";
			}
			
			if( !strStrCd.equals("%")){
				sql.setString(i++, strStrCd);
				strQuery += svc.getQuery("SEL_USER_WHERE_STR_CD") + "\n";
			}
			
			if( !strDeptCd.equals("%")){
				sql.setString(i++, strDeptCd);
				strQuery += svc.getQuery("SEL_USER_WHERE_DEPT_CD") + "\n";
			}
			
			if( !strTeamCd.equals("%")){
				sql.setString(i++, strTeamCd);
				strQuery += svc.getQuery("SEL_USER_WHERE_TEAM_CD") + "\n";
			}
			
			if( !strPcCd.equals("%")){
				sql.setString(i++, strPcCd);
				strQuery += svc.getQuery("SEL_USER_WHERE_PC_CD") + "\n";
			} 
			
			strQuery += svc.getQuery("SEL_USER_ORDER");
			sql.put(strQuery); 
			
			list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}

	/**
	 *  사용자 로그인이력을 보여준다.
	 *  POPUP
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectLogHistory(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	 

        try { 
			String strUserId = String2.nvl(form.getParam("strUserId"));	//사용자id 
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
	
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper(); 

			sql.put(svc.getQuery("SEL_LOG_HISTORY"));
			sql.setString(1, strUserId);  
			
			list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}
}
