/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mren.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>관리비항목 관리</p>
 * 
 * @created  on 1.0, 2010/03/10
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen607DAO extends AbstractDAO {

	/**
     * <p>관리비항목 내역조회</p>
     */
    @SuppressWarnings("rawtypes")
    public List getMaster(ActionForm form) throws Exception {

    	List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;
            
            //parameters
            String strStrCd		= String2.nvl(form.getParam("strStrCd"));	// [조회용]시설구분(점코드)
            String strMntnType	= String2.nvl(form.getParam("strMntnType"));// [조회용]관리비분류
            String strMntnFlag	= String2.nvl(form.getParam("strMntnFlag"));// [조회용]관리비구분팀

            sql.put(svc.getQuery("SEL_MR_MNTNITEM"));
            sql.setString(++i, strStrCd);              
            sql.setString(++i, strMntnType);              
            sql.setString(++i, strMntnFlag);              
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
    
    /**
     * <p>중복키값조회</p>
     */
    @SuppressWarnings("rawtypes")
    public List getDupKeyValue(ActionForm form, MultiInput mi) throws Exception {
    	List       list = null;
    	SqlWrapper  sql = null;
    	Service     svc = null;
    	try {
    		connect("pot");
    		svc  = (Service)form.getService();
    		sql  = new SqlWrapper();
    		int loopCnt = 0;
            // 1.점, 관리비코드 
            // 2.점, 관리비분류, 관리비구분, 계산항목, 사용여부
    		int i = 0;
    	    while (mi.next()) {
                if (mi.IS_INSERT()) {
                	// 1.점, 관리비코드 
                	if (loopCnt == 0)  {
                		sql.put(svc.getQuery("SEL_DUP_KEYVALUE"));
                	} else {
                		sql.put(svc.getQuery("SEL_DUP_UNIONALL"));
                	}
                	sql.put(svc.getQuery("SEL_SUB_DUP_KEYVALUE1"));	
                	sql.setString(++i ,mi.getString("STR_CD"));     
                	sql.setString(++i ,mi.getString("MNTN_ITEM_CD")); 
                	sql.put(svc.getQuery("SEL_DUP_UNIONALL"));
                	sql.put(svc.getQuery("SEL_SUB_DUP_KEYVALUE2"));	
                	sql.setString(++i ,mi.getString("STR_CD"));     
                	sql.setString(++i ,mi.getString("MNTN_TYPE"));     
                	sql.setString(++i ,mi.getString("MNTN_FLAG"));     
                	sql.setString(++i ,mi.getString("CAL_CD"));     
                	sql.setString(++i ,mi.getString("USE_YN"));
                	loopCnt++;
                } else if (mi.IS_UPDATE()) {
                	// 2.점, 관리비분류, 관리비구분, 계산항목, 사용여부
                	if (loopCnt == 0)  {
                		sql.put(svc.getQuery("SEL_DUP_KEYVALUE"));
                	} else {
                		sql.put(svc.getQuery("SEL_DUP_UNIONALL"));
                	}
                	sql.put(svc.getQuery("SEL_SUB_DUP_KEYVALUE2"));	
                	sql.setString(++i ,mi.getString("STR_CD"));     
                	sql.setString(++i ,mi.getString("MNTN_TYPE"));     
                	sql.setString(++i ,mi.getString("MNTN_FLAG"));     
                	sql.setString(++i ,mi.getString("CAL_CD"));     
                	sql.setString(++i ,mi.getString("USE_YN")); 
                	sql.put(svc.getQuery("SEL_SUB_DUP_KEYVALUE2_UPD"));	
            		sql.setString(++i ,mi.getString("MNTN_ITEM_CD")); 
            		loopCnt++;
                }
    	    }
    	    
    	    if (sql != null) sql.put(svc.getQuery("SEL_DUP_CLOSE"));

    		list = select2List(sql);
    	} catch (Exception e) {
    		throw e;
    	}
    	return list;
    }
    
	/**
	 * <p>공통코드[계산방식]</p>
	 */
	@SuppressWarnings("rawtypes")
	public List getEtcCodeSub(ActionForm form) throws Exception {
		
		List       list = null;
		SqlWrapper  sql = null;
		Service     svc = null;
		try {
			connect("pot");
			svc  = (Service)form.getService();
			sql  = new SqlWrapper();
			int i = 0;
			String strEtcCode	= String2.nvl(form.getParam("strEtcCode"));	// 공통코드(코드)
			
			sql.put(svc.getQuery("SEL_TC_COMMCODE"));
			sql.setString(++i, strEtcCode);              
			list = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

    
    /**
     * <p>관리비항목 저장</p>
     */
    public int save(ActionForm form, MultiInput mi, String userID)
    throws Exception {
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc = null;
        try {
            connect("pot");
            begin(); //DB트렌젝션 시작
            sql = new SqlWrapper();
            svc = (Service) form.getService();

            while (mi.next()) {
                sql.close();
                
                if (mi.IS_INSERT()) {
                	sql.put(svc.getQuery("INS_MR_MNTNITEM"));
                	int i = 0;
                    sql.setString(++i, mi.getString("STR_CD"));
                    sql.setString(++i, mi.getString("MNTN_ITEM_CD"));
                    sql.setString(++i, mi.getString("MNTN_ITEM_NM"));
                    sql.setString(++i, mi.getString("CAL_CD"));
                    //session의 사용자 ID
                    sql.setString(++i, userID);   
                    sql.setString(++i, userID);
                    res = update(sql);
                } else if (mi.IS_UPDATE()) {
                	sql.put(svc.getQuery("UPD_MR_MNTNITEM"));
                	int i = 0;
                    sql.setString(++i, mi.getString("MNTN_ITEM_NM"));
                    sql.setString(++i, mi.getString("MNTN_TYPE"));
                    sql.setString(++i, mi.getString("MNTN_FLAG"));
                    sql.setString(++i, mi.getString("CAL_CD"));
                    sql.setString(++i, mi.getString("CAL_TYPE"));
                    sql.setString(++i, mi.getString("AREA_UNIT_PRC"));
                    sql.setString(++i, mi.getString("PUB_APP_RATE"));
                    sql.setString(++i, mi.getString("TAX_INV_FLAG"));
                    sql.setString(++i, mi.getString("SORT_NO"));
                    sql.setString(++i, mi.getString("AUTO_DIV_YN"));
                    sql.setString(++i, mi.getString("AUTO_DIV_ITEM"));
                    sql.setString(++i, mi.getString("USE_YN"));
                    //session의 사용자 ID
                    sql.setString(++i, userID); 
                    sql.setString(++i, mi.getString("STR_CD"));
                    sql.setString(++i, mi.getString("MNTN_ITEM_CD"));
                    res = update(sql);
                } else {
                	/* 저장된 내역은 삭제 할 수 없음
                	sql.put(svc.getQuery("DEL_MR_MNTNITEM"));
                	int i = 0;
                    sql.setString(++i, mi.getString("STR_CD"));
                    sql.setString(++i, mi.getString("MNTN_ITEM_CD"));
                    res = update(sql);
                    */
                }
                
                if (res != 1) {
                	throw new Exception("" + "데이터의 적합성 문제로 인하여"
                			+ "데이터 입력을 하지 못했습니다.");
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
}
