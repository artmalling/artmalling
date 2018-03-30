/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.dao;

import java.util.HashMap;
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
 * <p> 신선단품 점출입발주 등록  DAO </p>
 * 
 * @created  on 1.0, 2010/03/14
 * @created  by 김경은
 * 
 * @modified on    
 * @modified by 
 * @caused   by 
 */

public class POrd109DAO extends AbstractDAO {
    	
	/**
	 * 신선단품 점출입발주 리스트 내역 조회
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
		String strSlipNo     = String2.nvl(form.getParam("strSlipNo"));
		String strSkuFlag    = "1"; // 단품
		String strSkuType    = "2"; // 신선단품
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_LIST"));
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSkuFlag);
		sql.setString(i++, strSkuType);          
		                                
		sql.setString(i++, userId);
		sql.setString(i++, org_flag);
		
		if("".equals(strSlipNo)){
			if("1".equals(org_flag)){						// 판매
				sql.put(svc.getQuery("SEL_SALE_ORG_CD"));
				sql.setString(i++, strProcStat);
				sql.setString(i++, strPumbun);
				sql.setString(i++, strBizType);
				sql.setString(i++, strOrgCd);
			}else if("2".equals(org_flag)){					// 매입
				sql.put(svc.getQuery("SEL_BUY_ORG_CD"));
				sql.setString(i++, strProcStat);
				sql.setString(i++, strPumbun);
				sql.setString(i++, strBizType);
				sql.setString(i++, strOrgCd);          
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
		} else{
			sql.put(svc.getQuery("WHERE_SLIP_NO")); 
			sql.setString(i++, strSlipNo);
		}
		
		sql.put(svc.getQuery("SEL_ORDERBY"));                     
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 신선단품 점출입발주  상세 내역 조회
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

		String strSlipFlag= String2.nvl(form.getParam("strSlipFlag"));		// 점출점
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));			// 점출점
		String strPStrCd  = String2.nvl(form.getParam("strPStrCd"));	    // 접입점
		String strSlipNo  = String2.nvl(form.getParam("strSlipNo"));		// 점출전표번호
		String strPSlipNo = String2.nvl(form.getParam("strPSlipNo"));		// 점입전표번호

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[3];
		
		connect("pot");
		// 1. 마스터
		if("E".equals(strSlipFlag))
			sql.setString(i++, strStrCd);
		else
			sql.setString(i++, strPStrCd);

		sql.setString(i++, strSlipNo);
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.put(strQuery);
		ret[0] = select2List(sql);

		sql.close();
		i= 1;
		// 3. 점출상세
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);            
		ret[1] = select2List(sql);
		
		sql.close();
		i= 1;
		// 4. 점입상세
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strPStrCd);
		sql.setString(i++, strPSlipNo);
		ret[2] = select2List(sql);

		return ret;
	}
	
	/**
	 * 단품코드 상세정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getSkuInfo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;   
		String strQuery = "";
		int i = 1;           

		String strStrCd     = String2.nvl(form.getParam("strStrCd")); 
		String strPumbunCd  = String2.nvl(form.getParam("strPumbunCd"));
		String strOrdDt     = String2.nvl(form.getParam("strOrdDt"));
		String strPrcAppDt  = String2.nvl(form.getParam("strPrcAppDt"));         
		String strSkuCd  	= String2.nvl(form.getParam("strSkuCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
	
		sql.setString(i++, strSkuCd);  
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOrdDt); 
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSkuCd);           
		
		strQuery = svc.getQuery("SEL_SKU_INFO") + "\n";

		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
    
	/**
	 *  신선단품 점출입발주  등록/수정한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String userId, String org_flag)
			throws Exception {
		
		HashMap<String, String> map = null;
		
		MultiInput mi1       = mi[0];
		MultiInput mi2       = mi[1]; 
		MultiInput mi3       = mi[2];
		
		int ret 	         = 0;
		int res 	         = 0;
		int i   	         = 0;
		int mstCnt 	         = 0;	

		String strBuyerYN    = "";		// 바이어,SM 여부
		String strSlipNo     = "";		// 전표번호
		String strStrCd      = "";	    // 점출입매장
		String strSlipNo1    = "";	    // 점출입전표번호
		String strPairStrCd  = "";	    // 점출입상대매장
		String strPairSlipNo = "";	    // 점출입상대전표번호   
		
		String strCSlipNo    = "";		// 점출전표번호
		String strDSlipNo    = "";		// 점입전표번호
		
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			strBuyerYN = form.getParam("strBuyerYN");		// 바이어,SM 여부
			
			
			// 마스터
			while (mi1.next()) {
				
				sql.close();
				
				// 1. 로그인아이디가 바이어, SM일 경우 확정처리한다.
				if("Y".equals(strBuyerYN) && "1".equals(org_flag)){			// 로그인사번이 판매조직일 경우 SM확정
					mi1.setString("SM_ID", userId);
					mi1.setString("SM_CONF_DT", mi1.getString("ORD_DT"));
					mi1.setString("ORD_CONF_DT", "        ");
					mi1.setString("SLIP_PROC_STAT", "01");
					
				}else if("Y".equals(strBuyerYN) && "2".equals(org_flag)){	// 로그인사번이 매입조직일 경우 바이어확정
					mi1.setString("BUYER_CONF_ID", userId);
					mi1.setString("ORD_CONF_DT", mi1.getString("ORD_DT"));
					mi1.setString("SM_CONF_DT", "        ");
					mi1.setString("SLIP_PROC_STAT", "04");
				}else{
				  mi1.setString("SM_CONF_DT", "        ");
					mi1.setString("ORD_CONF_DT", "        ");
					mi1.setString("SLIP_PROC_STAT", "00");					
				}	
							
				System.out.println("###신선단품점출입######################################");
				System.out.println("##strBuyerYN   ##"+strBuyerYN+":org_flag::"+org_flag);
				System.out.println("##SM_ID        ##"+mi1.getString("SM_ID"));
				System.out.println("##SM_CONF_DT   ##"+mi1.getString("SM_CONF_DT"));
				System.out.println("##BUYER_CONF_ID##"+mi1.getString("BUYER_CONF_ID"));
				System.out.println("##ORD_CONF_DT  ##"+mi1.getString("ORD_CONF_DT"));
				System.out.println("######################################################");
				
				if (mi1.IS_INSERT()) { // 저장

					// 2. 전표번호를 생성한다.(시퀀스사용)
					sql.put(svc.getQuery("SEL_SLIP_NO"));
					sql.setString(1, mi1.getString("STR_CD"));
					sql.setString(2, mi1.getString("ORD_DT"));   
					sql.setString(3, mi1.getString("SLIP_FLAG"));
  
					Map mapSlipNo = (Map)selectMap(sql);
					strSlipNo = mapSlipNo.get("SLIP_NO").toString();
					mi1.setString("SLIP_NO", strSlipNo);
					sql.close();
					
					if ("0".equals(strSlipNo)) {
						throw new Exception("[USER]"+ "전표를 구성하는 시퀀스가 존재하지 않습니다.");
					}
					
					i = 1; 
					// 3. 마스터테이블에 저장
					sql.put(svc.getQuery("INS_MASTER"));
					
					sql.setString(i++, mi1.getString("SLIP_NO"));  
					sql.setString(i++, mi1.getString("STR_CD"));  
					sql.setString(i++, mi1.getString("PUMBUN_CD"));     
					sql.setString(i++, mi1.getString("VEN_CD"));   
					sql.setString(i++, mi1.getString("NEW_PRC_APP_DT"));
					sql.setString(i++, mi1.getString("NEW_EVENT_CD"));  
					sql.setString(i++, mi1.getString("SLIP_FLAG"));       
					sql.setString(i++, "0"); 								/* 발주주체구분 : 0(백화점발주) */ 
					sql.setString(i++, "0");   								/* 발주구분           : 0(일반) */   
					sql.setString(i++, "0");								/* 자동전표구분 : 0(일반전표) */
					sql.setString(i++, "0");								/* 인상하구분      : 0(인상하아님) */      
					sql.setString(i++, mi1.getString("AFT_ORD_FLAG"));  
					if("E".equals(mi1.getString("SLIP_FLAG")))
						sql.setString(i++, "1");							/* 출입구분           : 1(점출) */
					else
						sql.setString(i++, "2");							/* 출입구분           : 2(점입) */   
					sql.setString(i++, mi1.getString("ORD_DT"));        
					sql.setString(i++, mi1.getString("DELI_DT"));   
					sql.setString(i++, mi1.getString("SM_CONF_DT"));        /* SM확정일자 */
					sql.setString(i++, mi1.getString("SM_ID"));             /* SM ID */  
					sql.setString(i++, mi1.getString("BUYER_CONF_ID"));     /* 바이어ID */
					sql.setString(i++, mi1.getString("ORD_CONF_DT"));       /* 바이어확정일자(발주확정일자) */ 
					sql.setString(i++, mi1.getString("BUYER_CD"));          
					sql.setString(i++, mi1.getString("SLIP_PROC_STAT"));	/* 로그인사번에따라 다름  */    
					sql.setString(i++, mi1.getString("DTL_CNT"));       
					sql.setString(i++, mi1.getString("ORD_TOT_QTY"));   
					sql.setString(i++, mi1.getString("NEW_COST_TAMT")); 
					sql.setString(i++, mi1.getString("NEW_SALE_TAMT")); 
					sql.setString(i++, mi1.getString("GAP_TOT_AMT"));   
					sql.setString(i++, mi1.getString("NEW_GAP_RATE"));
					sql.setString(i++, mi1.getString("VAT_TAMT"));			 /* 부가세 */
					sql.setString(i++, mi1.getString("BOTTLE_SLIP_YN"));    /* 공병전표여부  */ 
					sql.setString(i++, mi1.getString("REMARK"));        
					sql.setString(i++, mi1.getString("BIZ_TYPE"));      
					sql.setString(i++, mi1.getString("TAX_FLAG"));   
					sql.setString(i++, "0");                                 /* 수입발주구분 */
					sql.setString(i++, "N");   
					sql.setString(i++, mi1.getString("BIZ_TYPE"));     
					sql.setString(i++, mi1.getString("SLIP_FLAG"));
					sql.setString(i++, userId); 
					sql.setString(i++, userId);
					
					res = update(sql);
					mstCnt = res;
					sql.close();    
					
					// SMS전송
					if("E".equals(mi1.getString("SLIP_FLAG")) && res > 0)
						sendSMS(form, mi1, userId, org_flag);

				}
				else if(mi1.IS_UPDATE()){// 수정
					   
					i = 1;
					// 3. 마스터테이블에 수정
					sql.put(svc.getQuery("UPD_MASTER"));            
					sql.setString(i++, mi1.getString("REMARK"));    
					sql.setString(i++, mi1.getString("AFT_ORD_FLAG"));
					sql.setString(i++, mi1.getString("BOTTLE_SLIP_YN"));    /* 공병전표여부  */ 
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("STR_CD"));
					sql.setString(i++, mi1.getString("SLIP_NO"));
					res = update(sql);
					mstCnt = res;
					sql.close();  
					
					i = 1;
					sql.put(svc.getQuery("UPD_MASTER"));            
					sql.setString(i++, mi1.getString("REMARK"));    
					sql.setString(i++, mi1.getString("AFT_ORD_FLAG"));
					sql.setString(i++, mi1.getString("BOTTLE_SLIP_YN"));    /* 공병전표여부  */ 
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("P_STR_CD"));
					sql.setString(i++, mi1.getString("P_SLIP_NO"));
					res = update(sql);
					mstCnt = res;
					sql.close();  
				}
				
				if("E".equals(mi1.getString("SLIP_FLAG"))){				// 점출일 경우
					strStrCd    = mi1.getString("STR_CD");
					strSlipNo1  = mi1.getString("SLIP_NO");
					strCSlipNo  = mi1.getString("SLIP_NO");
					strDSlipNo  = mi1.getString("P_SLIP_NO");
					
				}else if("F".equals(mi1.getString("SLIP_FLAG"))){		// 점입일 경우(사용안함)
					strPairStrCd  = mi1.getString("STR_CD");
					strPairSlipNo = mi1.getString("SLIP_NO");
					strDSlipNo    = mi1.getString("SLIP_NO");
					strCSlipNo  = mi1.getString("P_SLIP_NO");
				}

				System.out.println("P_SLIP_NO::"+mi1.getString("P_SLIP_NO"));
				// 수정할 경우
				if(!"".equals(mi1.getString("P_SLIP_NO"))){
					strStrCd      = mi1.getString("STR_CD");
					strSlipNo1    = mi1.getString("SLIP_NO");
					strPairStrCd  = mi1.getString("P_STR_CD");
					strPairSlipNo = mi1.getString("P_SLIP_NO");
				} 
	
				map = new HashMap<String, String>();
				map.put("strStrCd",      strStrCd);
				map.put("strSlipNo1",    strSlipNo1);
				map.put("strPairStrCd",  strPairStrCd);    
				map.put("strPairSlipNo", strPairSlipNo);
				map.put("strSlipFlag",   mi1.getString("SLIP_FLAG"));

				// 4. 상세 데이터를 저장한다.
				saveDetail1(form, mi1, mi2, map, strCSlipNo, userId);
				saveDetail2(form, mi1, mi3, strDSlipNo, userId);
				
				strCSlipNo = "";
				strDSlipNo = "";
				
				// 5. 점출입 로그를 저장한다.
				saveMasterLog(form, mi1, userId);
			}	
			
			// 6. 마스터에 상대전표정보 업데이트
			res = savePairUpdate(form, map);
			
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
	 *  <p>
	 *  점출상세데이터를 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi1 
	 * @param mi2
	 * @param strID
	 * @param strSlipNo
	 * @return
	 * @throws Exception
	 */
	public int saveDetail1(ActionForm form, MultiInput mi1, MultiInput mi2, HashMap<String, String> map,  String strCSlipNo, String userId) 
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
			if(!"".equals(strCSlipNo)){
				// 상세
				while (mi2.next()) {
					sql.close();
					if (mi2.IS_INSERT()) { // 저장
						if(!"".equals(strCSlipNo)){
							mi2.setString("SLIP_NO", strCSlipNo);
							// 1. 전표상세번호 생성
							sql.put(svc.getQuery("SEL_ORD_SEQ_NO"));
							sql.setString(1, mi2.getString("STR_CD"));
							sql.setString(2, mi2.getString("SLIP_NO"));
				
							Map mapSeqNo = (Map)selectMap(sql);
							mi2.setString("ORD_SEQ_NO", mapSeqNo.get("ORD_SEQ_NO").toString());		          		
							sql.close();
		
							i = 1; 
							// 2. 상세테이블에 저장
							sql.put(svc.getQuery("INS_DETAIL"));
							
							sql.setString(i++, mi2.getString("STR_CD"));           
							sql.setString(i++, mi2.getString("SLIP_NO"));   				
							sql.setString(i++, mi2.getString("ORD_SEQ_NO"));   		
							sql.setString(i++, mi2.getString("PUMMOK_CD"));   			
							sql.setString(i++, mi2.getString("SKU_CD"));   					
							sql.setString(i++, mi2.getString("ORD_UNIT_CD"));   	
							sql.setString(i++, mi2.getString("MG_RATE"));  
							sql.setString(i++, mi2.getString("NEW_GAP_AMT"));      
							sql.setString(i++, mi2.getString("NEW_GAP_RATE"));   	   	
							sql.setString(i++, mi2.getString("ORD_QTY"));   				
							sql.setString(i++, mi2.getString("NEW_COST_PRC"));   	
							sql.setString(i++, mi2.getString("NEW_COST_AMT"));   	
							sql.setString(i++, mi2.getString("NEW_SALE_PRC"));   	
							sql.setString(i++, mi2.getString("NEW_SALE_AMT"));
							sql.setString(i++, mi2.getString("VAT_AMT"));  
							sql.setString(i++, mi2.getString("PUMBUN_CD"));   			
							sql.setString(i++, mi2.getString("VEN_CD"));   				
							sql.setString(i++, mi2.getString("SLIP_FLAG"));   			  
							sql.setString(i++, userId); 
							sql.setString(i++, userId);
							res = update(sql);
						}
					}else if(mi2.IS_UPDATE()){// 수정
						
						i = 1;
						// 2. 상세테이블에 수정
						sql.put(svc.getQuery("UPD_DETAIL"));            
						//mi2.setString("SLIP_NO", strCSlipNo);
						
						sql.setString(i++, mi2.getString("PUMMOK_CD"));              			
						sql.setString(i++, mi2.getString("SKU_CD"));   					
						sql.setString(i++, mi2.getString("ORD_UNIT_CD"));
						sql.setString(i++, mi2.getString("MG_RATE")); 
						sql.setString(i++, mi2.getString("NEW_GAP_AMT"));      
						sql.setString(i++, mi2.getString("NEW_GAP_RATE"));   	  	
						sql.setString(i++, mi2.getString("ORD_QTY"));   				
						sql.setString(i++, mi2.getString("NEW_COST_PRC"));   	
						sql.setString(i++, mi2.getString("NEW_COST_AMT"));   	     
						sql.setString(i++, mi2.getString("NEW_SALE_PRC"));   	
						sql.setString(i++, mi2.getString("NEW_SALE_AMT"));  
						sql.setString(i++, mi2.getString("VAT_AMT"));  
						sql.setString(i++, mi2.getString("PUMBUN_CD"));   			
						sql.setString(i++, mi2.getString("VEN_CD"));   				 			  
						sql.setString(i++, userId);
						sql.setString(i++, mi2.getString("STR_CD"));                           
						sql.setString(i++, mi2.getString("SLIP_NO"));   				
						sql.setString(i++, mi2.getString("ORD_SEQ_NO"));
						res = update(sql);
												
						// Detal2 상세전표 업데이트
						map.put("ordSeqNo", mi2.getString("ORD_SEQ_NO"));
						updateDetail(form, map);
						
					}else if(mi2.IS_DELETE()){ // 삭제
						
						// 2. 상세테이블에 삭제(Detail1)
						sql.put(svc.getQuery("DEL_DETAIL")); 
						
						sql.setString(1, mi2.getString("STR_CD"));
						sql.setString(2, mi2.getString("SLIP_NO"));
						sql.setString(3, mi2.getString("ORD_SEQ_NO"));  
						res = update(sql);
						
						// Detal2 상세전표 삭제
						map.put("ordSeqNo", mi2.getString("ORD_SEQ_NO"));
						deleteDetail(form, map);

					}
					
					
					if(ret == 0){
						ret = res;        
					}
					
					if (res != 1) {
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
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}
	
	/**
	 *  <p>
	 *  점입상세데이터를 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi1 
	 * @param mi3
	 * @param strID
	 * @param strSlipNo
	 * @return
	 * @throws Exception
	 */
	public int saveDetail2(ActionForm form, MultiInput mi1, MultiInput mi3, String strDSlipNo, String userId) 
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

			if(!"".equals(strDSlipNo)){
				// 상세
				while (mi3.next()) {
					sql.close();
					if (mi3.IS_INSERT()) { // 저장
							mi3.setString("SLIP_NO", strDSlipNo);
							
							// 1. 전표상세번호 생성
							sql.put(svc.getQuery("SEL_ORD_SEQ_NO"));
							
							sql.setString(1, mi3.getString("STR_CD"));
							sql.setString(2, mi3.getString("SLIP_NO"));
				
							Map mapSeqNo = (Map)selectMap(sql);
							mi3.setString("ORD_SEQ_NO", mapSeqNo.get("ORD_SEQ_NO").toString());			          		
							sql.close();
		
							i = 1; 
							// 2. 상세테이블에 저장
							sql.put(svc.getQuery("INS_DETAIL"));
							
							sql.setString(i++, mi3.getString("STR_CD"));           
							sql.setString(i++, mi3.getString("SLIP_NO"));   				
							sql.setString(i++, mi3.getString("ORD_SEQ_NO"));   		
							sql.setString(i++, mi3.getString("PUMMOK_CD"));   			
							sql.setString(i++, mi3.getString("SKU_CD"));   					
							sql.setString(i++, mi3.getString("ORD_UNIT_CD"));   	
							sql.setString(i++, mi3.getString("MG_RATE"));  
							sql.setString(i++, mi3.getString("NEW_GAP_AMT"));      
							sql.setString(i++, mi3.getString("NEW_GAP_RATE"));   	   	
							sql.setString(i++, mi3.getString("ORD_QTY"));   				
							sql.setString(i++, mi3.getString("NEW_COST_PRC"));   	
							sql.setString(i++, mi3.getString("NEW_COST_AMT"));   	
							sql.setString(i++, mi3.getString("NEW_SALE_PRC"));   	
							sql.setString(i++, mi3.getString("NEW_SALE_AMT"));  
							sql.setString(i++, mi3.getString("VAT_AMT"));  
							sql.setString(i++, mi3.getString("PUMBUN_CD"));   			
							sql.setString(i++, mi3.getString("VEN_CD"));   				
							sql.setString(i++, mi3.getString("SLIP_FLAG"));   			  
							sql.setString(i++, userId); 
							sql.setString(i++, userId);
					}else if(mi3.IS_DELETE()){ // 삭제
						
						// 2. 상세테이블에 삭제
						sql.put(svc.getQuery("DEL_DETAIL")); 
						
						sql.setString(1, mi3.getString("STR_CD"));
						sql.setString(2, mi3.getString("SLIP_NO"));
						sql.setString(3, mi3.getString("ORD_SEQ_NO"));         
					}
					res = update(sql);
					
					if(ret == 0){
						ret = res;        
					}
					
					if (res != 1) {
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
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}
	
	/**
	 *  <p>
	 *  상세정보를 업데이트한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi1 
	 * @param mi3
	 * @param strID
	 * @param strSlipNo
	 * @return
	 * @throws Exception
	 */
	public int updateDetail(ActionForm form, HashMap map) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		String strStrCd		    = "";		// 점출매장
		String strSlipNo1		= "";		// 점입매장
		String strPairStrCd     = "";	    // 점입매장
		String strPairSlipNo    = "";	    // 점입전표번호
		String ordSeqNo         = "";		// 상세번호
		String strSlipFlag      = "";		// 전표구분
		
		try {

			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			strStrCd		 = (String)map.get("strStrCd");
			strSlipNo1		 = (String)map.get("strSlipNo1");
			strPairStrCd     = (String)map.get("strPairStrCd");
			strPairSlipNo    = (String)map.get("strPairSlipNo");
			ordSeqNo         = (String)map.get("ordSeqNo");
			strSlipFlag      = (String)map.get("strSlipFlag");
			
			// 5. 점출점입 상세의 상대점, 상대전표를 업데이트
			sql.close();
			i = 1;				
			sql.put(svc.getQuery("UPD_P_DETAIL"));
	
			if("E".equals(strSlipFlag)){
				sql.setString(i++, strStrCd);  
				sql.setString(i++, strSlipNo1);
				sql.setString(i++, ordSeqNo);
				sql.setString(i++, strPairStrCd);
				sql.setString(i++, strPairSlipNo);  
				sql.setString(i++, ordSeqNo);   
			}else{
			  sql.setString(i++, strStrCd);  
				sql.setString(i++, strSlipNo1);  
				sql.setString(i++, ordSeqNo);
				sql.setString(i++, strPairStrCd);
				sql.setString(i++, strPairSlipNo); 
				sql.setString(i++, ordSeqNo);
				
			}
			res += update(sql);	
			
			if (res < 1) {
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
	 *  상세정보2를 삭제한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi1 
	 * @param mi3
	 * @param strID
	 * @param strSlipNo
	 * @return
	 * @throws Exception
	 */
	public int deleteDetail(ActionForm form, HashMap map) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		String strStrCd		    = "";		// 점출매장
		String strSlipNo1		= "";		// 점입매장
		String strPairStrCd     = "";	    // 점입매장
		String strPairSlipNo    = "";	    // 점입전표번호
		String ordSeqNo         = "";		// 상세번호
		String strSlipFlag      = "";		// 전표구분
		
		try {

			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			strStrCd		 = (String)map.get("strStrCd");
			strSlipNo1		 = (String)map.get("strSlipNo1");
			strPairStrCd     = (String)map.get("strPairStrCd");
			strPairSlipNo    = (String)map.get("strPairSlipNo");
			ordSeqNo         = (String)map.get("ordSeqNo");
			strSlipFlag      = (String)map.get("strSlipFlag");
			
			// 5. 점출점입 상세의 상대점, 상대전표를 업데이트
			sql.close();
			i = 1;				
			sql.put(svc.getQuery("DEL_DETAIL"));
	
			if("E".equals(strSlipFlag)){
				sql.setString(i++, strPairStrCd);
				sql.setString(i++, strPairSlipNo); 
				sql.setString(i++, ordSeqNo);
  
			}else{
				sql.setString(i++, strStrCd);  
				sql.setString(i++, strSlipNo1);
				sql.setString(i++, ordSeqNo);
			}
			res += update(sql);	
			
			if (res < 1) {
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
	 *  발주로그를 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi1 
	 * @param mi3
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
	 *  점출점입 마스터의 상대점, 상대전표를 업데이트한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi1 
	 * @param mi3
	 * @param strID
	 * @param strSlipNo
	 * @return
	 * @throws Exception
	 */
	public int savePairUpdate(ActionForm form, HashMap map) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		String strStrCd		    = "";		// 점출매장
		String strSlipNo1		= "";		// 점입매장
		String strPairStrCd     = "";	    // 점입매장
		String strPairSlipNo    = "";	    // 점입전표번호
		String strSlipFlag      = "";
		
		try {

			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			strStrCd		 = (String)map.get("strStrCd");
			strSlipNo1		 = (String)map.get("strSlipNo1");
			strPairStrCd     = (String)map.get("strPairStrCd");
			strPairSlipNo    = (String)map.get("strPairSlipNo");
			strSlipFlag      = (String)map.get("strSlipFlag");
			// 5. 점출점입 마스터의 상대점, 상대전표를 업데이트
			if("E".equals(strSlipFlag)){
			sql.close();
			i = 1;				
			sql.put(svc.getQuery("UPD_P_MASTER"));
			sql.setString(i++, strStrCd);  
			sql.setString(i++, strSlipNo1);
			sql.setString(i++, strPairStrCd);
			sql.setString(i++, strPairSlipNo);  
			sql.setString(i++, strPairStrCd);
			sql.setString(i++, strPairSlipNo);    
			res += update(sql);	
			sql.close();

			i = 1;
			sql.put(svc.getQuery("UPD_P_MASTER"));
			sql.setString(i++, strPairStrCd);  
			sql.setString(i++, strPairSlipNo);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSlipNo1);    
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSlipNo1);    
			res += update(sql);	
			}else{
				sql.close();
				i = 1;				
				sql.put(svc.getQuery("UPD_P_MASTER"));
				sql.setString(i++, strStrCd);  
				sql.setString(i++, strSlipNo1);
				sql.setString(i++, strStrCd);  
				sql.setString(i++, strSlipNo1);
				sql.setString(i++, strPairStrCd);
				sql.setString(i++, strPairSlipNo); 
				    
				res += update(sql);	
				sql.close();
	
				i = 1;
				sql.put(svc.getQuery("UPD_P_MASTER"));
				sql.setString(i++, strPairStrCd);  
				sql.setString(i++, strPairSlipNo);
				sql.setString(i++, strPairStrCd);  
				sql.setString(i++, strPairSlipNo);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSlipNo1);    
				res += update(sql);	
			}
			
			if (res < 2) {
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
	 *  신선단품 점출입발주  삭제한다.
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
			sql.setString(2, form.getParam("strPStrCd"));
			sql.setString(3, form.getParam("strSlipNo"));
			sql.setString(4, form.getParam("strPSlipNo"));
			res = update(sql);
			
			sql.close();
			sql.put(svc.getQuery("DEL_DETAIL_LOG")); 
			
			sql.setString(1, form.getParam("strStrCd"));
			sql.setString(2, form.getParam("strPStrCd"));
			sql.setString(3, form.getParam("strSlipNo"));
			sql.setString(4, form.getParam("strPSlipNo"));
			res = update(sql);
			
			sql.close();
			sql.put(svc.getQuery("DEL_MASTER")); 
			
			sql.setString(1, form.getParam("strStrCd"));
			sql.setString(2, form.getParam("strPStrCd"));
			sql.setString(3, form.getParam("strSlipNo"));
			sql.setString(4, form.getParam("strPSlipNo"));
			res = update(sql);

			if (res  != 2) {
				throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
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

          //  if (resp <= 0) {
          //      throw new Exception("[USER]"+ prs.getString(8));
          //  }                                          
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
