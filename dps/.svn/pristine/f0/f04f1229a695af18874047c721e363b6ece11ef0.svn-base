/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.dao;

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
 * <p>예제  DAO</p>
 *  
 * @created  on 1.0, 2010/01/13  
 * @created  by 정진영(FKSS) 
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class POrd510DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
     /**
	 * 수입제경비 등록/화정 마스터 조회 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form) throws Exception {

		List ret = null;  
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = ""; 
		int i = 1;
		
		String strStrCd   	  =  String2.nvl(form.getParam("strStrCd"));        
		String strOfferDtFrom =  String2.nvl(form.getParam("strOfferDtFrom")); 
		String strOfferDtTo   =  String2.nvl(form.getParam("strOfferDtTo"));  
		String strOfferNo     =  String2.nvl(form.getParam("strOfferNo"));      
		String strPbCd        =  String2.nvl(form.getParam("strPbCd"));             
		String strVenCd       =  String2.nvl(form.getParam("strVenCd"));       
		String strConfFlag    =  String2.nvl(form.getParam("strConfFlag"));   
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strOfferDtFrom);
		sql.setString(i++, strOfferDtTo);
		sql.setString(i++, strOfferNo);
		sql.setString(i++, strPbCd);
		sql.setString(i++, strVenCd);
		sql.setString(i++, strConfFlag);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOfferDtFrom);
		sql.setString(i++, strOfferDtTo); 
		sql.setString(i++, strOfferNo); 
		sql.setString(i++, strPbCd); 
		sql.setString(i++, strVenCd);
		sql.setString(i++, strConfFlag);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOfferDtFrom);
		sql.setString(i++, strOfferDtTo);
		sql.setString(i++, strOfferNo);
		sql.setString(i++, strPbCd);
		sql.setString(i++, strVenCd);
		sql.setString(i++, strConfFlag);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 수입제경비 등록/화정 마스터 조회 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */ 
	public List getDetail(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd   		=  String2.nvl(form.getParam("strStrCd"));        
		String strOfferYm =  String2.nvl(form.getParam("strOfferYm"));
		String strOfferSeqNo   =  String2.nvl(form.getParam("strOfferSeqNo"));  
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOfferYm);
		sql.setString(i++, strOfferSeqNo);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 수입제경비 등록/확정 마스터 조회 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */ 
	public List checkCostCd(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strCostCd   		=  String2.nvl(form.getParam("strCostCd"));       
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_COST_CD") + "\n";
		
		sql.setString(i++, strCostCd);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	

	/**
	 * 제경비를 저장, 수정 처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */ 
	public int conf(ActionForm form, MultiInput mi1, String userId)
			throws Exception {

		int ret = 0; 
		int res = 0;    //마스터
		int res2= 0;    //디테일
		int resp= 0;    //프로시저 리턴값

		int i = 1;		//마스터
		int j = 1;      //디테일
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
		    
			while (mi1.next()) { 
				i = 1; 
				j = 1;
				sql.close();
				if (mi1.IS_UPDATE()) { // 저장
					sql.close();

					System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
					System.out.println("수입원가 확정여부   " + mi1.getString("TMP_COST_CLOSE_FLAG"));
					System.out.println("userId   " + userId);
					System.out.println("STR_CD   " + mi1.getString("STR_CD"));
					System.out.println("OFFER_YM   " + mi1.getString("OFFER_YM"));
					System.out.println("OFFER_SEQ_NO   " + mi1.getString("OFFER_SEQ_NO"));
					System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

					sql.put(svc.getQuery("UPD_CONF"));					
					sql.setString(i++, mi1.getString("TMP_COST_CLOSE_FLAG")); 
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("STR_CD"));
					sql.setString(i++, mi1.getString("OFFER_YM"));
					sql.setString(i++, mi1.getString("OFFER_SEQ_NO"));

					res = update(sql);
					
					//*취소일때 수입원가 수불처리 */
					if(!"Y".equals(mi1.getString("TMP_COST_CLOSE_FLAG"))){
						psql.close();
						psql = new ProcedureWrapper();
						   
				    	psql.put("DPS.PR_POEXPSTK", 7);    
			           
		                psql.setString(1,mi1.getString("STR_CD"));        //점
			            psql.setString(2,mi1.getString("OFFER_YM"));      //오퍼번호
			            psql.setString(3,mi1.getString("OFFER_SEQ_NO"));  
			            psql.setString(4,"CAN");
			            psql.setString(5,userId);
			            psql.registerOutParameter(6, DataTypes.INTEGER);//5
			            psql.registerOutParameter(7, DataTypes.VARCHAR);//6
			            prs = updateProcedure(psql);
			            
		                resp += prs.getInt(6);    
		
		                if (resp != 0) {
		                   throw new Exception("[USER]" + prs.getString(7));
			            }
					}   

					sql.close();								

					if("Y".equals(mi1.getString("TMP_COST_CLOSE_FLAG"))){  //확정이면
						sql.put(svc.getQuery("UPD_CONF_DETAIL"));	
					}else{                                                 //취소면
						sql.put(svc.getQuery("UPD_UNCONF_DETAIL"));		
					}			
					
					sql.setString(j++, userId);
					sql.setString(j++, mi1.getString("STR_CD"));
					sql.setString(j++, mi1.getString("OFFER_YM"));
					sql.setString(j++, mi1.getString("OFFER_SEQ_NO"));
					
					res2 = update(sql);					
				}
				if("Y".equals(mi1.getString("TMP_COST_CLOSE_FLAG"))){
					psql.close();
					psql = new ProcedureWrapper();
					   
			    	psql.put("DPS.PR_POEXPSTK", 7);    
		           
	                psql.setString(1,mi1.getString("STR_CD"));        //점
		            psql.setString(2,mi1.getString("OFFER_YM"));      //오퍼번호
		            psql.setString(3,mi1.getString("OFFER_SEQ_NO"));  
		            psql.setString(4,"CON");
		            psql.setString(5,userId);
		            psql.registerOutParameter(6, DataTypes.INTEGER);//5
		            psql.registerOutParameter(7, DataTypes.VARCHAR);//6
		            prs = updateProcedure(psql);
		            
	                resp += prs.getInt(6);    
	
	                if (resp != 0) {
	                   throw new Exception("[USER]" + prs.getString(7));
		            }
				}else{
					psql.close();
					psql = new ProcedureWrapper();
					   
			    	psql.put("DPS.PR_POEXPSTK", 7);    
		           
	                psql.setString(1,mi1.getString("STR_CD"));        //점
		            psql.setString(2,mi1.getString("OFFER_YM"));      //오퍼번호
		            psql.setString(3,mi1.getString("OFFER_SEQ_NO"));  
		            psql.setString(4,"CAN");
		            psql.setString(5,userId);
		            psql.registerOutParameter(6, DataTypes.INTEGER);//5
		            psql.registerOutParameter(7, DataTypes.VARCHAR);//6
		            prs = updateProcedure(psql);
		            
	                resp += prs.getInt(6);    
	
	                if (resp != 0) {
	                   throw new Exception("[USER]" + prs.getString(7));
		            }
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
	
	/**
	 * 마감(확정)여부 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */ 
	public List checkYnFlag(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd   	  =  String2.nvl(form.getParam("strStrCd"));       
		String strOfferYm     =  String2.nvl(form.getParam("strOfferYm"));       
		String strOfferSeqNo  =  String2.nvl(form.getParam("strOfferSeqNo"));       
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("CHECK_YN_FLAG") + "\n";

		sql.setString(i++, strStrCd);
		sql.setString(i++, strOfferYm);
		sql.setString(i++, strOfferSeqNo);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOfferYm);
		sql.setString(i++, strOfferSeqNo);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
}
