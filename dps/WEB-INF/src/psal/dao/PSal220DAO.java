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
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
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

public class PSal220DAO extends AbstractDAO {

	/**
	 * 마스터 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String userid) throws Exception {
		try{
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 0;

		String strStrCd     = String2.nvl(form.getParam("strStrCd"));
		String strSaleDt    = String2.nvl(form.getParam("strSaleDt"));
		String strTranFlag  = String2.nvl(form.getParam("strTranFlag"));
		String strPosNo     = String2.nvl(form.getParam("strPosNo"));
		String strEtcGbn    = String2.nvl(form.getParam("strEtcGbn"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_MASTER"));
		sql.setString(++i, strStrCd);
		sql.setString(++i, strSaleDt);

		
		ret = select2List(sql);
		
		return ret;
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 행사구분 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMgHs(ActionForm form, String userid) throws Exception {
		try{
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 0;

		String strStrCd     = String2.nvl(form.getParam("strStrCd"));
		String strPumBunCd  = String2.nvl(form.getParam("strPumBunCd"));
		String strSaleDt    = String2.nvl(form.getParam("strSaleDt"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_HS_MG"));
		sql.setString(++i, strStrCd);
		sql.setString(++i, strPumBunCd);
		sql.setString(++i, strSaleDt);
		
		ret = select2List(sql);
		
		return ret;
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
     * 행사장별 POS 중복체크
	 * @return
	 * @throws Exception
	 */
	public Map selSeqNo(ActionForm form, String strStrCd, String strEventPlaceCd, String strPosNo) throws Exception {
	    int i = 0;
		Map mapList    = null;
		Service svc    = null;
		SqlWrapper sql = null;
	    
	    try {
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sql.put(svc.getQuery("SEL_SEQ_NO"));
	        sql.setString(++i, strStrCd);
	        sql.setString(++i, strEventPlaceCd);
	        sql.setString(++i, strPosNo);
	        mapList = selectMap(sql);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    
	    return mapList;
	}

	
	/**
	 * 엑셀 업로드 브랜드명, 품목명, 상품명  조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchExcel(ActionForm form, String userid, String OrgFlag) throws Exception {

		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 0;

		String strPumBunCd     = String2.nvl(form.getParam("strPumBunCd"));
		String strPumPokSrtCd  = String2.nvl(form.getParam("strPumPokSrtCd"));
		String strStrCd        = String2.nvl(form.getParam("strStrCd"));
		String strSkuCd        = String2.nvl(form.getParam("strSkuCd"));
		String strOrdDt        = String2.nvl(form.getParam("strOrdDt"));
		try{		
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			connect("pot");
			sql.put(svc.getQuery("SEL_EXCEL"));
			sql.setString(++i, strStrCd); //1
			sql.setString(++i, strSkuCd); //2
			sql.setString(++i, strOrdDt); //3
			sql.setString(++i, strStrCd); //4
			sql.setString(++i, userid);	  //5
			sql.setString(++i, OrgFlag);  //6
			
			ret = select2List(sql);
		
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
		return ret;
	}
	
	/**
	 * 매출수기등록 품목
	 * 
	 * @param form
	 * @param mi
	 * @param strId
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi1[], String userId)
			throws Exception {

		int ret 	= 0;
		int res 	= 0;
		int i   	= 0;
		int mstCnt 	= 0;	
		int resp    		= 0;     //프로시저 리턴값
		String  resm = "";
		
		//Map mapSlipNo      = null;
		

		
		SqlWrapper sql = null;
		Service svc = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		

		String strChk = "";
		
		
		try {
			connect("pot");
			begin();
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			

			while (mi1[0].next()) {
				
				sql.close();
				
				if (mi1[0].IS_INSERT()) { // 저장
					
					strChk = mi1[0].getString("CHK");
					
					if ("T".equals(strChk)) {
					
						//1. 매출테이블 Insert
						
						i = 1;
						
						sql.put(svc.getQuery("INS_MAECHUL_HS"));
						sql.setString(i++, mi1[0].getString("STR_CD"));
						sql.setString(i++, mi1[0].getString("SALE_DT"));
						sql.setString(i++, mi1[0].getString("REG_NO"));
						sql.setString(i++, mi1[0].getString("SALE_NO"));
						sql.setString(i++, mi1[0].getString("SEQ_NO"));
						sql.setString(i++, mi1[0].getString("EVT_CD"));
						sql.setString(i++, mi1[0].getString("MODEL_NO"));
						sql.setString(i++, mi1[0].getString("SKU_NAME"));
						sql.setString(i++, mi1[0].getString("SALE_FLAG"));
						sql.setString(i++, mi1[0].getString("SALE_TYPE"));
						sql.setString(i++, mi1[0].getString("SALE_QTY"));
						sql.setString(i++, mi1[0].getString("COST_PRC"));
						sql.setString(i++, mi1[0].getString("SALE_RATE"));
						sql.setString(i++, mi1[0].getString("SALE_PRC"));
						sql.setString(i++, mi1[0].getString("CTG1"));
						sql.setString(i++, mi1[0].getString("CTG2"));
						sql.setString(i++, mi1[0].getString("CTG3"));
						sql.setString(i++, mi1[0].getString("PUMBUN_CD"));
						sql.setString(i++, mi1[0].getString("SKU_CD"));
						sql.setString(i++, userId);
						
						res = update(sql);
						
						if (res <= 0) {
							throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
									+ "데이터 입력을 하지 못했습니다.(데이터 insert 실패)");
						}
						
						i = 1; 
						psql.put("DPS.PR_PSSKUDAY_HS", 9);				
						
						psql.setString(i++, mi1[0].getString("STR_CD")); 		// 점코드
				        psql.setString(i++, mi1[0].getString("SALE_DT")); 		// 지불년월
				        psql.setString(i++, mi1[0].getString("REG_NO"));		// 지불주기
				        psql.setString(i++, mi1[0].getString("SALE_NO"));		// 지불회차
				        psql.setString(i++, mi1[0].getString("SEQ_NO")); 		// 거래형태
				        psql.setString(i++, "0"); 
				        psql.setString(i++, userId);
				        psql.registerOutParameter(i++, DataTypes.INTEGER);	// 8
				        psql.registerOutParameter(i++, DataTypes.VARCHAR);	// 9
				        prs = updateProcedure(psql);
				            
				        resp += prs.getInt(8);    
				       
//						// 3. 마스터테이블에 저장
//						sql.put(svc.getQuery("INS_MASTER"));
//						
//						sql.setString(i++, mi1[0].getString("SLIP_NO"));  
//						sql.setString(i++, mi1[0].getString("STR_CD"));             
//						sql.setString(i++, mi1[0].getString("PUMBUN_CD"));     
//						sql.setString(i++, mi1[0].getString("VEN_CD"));                        
//						sql.setString(i++, mi1[0].getString("ORD_DT"));
//						sql.setString(i++, "");  
//						sql.setString(i++, mi1[0].getString("ORD_FLAG"));       
//						sql.setString(i++, "0"); 								/* 발주주체구분 : 0(백화점발주) */ 
//						sql.setString(i++, "0");   								/* 발주구분           : 0(일반) */   
//						sql.setString(i++, "0");								/* 자동전표구분 : 0(일반전표) */
//						sql.setString(i++, "0");								/* 인상하구분      : 0(인상하아님) */      
//						sql.setString(i++, "0");  
//						sql.setString(i++, "0");								/* 출입구분           : 0(출입아님) */    
//						sql.setString(i++, mi1[0].getString("ORD_DT"));        
//						sql.setString(i++, mi1[0].getString("ORD_DT"));   
//						sql.setString(i++, "");        /* SM확정일자 */
//						sql.setString(i++, "");             /* SM ID */  
//						sql.setString(i++, "");     /* 바이어ID */
//						sql.setString(i++, "");       /* 바이어확정일자(발주확정일자) */ 
//						sql.setString(i++, "");          
//						sql.setString(i++, "00");	/* 로그인사번에따라 다름  */    
//						sql.setString(i++, mi1[0].getString("DTL_CNT"));       
//						sql.setString(i++, mi1[0].getString("ORD_TOT_QTY"));   
//						sql.setString(i++, mi1[0].getString("NEW_COST_TAMT")); 
//						sql.setString(i++, mi1[0].getString("NEW_SALE_TAMT"));    
//						sql.setString(i++, mi1[0].getString("GAP_TOT_AMT"));   
//						sql.setString(i++, mi1[0].getString("NEW_GAP_RATE"));  
//						sql.setString(i++, mi1[0].getString("VAT_TAMT"));  		/* 부가세  */
//						sql.setString(i++, mi1[0].getString("BOTTLE_SLIP_YN"));    /* 공병전표여부  */ 
//						sql.setString(i++, mi1[0].getString("PAY_COND"));      
//						sql.setString(i++, mi1[0].getString("REMARK"));        
//						sql.setString(i++, mi1[0].getString("BIZ_TYPE"));      
//						sql.setString(i++, mi1[0].getString("TAX_FLAG")); 
//						sql.setString(i++, "0");                                 /* 수입발주구분 */
//						sql.setString(i++, "N");   
//						sql.setString(i++, mi1[0].getString("BIZ_TYPE"));     
//						sql.setString(i++, mi1[0].getString("SLIP_FLAG"));
//						sql.setString(i++, userId); 
//						sql.setString(i++, userId);
	
						
						
						// 4. 상세 데이터를 저장한다.
						//saveDetail(form, mi2, strSlipNo, userId);
	
						// 5. 발주매입Master 로그 저장  
						//saveMasterLog(form, mi1, userId);
				        if (resp != 0) {
				        	throw new Exception("[USER]"+ prs.getString(8));
						}
						else
						{
							ret = ret + 1;
						}
						// SMS전송
						//sendSMS(form, mi1, userId, org_flag);
					}

					
				}
				
				
				
				
			}
			
//			if (ret <= 0) {
//				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
//						+ "데이터 입력을 하지 못했습니다." );
//			}
			commit();
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}		
		return ret;
	}

	/**
	 * 매출수기등록 품목
	 * @param form
	 * @param mi
	 * @param strId
	 * @return
	 * @throws Exception
	 */
	private int insertMaster(ActionForm form, MultiInput mi, String strId, int nSeqNo) throws Exception {

		int ret = 0;
	    int i   = 0;	
		Service svc    = null;
		SqlWrapper sql = null;

	    try {
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sql.put(svc.getQuery("INS_MASTER"));
	        sql.setString(++i, mi.getString("STR_CD"));
	        sql.setString(++i, mi.getString("SALE_DT"));
	        sql.setString(++i, mi.getString("POS_NO"));
	        sql.setInt(++i,    nSeqNo);
	        sql.setString(++i, "2");	// 단품
	        sql.setString(++i, "");		// TRAN_NO
	        sql.setString(++i, strId);
	        sql.setString(++i, mi.getString("TRAN_FLAG"));
	        sql.setString(++i, mi.getString("ITEM_CD"));		// ITEM_CD
	        sql.setString(++i, mi.getString("ITEM_CD_TYPE"));	// 품번에 있는 SKU_FLAG
	        sql.setString(++i, mi.getString("ITEM_NAME"));		// ITEM__NAME
	        sql.setString(++i, mi.getString("PUMBUN_CD"));
	        sql.setString(++i, mi.getString("PUMMOK_CD"));
	        sql.setString(++i, mi.getString("EVENT_FLAG"));
	        sql.setString(++i, mi.getString("EVENT_RATE"));
	        sql.setInt(++i,    mi.getInt("SALE_PRC"));
	        sql.setInt(++i,    mi.getInt("SALE_QTY"));
	        sql.setInt(++i,    mi.getInt("SALE_PRC"));
	        sql.setInt(++i,    mi.getInt("SALE_QTY"));
	        sql.setString(++i, strId);
	        sql.setString(++i, strId);
	        sql.setInt(++i,    mi.getInt("CUST_CNT"));
	        ret = update(sql);
			sql.close();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
		return ret;
	}
	/**
	 * TR데이터 생성 프로시저 호출
	 * 
	 * @param form
	 * @param mi[]
	 * @param strId
	 * @return
	 * @throws Exception
	 */
	public ProcedureResultSet callProc(MultiInput mi, int nSeqNo, String strId)
			throws Exception {

		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i = 0;
				
        ProcedureWrapper 	psql = null; 
        ProcedureResultSet 	prs  = null; 
        psql = new ProcedureWrapper();

        // 처리로직 프로시저 호출
		psql.put("DPS.PR_PSDAY_ETC", 7);
		psql.setString(++i, mi.getString("STR_CD"));
		psql.setString(++i, mi.getString("SALE_DT"));
		psql.setString(++i, mi.getString("POS_NO"));
		psql.setInt(++i,    nSeqNo);
		psql.setString(++i, strId);
		psql.registerOutParameter(++i, DataTypes.INTEGER);
		psql.registerOutParameter(++i, DataTypes.VARCHAR);
		prs = updateProcedure(psql);
		return prs;
	}
}
