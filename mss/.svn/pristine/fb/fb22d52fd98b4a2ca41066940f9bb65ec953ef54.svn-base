/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mpro.dao;

import java.util.List;

import common.util.Util;

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
 * <p>SMS발송관리</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MPro104DAO extends AbstractDAO {

    /**
     * <p>마스터 내역을 조회힌다.</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getMaster(ActionForm form) throws Exception {

        List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        Util util = new Util();
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;
            String strStrCd		= String2.nvl(form.getParam("strStrCd"));	//점 코드
            String strSchFlag	= String2.nvl(form.getParam("strSchFlag"));	//조회구분
            String strSchSdt	= String2.nvl(form.getParam("strSchSdt"));	//기간(From)
            String strSchEdt	= String2.nvl(form.getParam("strSchEdt"));	//기간(To)
            String strGuestNm	= String2.nvl(form.getParam("strGuestNm"));	//고객명
            String strPromType	= String2.nvl(form.getParam("strPromType"));//약속유형

            if (strSchFlag.equals("01")) {			//접수일자
            	sql.put(svc.getQuery("SEL_PROMISE_TAKE_DT"));
            } else if (strSchFlag.equals("02")) {	//입고예정일
            	sql.put(svc.getQuery("SEL_PROMISE_IN_DELI_DT"));
            } else {								//약속일자
            	sql.put(svc.getQuery("SEL_PROMISE_FIRST_PROM_DT"));
            }
            sql.setString(++i, strPromType);              
            sql.setString(++i, strGuestNm);              
            sql.setString(++i, strStrCd);   
            sql.setString(++i, strSchSdt);        
            sql.setString(++i, strSchEdt);    
            
            list = select2List(sql);  
          /*list = util.decryptedStr(list,11);     //고객연락처
            list = util.decryptedStr(list,12);     //고객연락처
            list = util.decryptedStr(list,13);	   //고객연락처*/

        } catch (Exception e) {
            throw e;
        }
        return list;
    }
    
    /**
     * <p>SMS발송리스트(디테일)를 조회힌다.</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getDetail(ActionForm form) throws Exception {

        List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        Util util = new Util();

        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;

            String strStrCd		= String2.nvl(form.getParam("strStrCd"));	//점 코드
            String strTakeDt	= String2.nvl(form.getParam("strTakeDt"));	//접수일
            String strTakeSeq	= String2.nvl(form.getParam("strTakeSeq"));	//접수SEQ

            sql.put(svc.getQuery("SEL_SMSSENDMGR"));
            sql.setString(++i, strTakeSeq);              
            sql.setString(++i, strStrCd);              
            sql.setString(++i, strTakeDt);              
            list = select2List(sql);
            //복호화
          /*list = util.decryptedStr(list,4);	// 수신번호1
            list = util.decryptedStr(list,5);	// 수신번호2
            list = util.decryptedStr(list,6);	// 수신번호3 */
        } catch (Exception e) {
            throw e;
        }
        return list;
    } 
    
    /**
     * <p>저장</p>
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
        Util util = new Util();

        try {
            connect("pot");
            begin(); //DB트렌젝션 시작
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            
	        ProcedureWrapper psql = null; 
	        ProcedureResultSet prs = null; 
	        
            String strStrCd		= String2.nvl(form.getParam("strStrCd"));	//점 코드
            String strTakeDt	= String2.nvl(form.getParam("strTakeDt"));	//접수일
            String strTakeSeq	= String2.nvl(form.getParam("strTakeSeq"));	//접수SEQ
            
            
            while (mi.next()) {
                sql.close();
                
                psql = new ProcedureWrapper();
				psql.put("MSS.PR_MPSMSVENCREATE", 7);
				psql.setString(1, mi.getString("SEND_CONTENT"));
				psql.setString(2, mi.getString("SEND_PH1")+""+mi.getString("SEND_PH2")+mi.getString("SEND_PH3")); 
				psql.setString(3, mi.getString("RECV_PH1")+""+mi.getString("RECV_PH2")+mi.getString("RECV_PH3")); 
				psql.setString(4, userID); 	//전송자사번
				psql.setString(5, ""); 		//실시간 전종
				psql.registerOutParameter(6, DataTypes.VARCHAR);
				psql.registerOutParameter(7, DataTypes.VARCHAR);
				prs = updateProcedure(psql);
				
				String rtCd = prs.getString(6);
				String rtMsg = prs.getString(7);
				
				//SMS시스템에 정상등록이 아닐경우 ERR메시지 처리
				if (!rtCd.equals("0")) {
					throw new Exception("[USER]" + rtMsg );
				}
				
                if (mi.IS_INSERT()) {
                    int i = 0;
                    sql.put(svc.getQuery("INS_SMSSENDMGR"));
                    sql.setString(++i, mi.getString("SEND_DT"));
                    sql.setString(++i, mi.getString("SEND_DT"));
                    sql.setString(++i, strTakeDt);
                    sql.setString(++i, strStrCd); 
                    sql.setString(++i, strTakeSeq);
                    sql.setString(++i, mi.getString("SEND_TYPE"));
                    sql.setString(++i, mi.getString("SEND_CONTENT"));
                    // 암호화[수신번호]
                    sql.setString(++i, mi.getString("RECV_PH1"));
                    sql.setString(++i, mi.getString("RECV_PH2"));
                    sql.setString(++i, mi.getString("RECV_PH3"));
                    sql.setString(++i, mi.getString("SEND_PH1"));
                    sql.setString(++i, mi.getString("SEND_PH2"));
                    sql.setString(++i, mi.getString("SEND_PH3"));
                    sql.setString(++i, userID);   
                    sql.setString(++i, userID);   
                    res = update(sql);
                } else if (mi.IS_UPDATE()){
                    int i = 0;
                    sql.put(svc.getQuery("UPD_VENMST"));
                    sql.setString(++i, mi.getString("SEND_TYPE"));
                    // 암호화[수신번호]
                    sql.setString(++i, mi.getString("RECV_PH1"));
                    sql.setString(++i, mi.getString("RECV_PH2"));
                    sql.setString(++i, mi.getString("RECV_PH3"));
                    sql.setString(++i, mi.getString("SEND_PH1"));
                    sql.setString(++i, mi.getString("SEND_PH2"));
                    sql.setString(++i, mi.getString("SEND_PH3"));
                    sql.setString(++i, mi.getString("SEND_CONTENT"));
                    sql.setString(++i, userID);   
                    sql.setString(++i, mi.getString("SEND_DT"));
                    sql.setString(++i, mi.getString("SEQ_NO"));
                    res = update(sql);
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
