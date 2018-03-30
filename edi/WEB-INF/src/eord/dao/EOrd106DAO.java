/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package eord.dao;

import java.util.HashMap;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**   
 * <p> 규격단품 매입발주 등록  DAO </p>
 *           
 * @created  on 1.0, 2011/02/16  
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class EOrd106DAO extends AbstractDAO2 {
   	/**
	 * 규격단품 매입발주 리스트 내역 조회
	 *       
	 * @param form
	 * @return
	 * @throws Exception          
	 */
	public StringBuffer getList(ActionForm form, String userId) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		int i = 1;          

		String strCd         = String2.nvl(form.getParam("strCd"       ));                         // 점
		String venCd         = String2.nvl(form.getParam("venCd"       ));                         // 협력사
		String pumbunCd      = String2.nvl(form.getParam("pumbunCd"    ));                         // 품번
		String slipProcFlag  = String2.nvl(form.getParam("slipProcFlag"));                         // 전표상태
		String dateType      = String2.nvl(form.getParam("dateType"    ));                         // 기준일
		String startDate     = String2.nvl(form.getParam("startDate"   )).replaceAll("/", "");     // 조회시작일
		String endDate       = String2.nvl(form.getParam("endDate"     )).replaceAll("/", "");     // 조회종료일
		String slipFlag      = String2.nvl(form.getParam("slipFlag"    ));                         // 전표구분
		String slipNo        = String2.nvl(form.getParam("slipNo"      )).replaceAll("-", "");     // 전표번호
		String skuFlag       = "1";											                       // 단품
		String skuType       = "1"; 										                       // 규격단품
		
		sb  = new StringBuffer();
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_LIST"));
		sql.setString(i++, strCd);	
		sql.setString(i++, skuFlag);
		sql.setString(i++, skuType);
		sql.setString(i++, venCd);  
		sql.setString(i++, slipProcFlag);  
		sql.setString(i++, pumbunCd);  
		sql.setString(i++, slipFlag);  
		
		// 전표번호 유무에 따라 조건 변경
		if("".equals(slipNo)){
			if("0".equals(dateType)){					// 발주일
				sql.put(svc.getQuery("SEL_ORD_DT"));
			} else if("1".equals(dateType)){			// 발주확정일
				sql.put(svc.getQuery("SEL_ORD_CONF"));    
			} else if("2".equals(dateType)){			// 납품예정일
				sql.put(svc.getQuery("SEL_DELI_DT"));
			} else if("3".equals(dateType)){			// 검품확정일
				sql.put(svc.getQuery("SEL_CHK_DT"));
			}
			sql.setString(i++, startDate);
			sql.setString(i++, endDate);	
			
		}else{
			sql.put(svc.getQuery("WHERE_SLIP_NO")); 
			sql.setString(i++, slipNo);
		}
		
		sql.put(svc.getQuery("SEL_ORDERBY"));  
		sb = executeQueryByAjax(sql);
		return sb;
	}
	
	/**
	 * 규격단품 매입발주 마스터 내역 조회
	 *       
	 * @param form
	 * @return
	 * @throws Exception          
	 */
	public StringBuffer getMaster(ActionForm form, String userId) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		int i = 1;          

		String strCd         = String2.nvl(form.getParam("strCd"  ));       // 점
		String slipNo        = String2.nvl(form.getParam("slipNo" ));       // 전표번호
		
		sb  = new StringBuffer();
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_MASTER"));
		sql.setString(i++, strCd);	
		sql.setString(i++, slipNo);
		
		sb = executeQueryByAjax(sql);
		return sb;
	}
	
	/**
	 * 규격단품 매입발주 상세 내역 조회
	 *       
	 * @param form
	 * @return
	 * @throws Exception          
	 */
	public StringBuffer getDetail(ActionForm form, String userId) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		int i = 1;          

		String strCd         = String2.nvl(form.getParam("strCd"  ));       // 점
		String slipNo        = String2.nvl(form.getParam("slipNo" ));       // 전표번호
		
		sb  = new StringBuffer();
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_DETAIL"));
		sql.setString(i++, strCd);	
		sql.setString(i++, slipNo);
		
		sb = executeQueryByAjax(sql);
		return sb;
	}
	
	/**
	 * 품번 상세정보 조회
	 *       
	 * @param form
	 * @return
	 * @throws Exception          
	 */
	public StringBuffer getPumbunInfo(ActionForm form, String userId) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		int i = 1;          

		String strCd        = String2.nvl(form.getParam("strCd"  ));     // 점
		String venCd        = String2.nvl(form.getParam("venCd" ));      // 협력사
		String pumbunCd     = String2.nvl(form.getParam("pumbunCd" ));   // 품번
		
		sb  = new StringBuffer();
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_PUMBUN_INFO"));
		sql.setString(i++, strCd);	
		sql.setString(i++, venCd);
		sql.setString(i++, pumbunCd);
		
		sb = executeQueryByAjax(sql);
		System.out.println("sb::"+sb.toString());
		return sb;
	}
	
	/**
	 * 단품코드 상세정보 조회
	 *       
	 * @param form
	 * @return
	 * @throws Exception          
	 */
	public StringBuffer getSkuInfo(ActionForm form, String userId) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		int i = 1;          

		String strCd     = String2.nvl(form.getParam("strCd")); 						// 점
		String pumbunCd  = String2.nvl(form.getParam("pumbunCd"));						// 품번
		String prcAppDt  = String2.nvl(form.getParam("prcAppDt")).replaceAll("/", "");	// 가격적용일           
		String skuCd  	 = String2.nvl(form.getParam("skuCd"));							// 단품코드
		String ordYm  	 = String2.nvl(form.getParam("ordYm")).replaceAll("/", "");		// 발주년월 
		String ordDt  	 = String2.nvl(form.getParam("ordDt")).replaceAll("/", "");		// 발주일
		
		sb  = new StringBuffer();
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_SKU_INFO"));
		sql.setString(i++, ordYm);
		sql.setString(i++, ordDt);
		sql.setString(i++, strCd);     
		sql.setString(i++, skuCd);
		sql.setString(i++, prcAppDt); 
		sql.setString(i++, strCd);     
		sql.setString(i++, skuCd);  
		
		sb = executeQueryByAjax(sql);
		System.out.println("sb::"+sb.toString());
		return sb;
	}
	
	/**
	 * 규격단품 매입발주  저장/수정
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public StringBuffer save(ActionForm form, String userid) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int ret 	= 0;
		int res 	= 0;
		int i   	= 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			
			res = saveMaster(form ,userid);		// 마스터 저장
			
			if( ret > 0 || res > 0 ){				
				sb.append("<?xml version='1.0' encoding='utf-8'?>");
				sb.append("<t>");
				sb.append("<r id='1'>");
				sb.append("<c id='RET'>").append((ret+res));
				sb.append("</c>");
				sb.append("</r>");
				sb.append("</t>");
			}else {
				rollback();
				sb.append("<?xml version='1.0' encoding='utf-8'?>");
				sb.append("<t>");
				sb.append("<r id='1'>");
				sb.append("<c id='RET'>").append("데이터의 적합성 문제로 인하여 \n데이터 입력을 하지 못했습니다.");
				sb.append("</c>");
				sb.append("</r>");
				sb.append("</t>");
			}
			
			
			
		}catch(Exception e){
			rollback();
			throw e;
		} finally {
			end();
		}
		return sb;
	} 

	/**
	 * 규격단품 매입발주 마스터 등록/수정
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int saveMaster(ActionForm form, String userid) throws Exception {
		
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;	
		int ret = 0;
		String strSlipNo  = "";		// 전표번호
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String str_cd            = String2.nvl(form.getParam("str_cd"));
			String slip_no           = String2.nvl(form.getParam("slip_no")).trim().replaceAll("-", "");         
			String slip_proc_stat_nm = String2.nvl(form.getParam("slip_proc_stat_nm"));
			String slip_proc_stat    = String2.nvl(form.getParam("slip_proc_stat"));  
			String slip_flag         = String2.nvl(form.getParam("slip_flag"));       
			String aft_ord_flag_nm   = String2.nvl(form.getParam("aft_ord_flag_nm")); 
			String aft_ord_flag      = String2.nvl(form.getParam("aft_ord_flag"));    
			String pumbun_cd         = String2.nvl(form.getParam("pumbun_cd"));       
			String ord_flag_nm       = String2.nvl(form.getParam("ord_flag_nm"));     
			String ord_flag          = String2.nvl(form.getParam("ord_flag"));        
			String buyer_cd          = String2.nvl(form.getParam("buyer_cd"));        
			String buyer_nm          = String2.nvl(form.getParam("buyer_nm"));        
			String ven_cd            = String2.nvl(form.getParam("ven_cd"));          
			String ven_nm            = String2.nvl(form.getParam("ven_nm"));          
			String biz_type          = String2.nvl(form.getParam("biz_type"));        
			String biz_type_nm       = String2.nvl(form.getParam("biz_type_nm"));     
			String tax_flag          = String2.nvl(form.getParam("tax_flag"));        
			String tax_flag_nm       = String2.nvl(form.getParam("tax_flag_nm"));     
			String ord_dt            = String2.nvl(form.getParam("ord_dt")).trim().replaceAll("/", "");         
			String conf_dt           = String2.nvl(form.getParam("conf_dt")).trim().replaceAll("/", "");        
			String ord_own_flag      = String2.nvl(form.getParam("ord_own_flag"));    
			String ord_own_flag_nm   = String2.nvl(form.getParam("ord_own_flag_nm")); 
			String deli_dt           = String2.nvl(form.getParam("deli_dt")).trim().replaceAll("/", "");        
			String prc_app_dt        = String2.nvl(form.getParam("prc_app_dt")).trim().replaceAll("/", "");     
			String chk_dt            = String2.nvl(form.getParam("chk_dt")).trim().replaceAll("/", "");         
			String tot_qty           = String2.nvl(form.getParam("tot_qty")).replaceAll(",","");         
			String tot_cost_amt      = String2.nvl(form.getParam("tot_cost_amt")).replaceAll(",","");    
			String tot_sale_amt      = String2.nvl(form.getParam("tot_sale_amt")).replaceAll(",","");    
			String gap_tot_amt       = String2.nvl(form.getParam("gap_tot_amt")).replaceAll(",","");     
			String gap_rate          = String2.nvl(form.getParam("gap_rate"));        
			String remark            = String2.nvl(form.getParam("remark"));          
			String reg_date          = String2.nvl(form.getParam("reg_date")).trim().replaceAll("/", "");       
			String bottle_slip_yn    = String2.nvl(form.getParam("bottle_slip_yn"));  
			String vat_tamt          = String2.nvl(form.getParam("vat_tamt")).replaceAll(",","");
			String dtlCnt            = String2.nvl(form.getParam("dtlCnt"));  	

			connect("pot");
			begin(); 
			
			// 신규등록건
			if("".equals(slip_no)){
				// 전표번호를 생성한다.(시퀀스사용)
				sql.put(svc.getQuery("SEL_SLIP_NO"));	
				sql.setString(1, str_cd);
				sql.setString(2, ord_dt);
				
				Map mapSlipNo = (Map)executeQueryByMap(sql);
				slip_no = mapSlipNo.get("SLIP_NO").toString();
				sql.close();
				
				if ("0".equals(strSlipNo)) {
					throw new Exception("[USER]"+ "전표를 구성하는 시퀀스가 존재하지 않습니다.");
				}
				
				i = 1; 
				// 3. 마스터테이블에 저장
				
				sql.put(svc.getQuery("INS_MASTER"));
				
				sql.setString(i++, slip_no);  
				sql.setString(i++, str_cd);             
				sql.setString(i++, pumbun_cd);     
				sql.setString(i++, ven_cd);                        
				sql.setString(i++, prc_app_dt);
				sql.setString(i++, slip_flag);       
				sql.setString(i++, "0"); 								/* 발주주체구분 : 0(백화점발주) */ 
				sql.setString(i++, "1");   								/* 발주구분           : 0(일반), 1(EDI발주) */   
				sql.setString(i++, "0");								/* 자동전표구분 : 0(일반전표) */
				sql.setString(i++, "0");								/* 인상하구분      : 0(인상하아님) */      
				sql.setString(i++, aft_ord_flag );  
				sql.setString(i++, "0");								/* 출입구분           : 0(출입아님) */    
				sql.setString(i++, ord_dt);        
				sql.setString(i++, deli_dt);   
				sql.setString(i++, buyer_cd);          
				sql.setString(i++, "00");							    /* '00' 전표입력  */    
				sql.setString(i++, dtlCnt);							    /* 상세건수 */       
				sql.setString(i++, tot_qty);   
				sql.setString(i++, tot_cost_amt); 
				sql.setString(i++, tot_sale_amt);    
				sql.setString(i++, gap_tot_amt);   
				sql.setString(i++, gap_rate);  
				sql.setString(i++, vat_tamt);  							/* 부가세  */
				sql.setString(i++, bottle_slip_yn);    					/* 공병전표여부  */ 
				sql.setString(i++, "");  								// pay_cond    
				sql.setString(i++, remark);        
				sql.setString(i++, biz_type);      
				sql.setString(i++, tax_flag); 
				sql.setString(i++, "0");                                /* 수입발주구분 */
				sql.setString(i++, "N");   
				sql.setString(i++, biz_type);     
				sql.setString(i++, tax_flag);
				sql.setString(i++, userid); 
				sql.setString(i++, userid);
				
			}else{
				i = 1;
				// 3. 마스터테이블에 수정
				sql.put(svc.getQuery("UPD_MASTER")); 
				
				sql.setString(i++, pumbun_cd);     
				sql.setString(i++, ven_cd);        
				sql.setString(i++, prc_app_dt);
				sql.setString(i++, slip_flag);       
				sql.setString(i++, aft_ord_flag);   
				sql.setString(i++, ord_dt);        
				sql.setString(i++, deli_dt);   
				sql.setString(i++, buyer_cd);          
				sql.setString(i++, dtlCnt);       
				sql.setString(i++, tot_qty);   
				sql.setString(i++, tot_cost_amt); 
				sql.setString(i++, tot_sale_amt); 
				sql.setString(i++, gap_tot_amt);   
				sql.setString(i++, gap_rate);  
				sql.setString(i++, vat_tamt);  		   /* 부가세  */ 
				sql.setString(i++, bottle_slip_yn);    /* 공병전표여부  */ 
				sql.setString(i++, "");				// pay_cond      
				sql.setString(i++, remark);         
				sql.setString(i++, biz_type);      
				sql.setString(i++, tax_flag);
				sql.setString(i++, biz_type);     
				sql.setString(i++, slip_flag);
				sql.setString(i++, userid);
				sql.setString(i++, str_cd);
				sql.setString(i++, slip_no);
			}
				 
			ret = executeUpdate(sql);
			sql.close();

			ret += saveDetail(form ,slip_no, userid);		// 디테일 저장
			ret += saveMasterLog(form ,slip_no);	        // 로그저장
			
		}catch(Exception e){
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	/**
	 * 규격단품 매입발주 디테일 등록/수정
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int saveDetail(ActionForm form, String slip_no, String userid) throws Exception {
		
		HashMap<String, String> map = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;	
		int ret = 0;
		
		try{
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			String d_strCd[]      = form.getParam("d_strCd").split("/"); 
			String d_slip_no[]    = form.getParam("d_slip_no").split("/");    
			String d_pumbunCd[]   = form.getParam("d_pumbunCd").split("/");   
			String d_venCd[]      = form.getParam("d_venCd").split("/");      
			String d_slipFlag[]   = form.getParam("d_slipFlag").split("/");   
			String d_pummokCd[]   = form.getParam("d_pummokCd").split("/");   
			String d_skuNm[]      = form.getParam("d_skuNm").split("/");      
			String d_ordUnitCd[]  = form.getParam("d_ordUnitCd").split("/");  
			String d_ordUnitNm[]  = form.getParam("d_ordUnitNm").split("/");  
			String d_stkQty[]     = form.getParam("d_stkQty").split("/");     
			String d_avgSaleQty[] = form.getParam("d_avgSaleQty").split("/");  
			String d_avgSaleAmt[] = form.getParam("d_avgSaleAmt").split("/");  
			String d_newCostPrc[] = form.getParam("d_newCostPrc").split("/");  
			String d_newSalePrc[] = form.getParam("d_newSalePrc").split("/");  
			String d_mgRate[]     = form.getParam("d_mgRate").split("/");  
			String d_bottleCd[]   = form.getParam("d_bottleCd").split("/");   
			String d_bizType[]    = form.getParam("d_bizType").split("/");    
			String d_costZero[]   = form.getParam("d_costZero").split("/");   
			String d_saleZero[]   = form.getParam("d_saleZero").split("/");   
			String d_newGapRate[] = form.getParam("d_newGapRate").split("/");  
			String d_ord_seq_no[] = form.getParam("d_ord_seq_no").split("/");  
			String d_vatAmt[]     = form.getParam("d_vatAmt").split("/");     
			String d_skuCd[]      = form.getParam("d_skuCd").split("/");      
			String d_ordQty[]     = form.getParam("d_ordQty").split("/");     
			String d_newCostAmt[] = form.getParam("d_newCostAmt").split("/");  
			String d_newSaleAmt[] = form.getParam("d_newSaleAmt").split("/");  
			String d_newGapAmt[]  = form.getParam("d_newGapAmt").split("/");  
			String d_orgSkuCd[]   = form.getParam("d_orgSkuCd").split("/");  
			
			// 삭제한 DTL을 지운다.
			ret = deleteDetail(form, slip_no);
			
			for(int k = 0; k < d_strCd.length; k++){
				// 신규등록건
				if(" ".equals(d_ord_seq_no[k])){
					
					// 1. 전표상세번호 생성
					sql.put(svc.getQuery("SEL_ORD_SEQ_NO"));	
					sql.setString(1, d_strCd[k]);
					sql.setString(2, slip_no);
					
					Map mapSlipNo = (Map)executeQueryByMap(sql);
					d_ord_seq_no[k] = mapSlipNo.get("ORD_SEQ_NO").toString();
					sql.close();
														
					i = 1; 
					// 2. 상세테이블에 저장
					sql.put(svc.getQuery("INS_DETAIL"));
					
					sql.setString(i++, d_strCd[k]);           
					sql.setString(i++, slip_no);   				
					sql.setString(i++, d_ord_seq_no[k]);   		
					sql.setString(i++, d_pummokCd[k]);   			
					sql.setString(i++, d_skuCd[k]);   					
					sql.setString(i++, d_ordUnitCd[k]);   	     
					sql.setString(i++, d_mgRate[k]);  
					sql.setString(i++, d_newGapAmt[k]);      
					sql.setString(i++, d_newGapRate[k]);   	
					sql.setString(i++, d_stkQty[k]);   		
					sql.setString(i++, d_avgSaleQty[k]);   	
					sql.setString(i++, d_avgSaleAmt[k]);   	
					sql.setString(i++, d_ordQty[k]);   				
					sql.setString(i++, d_newCostPrc[k]);   	
					sql.setString(i++, d_newCostAmt[k]);   	
					sql.setString(i++, d_newSalePrc[k]);   	
					sql.setString(i++, d_newSaleAmt[k]);   
					sql.setString(i++, d_vatAmt[k]);  	 	/* 부가세  */ 
					sql.setString(i++, d_pumbunCd[k]);   			
					sql.setString(i++, d_venCd[k]);   				
					sql.setString(i++, d_slipFlag[k]);   			  
					sql.setString(i++, userid); 
					sql.setString(i++, userid);                 
					
				}else{
					i = 1;
					// 2. 상세테이블에 수정
					sql.put(svc.getQuery("UPD_DETAIL")); 
	
					sql.setString(i++, d_pummokCd[k]);              			
					sql.setString(i++, d_skuCd[k]);   					
					sql.setString(i++, d_ordUnitCd[k]);
					sql.setString(i++, d_mgRate[k]); 
					sql.setString(i++, d_newGapAmt[k]);      
					sql.setString(i++, d_newGapRate[k]);   	
					sql.setString(i++, d_stkQty[k]);   		
					sql.setString(i++, d_avgSaleQty[k]);   	
					sql.setString(i++, d_avgSaleAmt[k]);   	
					sql.setString(i++, d_ordQty[k]);   				
					sql.setString(i++, d_newCostPrc[k]);   	
					sql.setString(i++, d_newCostAmt[k]);   	     
					sql.setString(i++, d_newSalePrc[k]);   	
					sql.setString(i++, d_newSaleAmt[k]);   
					sql.setString(i++, d_vatAmt[k]);  	 	/* 부가세  */ 
					sql.setString(i++, d_pumbunCd[k]);   			
					sql.setString(i++, d_venCd[k]);   				
					sql.setString(i++, d_slipFlag[k]);   			  
					sql.setString(i++, userid);
					sql.setString(i++, d_strCd[k]);                           
					sql.setString(i++, d_slip_no[k].replaceAll("-",""));   				
					sql.setString(i++, d_ord_seq_no[k]);
				}
				ret = executeUpdate(sql);
				sql.close();
			}
				 
			
			  
		}catch(Exception e){
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}
	
	/**
	 * 규격단품 매입발주 디테일 삭제
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int deleteDetail(ActionForm form, String slip_no) throws Exception {
		
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;	
		int ret = 0;
		
		try{
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}

			sql = new SqlWrapper();
			svc = (Service) form.getService();

			String strCd[]      = String2.nvl(form.getParam("d_strCd")).split("/");
			String del_detail[] = String2.nvl(form.getParam("del_detail")).split("/");
			if(!"".equals(String2.nvl(form.getParam("del_detail")))){
				for(int k = 0; k < del_detail.length; k++){
					i = 1; 
					// 상세테이블 삭제
					sql.put(svc.getQuery("DEL_DETAIL"));
					
					sql.setString(i++, strCd[k]);           
					sql.setString(i++, slip_no);   				
					sql.setString(i++, del_detail[k]);   		
						
					ret = executeUpdate(sql);
					sql.close();
				}
			}
		}catch(Exception e){
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}
	
	/**
	 * 규격단품 매입발주 삭제
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public StringBuffer delete(ActionForm form, String userid) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int ret 	= 0;
		int res 	= 0;
		int i   	= 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			
			res = deleteAll(form);		// 마스터, 디테일 모두 삭제
			
			if( ret > 0 || res > 0 ){				
				sb.append("<?xml version='1.0' encoding='utf-8'?>");
				sb.append("<t>");
				sb.append("<r id='1'>");
				sb.append("<c id='RET'>").append((ret+res));
				sb.append("</c>");
				sb.append("</r>");
				sb.append("</t>");
			}else {
				rollback();
				sb.append("<?xml version='1.0' encoding='utf-8'?>");
				sb.append("<t>");
				sb.append("<r id='1'>");
				sb.append("<c id='RET'>").append("데이터의 적합성 문제로 인하여 \n데이터 입력을 하지 못했습니다.");
				sb.append("</c>");
				sb.append("</r>");
				sb.append("</t>");
			}
		}catch(Exception e){
			rollback();
			throw e;
		} finally {
			end();
		}
		return sb;
	} 
	
	/**
	 * 규격단품 매입발주 마스터,디테일 모두 삭제
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int deleteAll(ActionForm form) throws Exception {
		
		SqlWrapper sql = null;
		Service svc = null;
		int i   = 0;	
		int res = 0;
		
		try{
			connect("pot");
			begin();

			sql = new SqlWrapper();
			svc = (Service) form.getService();

			sql.close();
			sql.put(svc.getQuery("DEL_DETAIL_ALL")); 
			
			sql.setString(1, form.getParam("strCd"));
			sql.setString(2, form.getParam("slipNo").replaceAll("-",""));
			res = executeUpdate(sql);
			
			sql.close();
			sql.put(svc.getQuery("DEL_DETAIL_LOG")); 
			
			sql.setString(1, form.getParam("strCd"));
			sql.setString(2, form.getParam("slipNo").replaceAll("-",""));
			res = executeUpdate(sql);
			
			sql.close();
			sql.put(svc.getQuery("DEL_MASTER")); 
			
			sql.setString(1, form.getParam("strCd"));
			sql.setString(2, form.getParam("slipNo").replaceAll("-",""));
			res = executeUpdate(sql);
			
			if (res  < 0) {
				throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
						+ "데이터 삭제를 하지 못했습니다.");
			}
			
		}catch(Exception e){
			rollback();
			throw e;
		} finally {
			end();
		}
		return res;
	}
	
	/**
	 * 규격단품 매입발주 로그
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int saveMasterLog(ActionForm form, String slip_no) throws Exception {
		
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;	
		int ret = 0;
		
		try{
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}

			sql = new SqlWrapper();
			svc = (Service) form.getService();

			String str_cd            = String2.nvl(form.getParam("str_cd"));
			String slip_flag         = String2.nvl(form.getParam("slip_flag"));     
			
			sql.close();
			i = 1;				
			sql.put(svc.getQuery("INS_MASTER_LOG"));
			sql.setString(i++, str_cd);  
			sql.setString(i++, slip_no);;
			sql.setString(i++, slip_flag);
			sql.setString(i++, "00");    
			sql.setString(i++, str_cd);  
			sql.setString(i++, slip_no);
			sql.setString(i++, slip_flag);
			sql.setString(i++, "00");
			ret = executeUpdate(sql);				
			
			if (ret == 0) {
				throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
		}catch(Exception e){
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}
}
