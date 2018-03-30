/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>협력사마스터관리</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by
 */

public class MCae101DAO extends AbstractDAO {

	 /**
     * <p>카드사 콤보 조회</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getCardComp(ActionForm form) throws Exception {

        List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            sql.put(svc.getQuery("SEL_CARD_COMP"));
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
    
    /**
     * <p>마스터 내역을 조회힌다.</p>
     * 
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
            String strStrCd			= String2.nvl(form.getParam("strStrCd"));		//점 코드
            String strBuySaleFlag	= String2.nvl(form.getParam("strBuySaleFlag"));	//매출매입구분
            String strVenFlag		= String2.nvl(form.getParam("strVenFlag"));		//협력사구분
            String strVenCd			= String2.nvl(form.getParam("strVenCd"));		//협력사코드

            sql.put(svc.getQuery("SEL_VEN_MST"));
            sql.setString(++i, strStrCd);              
            sql.setString(++i, strBuySaleFlag);              
            sql.setString(++i, strVenCd);              
            sql.setString(++i, strVenFlag);              
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
    
    /**
     * <p>협력사마스터를 저장한다.</p>
     * @param form, mi, strID
     * @return ret
     * @throws Exception
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
                    //throw new Exception("" + "조회 후 등록 가능합니다.");
                } else if (mi.IS_UPDATE()) {
                    int i = 0;
                    sql.put(svc.getQuery("UPD_VEN_MST"));
                    //INSERT, UPDATE 조건 CHECK
                    sql.setString(++i, mi.getString("STR_CD"));
                    sql.setString(++i, mi.getString("VEN_CD"));
                    
                    //UPDATE
                    sql.setString(++i, mi.getString("VEN_FLAG"));
                    sql.setString(++i, mi.getString("CARD_COMP"));
                    //Action에서 넘겨받은 session의 사용자 ID
                    sql.setString(++i, userID);   
                    sql.setString(++i, mi.getString("STR_CD"));
                    sql.setString(++i, mi.getString("VEN_CD"));
                    
                    //INSERT
                    sql.setString(++i, mi.getString("STR_CD"));
                    sql.setString(++i, mi.getString("VEN_CD"));
                    sql.setString(++i, mi.getString("VEN_FLAG"));
                    sql.setString(++i, mi.getString("CARD_COMP"));
                    //Action에서 넘겨받은 session의 사용자 ID
                    sql.setString(++i, userID);   
                    sql.setString(++i, userID); 
                    
                } else {
                    //throw new Exception("" + "등록된 내역은 삭제 할 수 없습니다.");
                }

                res = update(sql);

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
