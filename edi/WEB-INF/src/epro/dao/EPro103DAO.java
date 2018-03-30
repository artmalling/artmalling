/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package epro.dao;

import java.net.URLDecoder;
import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
import ecom.util.Util;
/**
 * <p>SMS발송관리</p>
 * 
 * @created  on 1.0, 2011/06/27
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class EPro103DAO extends AbstractDAO {

    /**
     * <p>마스터 내역을 조회힌다.</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public String getMaster(ActionForm form) throws Exception {

        List list 		= null;
        SqlWrapper sql 	= null;
        Service svc 	= null;
        Util util 		= new Util();
        String rtJson 	= null;
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;
            String strStrCd		= String2.nvl(form.getParam("strStrcd"));	//점 코드
            String strSchFlag	= String2.nvl(form.getParam("strSchFlag"));	//조회구분
            String strVencd		= String2.nvl(form.getParam("strVencd"));	//협력사코드
            String strPumbuncd	= String2.nvl(form.getParam("strPumbuncd"));//품번코드
            String sDate		= String2.nvl(form.getParam("sDate"));		//기간(From)
            String eDate		= String2.nvl(form.getParam("eDate"));		//기간(To)
            String strCustNm	= String2.nvl(form.getParam("strCustNm"));	//고객명
            String strPromTy	= String2.nvl(form.getParam("strPromTy"));	//약속유형
            
            if (strSchFlag.equals("01")) {			//접수일자
            	sql.put(svc.getQuery("SEL_PROMISE_TAKE_DT"));
            } else if (strSchFlag.equals("02")) {	//입고예정일
            	sql.put(svc.getQuery("SEL_PROMISE_IN_DELI_DT"));
            } else {								//약속일자
            	sql.put(svc.getQuery("SEL_PROMISE_FIRST_PROM_DT"));
            }
            sql.setString(++i, strVencd);              
            sql.setString(++i, strPumbuncd);              
            sql.setString(++i, strPromTy);              
            sql.setString(++i, URLDecoder.decode(strCustNm, "UTF-8"));              
            sql.setString(++i, strStrCd);   
            sql.setString(++i, sDate);        
            sql.setString(++i, eDate);    
            
            list = select2List(sql);  
            list = util.decryptedStr(list,11);     //고객연락처
            list = util.decryptedStr(list,12);     //고객연락처
            list = util.decryptedStr(list,13);	   //고객연락처

			String cols= ""+
					"STR_CD,STR_NAME,TAKE_DT,TAKE_SEQ,IN_DELI_DT,FRST_PROM_DT," +
					"CUST_NM,MOBILE_PH,PROM_TYPE,PROC_STAT,PROM_DTL,MOBILE_PH1," +
					"MOBILE_PH2,MOBILE_PH3,SMS_YN"; 
			rtJson = util.listToJsonOBJ(list, cols);

        } catch (Exception e) {
            throw e;
        }
        return rtJson;
    }
    
    /**
     * <p>SMS발송리스트(디테일)를 조회힌다.</p>
     * 
     */
    @SuppressWarnings("rawtypes")
	public String getDetail(ActionForm form) throws Exception {

        List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        Util util 		= new Util();
        String rtJson 	= null;
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;
            String strStrcd		= String2.nvl(form.getParam("strStrcd"));	//점 코드
            String strTakeDt	= String2.nvl(form.getParam("strTakeDt"));	//접수일
            String strTakeSeq	= String2.nvl(form.getParam("strTakeSeq"));	//접수SEQ

            sql.put(svc.getQuery("SEL_SMSSENDMGR"));
            sql.setString(++i, strTakeSeq);              
            sql.setString(++i, strStrcd);              
            sql.setString(++i, strTakeDt);              
            list = select2List(sql);
            //복호화
            list = util.decryptedStr(list,4);	// 수신번호1
            list = util.decryptedStr(list,5);	// 수신번호2
            list = util.decryptedStr(list,6);	// 수신번호3
            
			String cols= ""+
					"SEND_DT,SEQ_NO,SEND_TYPE_NM,SEND_CONTENT,RECV_PH1,RECV_PH2," +
					"RECV_PH3,SEND_PH1,SEND_PH2,SEND_PH3,SEND_TYPE"; 
			rtJson = util.listToJsonOBJ(list, cols);
        } catch (Exception e) {
            throw e;
        }
        return rtJson;
    } 
    
    /**
     * <p>저장</p>
     * @param form, mi, strID
     * @return ret
     * @throws Exception
     */
    public String save(ActionForm form, String userID)
    throws Exception {
        int res = 0;
        String  rtString = null;
        SqlWrapper sql = null;
        Service svc = null;
        Util util = new Util();

        try {
            connect("pot");
            begin(); //DB트렌젝션 시작
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            
	        ProcedureWrapper 	psql 	= null; 
	        ProcedureResultSet 	prs 	= null; 
            String strStrCd		= String2.nvl(form.getParam("strStrCd"));	//점 코드
            String strTakeDt	= String2.nvl(form.getParam("strTakeDt"));	//접수일
            String strTakeSeq	= String2.nvl(form.getParam("strTakeSeq"));	//접수SEQ
            String strVenCd		= String2.nvl(form.getParam("strVenCd"));	//협력사코드
            String strSendType	= String2.nvl(form.getParam("strSendType"));	
            String strRecvPH1	= String2.nvl(form.getParam("strRecvPH1"));	
            String strRecvPH2	= String2.nvl(form.getParam("strRecvPH2"));	
            String strRecvPH3	= String2.nvl(form.getParam("strRecvPH3"));	
            String strSendPH1	= String2.nvl(form.getParam("strSendPH1"));	
            String strSendPH2	= String2.nvl(form.getParam("strSendPH2"));	
            String strSendPH3	= String2.nvl(form.getParam("strSendPH3"));	
            String strContent	= URLDecoder.decode(String2.nvl(form.getParam("strContent")), "UTF-8");	
            
            sql.close();
            psql = new ProcedureWrapper();
			psql.put("MSS.PR_MPSMSVENCREATE", 7);
			psql.setString(1, strContent);
			psql.setString(2, strSendPH1+""+strSendPH2+""+strSendPH3); 
			psql.setString(3, strRecvPH1+""+strRecvPH2+""+strRecvPH3); 
			psql.setString(4, strVenCd);	//협력사코드
			psql.setString(5, ""); 			//실시간 전송
			psql.registerOutParameter(6, DataTypes.VARCHAR);
			psql.registerOutParameter(7, DataTypes.VARCHAR);
			prs = updateProcedure(psql);
			
			String rtCd = prs.getString(6);
			String rtMsg = prs.getString(7);
			//SMS시스템에 정상등록이 아닐경우 ERR메시지 처리
			if (!rtCd.equals("0")) {
				throw new Exception("[USER]" + rtMsg );
			} else {
                int i = 0;
                sql.put(svc.getQuery("INS_SMSSENDMGR"));
                sql.setString(++i, strTakeDt);
                sql.setString(++i, strStrCd); 
                sql.setString(++i, strTakeSeq);
                sql.setString(++i, strSendType);
                sql.setString(++i, strContent);
                // 암호화[수신번호]
                sql.setString(++i, util.encryptedStr(strRecvPH1));
                sql.setString(++i, util.encryptedStr(strRecvPH2));
                sql.setString(++i, util.encryptedStr(strRecvPH3));
                sql.setString(++i, strSendPH1);
                sql.setString(++i, strSendPH2);
                sql.setString(++i, strSendPH3);
                sql.setString(++i, userID);   
                sql.setString(++i, userID);   
                res = update(sql);
			}
			
			if (res == 1) {
				rtString = "정상 처리되었습니다.";
			} else {
				throw new Exception("[USER]" + "정상적으로 처리 되지 않았습니다." );
			}

        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return rtString;
    }
}
