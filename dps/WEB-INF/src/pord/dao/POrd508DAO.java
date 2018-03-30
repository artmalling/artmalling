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

public class POrd508DAO extends AbstractDAO {
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
		
		String strStrCd   		=  String2.nvl(form.getParam("strStrCd"));        
		String strOfferDtFrom =  String2.nvl(form.getParam("strOfferDtFrom"));
		String strOfferDtTo   =  String2.nvl(form.getParam("strOfferDtTo"));  
		String strOfferNo     =  String2.nvl(form.getParam("strOfferNo"));    
		String strPbCd        =  String2.nvl(form.getParam("strPbCd"));       
		String strVenCd       =  String2.nvl(form.getParam("strVenCd"));      
		String strConfFlag    =  String2.nvl(form.getParam("strConfFlag"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_PO_OFFMST") + "\n";
		
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
	public List getDtl(ActionForm form) throws Exception {
		
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
		strQuery = svc.getQuery("SEL_PO_EXPNCM") + "\n";
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOfferYm);
		sql.setString(i++, strOfferSeqNo);
		
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
	 * 수입제경비 등록/화정 마스터 조회 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */ 
	public List chkCost(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd   	   = String2.nvl(form.getParam("strStrCd"));  
		String strOfferSheetNo = String2.nvl(form.getParam("strOfferSheetNo"));  
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("CHK_COST") + "\n";

		sql.setString(i++, strStrCd);
		sql.setString(i++, strOfferSheetNo);
		
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
	public int save(ActionForm form, MultiInput mi, String userId)
			throws Exception {

		int ret = 0;
		int res = 0;
		int i = 1;
		int resp    = 0;//프로시저 리턴값
		
		String strPStrCd      = "";
		String strPOfferYm    = "";  
		String strPOfferSeqNo = "";
		
		SqlWrapper sql = null;
		Service svc = null;
        ProcedureWrapper psql = null;	//프로시저 사용위함
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
            psql = new ProcedureWrapper();	//프로시저 사용위함
			svc = (Service) form.getService();

            ProcedureResultSet prs = null;
            
			while (mi.next()) {
				i = 1;
				sql.close();
				
				if (mi.IS_INSERT()) { // 저장
					sql.close();
					
					strPStrCd       = mi.getString("STR_CD");
					strPOfferYm     = mi.getString("OFFER_YM");
					strPOfferSeqNo  = mi.getString("OFFER_SEQ_NO");
					
					sql.put(svc.getQuery("INS_PO_EXPNCM"));
					
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("OFFER_YM"));
					sql.setString(i++, mi.getString("OFFER_SEQ_NO"));
					sql.setString(i++, mi.getString("IMP_COST_CD"));
					sql.setString(i++, mi.getString("OFFER_DT"));
					sql.setString(i++, mi.getString("OFFER_SHEET_NO"));
					sql.setString(i++, mi.getString("SUPPLY_CD"));
					sql.setString(i++, mi.getString("SUP_AMT"));
					sql.setString(i++, mi.getString("VAT_AMT"));
					sql.setString(i++, mi.getString("TOT_AMT"));
					sql.setString(i++, mi.getString("REMARK"));
					sql.setString(i++, userId);

				} else if (mi.IS_UPDATE()) {// 수정
					
					strPStrCd       = mi.getString("STR_CD");
					strPOfferYm     = mi.getString("OFFER_YM");
					strPOfferSeqNo  = mi.getString("OFFER_SEQ_NO");
					
					sql.put(svc.getQuery("UPD_PO_EXPNCM"));
					
					sql.setString(i++, mi.getString("SUPPLY_CD"));
					sql.setString(i++, mi.getString("SUP_AMT"));
					sql.setString(i++, mi.getString("VAT_AMT"));
					sql.setString(i++, mi.getString("TOT_AMT"));
					sql.setString(i++, mi.getString("REMARK"));
					sql.setString(i++, userId);
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("OFFER_YM"));
					sql.setString(i++, mi.getString("OFFER_SEQ_NO"));
					sql.setString(i++, mi.getString("IMP_COST_CD"));
				
				} else if (mi.IS_DELETE()) { // 삭제
					
					sql.put(svc.getQuery("DEL_PO_EXPNCM"));

					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("OFFER_YM"));
					sql.setString(i++, mi.getString("OFFER_SEQ_NO"));
					sql.setString(i++, mi.getString("IMP_COST_CD"));
				}
				res = update(sql);
							
				//수입제경비 프로시저 실행				
				
				ret += res;
			}
			
            psql.put("DPS.PR_POEXPDIV", 5);    
            psql.setString(1, strPStrCd);        //점
            psql.setString(2, strPOfferYm);      //OFFER 년월
            psql.setString(3, strPOfferSeqNo);   //OFFER 순번
            
            psql.registerOutParameter(4, DataTypes.INTEGER);//6
            psql.registerOutParameter(5, DataTypes.VARCHAR);//7
            prs = updateProcedure(psql);
            
            resp += prs.getInt(4);    

            if (resp != 0) {
                throw new Exception("" + prs.getString(5));
            }

			if (res != 1) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여 데이터 입력을 하지 못했습니다.");
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
	 * 제경비를 저장, 수정 처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int conf(ActionForm form, MultiInput mi, String userId)
			throws Exception {

		int ret = 0;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) { 
				i = 1;
				sql.close();
				if (mi.IS_UPDATE()) { // 저장
					sql.close();
					System.out.println("여기까지 오나:확정");
					sql.put(svc.getQuery("UPD_CONF"));

					String strYNGbn  =  String2.nvl(form.getParam("strYNGbn")); 
					
					sql.setString(i++, strYNGbn);
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("OFFER_YM"));
					sql.setString(i++, mi.getString("OFFER_SEQ_NO"));
				} 
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여 데이터 입력을 하지 못했습니다.");
				} 
				
				//수입제경비 프로시저 실행
				
				
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
