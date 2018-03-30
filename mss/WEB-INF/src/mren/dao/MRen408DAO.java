/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mren.dao;

import java.util.List;

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
* <p>관리비 엑셀 업로드</p>
* 
* @created  on 1.0, 2016.01.05
* @created  by 윤지영(FUJITSU KOREA LTD.)
* 
* @modified on 
* @modified by 
* @caused   by 
*/

public class MRen408DAO extends AbstractDAO {

	/**
	* <p>
	* 관리비 엑셀 업로드 내역 조회
	* </p>
	*/
	@SuppressWarnings("rawtypes")
	public List getMaster(ActionForm form, String userId ) throws Exception {

		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			
			int i = 0;
			
			String strCd 	= String2.nvl(form.getParam("strCd"));	  	// 시설구분
			String strCalym = String2.nvl(form.getParam("strCalym")); 	// 부과년월
			String strLoadDt = String2.nvl(form.getParam("strLoadDt")); // 업로드 일자
			
			sql.put(svc.getQuery("SEL_MASTER"));
			sql.setString(++i, userId);
			sql.setString(++i, strCd);
			sql.setString(++i, strCalym); 
			sql.setString(++i, strLoadDt); 
			
			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	/**
	* <p>
	* 관리비 엑셀 업로드 입금내역 체크
	* </p>
	*/
	public int tempProcess(ActionForm form, MultiInput mi, String userId) throws Exception {
		
		int ret = 0;
		int res = 0;  
		SqlWrapper sql = null; 
		Service svc    = null;
		String retDesc	= "";
		 
		try {
        	begin();
            connect("pot");  
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strCd 	= String2.nvl(form.getParam("strCd"));	    // 시설구분
			String strCalym = String2.nvl(form.getParam("strCalym"));   // 부과년월
			String strLoadDt = String2.nvl(form.getParam("strLoadDt")); // 업로드일자 
			
			int i	= -1; 
			
			sql.close();
			
			// 임대료관리비 입금내역(TEMP)데이터 삭제
			res = delete_Calpay(svc, mi, strCd, strCalym, userId);
			
			if(res < 0) {
				throw new Exception("[USER]"
	                    + "MR_CALPAY_EXCEL 데이터 삭제시 에러가  발생하였습니다."
	                    + "다시 확인하시기 바랍니다."); 
			}
			
			while (mi.next()) { 
				if (mi.IS_INSERT()) { // 저장     
					
					// 임대료관리비 입금내역(TEMP)테이블 저장
					res = insert_Calpay(svc, mi, strCd, strCalym, userId, strLoadDt);
					if(res < 0) {
						throw new Exception("[USER]"
			                    + "MR_CALPAY_EXCEL 데이터 입력시 에러가  발생하였습니다."
			                    + "다시 확인하시기 바랍니다."); 
					} 
				}
			}
			
			// 임대료관리비 입금내역(EXCEL)체크 프로시져
			retDesc = calpayChkData(svc, mi, strCd, strCalym, userId, strLoadDt);
			if(!retDesc.equals("0")) {
	        	throw new Exception(""
	                    +  retDesc);
			} 
			
			if(ret == 0){
				ret = res;        
			}
			
			if (res != 1) {
				throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
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

	/**
	* 임대료관리비 입금내역(TEMP) 삭제
	* 
	* @param form
	* @return
	* @throws Exception
	*/ 
	private int delete_Calpay(Service svc, MultiInput mi, String strCd, String  strCalym, String strUserId) throws Exception {
		String strLoc = "DEL_CALPAY_EXCEL";
		int ret = 0;
		SqlWrapper sql = null;
		sql = new SqlWrapper();		
		sql.put(svc.getQuery(strLoc));
		int i = 1;	  
		 
		sql.setString(i++, strUserId);  //사용자사번     
		
		ret += update(sql); 
		 
		return ret;
	}
	
	/**
	* 임대료관리비 입금내역(TEMP) 등록 
	* 
	* @param form
	* @return
	* @throws Exception
	*/ 
	private int insert_Calpay(Service svc, MultiInput mi, String strCd, String  strCalym, String strUserId, String strLoadDt) throws Exception {
		String strLoc = "INS_CALPAY_EXCEL";
		int ret = 0;
		SqlWrapper sql = null;
		sql = new SqlWrapper();		
		sql.put(svc.getQuery(strLoc));
		int i = 1;	  
		 
		sql.setString(i++, strUserId);  				//사용자사번   
		sql.setString(i++, strUserId);  				//사용자사번  
		sql.setString(i++, strLoadDt);  				//업로드일자  
		sql.setString(i++, strCd); 						//시설구분
		sql.setString(i++, mi.getString("VEN_CD")); 	//협력사코드    
		sql.setString(i++, strCalym);     				//부과년월
		sql.setString(i++, mi.getString("PAY_DT")); 	//입금일자    
		sql.setString(i++, mi.getString("PAY_AMT"));	//입금액
		sql.setString(i++, mi.getString("PAY_ARR_AMT"));//연체금액   
		sql.setString(i++, mi.getString("REMARK"));     //비고
		sql.setString(i++, mi.getString("ERR_MSG"));    //에러메세지
		sql.setString(i++, strUserId);     
		
		ret += update(sql); 
		 
		return ret;
	}
	
	/**
	* 임대료관리비 입금내역 체크 프로사져 호출 
	* 
	* @param form
	* @return
	* @throws Exception
	*/ 
	private String calpayChkData(Service svc, MultiInput mi, String strCd, String  strCalym, String strUserId, String strLoadDt) throws Exception {
		String ret = "";
		ProcedureWrapper psql = null;
		int i = 1;
		connect("pot");
		psql = new ProcedureWrapper();
		ProcedureResultSet prs = null; 
		   
		psql.close();
		psql.put("MSS.PR_CALPAY_EXCEL_CHECK", 6);
		
		psql.setString(1, strCd);
		psql.setString(2, strCalym);
		psql.setString(3, strUserId);
		psql.setString(4, strLoadDt);
		psql.registerOutParameter(5, DataTypes.INTEGER); // return value(에러 // normalYn)
		psql.registerOutParameter(6, DataTypes.VARCHAR);

		prs = updateProcedure(psql);
		ret = prs.getString(5);
		
		System.out.println("MSS.PR_CALPAY_EXCEL_CHECK 프로시저 에러 내역:" + ret);
		
		return ret;
	}
	
	/**
	* <p>
	* 관리비 엑셀 업로드 입금내역 저장 프로사져 호출
	* </p>
	*/
	public int save(ActionForm form, MultiInput mi, String userId) throws Exception {
		
		int ret = 0; 
		SqlWrapper sql = null; 
		Service svc    = null;
		String retDesc	= "";
		 
		try {
        	begin();
            connect("pot");  
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strCd 	= String2.nvl(form.getParam("strCd"));	  	// 시설구분
			String strCalym = String2.nvl(form.getParam("strCalym")); 	// 부과년월
			String strLoadDt = String2.nvl(form.getParam("strLoadDt")); // 업로드일자
			
			int i	= -1; 
			
			sql.close();   
				
			//임대료관리비 입금내역(EXCEL)저장 프로시져
			retDesc = calpaySaveData(svc, mi, strCd, strCalym, userId, strLoadDt);
			if(!retDesc.equals("0")) {
	        	throw new Exception(""
	                    +  retDesc);
			}  
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		
		return ret;
	}
	
	/**
	* 임대료관리비 입금내역 저장 프로사져 호출 
	* 
	* @param form
	* @return
	* @throws Exception
	*/ 
	private String calpaySaveData(Service svc, MultiInput mi, String strCd, String  strCalym, String strUserId, String strLoadDt) throws Exception {
		String ret = "";
		ProcedureWrapper psql = null;
		int i = 1;
		connect("pot");
		psql = new ProcedureWrapper();
		ProcedureResultSet prs = null;

		psql.close();
		psql.put("MSS.PR_CALPAY_EXCEL_SAVE", 6);
		psql.setString(1, strCd);
		psql.setString(2, strCalym);
		psql.setString(3, strUserId);
		psql.setString(4, strLoadDt);
		psql.registerOutParameter(5, DataTypes.INTEGER); // return value(에러 // normalYn)
		psql.registerOutParameter(6, DataTypes.VARCHAR);

		prs = updateProcedure(psql);
		ret = prs.getString(5);
		return ret;
	}	
}
