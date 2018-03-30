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
 * <p>예제  DAO</p> 
 *  
 * @created  on 1.0, 2010/03/24 
 * @created  by 박래형(FKSS)
 * 
 * @modified on  
 * @modified by 
 * @caused   by 
 */ 

public class POrd509DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */    	
	
	/**
	 * INVOICE 등록 리스트 내역 조회
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

		String  strStrCd	   = String2.nvl(form.getParam("strStrCd")); 
		String  strSStandardDt = String2.nvl(form.getParam("strSStandardDt"));
		String  strEStandardDt = String2.nvl(form.getParam("strEStandardDt")); 
		String  strStandardNo  = String2.nvl(form.getParam("strStandardNo"));
		String  strPumbun	   = String2.nvl(form.getParam("strPumbun"));
		String  strVen	       = String2.nvl(form.getParam("strVen"));  
		String  strCloseFlag   = String2.nvl(form.getParam("strCloseFlag")); 
	
		sql = new SqlWrapper(); 
		svc = (Service) form.getService();   
		connect("pot");		

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSStandardDt);
		sql.setString(i++, strEStandardDt);
		sql.setString(i++, strStandardNo);
		sql.setString(i++, strPumbun);
		sql.setString(i++, strVen);
		sql.setString(i++, strCloseFlag);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSStandardDt);
		sql.setString(i++, strEStandardDt);
		sql.setString(i++, strStandardNo);
		sql.setString(i++, strPumbun);
		sql.setString(i++, strVen);
		sql.setString(i++, strCloseFlag);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSStandardDt);
		sql.setString(i++, strEStandardDt);
		sql.setString(i++, strStandardNo);
		sql.setString(i++, strPumbun);
		sql.setString(i++, strVen);
		sql.setString(i++, strCloseFlag);
		
		sql.put(svc.getQuery("SEL_MASTER"));
		
		
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
//					System.out.println("여기까지 오나:확정");
					
					String strCloseDt =  ""; 
					String strToday   = String2.nvl(form.getParam("strToday")); 
//					System.out.println("CLOSE_FLAG = " + mi.getString("CLOSE_FLAG"));
//					System.out.println("strToday = " + strToday);
					
					if("N".equals(mi.getString("CLOSE_FLAG"))){		//N -> Y로 셋팅될것이기 때문에 확정일 자를 넣어준다
						strCloseDt = strToday;
					}else{
						strCloseDt = "NULL";
					}					
					
					sql.put(svc.getQuery("UPD_CONF"));
					
					sql.setString(i++, mi.getString("CHANGE_CLOSE_FLAG"));
					sql.setString(i++, strCloseDt);
					sql.setString(i++, userId);
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("OFFER_YM"));
					sql.setString(i++, mi.getString("OFFER_SEQ_NO"));
				} 
				res = update(sql);

//				System.out.println("널포인트익셉션");
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
	
	/**
	 * OFFER 마감 취소 가능여부
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */ 
	public List chkConfClose(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd   	   = String2.nvl(form.getParam("strStrCd"));  
		String strOfferYm      = String2.nvl(form.getParam("strOfferYm"));  
		String strOfferSeqNo   = String2.nvl(form.getParam("strOfferSeqNo"));  
		String strOfferSheetNo = String2.nvl(form.getParam("strOfferSheetNo"));  
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("CHK_CLOSE") + "\n";

		sql.setString(i++, strStrCd);
		sql.setString(i++, strOfferYm);
		sql.setString(i++, strOfferSeqNo);
		sql.setString(i++, strOfferSheetNo);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
}
