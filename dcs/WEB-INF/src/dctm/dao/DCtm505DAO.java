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
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import common.util.Util;
//import java.util.Map;
import jdk.management.cmm.SystemResourcePressureMXBean;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
import sun.nio.cs.ext.DoubleByteEncoder;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/03/29
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm505DAO extends AbstractDAO {
	/**
     * <p>회원조회</p>
     * 
     */        
    public List searchList(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        Util util = new Util();

        String strSendDate     	= String2.nvl(form.getParam("strSendDate"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        
        strQuery = svc.getQuery("SEL_TRAN_LIST") + "\n";
        
        sql.put(strQuery);
        sql.setString(i++, strSendDate);        
        ret = select2List(sql);
        //ret = util.decryptedStr(ret, 2);       
        commit();
        
        return ret;
        
    }
    
    /**
	 * 문자를 발송합니다.
	 * 
	 * @param form
	 * @param mi[]
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String userId)
			throws Exception {

		int ret 		= 0;
		int res 		= 0;
		Util util 		= new Util();
		SqlWrapper sql 	= null;
		Service svc 	= null;
        int i = 1;
        int nSeqNo		= 0;

        ProcedureWrapper psql = null;	//프로시저 사용위함
        ProcedureResultSet procResult = null;
        
        String strChk	= null;
        String strSendDate   = String2.nvl(form.getParam("strSendDate"));
        String strSendGb   = String2.nvl(form.getParam("strSendGb"));
        String strContent  = String2.nvl(form.getParam("strContent"));
        String strOpGubun  = String2.nvl(form.getParam("strOpGubun"));
        
        String strSeqNo	   = String2.nvl(form.getParam("strSeqNo"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();
        psql = new ProcedureWrapper();	//프로시저 사용위함
		ProcedureResultSet prs = null;

        connect("pot");
        
		sql.put(svc.getQuery("SEL_TRANGRP_SEQ"));
		
		if (strSeqNo.equals("0")) {
			Map mapSlipNo = (Map)selectMap(sql);
			nSeqNo = Integer.parseInt(mapSlipNo.get("SEQ_NO").toString());
		} else {
			nSeqNo = Integer.parseInt(strSeqNo); 
		}
		

		sql.close();
		
		
		try {
			begin();
			mi[1].next();
			while (mi[0].next()) {//DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
				//System.out.println("loop start");
				//if (!mi[0].IS_INSERT()&&!mi[0].IS_UPDATE()) {
					
					//strChk = mi[0].getString("CHK");
					
					//if (strChk.equals("T")){
						//System.out.println("check");
						System.out.println("발송구분 : "+strOpGubun);
						i = 1;
						if (strOpGubun.equals("2")) {   //온라인
							psql.put("DPS.PR_SEND_SMS_ONLINE", 16);
							//psql.put("DPS.PR_SEND_SMS_ONLINE_TEST", 16); 
							psql.setInt(i++, nSeqNo);
				            psql.setString(i++, strSendGb); 	
				            psql.setString(i++, userId);
				            psql.setString(i++, strSendDate);
				            psql.setString(i++, mi[0].getString("SUBJ"));		// 문자 제목
				            psql.setString(i++, mi[1].getString("MSG"));		// 문자 내용
				            psql.setString(i++, mi[0].getString("MAEJANG_NAME"));	// 고객명 
				            psql.setString(i++, mi[0].getString("RTN_NO"));		// 회신 번호
				            psql.setString(i++, mi[0].getString("HP_NO"));		// 발신 번호
				            psql.registerOutParameter(i++, DataTypes.INTEGER);
				            psql.registerOutParameter(i++, DataTypes.VARCHAR);
				            psql.setString(i++, mi[0].getString("TOT_AMT"));		// 누계
				            psql.setString(i++, mi[0].getString("SALE_AMT"));		// 매출
				            psql.setString(i++, mi[0].getString("SALE_CNT"));		// 건수
				            psql.setString(i++, mi[0].getString("REG_CNT"));		// 상품
				            psql.setString(i++, mi[0].getString("RANK"));			// 순위
						} else {						// 일반

							psql.put("DPS.PR_SEND_SMS_NEW", 11);				            
							//psql.put("DPS.PR_SEND_SMS_NEW_TEST", 11);
							psql.setInt(i++, nSeqNo);
				            psql.setString(i++, strSendGb); 	
				            psql.setString(i++, userId);
				            psql.setString(i++, strSendDate);
				            psql.setString(i++, mi[0].getString("SUBJ"));		// 문자 제목
				            psql.setString(i++, mi[1].getString("MSG"));		// 문자 내용
				            psql.setString(i++, mi[0].getString("CUST_NAME"));	// 고객명 
				            psql.setString(i++, mi[0].getString("RTN_NO"));		// 회신 번호
				            psql.setString(i++, mi[0].getString("HP_NO"));		// 발신 번호
				            psql.registerOutParameter(i++, DataTypes.INTEGER);
				            psql.registerOutParameter(i++, DataTypes.VARCHAR);
						}
			            prs = updateProcedure(psql);
						
		                if (prs.getInt(10) != 0) {
		                	throw new Exception("[USER-문자발송 등록을 실패하였습니다."+ prs.getInt(11) + "]");
	                    }else{
	                    	res ++;
	                    }
			            
					//}
					if(res > 0 ) ret = res;
				//}
			}
			commit();
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		
		return ret;
	}
	
	 /**
		 * 문자를 발송합니다.
		 * 
		 * @param form
		 * @param mi[]
		 * @param strID
		 * @return
		 * @throws Exception
		 */
	public int sendProcess(ActionForm form, MultiInput mi[], String userId)
				throws Exception {

			int ret 		= 0;
			Util util 		= new Util();
			SqlWrapper sql 	= null;
			Service svc 	= null;
	        int i = 1;

	        String strTranGrp   = String2.nvl(form.getParam("strTranGrp"));
	        String strRegDate   = String2.nvl(form.getParam("strRegDate"));
	        int nTranGrp		= Integer.parseInt(strTranGrp);

	        sql = new SqlWrapper();
	        svc = (Service) form.getService();


	        connect("pot");
	
			try {
				begin();
				i = 1;
				// 전송 인터페이스 테이블 업데이트 (전송 처리)
				sql.put(svc.getQuery("UPD_EMTRAN_ART"));
				sql.setString(i++, strRegDate);	// 등록일자
				sql.setInt(i++, nTranGrp);	// 전송그룹번호
		        ret		= update(sql);  
		        System.out.println("응답코드 :"+ret); 
		        if (ret<0)
		        	throw new Exception("[USER-문자발송을 실패하였습니다.(fail update em_tran, TranGrp="+strTranGrp+")]");
		        
		        // 전송 내역 테이블 업데이트(전송 처리)
		        i = 1;
		        sql.close();
				sql.put(svc.getQuery("UPD_SMST_ART"));
				sql.setString(i++, userId);	// 전송자
				sql.setString(i++, strRegDate);	// 등록일자
				sql.setInt(i++, nTranGrp);	// 전송그룹번호
				ret		= update(sql);	
				System.out.println("응답코드 :"+ret);
				if (ret<0)
		        	throw new Exception("[USER-문자발송을 실패하였습니다.(fail update smst, TranGrp="+strTranGrp+")]");
				
				sql.close();
				
				// 업데이트 진행에 문제가 없으면 commit 하여 최종 발송 처리
				commit();
				
			} catch (Exception e) {
				rollback();
				throw e;
			} finally {
				end();
			}
			
			return ret;
		}
	
	 /**
	 * 문자 발송 대기 내역을 삭제합니다.
	 * 
	 * @param form
	 * @param mi[]
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int delProcess(ActionForm form, MultiInput mi[], String userId)
			throws Exception {

		int ret 		= 0;
		Util util 		= new Util();
		SqlWrapper sql 	= null;
		Service svc 	= null;
        int i = 1;

        String strTranGrp   = String2.nvl(form.getParam("strTranGrp"));
        String strRegDate   = String2.nvl(form.getParam("strRegDate"));
        int nTranGrp		= Integer.parseInt(strTranGrp);

        sql = new SqlWrapper();
        svc = (Service) form.getService();


        connect("pot");
        
		try {
			begin();
			i = 1;
			sql.close();
			// 전송 인터페이스 테이블 업데이트 (전송 처리)
			sql.put(svc.getQuery("DEL_EMTRAN"));
			sql.setString(i++, strRegDate);	// 등록일자
			sql.setInt(i++, nTranGrp);	// 전송그룹번호
	        ret		= update(sql);  
	        System.out.println("응답코드 :"+ret); 
	        if (ret<0)
	        	throw new Exception("[USER-삭제처리를 실패하였습니다.(fail delete em_tran, TranGrp="+strTranGrp+")]");
	        
	        i = 1;
	        sql.close();
			// 전송 인터페이스 테이블 업데이트 (전송 처리)
			sql.put(svc.getQuery("DEL_EMTRAN_MMS"));
			sql.setString(i++, strRegDate);	// 등록일자
			sql.setInt(i++, nTranGrp);	// 전송그룹번호
	        ret		= update(sql);  
	        System.out.println("응답코드 :"+ret); 
	        if (ret<0)
	        	throw new Exception("[USER-삭제처리를 실패하였습니다.(fail delete em_tran_mms, TranGrp="+strTranGrp+")]");
	        
	        // 전송 내역 테이블 업데이트(전송 처리)
	        i = 1;
	        sql.close();
			sql.put(svc.getQuery("DEL_SMST"));
			sql.setString(i++, strRegDate);	// 등록일자
			sql.setInt(i++, nTranGrp);	// 전송그룹번호
			ret		= update(sql);	
			System.out.println("응답코드 :"+ret);
			if (ret<0)
	        	throw new Exception("[USER-문자발송을 실패하였습니다.(fail delete smst, TranGrp="+strTranGrp+")]");
			
			sql.close();
			
			// 업데이트 진행에 문제가 없으면 commit 하여 최종 발송 처리
			commit();
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		
		return ret;
	}
		
	
	 public List searchCust(ActionForm form, HttpServletRequest request) throws Exception {
	        List ret        = null;
	        SqlWrapper sql  = null;
	        Service svc     = null;
	        String strQuery = "";
	        int i = 1;
	        Util util = new Util();

	        String strStrCd     	= String2.nvl(form.getParam("strStrCd"));
	        String strFromDt     	= String2.nvl(form.getParam("strFromDt"));
	        String strToDt     		= String2.nvl(form.getParam("strToDt"));
	        String strCUST_GRADE    = String2.nvl(form.getParam("strCUST_GRADE"));
	        String strSEX_CD        = String2.nvl(form.getParam("strSEX_CD"));

	        String strPoint_from    = String2.nvl(form.getParam("strPoint_from"));
	        String strPoint_to      = String2.nvl(form.getParam("strPoint_to"));
	        
	        String strSMs           = String2.nvl(form.getParam("strSMs"));
	        String strDM           	= String2.nvl(form.getParam("strDM"));
	        String strBIR_MONTH_S   = String2.nvl(form.getParam("strBIR_MONTH_S"));
	        String strHOME_ADDR     = String2.nvl(form.getParam("strHOME_ADDR"));
	        String strSubj          = String2.nvl(form.getParam("strSubj"));
	        String strRtnNo   		= String2.nvl(form.getParam("strRtnNo"));
	        //String strContent     = String2.nvl(form.getParam("strContent"));
	        String strContent     	= "";
	        String strGb     		= String2.nvl(form.getParam("strGb"));
	        String strAge_from		= String2.nvl(form.getParam("strAge_from"));
	        String strAge_to		= String2.nvl(form.getParam("strAge_to"));
	        // 조회 조건
	        String strSchCond		= String2.nvl(form.getParam("strSchCond"));
	        String strCndtnGbn		= String2.nvl(form.getParam("strCndtnGbn"));
	        String strOrgCd			= String2.nvl(form.getParam("strOrgCd"));
	        String strFloor			= String2.nvl(form.getParam("strFloor"));
	        String strPumbunCd		= String2.nvl(form.getParam("strPumbunCd"));
	        String strSaleFr		= String2.nvl(form.getParam("strSaleFr"));
	        String strSaleTo		= String2.nvl(form.getParam("strSaleTo"));
	        
	        String strSendCnt		= String2.nvl(form.getParam("strSendCnt"));

	        sql = new SqlWrapper();
	        svc = (Service) form.getService();

	        connect("pot");
	        
	        
	        
	        //if (strGb.equals("sch"))
	        //	strQuery = svc.getQuery("SEL_CUST") + "\n";
	        //else
	        //	strQuery = svc.getQuery("SEL_CUST_REG") + "\n";
	        
	        if (strSchCond.equals("Y")) {
	        	// 매출데이터 연계
	        	strQuery = svc.getQuery("SEL_CUST_COND_TOP") + "\n";
	        	
	        	sql.setString(i++, strContent);
		        sql.setString(i++, strSubj);
	      		sql.setString(i++, strRtnNo);
	      		sql.setString(i++, strStrCd);
		        sql.setString(i++, strSaleFr);
		        sql.setString(i++, strSaleTo);
		        sql.setString(i++, strSEX_CD);
		        sql.setInt(i++, Integer.parseInt(strPoint_from));
		        sql.setInt(i++, Integer.parseInt(strPoint_to));
		        sql.setInt(i++, Integer.parseInt(strAge_from));
		        sql.setInt(i++, Integer.parseInt(strAge_to));
		        sql.setString(i++, strSMs);
		        sql.setString(i++, strHOME_ADDR);
		        sql.setString(i++, strHOME_ADDR);
		        sql.setString(i++, strFromDt);
			            		  
	        	if (strCndtnGbn.equals("1")) {	// 브랜드 조건
	        		strQuery = strQuery + svc.getQuery("SEL_CUST_COND1") + "\n";
	        		sql.setString(i++, strPumbunCd);
	        	} else if (strCndtnGbn.equals("2")) {	// 조직 조건
	        		strQuery = strQuery + svc.getQuery("SEL_CUST_COND2") + "\n";
	        		sql.setString(i++, strOrgCd);
	        	} else if (strCndtnGbn.equals("3")) {	// 층 조건
	        		strQuery = strQuery + svc.getQuery("SEL_CUST_COND3") + "\n";
	        		sql.setString(i++, strFloor);
	        	} else {
	        		throw new Exception("[USER-조회 조건을 확인해주세요.]");
	        	}

	        	strQuery = strQuery + svc.getQuery("SEL_CUST_COND_BOT") + "\n";
	        	sql.setString(i++, strToDt);
	        	sql.setInt(i++, Integer.parseInt(strSendCnt));

	        } else {
	        	// 기본 조건 조회
	        	strQuery = svc.getQuery("SEL_CUST") + "\n";
	        	sql.setString(i++, strContent);
		        sql.setString(i++, strSubj);
	      		sql.setString(i++, strRtnNo);
	      		sql.setString(i++, strStrCd);
		        sql.setString(i++, strFromDt);
		        sql.setString(i++, strSEX_CD);
		        sql.setInt(i++, Integer.parseInt(strPoint_from));
		        sql.setInt(i++, Integer.parseInt(strPoint_to));		        
		        sql.setString(i++, strSMs);
		        sql.setString(i++, strHOME_ADDR);
		        sql.setString(i++, strHOME_ADDR);
		        sql.setInt(i++, Integer.parseInt(strAge_from));
		        sql.setInt(i++, Integer.parseInt(strAge_to));
		        sql.setString(i++, strToDt);
	        	sql.setInt(i++, Integer.parseInt(strSendCnt));
	        }

	        sql.put(strQuery);
	        ret = select2List(sql);
	        //ret = util.decryptedStr(ret, 2);       
	        commit();
	        
	        return ret;
	    }
	 
	 public List regCust(ActionForm form, HttpServletRequest request) throws Exception {
	        List ret        = null;
	        SqlWrapper sql  = null;
	        Service svc     = null;
	        String strQuery = "";
	        int i = 1;
	        Util util = new Util();

	        String strStrCd     	= String2.nvl(form.getParam("strStrCd"));
	        String strFromDt     	= String2.nvl(form.getParam("strFromDt"));
	        String strToDt     		= String2.nvl(form.getParam("strToDt"));
	        String strCUST_GRADE    = String2.nvl(form.getParam("strCUST_GRADE"));
	        String strSEX_CD        = String2.nvl(form.getParam("strSEX_CD"));

	        String strPoint_from    = String2.nvl(form.getParam("strPoint_from"));
	        String strPoint_to      = String2.nvl(form.getParam("strPoint_to"));
	        
	        String strSMs           = String2.nvl(form.getParam("strSMs"));
	        String strDM           = String2.nvl(form.getParam("strDM"));
	        String strBIR_MONTH_S   = String2.nvl(form.getParam("strBIR_MONTH_S"));
	        String strHOME_ADDR     = String2.nvl(form.getParam("strHOME_ADDR"));
	        String strSubj           = String2.nvl(form.getParam("strSubj"));
	        String strRtnNo   = String2.nvl(form.getParam("strRtnNo"));
	        //String strContent     = String2.nvl(form.getParam("strContent"));
	        String strContent     = "";
	        String strGb     = String2.nvl(form.getParam("strGb"));
	        
	                
	        sql = new SqlWrapper();
	        svc = (Service) form.getService();

	        connect("pot");
	        sql.setString(i++, strContent);
	        sql.setString(i++, strSubj);
	        sql.setString(i++, strRtnNo);
	        sql.setString(i++, strStrCd);
	        sql.setString(i++, strFromDt);
	        sql.setString(i++, strSEX_CD);
	        sql.setString(i++, strPoint_from);
	        sql.setString(i++, strPoint_to);
	        sql.setString(i++, strSMs);
	        sql.setString(i++, strHOME_ADDR);
	        sql.setString(i++, strHOME_ADDR);
	        sql.setString(i++, strToDt);
	        //sql.setString(i++, strDM);
	        
	        if (strGb.equals("sch"))
	        	strQuery = svc.getQuery("SEL_CUST") + "\n";
	        else
	        	strQuery = svc.getQuery("SEL_CUST_REG") + "\n";
	        
	        sql.put(strQuery);
	        ret = select2List(sql);
	        //ret = util.decryptedStr(ret, 2);       
	        commit();
	        
	        return ret;
	    }
	 
	 
	 public List seqSlpNo(ActionForm form, HttpServletRequest request) throws Exception {
	        
	        List ret        = null;
			SqlWrapper sql  = null;
			Service svc     = null;                         
			String strQuery = "";
			int i = 0;	
			


			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			connect("pot");
			strQuery = svc.getQuery("SEL_TRANGRP_SEQ") + "\n";
			sql.put(strQuery);
			
			ret = select2List(sql);
			commit();
			
			return ret;
	        
	    }
	
}

