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
 * <p> 카드매출 데이터 조회DAO </p>
 * 
 * @created on 1.0, 2010/05/31
 * @created by 김영진
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal918DAO extends AbstractDAO { 
	/**
	 * <p>
	 * 카드매출 데이터 조회
	 * </p>
	 * 
	 */
	public List searchMaster(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null; 
		Service svc = null;
		//String query = "";
		String strQuery = "";

		int i = 1;
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));    
		String strReqDt    = String2.nvl(form.getParam("strReqDt"));
		String strReqToDt  = String2.nvl(form.getParam("strReqToDt")); 
		String strBcompCd  = String2.nvl(form.getParam("strBcompCd"));   
		String strJbrchId  = String2.nvl(form.getParam("strJbrchId"));  
		String strCardNo   = String2.nvl(form.getParam("strCardNo"));    
		String strApprNo   = String2.nvl(form.getParam("strApprNo"));  
		String strDivMonth = String2.nvl(form.getParam("strDivMonth"));
		String strSInOut   = String2.nvl(form.getParam("strSInOut")); 
		String strGB       = String2.nvl(form.getParam("strGB")); //-- 조회구분
		String strPosNo    = String2.nvl(form.getParam("strPosNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
			
		if((strGB.equals("0")) || (strGB.equals("A")))  {
			
			// 전일취소
			strQuery += svc.getQuery("SEL_MASTER_YCAN") + "\n";
			 
			sql.setString(i++, strStrCd   );
			if(strSInOut.equals("1")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SALE_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("2")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("3")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DATE") + "\n";			
			}
			
			if(!strBcompCd.equals("%")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMPCD") + "\n";
				sql.setString(i++, strBcompCd);
			}
			if(!strJbrchId.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_JBRCHID") + "\n";
				sql.setString(i++, strJbrchId);
			}
			if(!strCardNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_CARDNO") + "\n";
				sql.setString(i++, strCardNo);
			}
			if(!strApprNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_APPRNO") + "\n";
				sql.setString(i++, strApprNo);
			}
			if(!strDivMonth.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_DIVMONTH") + "\n";
				sql.setString(i++, strDivMonth);
			}
			
			if(!strPosNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_POSNO") + "\n";
				sql.setString(i++, strPosNo);
			}	
			
		}
			
			//
		if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
		}	
			
		if((strGB.equals("0")) || (strGB.equals("B")))  {
			// 당일취소
			strQuery += svc.getQuery("SEL_MASTER_TCAN_1") + "\n";
			 
			sql.setString(i++, strStrCd   );
			if(strSInOut.equals("1")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SALE_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("2")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("3")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DATE") + "\n";			
			}
			
			if(!strBcompCd.equals("%")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMPCD") + "\n";
				sql.setString(i++, strBcompCd);
			}
			if(!strJbrchId.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_JBRCHID") + "\n";
				sql.setString(i++, strJbrchId);
			}
			if(!strCardNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_CARDNO") + "\n";
				sql.setString(i++, strCardNo);
			}
			if(!strApprNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_APPRNO") + "\n";
				sql.setString(i++, strApprNo);
			}
			if(!strDivMonth.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_DIVMONTH") + "\n";
				sql.setString(i++, strDivMonth);
			}
			
			if(!strPosNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_POSNO") + "\n";
				sql.setString(i++, strPosNo);
			}	
			
			//
			strQuery += svc.getQuery("SEL_UNION") + "\n";
			
			strQuery += svc.getQuery("SEL_MASTER_TCAN_2") + "\n";
			 
			sql.setString(i++, strStrCd   );
			if(strSInOut.equals("1")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SALE_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("2")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("3")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DATE") + "\n";			
			}
			
			if(!strBcompCd.equals("%")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMPCD") + "\n";
				sql.setString(i++, strBcompCd);
			}
			if(!strJbrchId.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_JBRCHID") + "\n";
				sql.setString(i++, strJbrchId);
			}
			if(!strCardNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_CARDNO") + "\n";
				sql.setString(i++, strCardNo);
			}
			if(!strApprNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_APPRNO") + "\n";
				sql.setString(i++, strApprNo);
			}
			if(!strDivMonth.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_DIVMONTH") + "\n";
				sql.setString(i++, strDivMonth);
			}			
			
			if(!strPosNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_POSNO") + "\n";
				sql.setString(i++, strPosNo);
			}	
						
		}
			//
		if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
		}
		
		if((strGB.equals("0")) || (strGB.equals("C")))  {
			// 수기입력
			strQuery += svc.getQuery("SEL_MASTER_K") + "\n";
			 
			sql.setString(i++, strStrCd   );
			if(strSInOut.equals("1")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SALE_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("2")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("3")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DATE") + "\n";			
			}
			
			if(!strBcompCd.equals("%")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMPCD") + "\n";
				sql.setString(i++, strBcompCd);
			}
			if(!strJbrchId.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_JBRCHID") + "\n";
				sql.setString(i++, strJbrchId);
			}
			if(!strCardNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_CARDNO") + "\n";
				sql.setString(i++, strCardNo);
			}
			if(!strApprNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_APPRNO") + "\n";
				sql.setString(i++, strApprNo);
			}
			if(!strDivMonth.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_DIVMONTH") + "\n";
				sql.setString(i++, strDivMonth);
			}
			
			if(!strPosNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_POSNO") + "\n";
				sql.setString(i++, strPosNo);
			}	
		}
		
		//
		if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
		}
		
		if((strGB.equals("0")) || (strGB.equals("D")))  {
			
			// 승인번호 중복 1
			strQuery += svc.getQuery("SEL_MASTER_DUP_APPR_NO_1") + "\n";
			 
			sql.setString(i++, strStrCd   );
			if(strSInOut.equals("1")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SALE_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("2")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("3")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DATE") + "\n";			
			}
			
			if(!strBcompCd.equals("%")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMPCD") + "\n";
				sql.setString(i++, strBcompCd);
			}
			if(!strJbrchId.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_JBRCHID") + "\n";
				sql.setString(i++, strJbrchId);
			}
			if(!strCardNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_CARDNO") + "\n";
				sql.setString(i++, strCardNo);
			}
			if(!strApprNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_APPRNO") + "\n";
				sql.setString(i++, strApprNo);
			}
			if(!strDivMonth.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_DIVMONTH") + "\n";
				sql.setString(i++, strDivMonth);
			}
			
			if(!strPosNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_POSNO") + "\n";
				sql.setString(i++, strPosNo);
			}	
	
			//
			strQuery += svc.getQuery("SEL_UNION") + "\n";
		
			// 승인번호 중복 2
			strQuery += svc.getQuery("SEL_MASTER_DUP_APPR_NO_2") + "\n";
			 
			sql.setString(i++, strStrCd   );
			if(strSInOut.equals("1")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SALE_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("2")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("3")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DATE") + "\n";			
			}
			
			if(!strBcompCd.equals("%")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMPCD") + "\n";
				sql.setString(i++, strBcompCd);
			}
			if(!strJbrchId.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_JBRCHID") + "\n";
				sql.setString(i++, strJbrchId);
			}
			if(!strCardNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_CARDNO") + "\n";
				sql.setString(i++, strCardNo);
			}
			if(!strApprNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_APPRNO") + "\n";
				sql.setString(i++, strApprNo);
			}
			if(!strDivMonth.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_DIVMONTH") + "\n";
				sql.setString(i++, strDivMonth);
			}
			
			if(!strPosNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_POSNO") + "\n";
				sql.setString(i++, strPosNo);
			}	
		}
			//
		if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
		}
		
		if((strGB.equals("0")) || (strGB.equals("E")))  {
			// 발급사 중복
			strQuery += svc.getQuery("SEL_MASTER_DUP_CCOMP") + "\n";
			 
			sql.setString(i++, strStrCd   );
			if(strSInOut.equals("1")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SALE_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("2")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("3")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DATE") + "\n";			
			}
			
			if(!strBcompCd.equals("%")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMPCD") + "\n";
				sql.setString(i++, strBcompCd);
			}
			if(!strJbrchId.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_JBRCHID") + "\n";
				sql.setString(i++, strJbrchId);
			}
			if(!strCardNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_CARDNO") + "\n";
				sql.setString(i++, strCardNo);
			}
			if(!strApprNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_APPRNO") + "\n";
				sql.setString(i++, strApprNo);
			}
			if(!strDivMonth.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_DIVMONTH") + "\n";
				sql.setString(i++, strDivMonth);
			}
			
			if(!strPosNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_POSNO") + "\n";
				sql.setString(i++, strPosNo);
			}	
		}
			//
		if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
		}
		
		if((strGB.equals("0")) || (strGB.equals("F")))  {
			// 매입사 중복
			strQuery += svc.getQuery("SEL_MASTER_DUP_BCOMP") + "\n";
			 
			sql.setString(i++, strStrCd   );
			if(strSInOut.equals("1")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SALE_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("2")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("3")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DATE") + "\n";			
			}
			
			if(!strBcompCd.equals("%")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMPCD") + "\n";
				sql.setString(i++, strBcompCd);
			}
			if(!strJbrchId.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_JBRCHID") + "\n";
				sql.setString(i++, strJbrchId);
			}
			if(!strCardNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_CARDNO") + "\n";
				sql.setString(i++, strCardNo);
			}
			if(!strApprNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_APPRNO") + "\n";
				sql.setString(i++, strApprNo);
			}
			if(!strDivMonth.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_DIVMONTH") + "\n";
				sql.setString(i++, strDivMonth);
			}
			
			if(!strPosNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_POSNO") + "\n";
				sql.setString(i++, strPosNo);
			}	
		}
		//
		if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
		}
		
		if((strGB.equals("0")) || (strGB.equals("G")))  {
			// 카드빈 없음
			strQuery += svc.getQuery("SEL_MASTER_BIN_NEXISTS") + "\n";
			 
			sql.setString(i++, strStrCd   );
			if(strSInOut.equals("1")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SALE_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("2")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("3")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DATE") + "\n";			
			}
			
			if(!strBcompCd.equals("%")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMPCD") + "\n";
				sql.setString(i++, strBcompCd);
			}
			if(!strJbrchId.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_JBRCHID") + "\n";
				sql.setString(i++, strJbrchId);
			}
			if(!strCardNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_CARDNO") + "\n";
				sql.setString(i++, strCardNo);
			}
			if(!strApprNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_APPRNO") + "\n";
				sql.setString(i++, strApprNo);
			}
			if(!strDivMonth.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_DIVMONTH") + "\n";
				sql.setString(i++, strDivMonth);
			}
			
			if(!strPosNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_POSNO") + "\n";
				sql.setString(i++, strPosNo);
			}	
		}
		
		//
		if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
		}
		
		if((strGB.equals("0")) || (strGB.equals("H")))  {
			// 발급사 차이
			strQuery += svc.getQuery("SEL_MASTER_BIN_CCOMP") + "\n";
			 
			sql.setString(i++, strStrCd   );
			if(strSInOut.equals("1")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SALE_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("2")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("3")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DATE") + "\n";			
			}
			
			if(!strBcompCd.equals("%")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMPCD") + "\n";
				sql.setString(i++, strBcompCd);
			}
			if(!strJbrchId.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_JBRCHID") + "\n";
				sql.setString(i++, strJbrchId);
			}
			if(!strCardNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_CARDNO") + "\n";
				sql.setString(i++, strCardNo);
			}
			if(!strApprNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_APPRNO") + "\n";
				sql.setString(i++, strApprNo);
			}
			if(!strDivMonth.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_DIVMONTH") + "\n";
				sql.setString(i++, strDivMonth);
			}
			
			if(!strPosNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_POSNO") + "\n";
				sql.setString(i++, strPosNo);
			}	
		}
		
		//
		if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
		}
		
		if((strGB.equals("0")) || (strGB.equals("I")))  {
			// 매입사 차이
			strQuery += svc.getQuery("SEL_MASTER_BIN_BCOMP") + "\n";
			 
			sql.setString(i++, strStrCd   );
			if(strSInOut.equals("1")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SALE_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("2")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("3")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DATE") + "\n";			
			}
			
			if(!strBcompCd.equals("%")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMPCD") + "\n";
				sql.setString(i++, strBcompCd);
			}
			if(!strJbrchId.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_JBRCHID") + "\n";
				sql.setString(i++, strJbrchId);
			}
			if(!strCardNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_CARDNO") + "\n";
				sql.setString(i++, strCardNo);
			}
			if(!strApprNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_APPRNO") + "\n";
				sql.setString(i++, strApprNo);
			}
			if(!strDivMonth.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_DIVMONTH") + "\n";
				sql.setString(i++, strDivMonth);
			}
			
			if(!strPosNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_POSNO") + "\n";
				sql.setString(i++, strPosNo);
			}	
		}


		if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
		}	
			
		if((strGB.equals("0")) || (strGB.equals("J")))  {
			// 당일수기취소
			strQuery += svc.getQuery("SEL_MASTER_TCAN_SUJI") + "\n";
			 
			sql.setString(i++, strStrCd   );
			if(strSInOut.equals("1")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SALE_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("2")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("3")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DATE") + "\n";			
			}
			
			if(!strBcompCd.equals("%")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMPCD") + "\n";
				sql.setString(i++, strBcompCd);
			}
			if(!strJbrchId.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_JBRCHID") + "\n";
				sql.setString(i++, strJbrchId);
			}
			if(!strCardNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_CARDNO") + "\n";
				sql.setString(i++, strCardNo);
			}
			if(!strApprNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_APPRNO") + "\n";
				sql.setString(i++, strApprNo);
			}
			if(!strDivMonth.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_DIVMONTH") + "\n";
				sql.setString(i++, strDivMonth);
			}
			
			if(!strPosNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_POSNO") + "\n";
				sql.setString(i++, strPosNo);
			}	
			

			strQuery += svc.getQuery("SEL_UNION") + "\n";
			
			// 당일취소원거래무
			strQuery += svc.getQuery("SEL_MASTER_TCAN_NO_ORG") + "\n";
			 
			sql.setString(i++, strStrCd   );
			sql.setString(i++, strReqDt);
			sql.setString(i++, strReqToDt);
			sql.setString(i++, strStrCd   );
			sql.setString(i++, strReqDt);
			sql.setString(i++, strReqToDt);
			
			sql.setString(i++, strStrCd   );
			if(strSInOut.equals("1")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SALE_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("2")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("3")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DATE") + "\n";			
			}
			
			if(!strBcompCd.equals("%")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMPCD") + "\n";
				sql.setString(i++, strBcompCd);
			}
			if(!strJbrchId.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_JBRCHID") + "\n";
				sql.setString(i++, strJbrchId);
			}
			if(!strCardNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_CARDNO") + "\n";
				sql.setString(i++, strCardNo);
			}
			if(!strApprNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_APPRNO") + "\n";
				sql.setString(i++, strApprNo);
			}
			if(!strDivMonth.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_DIVMONTH") + "\n";
				sql.setString(i++, strDivMonth);
			}			
			if(!strPosNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_POSNO") + "\n";
				sql.setString(i++, strPosNo);
			}	
			
		}
		
		if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
		}	
		
		if((strGB.equals("0")) || (strGB.equals("K")))  {
			
			// 전일수기취소
			strQuery += svc.getQuery("SEL_MASTER_YCAN_SUJI") + "\n";
			 
			sql.setString(i++, strStrCd   );
			if(strSInOut.equals("1")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SALE_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("2")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DT") + "\n";
				sql.setString(i++, strReqDt);
				sql.setString(i++, strReqToDt);
			}else if(strSInOut.equals("3")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DATE") + "\n";			
			}
			
			if(!strBcompCd.equals("%")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMPCD") + "\n";
				sql.setString(i++, strBcompCd);
			}
			if(!strJbrchId.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_JBRCHID") + "\n";
				sql.setString(i++, strJbrchId);
			}
			if(!strCardNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_CARDNO") + "\n";
				sql.setString(i++, strCardNo);
			}
			if(!strApprNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_APPRNO") + "\n";
				sql.setString(i++, strApprNo);
			}
			if(!strDivMonth.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_DIVMONTH") + "\n";
				sql.setString(i++, strDivMonth);
			}
			if(!strPosNo.equals("")){
				strQuery += svc.getQuery("SEL_MASTER_WHERE_POSNO") + "\n";
				sql.setString(i++, strPosNo);
			}	
		}
		
		//
		//strQuery += svc.getQuery("SEL_MASTER_ORDER");
		strQuery += svc.getQuery("SEL_MASTER_ORDER_UNION");

		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	public String saveData(ActionForm form, MultiInput mi1, String userId, String org_flag)
			throws Exception {
		
		int resp    		= 0;     //프로시저 리턴값
		String res			= "";
		int i   			= 0;
		int ress = 0;
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));    
		
		SqlWrapper sql        = null;
		Service svc           = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		try {
		
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
		
			mi1.next();
				
			i = 1;  
			sql.put(svc.getQuery("UPD_MASTER"));;  
			
			sql.setString(i++, mi1.getString("CARD_NO"));     //카드번호
			sql.setString(i++, mi1.getString("EXP_DT"));      //유효기간              
			sql.setString(i++, mi1.getString("DIV_MONTH"));   //할부개월          
			sql.setString(i++, mi1.getString("APPR_NO"));     //승인번호                    
			sql.setString(i++, mi1.getString("APPR_DT")+mi1.getString("APPR_TIME"));   //승인일자 및 시간                   
			sql.setString(i++, mi1.getString("APPR_DT"));     //승인일자                       
			sql.setString(i++, mi1.getString("VEN_CD"));      //승인밴사                   
			sql.setString(i++, mi1.getString("CCOMP_CD"));    //발급사코드                     
			sql.setString(i++, mi1.getString("BCOMP_CD"));    //매입사코드                        
			sql.setString(i++, strStrCd); 		              // 점코드
			sql.setString(i++, mi1.getString("SALE_DT"));    // 매출일자
			sql.setString(i++, mi1.getString("POS_NO"));     // 포스번호
			sql.setString(i++, mi1.getString("TRAN_NO"));    // 거래번호
			sql.setString(i++, mi1.getString("POS_SEQ_NO")); // 일련번호
		    
		    update(sql);
		    
		    
			psql.put("DPS.PR_PS_CARDINFOUPD", 7);
			
			i=1;
		    psql.setString(i++, strStrCd); 		// 점코드
		    psql.setString(i++, mi1.getString("SALE_DT"));      // 매출일자
		    psql.setString(i++, mi1.getString("POS_NO"));       // 포스번호
		    psql.setString(i++, mi1.getString("TRAN_NO"));      // 거래번호
		    psql.setString(i++, mi1.getString("POS_SEQ_NO"));       // 일련번호
		    
		    psql.registerOutParameter(i++, DataTypes.INTEGER);//6
		    psql.registerOutParameter(i++, DataTypes.VARCHAR);//7
		
		    prs = updateProcedure(psql);
		   
		    
		    resp += prs.getInt(6);    
		    if (resp != 0) {
		        throw new Exception("[USER]"+ prs.getString(7));
		    }else{
		    	res = prs.getString(7);
		    }
		    
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return res;
	}
	
    /**
	* 점별 VANID 구분코드를  조회한다.
	*
	* @param  : 
	* @return :
	*/
	public List searchVanId(ActionForm form) throws Exception  {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;               

		//strStrCd	
		//strSaleDtS
		String strStrCd=String2.nvl(form.getParam("strStrCd"));
				
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		
		sql.put(svc.getQuery("SEARCH_VAN_ID")); 
		sql.setString(i++, strStrCd);
		
		ret = select2List(sql);

		return ret;
	}
	
}
