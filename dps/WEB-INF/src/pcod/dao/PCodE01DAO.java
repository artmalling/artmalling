/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

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

public class PCodE01DAO extends AbstractDAO {

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
		//String strTranFlag  = String2.nvl(form.getParam("strTranFlag"));
		//String strPosNo     = String2.nvl(form.getParam("strPosNo"));
		//String strEtcGbn    = String2.nvl(form.getParam("strEtcGbn"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_MASTER"));
		//sql.setString(++i, strStrCd);
		sql.setString(++i, strSaleDt);
		//sql.setString(++i, strTranFlag);
		//sql.setString(++i, strPosNo);
		//sql.setString(++i, strEtcGbn);
		
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
	 * 엑셀 업로드 브랜드명, 품목명, 행사율, 행사구분  조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchExcel(ActionForm form, String userid) throws Exception {
		try{
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 0;

		String strPumBunCd     = String2.nvl(form.getParam("strPumBunCd"));
		String strPumPokSrtCd  = String2.nvl(form.getParam("strPumPokSrtCd"));
		String strStrCd        = String2.nvl(form.getParam("strStrCd"));
		String strSaleDt       = String2.nvl(form.getParam("strSaleDt"));
		String strEvtflg       = String2.nvl(form.getParam("strEvtflg"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_EXCEL"));
		sql.setString(++i, strPumBunCd);
		sql.setString(++i, strPumPokSrtCd);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strEvtflg);
		sql.setString(++i, strSaleDt);
		
		ret = select2List(sql);
		
		return ret;
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
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
	public int save(ActionForm form, MultiInput mi[], String strId)
			throws Exception {

		Map mapList      = null;
		int ret          = 0;
		int res          = 0;
		//int nSeqNo       = 0;
		//String strStrCd  = "";
		String strSaleDt = String2.nvl(form.getParam("strSaleDt"));
		//String strProcId  = "";
		
		
        ProcedureResultSet prs = null; 
        
		try {
			connect("pot");
			begin();
			
			// POS별 브랜드그룹관리
			while (mi[0].next()) {
				//strStrCd  = mi[0].getString("STR_CD");
				//strProcId  = mi[0].getString("PROCESSID");
				
				//mapList = selSeqNo(form, strStrCd, strSaleDt, strPosNo);
				//nSeqNo  = Integer.parseInt(mapList.get("SEQ_NO").toString()) ;
				
				if (mi[0].IS_UPDATE()){			// 입력
					//res = insertMaster(form, mi[0], strId, nSeqNo);
					// TR데이터 생성 프로시저 호출
					
					prs = callProc(mi[0], strSaleDt, strId);
				}
				
				//System.out.println(prs.getString(4));
				//ret = prs.getInt(3);
				
				//System.out.println(String.valueOf(ret));
				
				//mi[0].set(", obj);

				if(prs.getInt(3) < 0){
					throw new Exception("[USER]"+ prs.getString(4));
				}
				ret += prs.getInt(3);
			}
			
			if (ret < 0) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다." );
			}
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
	        sql.setString(++i, "1");	// 품목
	        sql.setString(++i, "");		// TRAN_NO
	        sql.setString(++i, strId);
	        sql.setString(++i, mi.getString("TRAN_FLAG"));
	        sql.setString(++i, mi.getString("PUMBUN_CD"));		// ITEM_CD
	        sql.setString(++i, mi.getString("PUMMOK_CD"));		// ITEM_CD
	        sql.setString(++i, mi.getString("EVENT_FLAG"));		// ITEM_CD
	        sql.setString(++i, mi.getString("ITEM_CD_TYPE"));	// 품번에 있는 SKU_FLAG
	        sql.setString(++i, mi.getString("PUMBUN_NAME"));	// ITEM__NAME
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
	public ProcedureResultSet callProc(MultiInput mi, String strDt, String strId)
			throws Exception {

        ProcedureWrapper 	psql = null; 
        ProcedureResultSet 	prs  = null; 
        psql = new ProcedureWrapper();
		int i = 0;
		String strProcId = mi.getString("PROCESSID");
		System.out.println(strProcId);
		System.out.println(strDt);
		System.out.println(strId);
		
	        // 처리로직 프로시저 호출
			psql.put(strProcId, 4);
			psql.setString(++i, strDt);
			psql.setString(++i, strId);
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			prs = updateProcedure(psql);
			
		return prs;
	}
}
