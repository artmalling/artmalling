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
import java.util.HashMap;
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
 * <p> 규격단품 매입발주 등록  DAO </p>
 *  
 * @created  on 1.0, 2010/02/16
 * @created  by  
 * 
 * @modified on 
 * @modified by 
 * @caused   by  
 */

public class POrd211DAO extends AbstractDAO {
    	
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
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strBumun      = String2.nvl(form.getParam("strBumun"));
		String strTeam       = String2.nvl(form.getParam("strTeam"));
		String strPc         = String2.nvl(form.getParam("strPc"));
		String strOrgCd      = String2.nvl(form.getParam("strOrgCd"));
		String strGJdateType = String2.nvl(form.getParam("strGJdateType"));
		String strStartDt    = String2.nvl(form.getParam("strStartDt"));
		String strEndDt      = String2.nvl(form.getParam("strEndDt"));    
		String strProcStat   = String2.nvl(form.getParam("strProcStat")); 
		String strPumbun     = String2.nvl(form.getParam("strPumbun"));   
		String strBizType    = String2.nvl(form.getParam("strBizType"));
		String strVen        = String2.nvl(form.getParam("strVen"));  
		String strSlipNo     = String2.nvl(form.getParam("strSlipNo"));          
		String slipFlagList   = String2.nvl(form.getParam("slipFlagList")); 
		String strSkuFlag    = "1";	// 단품
		String strSkuType    = "1"; // 규격단품

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot"); 

		//넘어온 문자열을 쿼리 조건에 맞게 정한다.
		slipFlagList = "AND " + slipFlagList.substring(0, 11) + ' ' + slipFlagList.substring(11, slipFlagList.length());  

		if("".equals(strSlipNo)){
			sql.put(svc.getQuery("SEL_LIST"));
			sql.setString(i++, strProcStat);  
			sql.setString(i++, strProcStat);    
			sql.setString(i++, strSkuFlag);   
			sql.setString(i++, strProcStat);        
			sql.setString(i++, strPumbun);   
			sql.setString(i++, strVen);                    
			sql.setString(i++, userId);
			sql.setString(i++, org_flag); 
			
			if("1".equals(org_flag)){						// 판매
				sql.put(svc.getQuery("SEL_SALE_ORG_CD")); 
				sql.setString(i++, strOrgCd);
			}else if("2".equals(org_flag)){					// 매입
				sql.put(svc.getQuery("SEL_BUY_ORG_CD"));
				sql.setString(i++, strOrgCd);          
			}
			if("N".equals(strProcStat)){					// 미확정
				sql.put(svc.getQuery("SEL_NON_CONF"));
				//sql.setString(i++, '01');
			}
			
			if("0".equals(strGJdateType)){					// 발주일
				sql.put(svc.getQuery("SEL_ORD_DT"));
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);
			} else if("1".equals(strGJdateType)){			// 발주확정일
				sql.put(svc.getQuery("SEL_ORD_CONF"));    
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);		             
			} else if("2".equals(strGJdateType)){			// 납품예정일
				sql.put(svc.getQuery("SEL_DELI_DT"));
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);			
			} else if("3".equals(strGJdateType)){			// 검품확정일
				sql.put(svc.getQuery("SEL_CHK_DT"));
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);		
			}
			sql.put(slipFlagList);		//전표구분
			sql.put(svc.getQuery("SEL_ORDERBY"));  
			sql.setString(i++, strStrCd);				
		}else{          
			System.out.println("strSlipNo = " + strSlipNo);
			sql.put(svc.getQuery("SEL_SLIP_NO"));
			sql.setString(i++, strProcStat); 
			sql.setString(i++, strProcStat); 
			sql.setString(i++, strStrCd);	    
			sql.setString(i++, strSlipNo);	
			sql.setString(i++, userId); 
			sql.setString(i++, org_flag); 		
		}
		
		ret = select2List(sql);
		return ret;
	}  	   

	/**  
	 * 
	 * 확정시점 DB 전표진행상태 조회
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List checkSlipFlag(ActionForm form) throws Exception { 
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strSlipNo     = String2.nvl(form.getParam("strSlipNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_SLIP_FLAG"));
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);			
	
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 규격단품 매입발주  상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getDetail(ActionForm form) throws Exception {
		
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd   = String2.nvl(form.getParam("strStrCd"));			// 점
		String strSlipNo  = String2.nvl(form.getParam("strSlipNo"));		// 대입전표번호

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		
		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.put(strQuery); 
		ret[0] = select2List(sql);

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		
		ret[1] = select2List(sql);

		return ret;
	}
	/**
	 * 규격단품 대출입발주  상세 내역 조회                                                                       
	 * 
	 * @param form                     
	 * @return
	 * @throws Exception
	 */
	public List[] getDetail1(ActionForm form) throws Exception {
		
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		try{
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));			// 점
		String strSlipNo   = String2.nvl(form.getParam("strSlipNo"));		// 대입전표번호
		String strPSlipNo  = String2.nvl(form.getParam("strPSlipNo"));		// 대출전표번호
		String strSlipFlag = String2.nvl(form.getParam("strSlipFlag"));		// 대출전표번호

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[3];
		
		connect("pot");

		sql.setString(i++, strStrCd);
		if("C".equals(strSlipFlag))
			sql.setString(i++, strSlipNo);
		else
			sql.setString(i++, strPSlipNo);
		
		strQuery = svc.getQuery("SEL_MASTER1") + "\n";
		sql.put(strQuery); 
		ret[0] = select2List(sql);

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL1") + "\n";
		sql.put(strQuery);   
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo); 
		ret[1] = select2List(sql);                                       

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL1") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPSlipNo);
		ret[2] = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return ret;
	}
	/**
	 * 의류단품 점출입발주  상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getDetail3(ActionForm form) throws Exception { 
		
		List ret[] = null;  
		SqlWrapper sql = null;
		Service svc = null;  
		String strQuery = "";
		int i = 1;

		String strSlipFlag= String2.nvl(form.getParam("strSlipFlag"));		// 점출점
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));			// 점출점
		String strPStrCd  = String2.nvl(form.getParam("strPStrCd"));	    // 접입점
		String strSlipNo  = String2.nvl(form.getParam("strSlipNo"));		// 점출전표번호
		String strPSlipNo = String2.nvl(form.getParam("strPSlipNo"));	// 점입전표번호 */

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		
		connect("pot");
		// 1. 마스터	
		
		if("E".equals(strSlipFlag))
			sql.setString(i++, strStrCd);
		else
			sql.setString(i++, strPStrCd);

		sql.setString(i++, strSlipNo);
		strQuery = svc.getQuery("SEL_MASTER3") + "\n";
		sql.put(strQuery);
		ret[0] = select2List(sql);

		sql.close();
		i= 1;
		// 3. 점출상세
		strQuery = svc.getQuery("SEL_DETAIL3") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);            
		ret[1] = select2List(sql);
		
		return ret;
	}
	
	/**
	 * 의류단품 매가인상하  상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getDetail4(ActionForm form) throws Exception {
		
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd   = String2.nvl(form.getParam("strStrCd"));			// 점
		String strSlipNo  = String2.nvl(form.getParam("strSlipNo"));		// 대입전표번호
 
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		
		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		strQuery = svc.getQuery("SEL_MASTER4") + "\n";
		sql.put(strQuery); 
		ret[0] = select2List(sql);

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL4") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		ret[1] = select2List(sql);
		return ret;
	}
    
	/**
	 * INVOICE 등록  마스터 내역 조회
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getMaster5(ActionForm form) throws Exception {
		
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd   = String2.nvl(form.getParam("strStrCd"));			// 점
		String strSlipNo  = String2.nvl(form.getParam("strSlipNo"));		// 대입전표번호

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		
		connect("pot");
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		strQuery = svc.getQuery("SEL_MASTER5") + "\n"; 
		sql.put(strQuery); 
		ret[0] = select2List(sql);

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL5") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		ret[1] = select2List(sql);
		return ret;
	}
	
	/**
	 * INVOICE 등록  상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail5(ActionForm form) throws Exception {
		
		List ret = null;
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
		strQuery = svc.getQuery("SEL_DETAIL5") + "\n";

		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}

	/**
	*  단품발주 매입팀장 확정한다
	* 
	* @param form
	* @param 
	* @param userId, org_flag
	* @return
	* @throws Exception
	*/
	public int reject(ActionForm form, MultiInput mi1, MultiInput mi2, MultiInput mi3, String userId, String org_flag)
	throws Exception {

		System.out.println("반려일때");
		HashMap<String, String> map = null;
				
		int ret 	= 0;
		int res 	= 0;
		int resp    = 0;//프로시저 리턴값
		int i   	= 0;
		int mstCnt 	= 0;
		
		String strBuyerYN = "";		// 바이어,SM 여부
		String strStrCd  = "";
		String strSlipNo  = "";		// 전표번호
		String strConfStat = "";    // 확정 및 확정취소 전표상태(AFTER)
		String strSlipProcStat = "";    // 확정 및 확정취소 전표상태(CURRENT)
		String strSlipFlag = ""; 
		String strPStrCd = ""; 
		String strPSlipNo = ""; 
		String strImportFlag = "";
		String strBottleSlipYN = "";
		String strStrinCanYN = "";
		String strOrdFlag = "";
		String strJobGB = "";
		String varChkDt = "";
		SqlWrapper sql = null;
		Service svc = null;
		
		String stConfSlipProcStat = "";
		String sendFlag = "";		
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			strSlipProcStat = form.getParam("strSlipProcStat");	// 확정 및 확정취소 전표상태(CURRENT)
			strSlipFlag     = form.getParam("strSlipFlag");
			strStrCd        = form.getParam("strStrCd");
			strSlipNo       = form.getParam("strSlipNo");
			strPStrCd       = form.getParam("strPStrCd");
			strPSlipNo      = form.getParam("strPSlipNo");
			strImportFlag   = form.getParam("strImportFlag");
			strBottleSlipYN = form.getParam("strBottleSlipYN");
			strStrinCanYN   = form.getParam("strStrinCanYN");
			varChkDt        = form.getParam("varChkDt");
			strOrdFlag      = form.getParam("strOrdFlag");
			sendFlag 		= form.getParam("sendFlag");	
			strJobGB        = "CAN";
			
			// 마스터
			while (mi1.next()){
				
				sql.close();
				if ("CAN".equals(strJobGB)) { // 검품확정취소(마스터)					
					i = 1;
					sql.put(svc.getQuery("UPD_MASTER_CONF1")); 
					
					
					sql.setString(i++, sendFlag);
					sql.setString(i++, userId);
					sql.setString(i++, userId);
					if("F".equals(strSlipFlag)){
						sql.setString(i++, mi1.getString("P_STR_CD"));
					}else{

						sql.setString(i++, mi1.getString("STR_CD"));
					}
					sql.setString(i++, mi1.getString("SLIP_NO"));
				}
				res = update(sql);
				mstCnt = res;
				sql.close();
				

				// 4. 발주매입Master 로그 저장
				i = 1;				
				sql.close();
				sql.put(svc.getQuery("UPD_SLPMSTLG_CONF")); 
				
				//sql.setString(i++, strConfStat);  
				if("F".equals(strSlipFlag)){
					sql.setString(i++, mi1.getString("P_STR_CD"));
				}else{

					sql.setString(i++, mi1.getString("STR_CD"));
				}
				sql.setString(i++, mi1.getString("SLIP_NO"));
				
				mstCnt += update(sql);
			
				/* 대출입과점출입 */
				if("C".equals(strSlipFlag)|| "E".equals(strSlipFlag) || "F".equals(strSlipFlag)){
					sql.close();
					
					if ("CAN".equals(strJobGB)) { // 검품확정취소(마스터)

						i = 1;
						sql.put(svc.getQuery("UPD_MASTER_CONF1")); 
						
						sql.setString(i++, sendFlag);
						sql.setString(i++, userId);
						sql.setString(i++, userId);
						if("F".equals(strSlipFlag)){
							sql.setString(i++, mi1.getString("STR_CD"));
						}else{

							sql.setString(i++, mi1.getString("P_STR_CD"));
						}
						sql.setString(i++, mi1.getString("P_SLIP_NO"));
					}
					res = update(sql);
					
					mstCnt = res;
					sql.close();
			
					// 4. 발주매입Master 로그 저장
					i = 1;				
					sql.close();
					sql.put(svc.getQuery("UPD_SLPMSTLG_CONF")); 
					
					//sql.setString(i++, strConfStat);  
					if("F".equals(strSlipFlag)){
						sql.setString(i++, mi1.getString("STR_CD"));
					}else{
						sql.setString(i++, mi1.getString("P_STR_CD"));
					}
					sql.setString(i++, mi1.getString("P_SLIP_NO"));
					mstCnt += update(sql);
				}
				
				if (mstCnt != 2) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += res;
			}				
				// 디테일
			while (mi2.next()) {

				sql.close();					
				if ("CAN".equals(strJobGB)) { // 검품확정취소(디테일)					
					i = 1; 
					sql.put(svc.getQuery("UPD_DETAIL_CONF1")); 
					
					sql.setString(i++, mi2.getString("CHK_QTY"));      
					sql.setString(i++, userId);
					sql.setString(i++, mi2.getString("STR_CD"));
					sql.setString(i++, mi2.getString("SLIP_NO"));		
					sql.setString(i++, mi2.getString("ORD_SEQ_NO"));					
				}
				
				res = update(sql);
				
				if("E".equals(strSlipFlag) || "F".equals(strSlipFlag) ){	//점출일때 한번더 탄다.

					sql.close();					
					if ("CAN".equals(strJobGB)) { // 검품확정취소(디테일)					
						i = 1; 
						sql.put(svc.getQuery("UPD_DETAIL_CONF1")); 
						
						sql.setString(i++, mi2.getString("CHK_QTY"));
						sql.setString(i++, userId);
						sql.setString(i++, strPStrCd);
						sql.setString(i++, strPSlipNo);		
						sql.setString(i++, mi2.getString("ORD_SEQ_NO"));
					}
					res = update(sql);
				}		
				
				stConfSlipProcStat = "09";		

				// SMS전송
				map = new HashMap<String, String>();
				map.put("strStrCd",         strStrCd);
				map.put("strSlipNo",        strSlipNo);
				map.put("stConfSlipProcStat",  stConfSlipProcStat);    
				
				sendSMS(form, map, userId, org_flag, sendFlag);	
				
				if(ret == 0){
					ret = res;        
				}
				
				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
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
	*  단품발주 매입팀장 확정한다
	* 
	* @param form
	* @param 
	* @param userId, org_flag
	* @return
	* @throws Exception
	*/
	public int conf(ActionForm form, MultiInput mi1, MultiInput mi2, MultiInput mi3, String userId, String org_flag)
	throws Exception {

		HashMap<String, String> map = null;
				
		int ret 	= 0;
		int res 	= 0;
		int resp    = 0;//프로시저 리턴값
		int i   	= 0;
		int mstCnt 	= 0;
		
		String strBuyerYN = "";		// 바이어,SM 여부
		String strStrCd  = "";
		String strSlipNo  = "";		// 전표번호
		String strConfStat = "";    // 확정 및 확정취소 전표상태(AFTER)
		String strSlipProcStat = "";    // 확정 및 확정취소 전표상태(CURRENT)
		String strSlipFlag = ""; 
		String strPStrCd = ""; 
		String strPSlipNo = ""; 
		String strImportFlag = "";
		String strBottleSlipYN = "";
		String strStrinCanYN = "";
		String strOrdFlag = "";
		String strJobGB = "";
		String varChkDt = "";
		String strBizType = ""; 
		SqlWrapper sql = null;
		Service svc = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함

		String stConfSlipProcStat = "";
		String sendFlag = "";
		
		String smsFlag  = ""; // 확정시 점출입 전표만 SMS전송하기 위한 플레그(점입점 권한자에게 문자전송하기 위함) (0: 점출전표제외한 전표일때, 1:점출전표확정시)
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();   
			svc = (Service) form.getService();
	        psql = new ProcedureWrapper();	//프로시저 사용위함
	        ProcedureResultSet prs = null;
			
			strSlipProcStat = form.getParam("strSlipProcStat");	// 확정 및 확정취소 전표상태(CURRENT)
			strSlipFlag     = form.getParam("strSlipFlag");
			strStrCd        = form.getParam("strStrCd");
			strSlipNo       = form.getParam("strSlipNo");
			strPStrCd       = form.getParam("strPStrCd");
			strPSlipNo      = form.getParam("strPSlipNo");
			strImportFlag   = form.getParam("strImportFlag");
			strBottleSlipYN = form.getParam("strBottleSlipYN");
			strStrinCanYN   = form.getParam("strStrinCanYN");
			varChkDt        = form.getParam("varChkDt");
			strOrdFlag      = form.getParam("strOrdFlag");	
			strBizType      = form.getParam("strBizType");	
			sendFlag 		= form.getParam("sendFlag");	

			if("E".equals(strSlipFlag)){
			   if("08".equals(strSlipProcStat)){
				   strJobGB = "CAN";				//검품취소
			   }else{
				   strJobGB = "CON"; 				//검품확정
			   }
			}
			
			if("F".equals(strSlipFlag)){
			   if("08".equals(strSlipProcStat)){
				   strJobGB = "CON";
			   }else if("09".equals(strSlipProcStat)){
				   strJobGB = "CAN"; 
			   }
			}
			
			if("A".equals(strSlipFlag) || "B".equals(strSlipFlag)|| "C".equals(strSlipFlag) ||  "G".equals(strSlipFlag)){
			   if("09".equals(strSlipProcStat)){
				   strJobGB = "CAN";
			   }else{
				   strJobGB = "CON"; 
			   }
			}
		 	
			//* 수불 및 대금반영(취소)  */
			if("CAN".equals(strJobGB)){		
			
	    	   psql.put("DPS.PKG_POCONFIRM.PR_POSLPCONFIRM", 12);    
           
               psql.setString(1,strSlipFlag);       // 전표구분
               psql.setString(2,strStrCd);          // 점
               psql.setString(3,strSlipNo);         // 전표번호
               psql.setString(4,strPStrCd);         // 상대전표 점
               psql.setString(5,strPSlipNo);        // 상대전표번호 
               psql.setString(6,"CAN");  //취소 구분
               psql.setString(7,strBottleSlipYN);   // 공병구분
               psql.setString(8,strStrinCanYN);     // 취소 시  수불반영여부(점출)
               psql.setString(9,strOrdFlag);        // 통합발주여부
               psql.setString(10, userId);          // 사용자ID
           
               psql.registerOutParameter(11, DataTypes.INTEGER);//11
               psql.registerOutParameter(12, DataTypes.VARCHAR);//12
               prs = updateProcedure(psql);
            
               resp += prs.getInt(11);    

               if (resp != 0) {
                  throw new Exception("[USER]" + prs.getString(12));
               }               
			}
			
			// 마스터
			while (mi1.next()) {
				
				sql.close();
				//저장시 프로시저 호출위한 변수 셋팅
			   
				if ("CAN".equals(strJobGB)) { // 검품확정취소(마스터)
											
					i = 1;
					sql.put(svc.getQuery("UPD_MASTER_CONF1")); 

					sql.setString(i++, sendFlag);
					sql.setString(i++, userId);  
					sql.setString(i++, userId);
					if("F".equals(strSlipFlag)){
						sql.setString(i++, mi1.getString("P_STR_CD"));
					}else{

						sql.setString(i++, mi1.getString("STR_CD"));
					}
					sql.setString(i++, mi1.getString("SLIP_NO"));
				}else{ //검품확정(마스터) 확정이면
					
					i = 1; 
					sql.put(svc.getQuery("UPD_MASTER_CONF"));						 
		            if("E".equals(strSlipFlag)){	//점출점이면 점입점에서 확정(09)해야 하므로 임시로 FLAG 설정
		            	smsFlag = "1";					   
		            }else{	
		            	smsFlag = "0";
		            }  

					sql.setString(i++, mi1.getString("CHK_DT"));
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("ORD_TOT_QTY"));
					sql.setString(i++, mi1.getString("GAP_TOT_AMT"));
					sql.setString(i++, mi1.getString("NEW_GAP_RATE"));
					sql.setString(i++, mi1.getString("NEW_COST_TAMT"));
					sql.setString(i++, mi1.getString("NEW_SALE_TAMT"));
					
					if("G".equals(strSlipFlag)){
						sql.setString(i++, mi1.getString("GAP_COST_TAMT"));
						sql.setString(i++, mi1.getString("GAP_SALE_TAMT"));
						sql.setString(i++, mi1.getString("OLD_SALE_TAMT"));
					}else{
						sql.setString(i++, "0");
						sql.setString(i++, "0");
						sql.setString(i++, "0");
					}

					if("A".equals(strSlipFlag) || "B".equals(strSlipFlag)){
					   sql.setString(i++, mi1.getString("VAT_TAMT"));
					}else{
					   sql.setString(i++, "0");	
					}

				    if("1".equals(strImportFlag)){ 
				    	sql.setString(i++, mi1.getString("EXC_TAMT")); 
				    }else{
				    	sql.setString(i++, "0"); 	 
				    }

					sql.setString(i++, userId);
					
					if("F".equals(strSlipFlag)){
						sql.setString(i++, mi1.getString("P_STR_CD"));
					}else{

						sql.setString(i++, mi1.getString("STR_CD"));
					}
					sql.setString(i++, mi1.getString("SLIP_NO"));
					//strConfStat = "09";
				}
				res = update(sql);
				mstCnt = res;
				sql.close();
		
				// 4. 발주매입Master 로그 저장
				i = 1;				
				sql.close();
				sql.put(svc.getQuery("UPD_SLPMSTLG_CONF")); 
				
				if("F".equals(strSlipFlag)){
					sql.setString(i++, mi1.getString("P_STR_CD"));
				}else{
					sql.setString(i++, mi1.getString("STR_CD"));
				}
				sql.setString(i++, mi1.getString("SLIP_NO"));
				mstCnt += update(sql);				
			}
								
			stConfSlipProcStat = "09";

			// SMS전송
			if("CAN".equals(strJobGB)){
				System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
				System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
				System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
				System.out.println("취소일때만 SMS전송!!!!!!!!!!!!!!!!!!!");
				System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
				System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
				System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
				map = new HashMap<String, String>();
				map.put("strStrCd",         strStrCd);
				map.put("strSlipNo",        strSlipNo);
				map.put("stConfSlipProcStat",  stConfSlipProcStat);    
				
				sendSMS(form, map, userId, org_flag, sendFlag);		
			//검품확정시
			}else{
				//점출점에서 확정시 점입점 관리자에게 SMS전송
				if("1".equals(smsFlag)){	
					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
					System.out.println("점출 확정만 SMS전송!!!!!!!!!!!!!!!!!!!");
					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
					System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
					map = new HashMap<String, String>();
					map.put("strStrCd",         strPStrCd);
					map.put("strSlipNo",        strPSlipNo);
					map.put("stConfSlipProcStat",  "08");    
					
					sendSMS(form, map, userId, org_flag, sendFlag);							
				}
			}				
					// 디테일
			while (mi2.next()) {	
				sql.close();					
				if ("CAN".equals(strJobGB)) { // 검품확정취소(디테일)					
					i = 1; 
					sql.put(svc.getQuery("UPD_DETAIL_CONF1")); 
					
					sql.setString(i++, mi2.getString("CHK_QTY"));
					sql.setString(i++, userId);
					sql.setString(i++, mi2.getString("STR_CD"));
					sql.setString(i++, mi2.getString("SLIP_NO"));		
					sql.setString(i++, mi2.getString("ORD_SEQ_NO"));
					
				}else{ //검품확정(디테일)
					i = 1; 
					sql.put(svc.getQuery("UPD_DETAIL_CONF"));
		
					sql.setString(i++, mi2.getString("CHK_QTY"));
					sql.setString(i++, mi2.getString("NEW_GAP_AMT"));
					sql.setString(i++, mi2.getString("NEW_GAP_RATE"));      //신차익율
					sql.setString(i++, mi2.getString("NEW_COST_AMT"));
					sql.setString(i++, mi2.getString("NEW_SALE_AMT"));
					
					if("G".equals(strSlipFlag)){
						sql.setString(i++, mi2.getString("GAP_COST_AMT"));
						sql.setString(i++, mi2.getString("GAP_SALE_AMT"));
						sql.setString(i++, mi2.getString("OLD_SALE_AMT"));	//구매가금액
					}else{
						sql.setString(i++,"0");
						sql.setString(i++,"0");
						sql.setString(i++,"0");
					}
					
					if("A".equals(strSlipFlag) || "B".equals(strSlipFlag)){
					    sql.setString(i++, mi2.getString("VAT_AMT"));
					   
					}else{
					   sql.setString(i++, "0");	
					}
					
					if("1".equals(strImportFlag)){
					    sql.setString(i++, mi2.getString("EXC_AMT")); 
					}else{
					    sql.setString(i++, "0"); 	 
					}
					
					sql.setString(i++, userId);
					sql.setString(i++, mi2.getString("STR_CD"));
					sql.setString(i++, mi2.getString("SLIP_NO"));		
					sql.setString(i++, mi2.getString("ORD_SEQ_NO"));	
				}
				
				res = update(sql);
				
				/************상대전표 업데이트하는부분*****************/
				
				if(ret == 0){
					ret = res;        
				}
				
				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
			}				

  			//* 수불 및 대금반영 (확정) */
			if("CON".equals(strJobGB)){
				psql.close();
				psql = new ProcedureWrapper();
				
		    	psql.put("DPS.PKG_POCONFIRM.PR_POSLPCONFIRM", 12); 
		        psql.setString(1,strSlipFlag);      //전표구분
		        psql.setString(2,strStrCd);        //점
		        psql.setString(3,strSlipNo);       //전표번호			        
		        psql.setString(4,strPStrCd);       // 상대전표 점
		        psql.setString(5,strPSlipNo);      //상대전표번호 
		        psql.setString(6,"CON");  //확정
		        psql.setString(7,strBottleSlipYN);  // 공병구분  
		        psql.setString(8,strStrinCanYN);    // 점입확정 시 의미없음
		        psql.setString(9,strOrdFlag);       // 통합발주여부
		        psql.setString(10, userId);         //사용자ID
		       
		        psql.registerOutParameter(11, DataTypes.INTEGER);//10
		        psql.registerOutParameter(12, DataTypes.VARCHAR);//11
		        prs = updateProcedure(psql);
		        
		        resp += prs.getInt(11);    
		
		        if (resp != 0) {
		            throw new Exception("[USER]" + prs.getString(12));
		        }
			}   
		          //* 수입일때 -수입원가 산정  */
            if("1".equals(strImportFlag)){
				psql.close();
				psql = new ProcedureWrapper();
				
				psql.put("DPS.PR_POIMPORTCOST", 6);  
				psql.setString(1,strStrCd);        //점
				psql.setString(2,strSlipNo);       //전표번호
				psql.setString(3, userId);          //사용자ID
				
				if("09".equals(strSlipProcStat)){
					psql.setString(4,"2");  //취소 					
				}else{	
				    psql.setString(4,"1");  //확정
				}
				
				psql.registerOutParameter(5, DataTypes.INTEGER);//5
				psql.registerOutParameter(6, DataTypes.VARCHAR);//6
				prs = updateProcedure(psql);
				
				resp += prs.getInt(5);    
				
				if (resp != 0) {
				    throw new Exception("[USER]" + prs.getString(6));
				}
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
	 *  <p>
	 *  SMS발송
	 *  
	 *  </p>
	 * @param form
	 * @param mi1
	 * @param userId
	 * @param org_flag
	 * @return
	 * @throws Exception
	 */
	public int sendSMS(ActionForm form, HashMap map, String userId, String org_flag, String sendFlag) 
						throws Exception {

		int ret  = 0;
		int res  = 0;
		int resp = 0;     //프로시저 리턴값
		SqlWrapper sql = null;
		Service svc = null;
		int i;		
		
		String strStrCd		    = "";		// 점
		String strSlipNo		= "";		// 전표번호
		String stConfSlipProcStat = "";	

		
		ProcedureWrapper psql = null;	//프로시저 사용위함
		try {
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}

			strStrCd		 = (String)map.get("strStrCd");
			strSlipNo		 = (String)map.get("strSlipNo");
			stConfSlipProcStat  = (String)map.get("stConfSlipProcStat");
			
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			
			psql.put("DPS.PR_POSLPSMS_IFS", 8);  
		      
			i = 1;
            psql.setString(i++, strStrCd); 				// 점코드
            psql.setString(i++, strSlipNo); 	        // 전표번호
            psql.setString(i++, stConfSlipProcStat);		// 전표상태
            psql.setString(i++, userId);				// 처리자
            psql.setString(i++, org_flag);				// 조직구분
            psql.setString(i++, sendFlag);				// 처리구분(0:승인, 1:반려, 2:검품취소)   

            psql.registerOutParameter(i++, DataTypes.INTEGER);//7
            psql.registerOutParameter(i++, DataTypes.VARCHAR);//8

            prs = updateProcedure(psql);             
            
            resp += prs.getInt(7);                         
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}

	/**  
	 * 
	 * 수입 OFFER마감체크
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List chkOfferClose(ActionForm form) throws Exception { 
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = ""; 
		int i = 1;
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strOfferClose = String2.nvl(form.getParam("strOfferClose"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_OFF_CLOSE"));
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOfferClose);		 	
	
		ret = select2List(sql);
		return ret;
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
			if("0".equals(strSendFlag)){
				strSendFlag = "CON";
			}else if("2".equals(strSendFlag)){
				strSendFlag = "CAN";
			}else{
				strSendFlag = "BAN";
			}
			
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
	 * 세금계산서 발행여부
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List checkTaxYn(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strSlipNo     = String2.nvl(form.getParam("strSlipNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);

		strQuery = svc.getQuery("SEL_TAX_YN") + "\n";
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
