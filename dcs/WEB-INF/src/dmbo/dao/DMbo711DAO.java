/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.util.Util;
import common.vo.SessionInfo;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
 
/**
 * <p>VIP 방문 등록</p>
 * 
 * @created  on 1.0, 2010/06/29 
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by  
 */
public class DMbo711DAO extends AbstractDAO {

	/**
     * <p>VIP 방문 등록  마스터 조회</p>
     * 
     */
    public List searchMaster(ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null; 
        Util       util = new Util();
        String strQuery = "";
        int i = 1;
        
        HttpSession session     = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        
        String strBrchId = sessionInfo.getBRCH_ID();
        
        String strCardNo    = String2.nvl(form.getParam("strCardNo"));
        String strSsNo      = String2.nvl(form.getParam("strSsNo"));
        String strCustId    = String2.nvl(form.getParam("strCustId"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        sql.put(svc.getQuery("SEL_CUST_GRADE"));
        sql.setString(i++, strBrchId);      //가맹점ID
        sql.setString(i++, strCustId);      //회원ID
        sql.setString(i++, strSsNo);
        sql.setString(i++, strCardNo);
        Map map = selectMap(sql);            
        String strSelGrade = String2.nvl((String)map.get("CUST_GRADE")).equals("")?"0":(String)map.get("CUST_GRADE"); 
        sql.close();
        if(strSelGrade.equals("0")){ 
        	throw new Exception("[USER]" + "회원정보가 존재하지 않습니다.");
        }else if(strSelGrade.equals("N")){ 
            throw new Exception("[USER]" + "VIP 회원이 아닙니다.");
        }
        sql = new SqlWrapper();
        i=1;
        sql.setString(i++, strCustId);
        sql.setString(i++, strSsNo);
        sql.setString(i++, strCardNo);
        sql.setString(i++, strBrchId);
        sql.put(svc.getQuery("SEL_MASTER"));
        ret = select2List(sql);
        return ret; 
    }
 
    /**
     * <p>CRM 등급 조회</p>
     * 
     */
    public List searchGrade(ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null; 
        Util       util = new Util();
        String strQuery = "";
        int i = 1;
         
        HttpSession session     = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        
        String strBrchId = sessionInfo.getBRCH_ID();
        
        String strCardNo    = String2.nvl(form.getParam("strCardNo"));
        String strSsNo      = String2.nvl(form.getParam("strSsNo"));
        String strCustId    = String2.nvl(form.getParam("strCustId"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
                                        		 
        sql.setString(i++, strCustId);
        sql.setString(i++, strSsNo);
        sql.setString(i++, strCardNo);
        sql.setString(i++, strBrchId);
        
        strQuery = svc.getQuery("SEL_GRADE");
        
        sql.put(strQuery);
        ret = select2List(sql);
        return ret; 
    }
    
    /** 
     * <p>VIP 방문 등록 상세 조회</p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        Util       util     = new Util();
        String     strQuery = ""; 
        int i = 1;
  
        String strCustId = String2.nvl(form.getParam("strCustId"));
        String strInDate = String2.nvl(form.getParam("strInDate"));
        String strBrchId = String2.nvl(form.getParam("strBrchId"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
 
        sql.setString(i++, strCustId);
        sql.setString(i++, strBrchId);
        sql.setString(i++, strInDate);
        
        strQuery = svc.getQuery("SEL_DETAIL"); 
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    } 
    
    /**
     *  VIP 방문 등록/수정 처리한다.
     * 
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
    public String save(ActionForm form, MultiInput mi, String userId)
    throws Exception {
        
        String ret = null;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null;
        Util util      = new Util();
        
        try {
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            
            while (mi.next()) {
                if (mi.IS_INSERT()) { // 저장 
                    int i=1;
                    sql.put(svc.getQuery("INS_VIP_VISIT")); 
                    sql.setString(i++, mi.getString("BRCH_ID"));        //가맹점ID
                    sql.setString(i++, mi.getString("CUST_ID"));        //회원번호
                    sql.setString(i++, mi.getString("MEMBER_QTY"));     //동반 고객수
                    sql.setString(i++, mi.getString("CUST_MEMO"));      //메모내용
                    sql.setString(i++, userId);                         //로그인ID
                    sql.setString(i++, userId);                         //로그인ID
                }else if(mi.IS_UPDATE()){// 수정
                    int i=1;
                    sql.put(svc.getQuery("UPD_VIP_VISIT")); 
                    sql.setString(i++, mi.getString("CUST_MEMO"));     //메모내용
                    sql.setString(i++, mi.getString("MEMBER_QTY"));    //동반 고객수
                    sql.setString(i++, userId);                        //로그인ID
                    sql.setString(i++, mi.getString("CUST_ID"));       //회원번호
                    sql.setString(i++, mi.getString("IN_DATE"));       //방문일시
                }
                res = update(sql); 
                if (res != 1) {
                	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
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
