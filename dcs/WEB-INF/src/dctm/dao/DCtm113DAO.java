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
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>제휴카드사 회원탈퇴 현황</p>
 * 
 * @created  on 1.0, 2010/02/24
 * @created  by 김영진(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm113DAO extends AbstractDAO {
	/**
     * <p>제휴카드사 회원탈퇴 현황 조회</p>
     * 
     */
    public List searchMaster(ActionForm form, String strBrchId) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        Util   util     = new Util();
        int i = 1;
        String strJcompScedSDt = String2.nvl(form.getParam("strJcompScedSDt"));
        String strJcompScedEDt = String2.nvl(form.getParam("strJcompScedEDt"));
        String strTag          = String2.nvl(form.getParam("strTag"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        
        sql.setString(i++, strBrchId);
        //sql.setString(i++, strJcompScedSDt); 2011.08.16 컬럼누락으로 인해 임시 주석처리
        //sql.setString(i++, strJcompScedEDt); 2011.08.16 컬럼누락으로 인해 임시 주석처리
        
        strQuery = svc.getQuery("SEL_MASTER"); 
        
		if ("N".equals(strTag)){	        //N : 미통화
			strQuery += "\n               AND E.CALL_DATE  IS  NULL ";
		}else if ("Y".equals(strTag)){	   //Y : 통화 
			strQuery += "\n               AND E.CALL_DATE  IS  NOT NULL" ;
		}		

        sql.put(strQuery);
        ret = select2List(sql);
        //ret = util.decryptedStr(ret,5);     //자택전화1복호화.
		//ret = util.decryptedStr(ret,6);     //자택전화2 복호화.
		//ret = util.decryptedStr(ret,7);     //자택전화3 복호화.
        //ret = util.decryptedStr(ret,8);     //이동전화1복호화.
		//ret = util.decryptedStr(ret,9);     //이동전화2 복호화.
		//ret = util.decryptedStr(ret,10);    //이동전화3 복호화.
		 
        return ret;
    }
    /**
     * <p>제휴카드사 회원탈퇴 정보 상세 조회</p>
     * 
     */
    public List searchDetail(ActionForm form, String strBrchId, String strUserId) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        Util       util     = new Util();
        String     strQuery = "";
        int i = 1;
        
        String strJcompScedSDt = String2.nvl(form.getParam("strJcompScedSDt"));
        String strJcompScedEDt = String2.nvl(form.getParam("strJcompScedEDt"));
        String strCustId       = String2.nvl(form.getParam("strCustId"));
        String strCallDate     = String2.nvl(form.getParam("strCallDate"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
 
		if (strCallDate.equals(""))	{        //N : 미통화
		    sql.setString(i++, strUserId);
		    sql.setString(i++, strBrchId);
		    //sql.setString(i++, strJcompScedSDt); 2011.08.16 컬럼누락으로 인해 임시 주석처리
		    //sql.setString(i++, strJcompScedEDt); 2011.08.16 컬럼누락으로 인해 임시 주석처리 
			sql.setString(i++, strCustId);
			strQuery = svc.getQuery("SEL_NOCALL");
		}else if (!strCallDate.equals("")){   //Y : 통화 
		    sql.setString(i++, strBrchId);
		    //sql.setString(i++, strJcompScedSDt); 2011.08.16 컬럼누락으로 인해 임시 주석처리
		    //sql.setString(i++, strJcompScedEDt); 2011.08.16 컬럼누락으로 인해 임시 주석처리 
	        sql.setString(i++, strCallDate);
	        strQuery = svc.getQuery("SEL_YESCALL");
		}	

        sql.put(strQuery); 
        ret = select2List(sql);
        //ret = util.decryptedStr(ret,5);     //자택전화1복호화.
		//ret = util.decryptedStr(ret,6);     //자택전화2 복호화.
		//ret = util.decryptedStr(ret,7);     //자택전화3 복호화.
        //ret = util.decryptedStr(ret,8);     //이동전화1복호화.
		//ret = util.decryptedStr(ret,9);     //이동전화2 복호화.
		//ret = util.decryptedStr(ret,10);    //이동전화3 복호화.
        return ret;
    }
    
    /**
     *  제휴카드사 회원탈퇴 정보를  저장, 수정 처리한다.
     * 
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
    public String save(ActionForm form, MultiInput mi, String strUserId)
    throws Exception {
        
        String ret = null;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null;
        Util util      = new Util();
        
        String strTag  = String2.nvl(form.getParam("strTag"));
        
        try {
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            while (mi.next()) {
                if ("N".equals(strTag)) { // 저장
                    int i=1;
                    sql.put(svc.getQuery("INS_BANK_SCED"));
                    sql.setString(i++, mi.getString("CUST_ID"));        //회원번호
                    sql.setString(i++, strUserId);                      //로그인ID CALLID
                    sql.setString(i++, mi.getString("CALL_DESC"));      //메모내용
                    sql.setString(i++, strUserId);                      //로그인ID CALLID
                }else if("Y".equals(strTag)){// 수정
                    int i=1;
                    sql.put(svc.getQuery("UPD_BANK_SCED")); 
                    sql.setString(i++, mi.getString("CALL_DESC"));     //메모내용
                    sql.setString(i++, strUserId);                     //로그인ID CALLID
                    sql.setString(i++, mi.getString("CUST_ID"));       //회원번호
                    sql.setString(i++, mi.getString("CALL_DATE"));     //메모일시
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

