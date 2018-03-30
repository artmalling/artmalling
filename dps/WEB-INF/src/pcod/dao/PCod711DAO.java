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
 * <p>행사장 POS관리</p>
 * 
 * @created  on 1.0, 2016/10/24
 * @created  by 박래형
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod711DAO extends AbstractDAO {

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
		
		String strStrCd        = String2.nvl(form.getParam("strStrCd"));
		String strEventPlaceCd = String2.nvl(form.getParam("strEventPlaceCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";	
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventPlaceCd);
		sql.put(strQuery);

		ret = select2List(sql);
		return ret;
	}

	/**
	 * 행사장별 POS, 제외브랜드 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] searchDetail(ActionForm form) throws Exception {
		
		List ret[]      = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strQuery = "";
		ret   = new List[2];
		int i = 0;	
		
		String strStrCd        = String2.nvl(form.getParam("strStrCd"));
		String strEventPlaceCd = String2.nvl(form.getParam("strEventPlaceCd"));

		connect("pot");
		
		// 행사장별 POS 조회
		sql = new SqlWrapper();
		svc = (Service) form.getService();	
		
		i = 0;
		strQuery = "";
		
		// 행사장별 POS관리 조회
		strQuery = svc.getQuery("SEL_DETAIL1") + "\n";	
		sql.setString(++i, strStrCd);
		sql.setString(++i, strEventPlaceCd);
		sql.put(strQuery);
		ret[0] = select2List(sql);
		sql.close();

		// 행사장별 POS 조회
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		i = 0;
		strQuery = "";

		// 제외브랜드 관리 조회
		strQuery = svc.getQuery("SEL_DETAIL2") + "\n";	
		sql.setString(++i, strStrCd);
		sql.setString(++i, strEventPlaceCd);
		sql.put(strQuery);
		ret[1] = select2List(sql);
		sql.close();
		
		return ret;
	}

	/**
	 * 행사장별 POS, 제외브랜드
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

		int ret           = 0;
		int res           = 0;
		Service svc       = null;
		boolean bCkhDup   = false;
		String strCudFlag = "";
		String strStrCd   = "";
		String strPosNo   = "";
		String strSaleDt  = "";
		String strEventPlaceCd = "";
		String strExPumbunCd   = "";
		
		int i;
		
		try {
			connect("pot");
			begin();
			
			// 행사장별 POS관리
			while (mi[0].next()) {
				
				if (mi[0].IS_INSERT()){			// 입력
					strStrCd        = mi[0].getString("STR_CD");
					strEventPlaceCd = mi[0].getString("EVENT_PLACE_CD");
					strPosNo        = mi[0].getString("POS_NO");

					// 중복체크
					bCkhDup = chkDupDtl1(form, strStrCd, strEventPlaceCd, strPosNo);
					if(!bCkhDup){
						throw new Exception("[USER]" + "중복된 POS번호(" + strPosNo +  ") 가 존재합니다.");
					}

					strCudFlag = "I";
					res = insertDetail1(form, mi[0], strId);
    				
				}else if (mi[0].IS_DELETE()){	// 삭제
					strCudFlag = "D";
					res = deleteDetail1(form, mi[0], strId);
				}
				
				// 히스토리 저장
				insertHisDtl1(form, mi[0], strId, strCudFlag);
				ret += res;
			}
			
			// 제외 브랜드관리
			while (mi[1].next()) {
				
				if (mi[1].IS_INSERT()){			// 입력
					strStrCd        = mi[0].getString("STR_CD");
					strEventPlaceCd = mi[0].getString("EVENT_PLACE_CD");
					strSaleDt       = mi[1].getString("SALE_DT");
					strExPumbunCd   = mi[1].getString("EX_PUMBUN_CD");
					
					// 중복체크
					bCkhDup = chkDupDtl2(form, strStrCd, strEventPlaceCd, strExPumbunCd, strSaleDt);
					if(!bCkhDup){
						throw new Exception("[USER]" + "중복된 일자(" + strSaleDt + ")에 \n"
								                     + "브랜드코드(" + strExPumbunCd + ") 가 존재합니다.");
					}
					
					res = insertDetail2(form, mi[1], strId);
    				
				}else if (mi[1].IS_UPDATE()){	// 수정
					res = updateDetail2(form, mi[1], strId);
    				
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
	 * 행사장별 POS 입력
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
			sql            = new SqlWrapper();
			svc = (Service) form.getService();
			
			sql.put(svc.getQuery("INS_DETAIL1"));
	        sql.setString(++i, mi.getString("STR_CD"));
	        sql.setString(++i, mi.getString("EVENT_PLACE_CD"));
	        sql.setString(++i, mi.getString("POS_NO"));
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
	 * 행사장별 POS 삭제
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
		    sql.setString(++i, mi.getString("EVENT_PLACE_CD"));
		    sql.setString(++i, mi.getString("POS_NO"));
		    ret = update(sql);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    
		sql.close();
		return ret;
	}

	/**
	 * 행사장별 POS 히스토리 저장
	 * @param form
	 * @param mi
	 * @param strId
	 * @return
	 * @throws Exception
	 */
	private void insertHisDtl1(ActionForm form, MultiInput mi, String strId, String strCudFlag) throws Exception {

		int ret = 0;
	    int i   = 0;	
		Service svc    = null;
		SqlWrapper sql = null;
		sql            = new SqlWrapper();
		svc = (Service) form.getService();

		sql.put(svc.getQuery("INS_HIS_DTL1"));	
	    sql.setString(++i, mi.getString("STR_CD"));
	    sql.setString(++i, mi.getString("EVENT_PLACE_CD"));
	    sql.setString(++i, mi.getString("POS_NO"));
	    sql.setString(++i, strCudFlag);
	    sql.setString(++i, strId);
	    ret = update(sql);
		sql.close();
	}
	
	/**
     * 행사장별 POS 중복체크
	 * @return
	 * @throws Exception
	 */
	public boolean chkDupDtl1(ActionForm form, String strStrCd, String strEventPlaceCd, String strPosNo) throws Exception {
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
	        sql.setString(++i, strEventPlaceCd);
	        sql.setString(++i, strPosNo);
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
	 * 제외 브랜드관리 입력
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
	        sql.setString(++i, mi.getString("EVENT_PLACE_CD"));
	        sql.setString(++i, mi.getString("EX_PUMBUN_CD"));
	        sql.setString(++i, mi.getString("SALE_DT"));
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
	 * 제외 브랜드관리 수정
	 * @param form
	 * @param mi
	 * @param strId
	 * @return
	 * @throws Exception
	 */
	private int updateDetail2(ActionForm form, MultiInput mi, String strId) throws Exception {

		int ret = 0;
	    int i   = 0;	
		Service svc    = null;
		SqlWrapper sql = null;

	    try {
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sql.put(svc.getQuery("UPD_DETAIL2"));	
	        sql.setString(++i, mi.getString("SALE_DT"));
	        sql.setString(++i, strId);
	        sql.setString(++i, mi.getString("STR_CD"));
	        sql.setString(++i, mi.getString("EVENT_PLACE_CD"));
	        sql.setString(++i, mi.getString("EX_PUMBUN_CD"));
	        sql.setString(++i, mi.getString("ORG_SALE_DT"));
	        ret = update(sql);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    
		sql.close();
		return ret;
	}

	/**
	 * 제외 브랜드관리 삭제
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
	        sql.setString(++i, mi.getString("EVENT_PLACE_CD"));
	        sql.setString(++i, mi.getString("EX_PUMBUN_CD"));
	        sql.setString(++i, mi.getString("ORG_SALE_DT"));
	        ret = update(sql);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    
		sql.close();
		return ret;
	}
	
	/**
     * 제외 브랜드관리 중복체크
	 * @return
	 * @throws Exception
	 */
	public boolean chkDupDtl2(ActionForm form, String strStrCd, String strEventPlaceCd, String strExPumbunCd, String strSaleDt) throws Exception {
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
	        sql.setString(++i, strEventPlaceCd);
	        sql.setString(++i, strExPumbunCd);
	        sql.setString(++i, strSaleDt);
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
