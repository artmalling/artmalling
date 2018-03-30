/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.dao;

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

public class DCtm104DAO extends AbstractDAO {

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

		//String strStrCd     = String2.nvl(form.getParam("strStrCd"));
		String strSaleDt    = String2.nvl(form.getParam("strSaleDt"));
		String strDi  		= String2.nvl(form.getParam("strDi"));
		//String strPosNo     = String2.nvl(form.getParam("strPosNo"));
		//String strEtcGbn    = String2.nvl(form.getParam("strEtcGbn"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_MASTER"));
		//sql.setString(++i, strStrCd);
		sql.setString(++i, strSaleDt);
		sql.setString(++i, strDi);

		
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

		String strCardNo    	= String2.nvl(form.getParam("strCardNo"));
		String strCustNm  		= String2.nvl(form.getParam("strCustNm"));
		String strHpNo        	= String2.nvl(form.getParam("strHpNo"));

		try{		
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			connect("pot");
			sql.put(svc.getQuery("SEL_EXCEL"));
			sql.setString(++i, strCardNo); //1
			sql.setString(++i, strCustNm); //2
			sql.setString(++i, strHpNo); //3
		
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
			
			//sql = new SqlWrapper();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			

			while (mi1[0].next()) {
				
				//sql.close();
				
				if (mi1[0].IS_INSERT()) { // 저장
					
					strChk = mi1[0].getString("CHK");
					
					if ("T".equals(strChk)) {
						
						i = 1; 
						psql.put("DPS.PR_CUST_INS2EXCEL", 19);				
						
						psql.setString(i++, mi1[0].getString("ENTR_DT")); 		// 가입일자
				        psql.setString(i++, mi1[0].getString("CUST_NAME")); 	// 가입자명
				        psql.setString(i++, mi1[0].getString("SEX_CD"));		// 성별구분
				        psql.setString(i++, mi1[0].getString("BIRTH_DT"));		// 생년월일
				        psql.setString(i++, mi1[0].getString("BIRTH_FLAG")); 	// 생일구분
				        psql.setString(i++, mi1[0].getString("EMAILADDR")); 	// 메일주소
				        psql.setString(i++, mi1[0].getString("ADDR_FLAG")); 	// 주소구분
				        psql.setString(i++, mi1[0].getString("ADDR")); 			// 주소
				        psql.setString(i++, mi1[0].getString("POST_CD")); 		// 우편번호
				        psql.setString(i++, mi1[0].getString("HP_NO")); 		// 핸드폰번호		10
				        psql.setString(i++, mi1[0].getString("TEL_NO")); 		// 전화번호
				        psql.setString(i++, mi1[0].getString("DM")); 		// DM수신여부
				        psql.setString(i++, mi1[0].getString("SMS")); 		// SMS수신여부
				        psql.setString(i++, mi1[0].getString("MAIL")); 		// 메일수신여부
				        psql.setString(i++, mi1[0].getString("CARD_NO")); 		// 카드번호
				        psql.setString(i++, mi1[0].getString("PWD")); 		// 비밀번호
				        psql.setString(i++, userId);						// 등록자
				        psql.registerOutParameter(i++, DataTypes.INTEGER);	// 18
				        psql.registerOutParameter(i++, DataTypes.VARCHAR);	// 19 
				        prs = updateProcedure(psql);
				        
				            
				        resp += prs.getInt(18);    
				       
//						
				        if (resp != 0) {
				        	throw new Exception("[USER]"+ prs.getString(19));
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

