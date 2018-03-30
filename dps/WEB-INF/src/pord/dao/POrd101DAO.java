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
 * <p>물품 입고/반품 등록</p> 
 *   
 * @created  on 1.0, 2010/01/26 
 * @created  by 박래형(FUJITSU KOREA LTD.) 
 *  
 * @modified on   
 * @modified by 
 * @caused   by  
 */ 

public class POrd101DAO extends AbstractDAO {    	 
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
	
		sql.put(svc.getQuery("SEL_LIST"));
		sql.setString(i++, strStrCd);		
		sql.setString(i++, userId);
		sql.setString(i++, org_flag);
		 
		if("".equals(strSlipNo)){
			if("1".equals(org_flag)){						// 판매
				sql.put(svc.getQuery("SEL_SALE_ORG_CD"));
				sql.setString(i++, strProcStat);
				sql.setString(i++, strPumbun);
				sql.setString(i++, strVen);                    
				sql.setString(i++, strSlip_flag);
				sql.setString(i++, strOrgCd);
			}else if("2".equals(org_flag)){					// 매입
				sql.put(svc.getQuery("SEL_BUY_ORG_CD"));
				sql.setString(i++, strProcStat);
				sql.setString(i++, strPumbun);
				sql.setString(i++, strVen);                    
				sql.setString(i++, strSlip_flag);
				sql.setString(i++, strOrgCd);          
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
		}else{
			sql.put(svc.getQuery("WHERE_SLIP_NO")); 
			sql.setString(i++, strSlipNo);
		}
		sql.put(svc.getQuery("SEL_ORDERBY"));  

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
//		System.out.println("strquery : "+ strQuery);
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
//		System.out.println("strquery : "+ strQuery);
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;

	}
	
	/**
	 *  물품 입고/반품 내용을  저장, 수정 처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi1, MultiInput mi2, String userId, String org_flag)
	throws Exception {

		int ret 	= 0;
		int res 	= 0;
		int i   	= 0;
		int mstCnt 	= 0;
		int resp    		= 0;     //프로시저 리턴값
		
		String strBuyerYN = "";		// 바이어,SM 여부
		String strSlipNo  = "";		// 전표번호
		
		SqlWrapper sql = null;
		Service svc = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			strBuyerYN = form.getParam("strBuyerYN");		// 바이어,SM 여부
			
			
			// 마스터
			while (mi1.next()) {
				
				sql.close();

				System.out.println("strBuyerYN::"+strBuyerYN+":org_flag:"+org_flag);
				// 로그인아이디가 바이어, SM일 경우 확정처리한다.
				if("Y".equals(strBuyerYN) && "1".equals(org_flag)){			// 로그인사번이 판매조직일 경우 SM확정
					mi1.setString("SM_ID", userId);
					mi1.setString("SM_CONF_DT", mi1.getString("ORD_DT"));
					mi1.setString("ORD_CONF_DT", "        ");
					mi1.setString("SLIP_PROC_STAT", "01");
					
				}else if("Y".equals(strBuyerYN) && "2".equals(org_flag)){	// 로그인사번이 매입조직일 경우 바이어확정
					mi1.setString("BUYER_CONF_ID", userId);
					mi1.setString("SM_CONF_DT", "        ");
					mi1.setString("ORD_CONF_DT", mi1.getString("ORD_DT"));
					mi1.setString("SLIP_PROC_STAT", "04");
				}else{
					mi1.setString("SM_CONF_DT", "        ");
					mi1.setString("ORD_CONF_DT", "        ");
					mi1.setString("SLIP_PROC_STAT", "00");					
				}					
				
			

//				System.out.println("######################################################");
//				System.out.println("##strBuyerYN   ##"+strBuyerYN+":org_flag::"+org_flag);
//				System.out.println("##SM_ID        ##"+mi1.getString("SM_ID"));
//				System.out.println("##SM_CONF_DT   ##"+mi1.getString("SM_CONF_DT"));
//				System.out.println("##BUYER_CONF_ID##"+mi1.getString("BUYER_CONF_ID"));
//				System.out.println("##ORD_CONF_DT  ##"+mi1.getString("ORD_CONF_DT"));
//				System.out.println("######################################################");

				if (mi1.IS_INSERT()) { // 저장
					
					// 전표번호를 생성한다.(시퀀스사용)
					sql.put(svc.getQuery("SEL_SLIP_NO"));
					sql.setString(1, mi1.getString("STR_CD"));
					sql.setString(2, mi1.getString("ORD_DT"));
					sql.setString(3, mi1.getString("SLIP_FLAG"));
					System.out.println("sql : "+ sql);
					
					Map mapSlipNo = (Map)selectMap(sql);
					strSlipNo = mapSlipNo.get("SLIP_NO").toString();
					mi1.setString("SLIP_NO", strSlipNo); 
					sql.close();										

					String strDetailCount	= String2.nvl(form.getParam("strDetailCount"));
					
					i = 1; 
					// 3. 마스터테이블에 저장
					sql.put(svc.getQuery("INS_MASTER"));
					
					 sql.setString(i++, mi1.getString("SLIP_NO")); 
					 sql.setString(i++, mi1.getString("STR_CD"));  
					 sql.setString(i++, mi1.getString("PUMBUN_CD")); 
					 sql.setString(i++, mi1.getString("VEN_CD"));   
					 sql.setString(i++, mi1.getString("SLIP_FLAG"));
					 sql.setString(i++, "0");  							/* 발주주체구분 : 0(백화점발주) */ 
					 sql.setString(i++, "0");    						/* 발주구분           : 0(일반) */  
					 sql.setString(i++, "0"); 							/* 자동전표구분 : 0(일반전표) */   
					 sql.setString(i++, mi1.getString("AFT_ORD_FLAG")); /* 사전사후구분 : 0(사전전표) */ 
					 sql.setString(i++, mi1.getString("ORD_DT"));		/* 발주일 */    
					 sql.setString(i++, mi1.getString("DELI_DT"));		/* 납품예정일 */
					 sql.setString(i++, mi1.getString("MG_APP_DT"));	/* 마진적용일 */
					 sql.setString(i++, mi1.getString("EVENT_FLAG"));	/* 행사구분 */
					 sql.setString(i++, mi1.getString("EVENT_RATE"));	/* 행사율 */
					 sql.setString(i++, mi1.getString("SM_CONF_DT"));	/* SM확정일자 */
					 sql.setString(i++, mi1.getString("SM_ID"));		/* SM ID */  
					 sql.setString(i++, mi1.getString("BUYER_CONF_ID"));/* 바이어ID */
					 sql.setString(i++, mi1.getString("ORD_CONF_DT"));	/* 바이어확정일자(발주확정일자) */ 
					 sql.setString(i++, mi1.getString("BUYER_CD"));          
					 sql.setString(i++, mi1.getString("SLIP_PROC_STAT"));   
					 sql.setString(i++, mi1.getString("DTL_CNT"));     
					 sql.setString(i++, mi1.getString("ORD_TOT_QTY"));
					 sql.setString(i++, mi1.getString("NEW_COST_TAMT")); 
					 sql.setString(i++, mi1.getString("NEW_SALE_TAMT")); 
					 sql.setString(i++, mi1.getString("GAP_TOT_AMT")); 
					 sql.setString(i++, mi1.getString("NEW_GAP_RATE"));
					 sql.setString(i++, mi1.getString("VAT_TAMT"));  		/* 부가세  */ 
					 sql.setString(i++, mi1.getString("REMARK"));        
					 sql.setString(i++, mi1.getString("BIZ_TYPE"));      
					 sql.setString(i++, mi1.getString("TAX_FLAG"));     
					 sql.setString(i++, "N");   
					 sql.setString(i++, userId); 
					 sql.setString(i++, userId);  
					 sql.setString(i++, mi1.getString("BIZ_TYPE"));     
					 sql.setString(i++, mi1.getString("SLIP_FLAG"));

					 res = update(sql);
					 
					// 4. 상세 데이터를 저장한다.
					saveDetail(form, mi1, mi2, strSlipNo, userId);

					// 5. 발주매입Master 로그 저장  
					saveMasterLog(form, mi1, userId);
					
					if (res <= 0) {
						throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
					// SMS전송
					sendSMS(form, mi1, userId, org_flag);
					 
				}else if(mi1.IS_UPDATE()){// 수정
					
					i = 1;
					sql.put(svc.getQuery("UPD_MASTER"));  
					
//					sql.setString(i++, mi1.getString("STR_CD"));
					sql.setString(i++, mi1.getString("SLIP_FLAG"));
					sql.setString(i++, mi1.getString("AFT_ORD_FLAG"));
					sql.setString(i++, mi1.getString("PUMBUN_CD"));
					sql.setString(i++, mi1.getString("ORD_DT"));
					sql.setString(i++, mi1.getString("DELI_DT"));
					sql.setString(i++, mi1.getString("MG_APP_DT"));
					sql.setString(i++, mi1.getString("EVENT_FLAG"));
					sql.setString(i++, mi1.getString("EVENT_RATE"));
					sql.setString(i++, mi1.getString("REMARK"));
					sql.setString(i++, mi1.getString("DTL_CNT"));					
					sql.setString(i++, mi1.getString("ORD_TOT_QTY"));
					sql.setString(i++, mi1.getString("NEW_COST_TAMT"));
					sql.setString(i++, mi1.getString("NEW_SALE_TAMT"));
					sql.setString(i++, mi1.getString("GAP_TOT_AMT"));
					sql.setString(i++, mi1.getString("NEW_GAP_RATE"));
					sql.setString(i++, mi1.getString("VAT_TAMT"));  		/* 부가세  */ 
					sql.setString(i++, mi1.getString("BIZ_TYPE"));     
					 sql.setString(i++, mi1.getString("SLIP_FLAG"));
					sql.setString(i++, mi1.getString("STR_CD"));
					sql.setString(i++, mi1.getString("SLIP_NO"));
					
					res = update(sql);
					
					// 4. 상세 데이터를 저장한다.
					saveDetail(form, mi1, mi2, strSlipNo, userId);

					// 5. 발주매입Master 로그 저장  
					saveMasterLog(form, mi1, userId);
					
					if (res <= 0) {
						throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
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
	 *  <p>
	 *  상세데이터를 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi2
	 * @param strID
	 * @param strSlipNo
	 * @return
	 * @throws Exception
	 */
	public int saveDetail(ActionForm form, MultiInput mi1, MultiInput mi2, String strSlipNo, String userId) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;		
		
		try {
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			// 디테일
			while (mi2.next()) {
		
				sql.close();	
				
				if (mi2.IS_INSERT()) { // 저장						
					if(!"".equals(strSlipNo)){
						mi2.setString("SLIP_NO", strSlipNo);
					}						
					// 1. 전표상세번호 생성
					sql.put(svc.getQuery("SEL_ORD_SEQ_NO"));
					
					sql.setString(1, mi1.getString("STR_CD"));								//점코드 못받아온다
					sql.setString(2, mi1.getString("SLIP_NO"));
					
					Map mapSeqNo = (Map)selectMap(sql);
					mi2.setString("ORD_SEQ_NO", mapSeqNo.get("ORD_SEQ_NO").toString());					
					sql.close();
				
					i = 1; 
					sql.put(svc.getQuery("INS_DETAIL"));
					sql.setString(i++, mi2.getString("STR_CD"));							//점코드 못받아온다
					sql.setString(i++, mi2.getString("SLIP_NO"));						
					sql.setString(i++, mi2.getString("ORD_SEQ_NO"));			
					sql.setString(i++, mi2.getString("PUMMOK_CD"));	  
					sql.setString(i++, mi2.getString("PUMMOK_SRT_CD"));
					sql.setString(i++, "        ");                    /* 단품코드 */   											
					sql.setString(i++, mi2.getString("ORD_UNIT_CD"));
					sql.setString(i++, mi2.getString("MG_RATE"));
					sql.setString(i++, mi2.getString("ORD_QTY"));	
					sql.setString(i++, mi2.getString("MG_RATE"));							//신차익율은 마진율과 같게
					sql.setString(i++, mi2.getString("NEW_GAP_AMT"));
					sql.setString(i++, mi2.getString("NEW_COST_PRC"));
					sql.setString(i++, mi2.getString("NEW_COST_AMT"));
					sql.setString(i++, mi2.getString("NEW_SALE_PRC"));
					sql.setString(i++, mi2.getString("NEW_SALE_AMT"));
					sql.setString(i++, mi2.getString("VAT_AMT"));  		                    /* 부가세  */ 
					sql.setString(i++, mi2.getString("PUMBUN_CD"));							//품번코드		
					sql.setString(i++, mi2.getString("VEN_CD"));		
					sql.setString(i++, mi2.getString("SLIP_FLAG"));							
					sql.setString(i++, mi2.getString("TAG_FLAG"));							//택 구분
					sql.setString(i++, mi2.getString("TAG_PRT_OWN_FLAG"));					//택 발행 주체
					sql.setString(i++, userId);
					sql.setString(i++, userId); 	
					res = update(sql);

				}else if(mi2.IS_UPDATE()){// 디테일 수정
					System.out.println("detail update 시작");
					i = 1; 
					sql.put(svc.getQuery("UPD_DETAIL")); 
					sql.setString(i++, mi2.getString("PUMMOK_CD"));
					sql.setString(i++, mi2.getString("PUMMOK_SRT_CD"));
					sql.setString(i++, mi2.getString("ORD_UNIT_CD"));  
					sql.setString(i++, mi2.getString("MG_RATE"));		//마진율
					sql.setString(i++, mi2.getString("ORD_QTY"));
					sql.setString(i++, mi2.getString("NEW_COST_PRC"));
					sql.setString(i++, mi2.getString("NEW_COST_AMT"));
					sql.setString(i++, mi2.getString("NEW_SALE_PRC"));
					sql.setString(i++, mi2.getString("NEW_SALE_AMT"));
					sql.setString(i++, mi2.getString("NEW_GAP_AMT"));
					sql.setString(i++, mi2.getString("MG_RATE"));      // 신차익율
					sql.setString(i++, mi2.getString("VAT_AMT"));      /* 부가세  */ 
					sql.setString(i++, mi2.getString("PUMBUN_CD"));
					sql.setString(i++, mi2.getString("VEN_CD"));
					sql.setString(i++, mi2.getString("SLIP_FLAG"));
					sql.setString(i++, mi2.getString("TAG_FLAG"));
					sql.setString(i++, mi2.getString("TAG_PRT_OWN_FLAG"));				
					sql.setString(i++, userId);							//수정자						
					sql.setString(i++, mi2.getString("STR_CD"));
					sql.setString(i++, mi2.getString("SLIP_NO"));		
					sql.setString(i++, mi2.getString("ORD_SEQ_NO"));
					res = update(sql);
					
				}else if(mi2.IS_DELETE()){ // 삭제
					i = 1;
					sql.put(svc.getQuery("DEL_DETAIL")); 
					//수정자						
					sql.setString(i++, mi2.getString("STR_CD"));
					sql.setString(i++, mi2.getString("SLIP_NO"));		
					sql.setString(i++, mi2.getString("ORD_SEQ_NO"));
					res = update(sql);
				}
				
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
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}
	
	/**
	*  규격단품 매입발주  삭제한다.
	* 
	* @param form
	* @param mi1
	* @param strID
	* @return
	* @throws Exception
	*/
	public int delete(ActionForm form, String userId)
		throws Exception {
		
		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			sql.close();
			sql.put(svc.getQuery("DEL_DETAIL_ALL")); 
			
			sql.setString(1, form.getParam("strStrCd"));
			sql.setString(2, form.getParam("strSlipNo"));
			res = update(sql);
			
			sql.close();
			sql.put(svc.getQuery("DEL_DETAIL_LOG")); 
			
			sql.setString(1, form.getParam("strStrCd"));
			sql.setString(2, form.getParam("strSlipNo"));
			res = update(sql);
			
			sql.close();
			sql.put(svc.getQuery("DEL_MASTER")); 
			
			sql.setString(1, form.getParam("strStrCd"));
			sql.setString(2, form.getParam("strSlipNo"));
			res = update(sql);
		
			if (res  < 0) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 삭제를 하지 못했습니다.");
			}
		
			ret += res;
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
//		System.out.println("strquery : "+ strQuery);
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}

	/**
	 * 단축코드 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getPmkSrtInfo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strPumbunCd	= String2.nvl(form.getParam("strPumbunCd"));
		String strPmkSrtCd	= String2.nvl(form.getParam("strPmkSrtCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strPmkSrtCd);

		strQuery = svc.getQuery("SEL_PUMMOK_SRT_INFO") + "\n";
//		System.out.println("strquery : "+ strQuery);
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}

	/**
	 *  <p>
	 *  발주로그를 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi1 
	 * @param strID
	 * @param strSlipNo
	 * @return
	 * @throws Exception
	 */
	public int saveMasterLog(ActionForm form, MultiInput mi1, String userId) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		
		try {

			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			// 5. 발주매입Master 로그 저장
			sql.close();
			i = 1;				
			sql.put(svc.getQuery("INS_MASTER_LOG"));
			sql.setString(i++, mi1.getString("STR_CD"));  
			sql.setString(i++, mi1.getString("SLIP_NO"));;
			sql.setString(i++, mi1.getString("SLIP_FLAG"));
			sql.setString(i++, mi1.getString("SLIP_PROC_STAT"));    
			sql.setString(i++, mi1.getString("STR_CD"));  
			sql.setString(i++, mi1.getString("SLIP_NO"));
			sql.setString(i++, mi1.getString("SLIP_FLAG"));
			sql.setString(i++, mi1.getString("SLIP_PROC_STAT"));
			res += update(sql);				
			
			if (res == 0) {
				throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			ret += res;
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
	public int sendSMS(ActionForm form, MultiInput mi1, String userId, String org_flag) 
						throws Exception {

		int ret  = 0;
		int res  = 0;
		int resp = 0;     //프로시저 리턴값
		SqlWrapper sql = null;
		Service svc = null;
		int i;		
		
		ProcedureWrapper psql = null;	//프로시저 사용위함
		try {
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			
			psql.put("DPS.PR_POSLPSMS_IFS", 8);  
		    
			i = 1;
            psql.setString(i++, mi1.getString("STR_CD")); 				// 점코드
            psql.setString(i++, mi1.getString("SLIP_NO")); 				// 전표번호
            psql.setString(i++, mi1.getString("SLIP_PROC_STAT"));		// 전표상태
            psql.setString(i++, userId);								// 처리자
            psql.setString(i++, org_flag);							    // 조직구분
            psql.setString(i++, "0");							        // 처리구분(0:승인, 1:반려, 2:검품취소)   

            psql.registerOutParameter(i++, DataTypes.INTEGER);//7
            psql.registerOutParameter(i++, DataTypes.VARCHAR);//8


            prs = updateProcedure(psql);             
            
            resp += prs.getInt(7);    
           // if (resp <= 0) {
           //     throw new Exception("[USER]"+ prs.getString(8));
           // }                                          
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}
}

