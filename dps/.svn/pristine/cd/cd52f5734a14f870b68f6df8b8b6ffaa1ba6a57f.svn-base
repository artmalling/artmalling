/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.util.List;
import java.util.Map;

import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal928DAO extends AbstractDAO {

	/**
	 * 마스터 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		

		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));        //점                
		String strCardsa 		= String2.nvl(form.getParam("strCardsa"));       //카드사            
		String strBcomp 		= String2.nvl(form.getParam("strBcomp"));        //매입사            
		String strPosFloor 		= String2.nvl(form.getParam("strPosFloor"));   //포스층            
		String strPosFlag 		= String2.nvl(form.getParam("strPosFlag"));    //포스구분          
		String strPosNoS 	    = String2.nvl(form.getParam("strPosNoS"));     //포스시작번호      
		String strPosNoE 	    = String2.nvl(form.getParam("strPosNoE"));     //포스종료번호      
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));    //시작일자          
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));    //종료일자          

		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_CARD_SALE"));
		
		sql.setString(i++, strCardsa);
		sql.setString(i++, strPosFloor);
		sql.setString(i++, strPosFlag);
		sql.setString(i++, strPosNoS);
		sql.setString(i++, strPosNoE);
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strSaleDtE);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strSaleDtE);
		sql.setString(i++, strPosNoS);
		sql.setString(i++, strPosNoE);

		sql.setString(i++, strCardsa);
		sql.setString(i++, strBcomp);
		
		
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strSaleDtE);
		sql.setString(i++, strPosNoS);
		sql.setString(i++, strPosNoE);
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strSaleDtE);
		sql.setString(i++, strCardsa);
		sql.setString(i++, strBcomp);
		
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strSaleDtE);
		sql.setString(i++, strPosNoS);
		sql.setString(i++, strPosNoE);
		
		
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strSaleDtE);
		sql.setString(i++, strPosNoS);
		sql.setString(i++, strPosNoE);
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strSaleDtE);
		sql.setString(i++, strCardsa);
		sql.setString(i++, strBcomp);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPosFloor);
		sql.setString(i++, strPosFlag);
		
		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * 상세 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		String strPayType1 = ""; // 신용카드 
		String strPayType2 = ""; // 제휴카드 
		String strPayType3 = ""; // 직불카드 
		String strPayType4 = ""; // 은련카드
		int i 			= 1;
		

		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strCardsa 		= String2.nvl(form.getParam("strCardsa"));
		String strBcomp 		= String2.nvl(form.getParam("strBcomp"));
		String strPosFloor 		= String2.nvl(form.getParam("strPosFloor"));
		String strPosFlag 		= String2.nvl(form.getParam("strPosFlag"));
		String strPosNoS 	    = String2.nvl(form.getParam("strPosNoS"));
		String strPosNoE 	    = String2.nvl(form.getParam("strPosNoE"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));
		String strCardFlag 		= String2.nvl(form.getParam("strCardFlag"));
		
		if(strCardFlag.equals("B")){   // 직불카드일때
			strPayType1 = "";
			strPayType2 = "";
			strPayType3 = "12"; // 직불카드
			strPayType4 = "";
		}else{ //신용카드일때
			strPayType1 = "10";  // 신용카드
			strPayType2 = "11";  // 제휴카드
			strPayType3 = "";
			strPayType4 = "13";  // 은련카드
		}
				
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_CARD_SALE_DATE"));
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strSaleDtE);
		sql.setString(i++, strPosNoS);
		sql.setString(i++, strPosNoE);

		sql.setString(i++, strCardsa);
		sql.setString(i++, strBcomp);
		
		sql.setString(i++, strPayType1);
		sql.setString(i++, strPayType2);
		sql.setString(i++, strPayType3);
		sql.setString(i++, strPayType4);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPosFloor);
		sql.setString(i++, strPosFlag);
		
		
	
		ret = select2List(sql);
		
		return ret;
	}


	/**
	 * POSNO 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPosNoMM(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		

		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_POSNOMM"));

	
		ret = select2List(sql);
		
        return ret;
	}

	/**
	 * 일별 카드매출정보을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDay(ActionForm form) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 1;		

		String strDt 		= String2.nvl(form.getParam("strDt"));
		String strPosNo  	= String2.nvl(form.getParam("strPosNo"));
		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strCardCd  	= String2.nvl(form.getParam("strCardCd"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_POS_TRAN"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strDt);
		sql.setString(i++, strPosNo);
		sql.setString(i++, strCardCd);

		ret = select2List(sql);

		return ret;
	}

}
