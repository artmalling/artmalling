/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.dao;
 
import java.util.ArrayList;
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

import common.util.Util;
/**
 * <p>물품 입고/반품 등록</p>
 *  
 * @created  on 1.0, 2010/01/26
 * @created  by 박래형(FUJITSU KOREA LTD.)
 * 
 * @modified on   
 * @modified by    
 * @caused   by    
 */

public class POrd212DAO extends AbstractDAO {    	 
	/**
	 * 규격단품 매입발주 리스트 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getList(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = ""; 
		int i = 1;
				
		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strSlpNo       = String2.nvl(form.getParam("strSlpNo")); 
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_LIST"));  
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlpNo); 
		sql.setString(i++, userId); 
		sql.setString(i++, org_flag); 
		
		ret = select2List(sql);
		return ret;
	}	 
	/**
	 * 규격단품 매입발주 리스트 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getPreslipNo(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = ""; 
		int i = 1;
				
		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strSlpNo       = String2.nvl(form.getParam("strSlpNo")); 
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_CONF_SLIP_NO"));  
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlpNo); 
		sql.setString(i++, userId); 
		sql.setString(i++, org_flag); 
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 *전표출력시 마스터 데이터 저장
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int conf(ActionForm form, String userId)
			throws Exception {

		int ret = 0;
		int res = 0;
		int resp = 0;//프로시저 리턴값
		
		String strStrCd  = "";
		String strSlipNo  = "";		    // 전표번호
		String strSlipFlag ="";
		String strConDt ="";
		String strBotFlag ="";
		
		SqlWrapper sql = null;
		Service svc = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함 
        

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();	//프로시저 사용위함
		    ProcedureResultSet prs = null;
   
		    strSlipNo       = form.getParam("strSlipNo");
			strStrCd        = form.getParam("strStrCd");
			strSlipFlag     = form.getParam("strSlipFlag");
			strConDt        = form.getParam("strConDt");
			strBotFlag      = form.getParam("strBotFlag");
			
			psql.close(); 
			psql = new ProcedureWrapper();
			
	    	psql.put("DPS.PR_POSLPMULTICONF", 8); 
	    	
	    	psql.setString(1,strSlipFlag);     //전표구분
            psql.setString(2,strStrCd);        //점
            psql.setString(3,strSlipNo);       //전표번호
            psql.setString(4,strConDt);       //검품일
            psql.setString(5,strBotFlag);       //공병유무
            psql.setString(6, userId);          //사용자ID
           
            psql.registerOutParameter(7, DataTypes.INTEGER);//7
            psql.registerOutParameter(8, DataTypes.VARCHAR);//8
            prs = updateProcedure(psql);
            
            resp += prs.getInt(7);    

            if (resp != 0) {
                throw new Exception("[USER]" + prs.getString(8));
            }

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return resp;
	}	

	/**  
	 * 
	 * 확정시 단품 매가체크
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List chkAppDtPrice(ActionForm form) throws Exception { 
		String rtCd 			= null;
		int resp                = 0;
		String rtMsg 			= null;
		ArrayList listTemp		= new ArrayList();
		ArrayList list			= new ArrayList();
		ProcedureWrapper psql 	= null;
		ProcedureResultSet prs 	= null;
		try {
        	begin();
            connect("pot");
            psql = new ProcedureWrapper();
			int i=1;
            
			String strStrCd 	= String2.nvl(form.getParam("strStrCd")); 	// 점코드
			String strSlipNo 	= String2.nvl(form.getParam("strSlipNo"));	// 전표번호
			String strSendFlag 	= String2.nvl(form.getParam("strSendFlag"));// 취소구분

			strSendFlag = "CON";
			
		    psql.put("DPS.PR_POSKUPRCCHK", 5); 
			
			psql.setString(i++, strStrCd);
			psql.setString(i++, strSlipNo);
			psql.setString(i++, strSendFlag);
			psql.registerOutParameter(i++, DataTypes.VARCHAR);
			psql.registerOutParameter(i++, DataTypes.VARCHAR);
			prs = updateProcedure(psql);
			
			rtCd = prs.getString(4);
			rtMsg = prs.getString(5);
			
			listTemp.add(rtCd);
			listTemp.add(rtMsg);
			list.add(listTemp);

	        resp += prs.getInt(4);   
	        
		} catch (Exception e) {
			System.out.println("########## Exception :"  + e);
			rollback();
			throw e;
		} finally {
			end();
		}
		return list;
	}

	/**  
	 * 
	 * 확정시품목 마진율 체크
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List chkMgRate(ActionForm form) throws Exception { 
		String rtCd 			= null;
		int resp                = 0;
		String rtMsg 			= null;
		ArrayList listTemp		= new ArrayList();
		ArrayList list			= new ArrayList();
		ProcedureWrapper psql 	= null;
		ProcedureResultSet prs 	= null;
		try {
        	begin();
            connect("pot");
            psql = new ProcedureWrapper();
			int i=1;
            
			String strStrCd 	= String2.nvl(form.getParam("strStrCd")); 	// 점코드
			String strSlipNo 	= String2.nvl(form.getParam("strSlipNo"));	// 전표번호
			String strSendFlag 	= "CON";
			
		    psql.put("DPS.PR_POPBNMGCHK", 5);
			
			psql.setString(i++, strStrCd);
			psql.setString(i++, strSlipNo);
			psql.setString(i++, strSendFlag);
			psql.registerOutParameter(i++, DataTypes.VARCHAR);
			psql.registerOutParameter(i++, DataTypes.VARCHAR);   
			prs   = updateProcedure(psql);
			
			rtCd  = prs.getString(4);
			rtMsg = prs.getString(5);
			
			listTemp.add(rtCd);
			listTemp.add(rtMsg);
			list.add(listTemp);

	        resp += prs.getInt(4);    
	
		} catch (Exception e) {
			System.out.println("########## Exception :"  + e);
			rollback();
			throw e;
		} finally {
			end();
		}
		
		return list;
	}
	
	/**
	 * <p>대금지불 마감 체크 </p>
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List chkPayClose(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd	= String2.nvl(form.getParam("strStrCd"));
		String strVenCd	= String2.nvl(form.getParam("strVenCd"));
		String strChkDt	= String2.nvl(form.getParam("strChkDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strVenCd);
		sql.setString(i++, strChkDt);

		strQuery = svc.getQuery("SEL_PAY_CLOSE_CHK") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}

/**
	 * 재고실사 마감여부
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List chechJgDtFlag(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strChkDt      = String2.nvl(form.getParam("strChkDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strChkDt);

		strQuery = svc.getQuery("SEL_CHK_JG") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
}
