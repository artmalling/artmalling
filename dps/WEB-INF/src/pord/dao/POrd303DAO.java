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
    
public class POrd303DAO extends AbstractDAO { 
	/** 
	 * 품번에 단품종류를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List checkPbnSkuType(ActionForm form) throws Exception {
		
		List ret = null; 
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = ""; 
		int i = 1;
		
		String strStrCd     = String2.nvl(form.getParam("strStrCd")); 
		String strPumbunCd  = String2.nvl(form.getParam("strPumbunCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");		
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strPumbunCd);  
		strQuery = svc.getQuery("SEL_PBN_SKU_TYPE") + "\n";

		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}   
 
	/**
	 * TAG 발행의뢰 마스터 부분을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */ 
	public List searchMaster(ActionForm form, String userId, String org_flag) throws Exception {
		List ret = null;   
		SqlWrapper sql = null; 
		Service svc = null;
		String strQuery = "";
		int i = 1;
		String strStrCd    = String2.nvl(form.getParam("strStrCd")); 
		String strTagFlag  = String2.nvl(form.getParam("strTagFlag"));
		String strReqDate  = String2.nvl(form.getParam("strReqDate")); 
		String strReqDate2 = String2.nvl(form.getParam("strReqDate2"));
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		String strFlag     = String2.nvl(form.getParam("strFlag"));
		String strSlipNo   = String2.nvl(form.getParam("strSlipNo"));		
		String tmpTagFlag  = null;
		
		String strSkuFlag  = null; 
		tmpTagFlag = strTagFlag.substring(0, 1); 
		
		System.out.println("strSkuFlag = " + strSkuFlag);
		
		sql = new SqlWrapper(); 
		svc = (Service) form.getService(); 
 
		connect("pot"); 
		
		if("2".equals(tmpTagFlag)){
			strSkuFlag = "2";
		}else{ 
			strSkuFlag = "1";
		}

		if("".equals(strSlipNo)){
			sql.setString(i++, strStrCd);		//구분 : 신규, 재발행             
			sql.setString(i++, strReqDate);
			sql.setString(i++, strReqDate2);
			sql.setString(i++, strPumbunCd);             
			sql.setString(i++, strSkuFlag); 
			sql.setString(i++, userId);
			sql.setString(i++, org_flag); 
			sql.put(svc.getQuery("SEL_MASTER"));
			
			if("2".equals(tmpTagFlag)){		 
				sql.setString(i++, strTagFlag);  
				sql.put(svc.getQuery("SEL_TAG_FLAG"));
			}
			
			System.out.println("strFlag = " + strFlag);
			if("2".equals(strFlag)){		 
				sql.put(svc.getQuery("SEL_TAG_PRT_CNT1"));
			}else if("3".equals(strFlag)){
				sql.put(svc.getQuery("SEL_TAG_PRT_CNT2"));		
		    }			
		}else{
			sql.put(svc.getQuery("SEL_SLIP_NO"));	
			sql.setString(i++, strStrCd);		     
			sql.setString(i++, strSlipNo);	
			sql.setString(i++, userId);
			sql.setString(i++, org_flag); 	     		
		}
		
		ret = select2List(sql);
		return ret;
	}

	/**
	 * TAG 발행의뢰 품목  디테일 부분을 조회한다. 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form) throws Exception {

		List ret = null;
		Util util = new Util();
	
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1; 

		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSlipNo = String2.nvl(form.getParam("strSlipNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService(); 

		connect("pot");

		sql.setString(i++, strStrCd); 
		sql.setString(i++, strSlipNo);

		strQuery = svc.getQuery("SEL_PUMMOK");
		sql.put(strQuery);

   
		ret = select2List(sql); 

		//복호화
		return ret;
	} 


	/**
	 * TAG 발행의뢰 단품  디테일 부분을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail2(ActionForm form) throws Exception {

		List ret = null;
		Util util = new Util();
	
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSlipNo = String2.nvl(form.getParam("strSlipNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
 
		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);

		strQuery = svc.getQuery("SEL_SKU");
		sql.put(strQuery);


		ret = select2List(sql);

		//복호화
		return ret;
	}
	
	/**
	 * 택발행 이후 마스터 정보 수정한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int updTagFlagData(ActionForm form, MultiInput mi1, String userId)
	throws Exception {

		int ret 	= 0;
		int res 	= 0;
		int i   	= 0;
		
		SqlWrapper sql = null;
		Service svc = null;

		System.out.println("왜 DAO1");		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			System.out.println("왜 DAO2");
			
			// 마스터
			while (mi1.next()) {				
				sql.close();

				System.out.println("왜 DAO3");
					
				i = 1;
				sql.put(svc.getQuery("UPD_MASTER")); 

				System.out.println("왜 DAO4");
				sql.setString(i++, userId);
				sql.setString(i++, mi1.getString("STR_CD"));
				sql.setString(i++, mi1.getString("SLIP_NO"));

				System.out.println("ID = " + userId);
				System.out.println("점코드 = " + mi1.getString("STR_CD"));
				System.out.println("전표번호 = " + mi1.getString("SLIP_NO"));

				res = update(sql);
				sql.close();		
				 
				if (res < 0) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
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
