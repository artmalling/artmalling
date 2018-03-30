/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dcom.dao;

import javax.servlet.http.HttpSession;

import common.vo.SessionInfo;

import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;



/**
 * <p>포인트 강제적립/차감</p>
 * 
 * @created  on 1.0, 2010/01/25
 * @created  by 남형석
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DComDAO extends AbstractDAO {


	/**
	 * <p>포인트 강제적립/차감 내역 저장</p>
	 * 
	 * @created  on 1.0, 2010/01/25
	 * @created  by 남형석
	 * 
	 * @modified on 
	 * @modified by 
	 * @caused   by 
	 */
	
	public ProcedureResultSet saveData (String para1,String para2,int para3,String para4) throws Exception {
		int 		ret = 0;
        SqlWrapper  sql = null;
        ProcedureWrapper psql = null;
        Service     svc = null;

        try {
        	if( getTrConnection() == null){
        	    begin();
                connect("pot");
        	}
            sql  = new   SqlWrapper();
            psql = new ProcedureWrapper();
			int i=1;
			
			psql.put("DCS.PR_SOCKET_TEST", 4);
			
			psql.setString(i++, para1);
			psql.setString(i++, para2);
			psql.setInt(i++, para3);
			psql.setString(i++, para4);
			
			//psql.registerOutParameter(++i, DataTypes.VARCHAR);//5
			//psql.registerOutParameter(++i, DataTypes.VARCHAR);//6
			//psql.registerOutParameter(++i, DataTypes.INTEGER);//7
			//psql.registerOutParameter(++i, DataTypes.VARCHAR);//8
			
			return updateProcedure(psql);
			//getString(8)
		
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null)
				end();
		}
		
	}	

	/**
	 * <p>로그 쌓이기</p>
	 * 
	 * @created  on 1.0, 2010/01/25
	 * @created  by 남형석
	 * 
	 * @modified on 
	 * @modified by 
	 * @caused   by 
	 */
	
	public ProcedureResultSet logSave (String logGubun, String para1,String para2,String para3,String para4,String para5) throws Exception {
		
		int 		ret = 0;
        SqlWrapper  sql = null;
        ProcedureWrapper psql = null;
        Service     svc = null;
        ProcedureResultSet proset = null; 

        try {
        	if( getTrConnection() == null){
                connect("pot");
        	    begin();
        	}
            sql  = new   SqlWrapper();
            psql = new ProcedureWrapper();
			int i=1;
			if(logGubun.equals("S")){
			    psql.put("DCS.PR_TBL_SHIST_INSERT", 7);
			}else{
				psql.put("DCS.PR_TBL_UHIST_INSERT", 7);
			}
			
			psql.setString(i++, para1);
			psql.setString(i++, para2);
			psql.setString(i++, para3);
			psql.setString(i++, para4);
			psql.setString(i++, para5);
			
			psql.registerOutParameter(i++, DataTypes.INTEGER);//
			psql.registerOutParameter(i++, DataTypes.VARCHAR);//
			proset = updateProcedure(psql);
			System.out.println(proset.getString(7));
			return proset;
			
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null || logGubun.equals("S"))
				end();
		}
	}
	
}
