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


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>POS별 브랜드관리</p>
 * 
 * @created  on 1.0, 2016/11/02
 * @created  by 박래형
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod713DAO extends AbstractDAO {

	/**
	 * 행사장마스터를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {
		
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strPosNo = String2.nvl(form.getParam("strPosNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";	
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPosNo);
		sql.put(strQuery);

		ret = select2List(sql);
		return ret;
	}

	/**
	 * POS별 브랜드그룹 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] searchDetail1(ActionForm form) throws Exception {
		
		List ret[]      = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strQuery = "";
		ret   = new List[1];
		int i = 0;	
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strPosNo = String2.nvl(form.getParam("strPosNo"));

		connect("pot");
		
		// POS별 브랜드 조회
		sql = new SqlWrapper();
		svc = (Service) form.getService();	
		
		i = 0;
		strQuery = svc.getQuery("SEL_DETAIL1") + "\n";	
		sql.setString(++i, strStrCd);
		sql.setString(++i, strPosNo);
		sql.put(strQuery);
		ret[0] = select2List(sql);
		sql.close();
		
		return ret;
	}

	/**
	 * POS별 브랜드 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] searchDetail2(ActionForm form) throws Exception {
		
		List ret[]      = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strQuery = "";
		ret   = new List[1];
		int i = 0;	
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strPosNo = String2.nvl(form.getParam("strPosNo"));
		String strGrpCd = String2.nvl(form.getParam("strGrpCd"));

		connect("pot");
		
		// POS별 브랜드 조회
		sql = new SqlWrapper();
		svc = (Service) form.getService();	
		
		i = 0;
		strQuery = svc.getQuery("SEL_DETAIL2") + "\n";	
		sql.setString(++i, strStrCd);
		sql.setString(++i, strPosNo);
		sql.setString(++i, strGrpCd);
		sql.put(strQuery);
		ret[0] = select2List(sql);
		sql.close();
		
		return ret;
	}

	/**
	 * POS별 브랜드, 제외브랜드
	 * 저장, 수정, 삭제 처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strId
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strId)
			throws Exception {

		int ret            = 0;
		int res            = 0;
		boolean bCkhDup    = false;
		String strStrCd    = "";
		String strPosNo    = "";
		String strGrpCd    = "";
		String strPumbunCd = "";
		
		int i;
		
		try {
			connect("pot");
			begin();
			
			// POS별 브랜드그룹관리
			while (mi[0].next()) {
				
				if (mi[0].IS_INSERT()){			// 입력
					strStrCd = mi[0].getString("STR_CD");
					strPosNo = mi[0].getString("POS_NO");
					strGrpCd = mi[0].getString("GRP_CD");

					// 중복체크
					bCkhDup = chkDupDtl1(form, strStrCd, strPosNo, strGrpCd);
					if(!bCkhDup){
						throw new Exception("[USER]" + "중복된 그룹(" + strGrpCd +  ")이 존재합니다.");
					}

					res = insertDetail1(form, mi[0], strId);
    				
				}else if (mi[0].IS_UPDATE()){	// 수정

					res = updateDetail1(form, mi[0], strId);
					
				}else if (mi[0].IS_DELETE()){	// 삭제

					// 중복체크
					bCkhDup = chkPosPbnCnt(form, strStrCd, strPosNo, strGrpCd);
					if(!bCkhDup){
						throw new Exception("[USER]" + "POS별 브랜드마스터에 그룹(" + strGrpCd +  ")이 존재합니다.");
					}
					res = deleteDetail1(form, mi[0], strId);
				}
				
				ret += res;
			}
			
			// POS별 브랜드관리
			while (mi[1].next()) {
				
				if (mi[1].IS_INSERT()){			// 입력
					strStrCd    = mi[1].getString("STR_CD");
					strPosNo    = mi[1].getString("POS_NO");
					strGrpCd    = mi[1].getString("GRP_CD");
					strPumbunCd = mi[1].getString("PUMBUN_CD");

					// 중복체크
					bCkhDup = chkDupDtl2(form, strStrCd, strPosNo, strGrpCd, strPumbunCd);
					if(!bCkhDup){
						throw new Exception("[USER]" + "중복된 품번(" + strPumbunCd +  ")이 존재합니다.");
					}

					res = insertDetail2(form, mi[1], strId);
    				
				}else if (mi[1].IS_DELETE()){	// 삭제
					res = deleteDetail2(form, mi[1], strId);
				}
				
				ret += res;
			}
			
			if (ret <= 0) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다." );
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
	 * POS별 브랜드그룹 입력
	 * @param form
	 * @param mi
	 * @param strId
	 * @return
	 * @throws Exception
	 */
	private int insertDetail1(ActionForm form, MultiInput mi, String strId) throws Exception {

		int ret = 0;
	    int i   = 0;	
		Service svc    = null;
		SqlWrapper sql = null;

	    try {
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sql.put(svc.getQuery("INS_DETAIL1"));
	        sql.setString(++i, mi.getString("STR_CD"));
	        sql.setString(++i, mi.getString("POS_NO"));
	        sql.setString(++i, mi.getString("GRP_CD"));
	        sql.setString(++i, mi.getString("GRP_NM"));
	        sql.setInt(++i,    mi.getInt("ORDER_SEQ"));
	        sql.setString(++i, mi.getString("USE_YN"));
	        sql.setString(++i, strId);
	        sql.setString(++i, strId);
	        ret = update(sql);
			sql.close();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
		return ret;
	}

	/**
	 * POS별 브랜드그룹 수정
	 * @param form
	 * @param mi
	 * @param strId
	 * @return
	 * @throws Exception
	 */
	private int updateDetail1(ActionForm form, MultiInput mi, String strId) throws Exception {

		int ret = 0;
	    int i   = 0;	
		Service svc    = null;
		SqlWrapper sql = null;

	    try {
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sql.put(svc.getQuery("UPD_DETAIL1"));	
	        sql.setString(++i, mi.getString("GRP_NM"));
	        sql.setInt(++i,    mi.getInt("ORDER_SEQ"));
	        sql.setString(++i, mi.getString("USE_YN"));
	        sql.setString(++i, strId);
	        sql.setString(++i, mi.getString("STR_CD"));
	        sql.setString(++i, mi.getString("POS_NO"));
	        sql.setString(++i, mi.getString("GRP_CD"));
		    ret = update(sql);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    
		sql.close();
		return ret;
	}

	/**
	 * POS별 브랜드그룹 삭제
	 * @param form
	 * @param mi
	 * @param strId
	 * @return
	 * @throws Exception
	 */
	private int deleteDetail1(ActionForm form, MultiInput mi, String strId) throws Exception {

		int ret = 0;
	    int i   = 0;	
		Service svc    = null;
		SqlWrapper sql = null;

	    try {
			sql            = new SqlWrapper();
			svc = (Service) form.getService();
			
			sql.put(svc.getQuery("DEL_DETAIL1"));	
		    sql.setString(++i, mi.getString("STR_CD"));
		    sql.setString(++i, mi.getString("POS_NO"));
		    sql.setString(++i, mi.getString("GRP_CD"));
		    ret = update(sql);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    
		sql.close();
		return ret;
	}
	
	/**
     * POS별 브랜드그룹 중복체크
	 * @return
	 * @throws Exception
	 */
	public boolean chkDupDtl1(ActionForm form, String strStrCd, String strPosNo, String strGrpCd) throws Exception {
	    int i = 0;
		Map mapList    = null;
	    boolean bFlag  = true;
		Service svc    = null;
		SqlWrapper sql = null;
	    
	    try {
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sql.put(svc.getQuery("CHK_DUPDTL1"));
	        sql.setString(++i, strStrCd);
	        sql.setString(++i, strPosNo);
	        sql.setString(++i, strGrpCd);
	        mapList = selectMap(sql);
	        
	        // 중복데이터가 존재하면 false 리턴
	        if(!"0".equals(mapList.get("CNT").toString())) bFlag = !bFlag;
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    
	    return bFlag;
	}
	
	/**
     * POS별 브랜드 마스터 데이터 존재여부 체크
	 * @return
	 * @throws Exception
	 */
	public boolean chkPosPbnCnt(ActionForm form, String strStrCd, String strPosNo, String strGrpCd) throws Exception {
	    int i = 0;
		Map mapList    = null;
	    boolean bFlag  = true;
		Service svc    = null;
		SqlWrapper sql = null;
	    
	    try {
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sql.put(svc.getQuery("CHK_POSPBN_CNT"));
	        sql.setString(++i, strStrCd);
	        sql.setString(++i, strPosNo);
	        sql.setString(++i, strGrpCd);
	        mapList = selectMap(sql);
	        
	        // 중복데이터가 존재하면 false 리턴
	        if(!"0".equals(mapList.get("CNT").toString())) bFlag = !bFlag;
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    
	    return bFlag;
	}
	
	/**
	 * POS별 브랜드 입력
	 * @param form
	 * @param mi
	 * @param strId
	 * @return
	 * @throws Exception
	 */
	private int insertDetail2(ActionForm form, MultiInput mi, String strId) throws Exception {

		int ret = 0;
	    int i   = 0;	
		Service svc    = null;
		SqlWrapper sql = null;

	    try {
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sql.put(svc.getQuery("INS_DETAIL2"));
	        sql.setString(++i, mi.getString("STR_CD"));
	        sql.setString(++i, mi.getString("POS_NO"));
		    sql.setString(++i, mi.getString("GRP_CD"));
	        sql.setString(++i, mi.getString("PUMBUN_CD"));
	        sql.setString(++i, strId);
	        sql.setString(++i, strId);
	        ret = update(sql);
			sql.close();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
		return ret;
	}

	/**
	 * POS별 브랜드 삭제
	 * @param form
	 * @param mi
	 * @param strId
	 * @return
	 * @throws Exception
	 */
	private int deleteDetail2(ActionForm form, MultiInput mi, String strId) throws Exception {

		int ret = 0;
	    int i   = 0;	
		Service svc    = null;
		SqlWrapper sql = null;

	    try {
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sql.put(svc.getQuery("DEL_DETAIL2"));	
		    sql.setString(++i, mi.getString("STR_CD"));
		    sql.setString(++i, mi.getString("POS_NO"));
		    sql.setString(++i, mi.getString("GRP_CD"));
		    sql.setString(++i, mi.getString("PUMBUN_CD"));
		    ret = update(sql);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    
		sql.close();
		return ret;
	}
	
	/**
     * POS별 브랜드 중복체크
	 * @return
	 * @throws Exception
	 */
	public boolean chkDupDtl2(ActionForm form, String strStrCd, String strPosNo, String strGrpCd, String strPumbunCd) throws Exception {
	    int i = 0;
		Map mapList    = null;
	    boolean bFlag  = true;
		Service svc    = null;
		SqlWrapper sql = null;
	    
	    try {
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sql.put(svc.getQuery("CHK_DUPDTL2"));
	        sql.setString(++i, strStrCd);
	        sql.setString(++i, strPosNo);
	        sql.setString(++i, strGrpCd);
	        sql.setString(++i, strPumbunCd);
	        mapList = selectMap(sql);
	        
	        // 중복데이터가 존재하면 false 리턴
	        if(!"0".equals(mapList.get("CNT").toString())) bFlag = !bFlag;
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    
	    return bFlag;
	}
}
