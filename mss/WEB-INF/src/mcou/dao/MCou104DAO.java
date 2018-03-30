/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcou.dao;

import java.util.List;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>[상담/계약]바이어변경이력조회</p>
 * 
 * @created  on 1.0, 2011/03/03
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCou104DAO extends AbstractDAO {

    /**
     * <p>마스터 조회</p>
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
            //화면(JSP)에서 입력된 (조회)파라미터(Paramater)
            String strStrCd		= String2.nvl(form.getParam("strStrCd"));		// 점코드
            String strDeptCd	= String2.nvl(form.getParam("strDeptCd"));		// 부문
            String strTeamCd	= String2.nvl(form.getParam("strTeamCd"));		// 팀
            String strPcCd		= String2.nvl(form.getParam("strPcCd"));		// PC
            String strSdate		= String2.nvl(form.getParam("strSdate"));		// 조회시작일
            String strEdate		= String2.nvl(form.getParam("strEdate"));		// 조회종료일
            String strWordFlag	= String2.nvl(form.getParam("strWordFlag"));	// 검색어구분
            String strWord		= String2.nvl(form.getParam("strWord"));		// 검색어
            String strProcStat	= String2.nvl(form.getParam("strProcStat"));	// 상담진행상태
            String strBuyerCd	= String2.nvl(form.getParam("strBuyerCd"));		// 바이어코드

            sql.put(svc.getQuery("SEL_MO_COUNSELREQ"));
            sql.setString(++i, strStrCd);              
            sql.setString(++i, strDeptCd);              
            sql.setString(++i, strTeamCd);             
            sql.setString(++i, strPcCd);              
            sql.setString(++i, strSdate);              
            sql.setString(++i, strEdate);              
            sql.setString(++i, strProcStat);              
            sql.setString(++i, strBuyerCd);      
            if (strWordFlag.equals("1")) {	// 회사명
            	sql.put(svc.getQuery("SEL_MO_COUNSELREQ_COMP"));
            	sql.setString(++i, strWord);// 대표자명  
            } else if (strWordFlag.equals("2")) {
            	sql.put(svc.getQuery("SEL_MO_COUNSELREQ_REP"));
            	sql.setString(++i, strWord);// 신청인  
            } else if (strWordFlag.equals("3")) {
            	sql.put(svc.getQuery("SEL_MO_COUNSELREQ_REQ"));
            	sql.setString(++i, strWord);  
            }
            	
            list = select2List(sql);
        } catch (Exception e) {//오류처리
            throw e;
        }
        return list;
    }
    
    /**
     * <p> POP(상세) 조회 </p>
     *  
     */
    @SuppressWarnings("rawtypes")
    public List getDetail(ActionForm form) throws Exception {
    	
    	List       list = null;
    	SqlWrapper  sql = null;
    	Service     svc = null;
    	
    	try {
    		connect("pot");
    		svc  = (Service)form.getService();
    		sql  = new SqlWrapper();
    		int i = 0;
    		//화면(JSP)에서 입력된 (조회)파라미터(Paramater)
    		String strReqDt		= String2.nvl(form.getParam("strReqDt"));	//신청일
    		String strReqSeq	= String2.nvl(form.getParam("strReqSeq"));	//신청SEQ
    		
    		sql.put(svc.getQuery("SEL_MO_BUYERMODHIS"));
    		sql.setString(++i, strReqDt);              
    		sql.setString(++i, strReqSeq);              
    		list = select2List(sql);
    	} catch (Exception e) {//오류처리
    		throw e;
    	}
    	return list;
    }
}
