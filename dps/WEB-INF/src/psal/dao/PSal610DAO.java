/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import common.util.Util;
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
 * <p>무인정산자료 비교표</p>
 * 
 * @created  on 1.0, 2016/10/27
 * @created  by 박래형
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal610DAO extends AbstractDAO {

	/**
	 * 무인정산자료 비교표 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String strId) throws Exception {
		
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strQuery = "";
		int i = 0;	
		
		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strSaleDt      = String2.nvl(form.getParam("strSaleDt"));
		String strSaleEndDt   = String2.nvl(form.getParam("strSaleEndDt"));
		String strPosNo       = String2.nvl(form.getParam("strPosNo"));
		String strRdGubun     = String2.nvl(form.getParam("strRdGubun"));
		String strChkGrp      = String2.nvl(form.getParam("strChkGrp"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		if (strRdGubun.equals("1")) {
			if (strChkGrp.equals("1"))
				strQuery = svc.getQuery("SEL_MASTER_GRPDAY") + "\n";
			else
				strQuery = svc.getQuery("SEL_MASTER_DAY") + "\n";
		} else {
			if (strChkGrp.equals("1")) {
				strQuery = svc.getQuery("SEL_MASTER_GRP") + "\n";
				sql.setString(++i, strSaleDt);
				sql.setString(++i, strSaleEndDt);
			} else { 
				strQuery = svc.getQuery("SEL_MASTER") + "\n";
				sql.setString(++i, strSaleDt);
				sql.setString(++i, strSaleEndDt);
			}
		}
			
		
		sql.setString(++i, strStrCd);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strSaleDt);
		sql.setString(++i, strSaleEndDt);
		sql.setString(++i, strPosNo);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strSaleDt);
		sql.setString(++i, strSaleEndDt);
		sql.setString(++i, strPosNo);
//		sql.setString(++i, strId);
		sql.put(strQuery);

		ret = select2List(sql);
		return ret;
	}

	/**
	 * 무인정산자료 비교표 상세조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form, String strId) throws Exception {
		
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;                         
		String strQuery = "";
		int i = 0;	
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strStrDt = String2.nvl(form.getParam("strStrDt"));
		String strEndDt = String2.nvl(form.getParam("strEndDt"));
		String strPosNo = String2.nvl(form.getParam("strPosNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.setString(++i, strStrCd);
		sql.setString(++i, strStrDt);
		sql.setString(++i, strEndDt);
		sql.setString(++i, strPosNo);
		sql.put(strQuery);

		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 무인정산자료 비교표 상세조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List chkProcess(ActionForm form, String strId) throws Exception {
		
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;                         
		String strQuery = "";
		int i = 0;	
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strProcDt = String2.nvl(form.getParam("strDate"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		strQuery = svc.getQuery("SEL_DATE") + "\n";
		sql.setString(++i, strStrCd);
		sql.setString(++i, strProcDt);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strProcDt);
		sql.put(strQuery);
		
		ret = select2List(sql);
		commit();
		
		return ret;
	}
	
	/**
	 *  공제 회계전송
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public String runProcess(ActionForm form, MultiInput mi1, String userId, String org_flag)
			throws Exception {

		int resp    		= 0;     //프로시저 리턴값
		String res          = "";
		int i   			= 0;
		
		Service svc           = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		try {
			System.out.println("try");
			connect("pot");
			begin();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;

			String strStrCd = String2.nvl(form.getParam("strStrCd"));
			String strDate  = String2.nvl(form.getParam("strDate"));
			String strGb	= String2.nvl(form.getParam("strGb"));
			
			
			//mi1.next();
			i = 1;
			psql.put("DPS.PR_PSVALEX_CUR_IFS_M", 5);
			
		     
            psql.setString(i++, strStrCd); 		// 점코드
            psql.setString(i++, strDate);		// 처리일자
            psql.setString(i++, strGb);			// 처리구분
            psql.registerOutParameter(i++, DataTypes.INTEGER);	// 4
            psql.registerOutParameter(i++, DataTypes.VARCHAR);	// 5
            System.out.println("procdure call");
            prs = updateProcedure(psql);
            System.out.println(prs);
            resp += prs.getInt(4);    
            if (resp != 0) {
                throw new Exception("[USER]"+ prs.getString(5));
            }else{
            	res = prs.getString(5);
            }
			
            commit();
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return res;
	}
	
	/**
	 * 무인정산자료 비교표 해당 일자 내역 유무를 조회.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List chkValexData(ActionForm form, String strId) throws Exception {
		
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;                         
		String strQuery = "";
		int i = 0;	
		
		String strStr = String2.nvl(form.getParam("strStr"));
		String strDt = String2.nvl(form.getParam("strDt"));
		String strPos = String2.nvl(form.getParam("strPos"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		strQuery = svc.getQuery("SEL_CHKDATA") + "\n";
		sql.setString(++i, strStr);
		sql.setString(++i, strDt);
		sql.setString(++i, strPos);
		sql.put(strQuery);
		
		ret = select2List(sql);
		
		return ret;
	}
	
	/**
	 * 정산기 내역 저장.
	 * 
	 * @param form
	 * @param mi[]
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strID)
			throws Exception {

		int res 		= 0;
		int i			= 0;
		//SqlWrapper sql 	= null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		ProcedureResultSet prs = null;
		//Service svc 	= null;

		
		String strStrCd 	= "";		// 점코드
		String strSaleDt 	= "";		// 일자
		String strPosNo 	= "";		// POS/PDA 번호
		String strCalCd 	= "";		// 정산 구분
		Integer nCalAmt		= 0;		// 정산 금액
		//String strBigo 	    = URLDecoder.decode("", "UTF-8");  
		String strBigo 	    = "";		// 비고

		try {
			connect("pot");
			begin();
			//sql = new SqlWrapper();
			//svc = (Service) form.getService();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			
			//System.out.println("2");
			while (mi[0].next()) {//DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
				psql.close();
				//System.out.println("3");
				strStrCd = mi[0].getString("STR_CD");
				strSaleDt = mi[0].getString("SALE_DT");
				strPosNo = mi[0].getString("POS_NO");
				strCalCd = mi[0].getString("CAL_CD");
				nCalAmt = mi[0].getInt("CAL_AMT");
				strBigo = URLDecoder.decode(mi[0].getString("BIGO"), "UTF-8");
				i = 1;
				
				if (mi[0].IS_INSERT()) { // 입력
					psql.put("DPS.PR_PSVALEX_MODIF", 10);
					psql.setString(i++, strStrCd);
					psql.setString(i++, strSaleDt);
					psql.setString(i++, strPosNo);
					psql.setString(i++, strCalCd);
					psql.setInt(i++, nCalAmt);
					psql.setString(i++, strID);
					psql.setString(i++, strBigo);
					psql.setString(i++, "I");
		            psql.registerOutParameter(i++, DataTypes.INTEGER);
		            psql.registerOutParameter(i++, DataTypes.VARCHAR);
	
		            
		            prs = updateProcedure(psql);
					
	                if (prs.getInt(9) != 0) {
	                	throw new Exception("[USER-정산내역 입력에 실패하였습니다."+ prs.getString(10) + "]");
	                }else{
	                	res ++;
	                }
	                
	    			if (res == 0) {
	    				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
	    						+ "데이터 입력을 하지 못했습니다.["+strStrCd+strSaleDt+strPosNo+strCalCd+"I"+"]");
	    			}

				} else if (mi[0].IS_UPDATE()) {
					
					psql.put("DPS.PR_PSVALEX_MODIF", 10);
					psql.setString(i++, strStrCd);
					psql.setString(i++, strSaleDt);
					psql.setString(i++, strPosNo);
					psql.setString(i++, strCalCd);
					psql.setInt(i++, nCalAmt);
					psql.setString(i++, strID);
					psql.setString(i++, strBigo);
					psql.setString(i++, "U");
		            psql.registerOutParameter(i++, DataTypes.INTEGER);
		            psql.registerOutParameter(i++, DataTypes.VARCHAR);
					
					prs = updateProcedure(psql);
					
	                if (prs.getInt(9) != 0) {
	                	throw new Exception("[USER-정산내역 수정에 실패하였습니다."+ prs.getString(10) + "]");
	                }else{
	                	res ++;
	                }
	                
	    			if (res == 0) {
	    				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
	    						+ "데이터 입력을 하지 못했습니다.["+strStrCd+strSaleDt+strPosNo+strCalCd+"U"+"]");
	    			}
					
				}	// end if
				
			} // end while
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		
		return res;
		
	}
	
	/**
	 * 무인정산자료 타사 상품권 조회.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchOGift(ActionForm form, String strId) throws Exception {
		
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strQuery = "";
		int i = 0;	
		
		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strSaleDt      = String2.nvl(form.getParam("strSaleDt"));
		String strSaleEndDt   = String2.nvl(form.getParam("strSaleEndDt"));
		String strPosNo       = String2.nvl(form.getParam("strPosNo"));
		String strRdGubun     = String2.nvl(form.getParam("strRdGubun"));
		String strChkGrp      = String2.nvl(form.getParam("strChkGrp"));
		String strSys      	  = String2.nvl(form.getParam("strSys"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		
		if (strChkGrp.equals("GRP")) {	// 그룹별
			if (strSys.equals("SYS"))
				strQuery = svc.getQuery("SEL_OGIFT_SYSGRP") + "\n";
			else
				strQuery = svc.getQuery("SEL_OGIFT_GRP") + "\n";
		} else {						// 일반
			if (strSys.equals("SYS"))
				strQuery = svc.getQuery("SEL_OGIFT_SYS") + "\n";
			else
				strQuery = svc.getQuery("SEL_OGIFT") + "\n";
		}
			
		
				
		sql.setString(++i, strStrCd);
		if (strRdGubun.equals("DAY"))	{	// 일자별
			sql.setString(++i, strSaleDt);
			sql.setString(++i, strSaleDt);
		} else {
			sql.setString(++i, strSaleDt);	// 기간합
			sql.setString(++i, strSaleEndDt);
		}
		sql.setString(++i, strPosNo);

		sql.put(strQuery);

		ret = select2List(sql);
		return ret;
	}
}
