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

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>회원메모관리</p>
 * 
 * @created  on 1.0, 2010/02/10
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DCtm116DAO extends AbstractDAO {

	/**
     * <p>회원메모관리  마스터 조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        int i = 1;
        String strCardNo    = String2.nvl(form.getParam("strCardNo"));
        String strSsNo      = String2.nvl(form.getParam("strSsNo"));
        String strCustId    = String2.nvl(form.getParam("strCustId"));
        String strMemoDateF = String2.nvl(form.getParam("strMemoDateF"));
        String strMemoDateT = String2.nvl(form.getParam("strMemoDateT"));
        String strCompPersFlag = String2.nvl(form.getParam("strCompPersFlag"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
                                        		 
        sql.setString(i++, strMemoDateF); 
        sql.setString(i++, strMemoDateT);
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
		
		if (!String2.isEmpty(String2.trim((strCustId)))){
			strQuery += svc.getQuery("SEL_MASTER_CUST_ID") + "\n";
			sql.setString(i++, strCustId);
		}	
		
		if (!String2.isEmpty(String2.trim((strSsNo)))){
			strQuery += svc.getQuery("SEL_MASTER_SS_NO") + "\n";
			sql.setString(i++, strSsNo);
		}

		if (!String2.isEmpty(String2.trim((strCardNo)))){
			strQuery += svc.getQuery("SEL_MASTER_CARD_NO") + "\n";
			sql.setString(i++, strCardNo);
		}
		
		strQuery += svc.getQuery("SEL_MASTER_END") + "\n";

        if(strCompPersFlag.equals("C")){ 
        	strQuery += ("              AND B.COMP_PERS_FLAG  <> 'P'                     \n");
        	strQuery +=  ("           ORDER BY A.MEMO_DATE  DESC                         \n");
  
        }else{
        	strQuery +=  ("             AND B.COMP_PERS_FLAG = ?                         \n");
        	//strQuery +=  ("           ORDER BY A.MEMO_DATE  DESC                         \n");
        	strQuery +=  ("           ORDER BY A.MEMO_DATE                           \n");
            sql.setString(i++, strCompPersFlag);
        }
        
        sql.put(strQuery);
        ret = select2List(sql);
        //ret = util.decryptedStr(ret,5);     //주민등록번호 복호화.
        return ret; 
    }
 
    /**
     * <p>회원메모  상세 조회</p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        Util       util     = new Util();
        String     strQuery = "";
        int i = 1;
        
        String strCustId   = String2.nvl(form.getParam("strCustId"));
        String strMemoDate = String2.nvl(form.getParam("strMemoDate"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
 
        sql.setString(i++, strCustId);
        sql.setString(i++, strMemoDate);
        
        strQuery = svc.getQuery("SEL_DETAIL"); 
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    } 
    
    /**
     *  회원메모를  저장, 수정 처리한다.
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
        //int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null;
        Util util      = new Util();
        
        String strUpdFlag   = String2.nvl(form.getParam("strUpdFlag"));
        
        try {
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            
            while (mi.next()) {
                if (mi.IS_INSERT()) { // 저장
                    int i=1;
                    sql.put(svc.getQuery("INS_MEMO")); 
                    sql.setString(i++, mi.getString("CUST_ID"));        //회원번호
                    sql.setString(i++, mi.getString("MEMO_TYPE"));      //메모구분
                    sql.setString(i++, mi.getString("MEMO_DESC"));      //메모내용
                    sql.setString(i++, userId);                         //로그인ID
        
                }else if(mi.IS_UPDATE()){// 수정
                	
                	if(strUpdFlag.equals("1")){ // 수정저장 
                		int i=1;
                        sql.put(svc.getQuery("UPD_MEMO")); 
                        sql.setString(i++, mi.getString("MEMO_DESC"));     //메모내용
                        sql.setString(i++, userId);                         //로그인ID
                        sql.setString(i++, mi.getString("CUST_ID"));       //회원번호
                        sql.setString(i++, mi.getString("MEMO_DATE"));     //메모일시
                    }else if(strUpdFlag.equals("2")) { // 수정신규저장
                        int i=1;
                        sql.put(svc.getQuery("UPD_MEMO_INS")); 
                        sql.setString(i++, mi.getString("MEMO_DESC"));     //메모내용
                        sql.setString(i++, mi.getString("MEMO_TYPE"));     //메모구분
                        sql.setString(i++, userId);                        //로그인ID
                        sql.setString(i++, mi.getString("MEMO_DATE"));     //메모일시
                        sql.setString(i++, mi.getString("CUST_ID"));       //회원번호
                        sql.setString(i++, mi.getString("MEMO_DATE"));     //메모일시
                    } else{	// 추가신규저장
	                    int i=1;
	                    sql.put(svc.getQuery("UPD_MEMO_ADD")); 
	                    sql.setString(i++, mi.getString("CUST_ID"));        //회원번호
	                    sql.setString(i++, mi.getString("MEMO_TYPE"));      //메모구분
	                    sql.setString(i++, mi.getString("MEMO_DESC"));      //메모내용
	                    sql.setString(i++, userId);                         //로그인ID
                        sql.setString(i++, mi.getString("MEMO_DATE"));      //메모일시
	                }
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
