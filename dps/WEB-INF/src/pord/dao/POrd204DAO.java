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
 * <p>물품 입고/반품 등록</p> 
 *    
 * @created  on 1.0, 2010/01/26 
 * @created  by 박래형(FUJITSU KOREA LTD.)
 *  
 * @modified on    
 * @modified by  
 * @caused   by 
 */

public class POrd204DAO extends AbstractDAO {    	
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
		String strGiJunDtType= String2.nvl(form.getParam("strGiJunDtType"));
		String strStartDt    = String2.nvl(form.getParam("strStartDt"));
		String strEndDt      = String2.nvl(form.getParam("strEndDt"));    
		String strProcStat   = String2.nvl(form.getParam("strProcStat")); 
		String strPumbun     = String2.nvl(form.getParam("strPumbun"));   
		String strVen        = String2.nvl(form.getParam("strVen"));       
		String strSlip_flag  = String2.nvl(form.getParam("strSlip_flag")); 
		String strSlipNo     = String2.nvl(form.getParam("strSlipNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");

		if("".equals(strSlipNo)){
			sql.put(svc.getQuery("SEL_LIST"));
			sql.setString(i++, strProcStat);
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);                    
			sql.setString(i++, strSlip_flag);
			sql.setString(i++, userId); 
			sql.setString(i++, org_flag); 
			
			if("1".equals(org_flag)){						// 판매
				sql.put(svc.getQuery("SEL_SALE_ORG_CD"));
				sql.setString(i++, strOrgCd);
			}else if("2".equals(org_flag)){					// 매입
				sql.put(svc.getQuery("SEL_BUY_ORG_CD"));
				sql.setString(i++, strOrgCd);          
			}
			if("N".equals(strProcStat)){						//미확정
				sql.put(svc.getQuery("SEL_NON_CONF"));
				//sql.setString(i++, '01');
			}
			if("0".equals(strGiJunDtType)){					// 발주일
				sql.put(svc.getQuery("SEL_ORD_DT"));
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);
			} else if("1".equals(strGiJunDtType)){			// 발주확정일
				sql.put(svc.getQuery("SEL_ORD_CONF"));    
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);		             
			} else if("2".equals(strGiJunDtType)){			// 납품예정일
				sql.put(svc.getQuery("SEL_DELI_DT"));
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);			
			} else if("3".equals(strGiJunDtType)){			// 검품확정일
				sql.put(svc.getQuery("SEL_CHK_DT"));
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);		 
			}
			sql.setString(i++, strStrCd);		
			sql.put(svc.getQuery("SEL_ORDERBY"));  			
		}else{
			System.out.println("strSlipNo = " + strSlipNo);
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
	 * 품목 매입발주 매입/반품  내역 조회
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

		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strSlipNo     = String2.nvl(form.getParam("strSlipNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);

		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 품목 매입발주 매입/반품  상세 내역 조회
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
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strSlipNo     = String2.nvl(form.getParam("strSlipNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);

		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;

	}
	
	/**
	 * 행사구분 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMarginFlag(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd			= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd		= String2.nvl(form.getParam("strPumbunCd"));
		String strMarginAppDt	= String2.nvl(form.getParam("strMarginAppDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strMarginAppDt);

		strQuery = svc.getQuery("SEL_MARGIN_FLAG") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 행사율 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMarginRate(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd			= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd		= String2.nvl(form.getParam("strPumbunCd"));
		String strMarginAppDt	= String2.nvl(form.getParam("strMarginAppDt"));
		String strMarginGbn	    = String2.nvl(form.getParam("strMarginGbn"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strMarginAppDt);
		sql.setString(i++, strMarginGbn);

		strQuery = svc.getQuery("SEL_MARGIN_RATE") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	*  비단품(품목) 매입/반품 등록전표를  검품 확정(취소)한다
	* 
	* @param form
	* @param 
	* @param userId, org_flag
	* @return
	* @throws Exception
	*/
	
	public int reject(ActionForm form, MultiInput mi1, MultiInput mi2, String userId, String org_flag)
	throws Exception {
		
		HashMap<String, String> map = null;

		int ret 	= 0;
		int res 	= 0;
		int resp    = 0;//프로시저 리턴값
		int i   	= 0;
		int mstCnt 	= 0;
		
		String strBuyerYN = "";		    // 바이어,SM 여부
		String strStrCd  = "";
		String strSlipNo  = "";		    // 전표번호
		String strConfStat = "";        // 확정 및 확정취소 전표상태(AFTER)
		String strSlipProcStat = "";    // 확정 및 확정취소 전표상태(CURRENT)
		String strSlipFlag = ""; 
		String strOrgSlipProcStat = "";

		String stConfSlipProcStat = "";
		String sendFlag = "";
		
		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
		    ProcedureResultSet prs = null;
			
			strSlipProcStat = form.getParam("strSlipProcStat");	// 확정 및 확정취소 전표상태(CURRENT)
			strSlipFlag     = form.getParam("strSlipFlag");
			strStrCd        = form.getParam("strStrCd");
			strSlipNo       = form.getParam("strSlipNo");

			sendFlag        = form.getParam("sendFlag");
			strOrgSlipProcStat = form.getParam("strOrgSlipProcStat");
			
			// 마스터
			while (mi1.next()) {
				
				sql.close();
				
				if ("09".equals(strSlipProcStat)) { // 검품확정취소(마스터)
										
					i = 1;
					sql.put(svc.getQuery("UPD_MASTER_CONF1")); 
					
					sql.setString(i++, userId);
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("STR_CD"));
					sql.setString(i++, mi1.getString("SLIP_NO"));
					strConfStat = "00";
				}else{ //검품확정(마스터)
					
					i = 1; 
					sql.put(svc.getQuery("UPD_MASTER_CONF"));

    				sql.setString(i++, mi1.getString("ORD_CF_DT"));
    				sql.setString(i++, mi1.getString("CHK_DT"));
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("ORD_TOT_QTY"));
					sql.setString(i++, mi1.getString("GAP_TOT_AMT"));
					sql.setString(i++, mi1.getString("NEW_GAP_RATE"));
					sql.setString(i++, mi1.getString("NEW_COST_TAMT"));
					sql.setString(i++, mi1.getString("NEW_SALE_TAMT"));
					sql.setString(i++, mi1.getString("VAT_TAMT"));
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("STR_CD"));
					sql.setString(i++, mi1.getString("SLIP_NO"));
					strConfStat = "09";
				}
				res = update(sql);
				mstCnt = res;
				sql.close();
		
				// 4. 발주매입Master 로그 저장
				i = 1;				
				sql.close();
				sql.put(svc.getQuery("UPD_SLPMSTLG_CONF")); 
				
				sql.setString(i++, strConfStat);  
				sql.setString(i++, mi1.getString("STR_CD"));
				sql.setString(i++, mi1.getString("SLIP_NO"));
				
				mstCnt += update(sql);			
				
				if (mstCnt != 2) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += res;
			    }				
				// 디테일
				while (mi2.next()) {
			
					sql.close();					
					if ("09".equals(strSlipProcStat)) { // 검품확정취소(디테일)					
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
						sql.setString(i++, mi2.getString("MG_RATE"));      //신차익율
						sql.setString(i++, mi2.getString("NEW_COST_AMT"));
						sql.setString(i++, mi2.getString("NEW_SALE_AMT"));
						sql.setString(i++, mi2.getString("VAT_AMT"));
						sql.setString(i++, userId);
						sql.setString(i++, mi2.getString("STR_CD"));
						sql.setString(i++, mi2.getString("SLIP_NO"));		
						sql.setString(i++, mi2.getString("ORD_SEQ_NO"));	
					}
					res = update(sql);
					
					if(ret == 0){
						ret = res;        
					}
					
					if (res != 1) {
						throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}                                                   
				}		

				stConfSlipProcStat = "09";
				if("0".equals(sendFlag)){	//검품확정시에는 SMS 전송을 하지 않는다	
					System.out.println("확정시에는 SMS발송하지 않음");
				}else{
					System.out.println("반려 SMS발송");
					// SMS전송
					map = new HashMap<String, String>();
					map.put("strStrCd",         strStrCd);
					map.put("strSlipNo",        strSlipNo);
					map.put("stConfSlipProcStat",  stConfSlipProcStat);    
					
					sendSMS(form, map, userId, org_flag, sendFlag);	
					
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
	*  비단품(품목) 매입/반품 등록전표를  검품 확정(취소)한다
	* 
	* @param form
	* @param 
	* @param userId, org_flag
	* @return
	* @throws Exception
	*/
	
	public int conf(ActionForm form, MultiInput mi1, MultiInput mi2, String userId, String org_flag)
	throws Exception {

		HashMap<String, String> map = null;
		
		int ret 	= 0;
		int res 	= 0;
		int resp    = 0;//프로시저 리턴값
		int i   	= 0;
		int mstCnt 	= 0;
		
		String strBuyerYN = "";		    // 바이어,SM 여부
		String strStrCd  = "";
		String strSlipNo  = "";		    // 전표번호
		String strConfStat = "";        // 확정 및 확정취소 전표상태(AFTER)
		String strSlipProcStat = "";    // 확정 및 확정취소 전표상태(CURRENT)
		String strSlipFlag = ""; 
		
		String stConfSlipProcStat = "";
		String sendFlag = "";
		String strOrgSlipProcStat = "";
		
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
			
			strSlipProcStat = form.getParam("strSlipProcStat");	// 확정 및 확정취소 전표상태(CURRENT)
			strSlipFlag     = form.getParam("strSlipFlag");
			strStrCd        = form.getParam("strStrCd");
			strSlipNo       = form.getParam("strSlipNo");
			
			sendFlag        = form.getParam("sendFlag");
			strOrgSlipProcStat = form.getParam("strOrgSlipProcStat");

			//* 수불 및 대금반영(취소)  */
			if ("09".equals(strSlipProcStat)){
				System.out.println("검품확정취소");
				
	    	   psql.put("DPS.PKG_POCONFIRM.PR_POSLPCONFIRM", 12);    
           
               psql.setString(1,strSlipFlag);      //전표구분
               psql.setString(2,strStrCd);        //점
               psql.setString(3,strSlipNo);       //전표번호
               psql.setString(4,strStrCd);       // 점
               psql.setString(5,strSlipNo);      //전표번호 
               psql.setString(6,"CAN");  //취소 구분
               psql.setString(7,"N");  // 공병구분
               psql.setString(8,"Y");  // 취소 시  수불반영여부(점출)
               psql.setString(9,"0");  // 통합발주 없음 0
               psql.setString(10, userId);          //사용자ID
           
               psql.registerOutParameter(11, DataTypes.INTEGER);//10
               psql.registerOutParameter(12, DataTypes.VARCHAR);//11
               prs = updateProcedure(psql);
            
               resp += prs.getInt(11);    

               if (resp != 0) {
                  throw new Exception("[USER]" + prs.getString(12));
               }
			}
			
			// 마스터
			while (mi1.next()) {         
				
				sql.close();
				
				if ("09".equals(strSlipProcStat)) { // 검품확정취소(마스터)
					
					String strDetailCount	= String2.nvl(form.getParam("strDetailCount"));
					
					i = 1; 
					sql.put(svc.getQuery("UPD_MASTER_CONF1")); 
					
					sql.setString(i++, userId);
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("STR_CD"));
					sql.setString(i++, mi1.getString("SLIP_NO"));
					strConfStat = "00";
				}else{ //검품확정(마스터)
					
					i = 1; 
					sql.put(svc.getQuery("UPD_MASTER_CONF"));

    				sql.setString(i++, mi1.getString("ORD_CF_DT"));
    				sql.setString(i++, mi1.getString("CHK_DT"));
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("ORD_TOT_QTY"));
					sql.setString(i++, mi1.getString("GAP_TOT_AMT"));
					sql.setString(i++, mi1.getString("NEW_GAP_RATE"));
					sql.setString(i++, mi1.getString("NEW_COST_TAMT"));
					sql.setString(i++, mi1.getString("NEW_SALE_TAMT"));
					sql.setString(i++, mi1.getString("VAT_TAMT"));
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("STR_CD"));
					sql.setString(i++, mi1.getString("SLIP_NO"));
					strConfStat = "09";
				}
				res = update(sql);
				mstCnt = res;
				sql.close();
		
				// 4. 발주매입Master 로그 저장
				i = 1;				
				sql.close();
				sql.put(svc.getQuery("UPD_SLPMSTLG_CONF")); 
				
				sql.setString(i++, strConfStat);  
				sql.setString(i++, mi1.getString("STR_CD"));
				sql.setString(i++, mi1.getString("SLIP_NO"));
				
				mstCnt += update(sql);			
				
				if (mstCnt != 2) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += res;
			}				
				// 디테일
				while (mi2.next()) {
			 
					sql.close();					
					if ("09".equals(strSlipProcStat)) { // 검품확정취소(디테일)					
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
						sql.setString(i++, mi2.getString("MG_RATE"));      //신차익율
						sql.setString(i++, mi2.getString("NEW_COST_AMT"));
						sql.setString(i++, mi2.getString("NEW_SALE_AMT"));
						sql.setString(i++, mi2.getString("VAT_AMT"));
						sql.setString(i++, userId);
						sql.setString(i++, mi2.getString("STR_CD"));
						sql.setString(i++, mi2.getString("SLIP_NO"));		
						sql.setString(i++, mi2.getString("ORD_SEQ_NO"));	
					}
					res = update(sql);
					
					if(ret == 0){
						ret = res;        
					}
					
					if (res != 1) {
						throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}                                                   
				}
				
				/* 수불 및 대금반영(확정)  
				*/
				if ("00".equals(strSlipProcStat)){
					
		    	   psql.put("DPS.PKG_POCONFIRM.PR_POSLPCONFIRM", 12);    
	           
	               psql.setString(1,strSlipFlag);      //전표구분
	               psql.setString(2,strStrCd);        //점
	               psql.setString(3,strSlipNo);       //전표번호
	               psql.setString(4,strStrCd);       // 점
	               psql.setString(5,strSlipNo);      //전표번호
	               psql.setString(6,"CON");  //취소 구분
	               psql.setString(7,"N");  //공병구분
	               psql.setString(8,"Y");  // 취소 시  수불반영여부(점출)
	               psql.setString(9,"0");  // 통합발주 없음 0
	               psql.setString(10, userId);          //사용자ID
	           
	               psql.registerOutParameter(11, DataTypes.INTEGER);//10
	               psql.registerOutParameter(12, DataTypes.VARCHAR);//11
	               prs = updateProcedure(psql);
	               
	               resp += prs.getInt(11);    

	               if (resp != 0) {
	                  throw new Exception("[USER]" + prs.getString(12));
	               }	                              
				}

				stConfSlipProcStat = "09";

				if("0".equals(sendFlag)){	//검품확정시에는 SMS 전송을 하지 않는다	
					System.out.println("확정시 SMS발송 하지 않음");
				}else{
					// SMS전송
					map = new HashMap<String, String>();
					map.put("strStrCd",         strStrCd);
					map.put("strSlipNo",        strSlipNo);
					map.put("stConfSlipProcStat",  stConfSlipProcStat);    
					
					sendSMS(form, map, userId, org_flag, sendFlag);			
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
	 * 품목코드 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getPummokInfo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strPumbunCd	= String2.nvl(form.getParam("strPumbunCd"));
		String strPummokCd	= String2.nvl(form.getParam("strPummokCd"));
 
		sql = new SqlWrapper();  
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strPummokCd);

		strQuery = svc.getQuery("SEL_PUMMOK_INFO") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
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
            psql.setString(i++, stConfSlipProcStat);	// 전표상태
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
			String strSendFlag 	= String2.nvl(form.getParam("strSendFlag"));// 취소구분
			if("0".equals(strSendFlag)){
				strSendFlag = "CON";
			}else if("2".equals(strSendFlag)){
				strSendFlag = "CAN";
			}else{
				strSendFlag = "BAN";
			}
			
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
}
