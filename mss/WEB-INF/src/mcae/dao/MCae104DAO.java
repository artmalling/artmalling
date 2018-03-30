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
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>인정율 마스터관리</p>
 * 
 * @created  on 1.0, 2011/03/02
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCae104DAO extends AbstractDAO {
	 /**
     * <p>마스터 내역을 조회힌다.</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getMaster(ActionForm form) throws Exception {

    	List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        ProcedureWrapper proc = new ProcedureWrapper();
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;
            String strStrCd		= String2.nvl(form.getParam("strStrCd"));	// 점코드
            String strDeptCd	= String2.nvl(form.getParam("strDeptCd"));	// 부문
            String strTeamCd	= String2.nvl(form.getParam("strTeamCd"));	// 팀
            String strPcCd		= String2.nvl(form.getParam("strPcCd"));	// PC
            String strPumbunCd	= String2.nvl(form.getParam("strPumbunCd"));// 브랜드코드
            String strApprate	= String2.nvl(form.getParam("strApprate"));	// 브랜드코드

            sql.put(svc.getQuery("SEL_APPRATE"));
            sql.setString(++i, strStrCd);              
            sql.setString(++i, strDeptCd);              
            sql.setString(++i, strTeamCd);              
            sql.setString(++i, strPcCd);              
            sql.setString(++i, strPumbunCd);              
            sql.setString(++i, strApprate);              
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
    
    /**
     * <p>응모자 내역을 저장한다.</p>
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
                	String strChk = mi.getString("CHK_BOX");
                	if (strChk.equals("T")) {
	                    int i = 0;
	                    sql.put(svc.getQuery("UPD_APPRATE"));
	                    //INSERT, UPDATE 조건 CHECK
	                    sql.setString(++i, mi.getString("STR_CD"));
	                    sql.setString(++i, mi.getString("PUMBUN_CD"));
	                    
	                    //UPDATE
	                    sql.setString(++i, mi.getString("APP_RATE"));
	                    //Action에서 넘겨받은 session의 사용자 ID
	                    sql.setString(++i, userID);   
	                    sql.setString(++i, mi.getString("STR_CD"));
	                    sql.setString(++i, mi.getString("PUMBUN_CD"));
	                    
	                    //INSERT
	                    sql.setString(++i, mi.getString("STR_CD"));
	                    sql.setString(++i, mi.getString("PUMBUN_CD"));
	                    sql.setString(++i, mi.getString("APP_RATE"));
	                    //Action에서 넘겨받은 session의 사용자 ID
	                    sql.setString(++i, userID);   
	                    sql.setString(++i, userID);
	                    res = update(sql);
	                    
	                    if (res != 1) {
	                    	throw new Exception("" + "데이터의 적합성 문제로 인하여"
	                    			+ "데이터 입력을 하지 못했습니다.");
	                    }
	                    
	                    // 브랜드 인정율 history 등록 (수정시에도 무조건 insert)
	                    i = 0;
	                    sql.close();
	                    sql.put(svc.getQuery("INS_APPRATE_HIS"));
	                    sql.setString(++i, mi.getString("STR_CD"));
	                    sql.setString(++i, mi.getString("PUMBUN_CD"));
	                    sql.setString(++i, mi.getString("APP_RATE"));
	                    sql.setString(++i, userID);   
	                    sql.setString(++i, userID);
	                    res = update(sql);
	                    
	                    if (res != 1) {
	                    	throw new Exception("" + "데이터의 적합성 문제로 인하여"
	                    			+ "데이터 입력을 하지 못했습니다.");
	                    }
	                    ret += res;
                	}
                    
                } else {
                    //throw new Exception("" + "등록된 내역은 삭제 할 수 없습니다.");
                }
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
