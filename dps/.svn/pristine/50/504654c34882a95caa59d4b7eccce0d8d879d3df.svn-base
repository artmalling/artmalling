/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.base.BaseProperty;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper; 
import kr.fujitsu.ffw.util.String2;
import ksnetlib.filedatacomm.KSNetLib;

import org.apache.log4j.Logger;

import common.vo.SessionInfo;

/**
 * <p>
 * 입금상세데이터조회 DAO
 * </p>
 * 
 * @created on 1.0, 2010/06/01
 * @created by 김영진
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal932DAO extends AbstractDAO {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal932DAO.class);

	/**
	 * <p>
	 * 입금상세데이터조회 조회
	 * </p>
	 * 
	 */
	public List searchMaster(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";

		int i = 1;
		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strPayDtS 	= String2.nvl(form.getParam("strPayDtS"));
		String strPayDtE 	= String2.nvl(form.getParam("strPayDtE"));
		String strJbrchId 	= String2.nvl(form.getParam("strJbrchId"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		query = svc.getQuery("SEL_MASTER"); 
		sql.setString(i++, strStrCd   );
		sql.setString(i++, strPayDtS  );
		sql.setString(i++, strPayDtE  );
		sql.setString(i++, strJbrchId );
		
		sql.setString(i++, strPayDtS  );
		sql.setString(i++, strPayDtE  );

		sql.put(query);
		ret = select2List(sql);

		return ret;
	}
	
	/**
     * 회계기표일자를 저장 한다.
     * 
     * @param form
     * @param mi 
     * @param strID
     * @return
     * @throws Exception
     */
    public int save2(ActionForm form, MultiInput mi, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
    	int ret = 0; 
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null;

        HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        String strUserId = sessionInfo.getUSER_ID();
        
        try {        	
            connect("pot"); 
            begin(); 

            sql = new SqlWrapper();
            svc = (Service) form.getService();
            while (mi.next()) {            	
        		int i=1;       
        		sql.close();     		
        		sql.put(svc.getQuery("UPD_PAYD_REAL_DT"));
        		sql.setString(i++, mi.getString("REAL_DT"));
        		sql.setString(i++, mi.getString("PAY_DT"));
        		sql.setString(i++, mi.getString("PAY_SEQ"));
        		sql.setString(i++, mi.getString("SEQ_NO"));
        		//sql.setString(i++, strUserId);
        		
        		res = update(sql);       		
        		if (res < 1) {
        			throw new Exception();
        		}
                ret ++;
            }
            
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }
        return ret;
    }
    
    /**
     * 회계기표일자를 저장 한다.
     * 
     * @param form
     * @param mi 
     * @param strID
     * @return
     * @throws Exception
     */
    public int save(ActionForm form, MultiInput mi, HttpServletRequest request, HttpServletResponse response) throws Exception {
        /*
    	int ret = 0; 
        int res = 0;
        ProcedureWrapper psql = null;
        Service svc    = null;
        ProcedureResultSet proset = null; 

        HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        String strUserId = sessionInfo.getUSER_ID();
        
        try {
        	
            connect("pot"); 
            begin(); 

            String strAccntMigDt =  String2.nvl(form.getParam("strAccntMigDt"));
            while (mi.next()) {
                psql = new ProcedureWrapper();
        		int i=1;  
     
        	    psql.put("DPS.PR_PSAL932_SAP", 8);
        		psql.setString(i++, mi.getString("STR_CD"));
//        		psql.setString(i++, strAccntMigDt);
        		psql.setString(i++, mi.getString("REAL_DT"));
        		psql.setString(i++, mi.getString("PAY_DT"));
        		psql.setString(i++, mi.getString("PAY_SEQ"));
        		psql.setString(i++, mi.getString("SEQ_NO"));
        		psql.setString(i++, strUserId);
        		psql.registerOutParameter(i++, DataTypes.INTEGER);
        		psql.registerOutParameter(i++, DataTypes.VARCHAR);
        		
        		
        		System.out.println(mi.getString("STR_CD"));
        		System.out.println(mi.getString("REAL_DT"));
        		System.out.println(mi.getString("PAY_DT"));
        		System.out.println(mi.getString("PAY_SEQ"));
        		System.out.println(mi.getString("SEQ_NO"));
        		proset = updateProcedure(psql);
        		
        		psql.close();
        		int prsRet = proset.getInt(7);
                if (prsRet != 0) {
                	throw new Exception("[USER]" + proset.getString(8));
                }
                ret++;
            }
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }
        return ret;
        */
    	//apply
    	int ret = 0; 
        int res = 0;
        int prsRet = 0;
        ProcedureWrapper psql = null;
        Service svc    = null;
        ProcedureResultSet proset = null; 

        HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        String strUserId = sessionInfo.getUSER_ID();
        
        try {        	
            connect("pot"); 
            begin(); 

            String strStrCd =  String2.nvl(form.getParam("strStrCd"));
            String strPayDt =  String2.nvl(form.getParam("strPayDt"));
            
            //while (mi.next()) {
                psql = new ProcedureWrapper();
        		int i=1;  
        		
        	    psql.put("DPS.PR_PSAL931", 5);
        		psql.setString(i++, strStrCd);
//        		psql.setString(i++, strAccntMigDt);
        		psql.setString(i++, strPayDt);
        		psql.setString(i++, strUserId);
        		psql.registerOutParameter(i++, DataTypes.INTEGER);
        		psql.registerOutParameter(i++, DataTypes.VARCHAR);
        		
        		
        		//System.out.println(mi.getString("STR_CD"));
        		System.out.println(strPayDt);
        		proset = updateProcedure(psql);
        		System.out.println("Message"+proset.getInt(4));
        		System.out.println("Message"+proset.getString(5));
        		psql.close();
        		prsRet = proset.getInt(4);
                if (prsRet != 0) {
                	throw new Exception("[USER]" + proset.getString(5));
                }
                ret++;
            //}
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }
        return prsRet;
    }
    
    /**
	 * <p>
	 * 청구대상데이터 청구
	 * </p>
	 * 
	 */
	public int recData(ActionForm form, HttpServletRequest request) throws Exception {
		
		String paramStrCd 	= String2.nvl(form.getParam("paramStrCd"));
		String paramReqDt 	= String2.nvl(form.getParam("strPayDt"));
		String paramReqDts  = paramReqDt.substring(2,8);
		String strDeviceId  = "";
		ProcedureWrapper psql = new ProcedureWrapper();
		SqlWrapper sql = new SqlWrapper();
		Service svc = (Service) form.getService();
		//
		List list = null;
		int procCnt = 0;
		String procMsg = "";
		int io = 1;
		try {
			connect("pot");
			
			// 청구시 단말기id 조회 
			sql.put(svc.getQuery("SEL_DEVICEID"));
			sql.setString(1, paramStrCd);
			System.out.println("paramStrCd : "+ paramStrCd);
			System.out.println("strPayDt : "+paramReqDt);
			
			Map mapDeviceId = (Map)selectMap(sql);
			System.out.println("sql : "+ sql);
			strDeviceId = mapDeviceId.get("DEVICE_ID").toString();
			System.out.println("strDeviceId : "+ strDeviceId);
			if (strDeviceId.equals("") || strDeviceId==null ){
				throw new Exception("[USER-단말기ID오류]"+"해당점에 KSNET 단말기ID가 정의되지 않았습니다.");
			}
			
			// 모듈 클래스 생성
    		KSNetLib ksnetlib = new KSNetLib();
 
    		// 파일 데이터 수신
    		int recvResult = ksnetlib.recvFileData(
    				"210.181.29.21",			// 서버 아이피
    				20189,						// 서버 포트
    				5000,						// 서버 연결 및 송수신 타임아웃
    				"D:\\java\\batch\\Van_Data\\EDI_RCVAREA\\" +paramStrCd+"_"+paramReqDt+".rcv",	// 수신 받은 데이터를 저장할 경로를 포함한 파일명(*운영기*)
    				'H',						// 구분 코드 (문서 참고)
    				strDeviceId,
    				//"DPT0000199",				// 기관 코드
    				//"TESTMER001",				// 기관 코드
    				"REPLY",					// 입금 내역 코드 (문서 참고)
    				150,						// 입금 내역 코드에 따른 한 레코드 크기 (문서 참고)
    				paramReqDts					// 수신 일자 (YYMMDD)
    				);    

    		/*
    		// 파일 데이터 수신
    		int recvResult = ksnetlib.recvFileData(
    				"210.181.29.21",			// 서버 아이피
    				20189,						// 서버 포트
    				5000,						// 서버 연결 및 송수신 타임아웃
    				"W:\\Van_Data\\EDI_RCVAREA\\" +paramStrCd+"_"+paramReqDt+".rcv",	// 수신 받은 데이터를 저장할 경로를 포함한 파일명(*운영기*)
    				//"C:\\POSsever\\FTPROOT\\Van_Data\\EDI_RCVAREA\\" +paramStrCd+"_"+paramReqDt+".rcv",	// 수신 받은 데이터를 저장할 경로를 포함한 파일명(*개발기*)
    				'H',						// 구분 코드 (문서 참고)
    				"DPT0F33824",				// 기관 코드
    				//"TESTMER001",				// 기관 코드
    				"REPLY",					// 입금 내역 코드 (문서 참고)
    				150,						// 입금 내역 코드에 따른 한 레코드 크기 (문서 참고)
    				paramReqDts					// 수신 일자 (YYMMDD)
    				);    
    		*/
    		
    		String sendMessage = ksnetlib.getErrorMessage(recvResult); 
    		
    		if (recvResult != 0) {    			
			    throw new Exception("[USER]"+sendMessage);			
			}else{
				procCnt = recvResult;
			} 
			
			
		} catch (Exception e) {
            //rollback();
            throw e;
        } 
		finally {
			//end();
		}
		
        return procCnt;
	}
	
public int recData_first(ActionForm form, HttpServletRequest request) throws Exception {
		
		String paramStrCd 	= String2.nvl(form.getParam("paramStrCd"));
		String paramReqDt 	= String2.nvl(form.getParam("strPayDt"));
		String paramReqDts  = paramReqDt.substring(2,8);
		String strDeviceId  = "";
		ProcedureWrapper psql = new ProcedureWrapper();
		SqlWrapper sql = new SqlWrapper();
		Service svc = (Service) form.getService();
		//
		List list = null;
		int procCnt = 0;
		String procMsg = "";
		int io = 1;
		try {
			connect("pot");
			
			// 청구시 단말기id 조회 
			sql.put(svc.getQuery("SEL_DEVICEID"));
			sql.setString(1, paramStrCd);
			System.out.println("paramStrCd : "+ paramStrCd);
			System.out.println("strPayDt : "+paramReqDt);
			
			Map mapDeviceId = (Map)selectMap(sql);
			System.out.println("sql : "+ sql);
			strDeviceId = mapDeviceId.get("DEVICE_ID").toString();
			System.out.println("strDeviceId : "+ strDeviceId);
			if (strDeviceId.equals("") || strDeviceId==null ){
				throw new Exception("[USER-단말기ID오류]"+"해당점에 KSNET 단말기ID가 정의되지 않았습니다.");
			}
			
			// 모듈 클래스 생성
    		KSNetLib ksnetlib = new KSNetLib();
 
    		// 파일 데이터 수신
    		int recvResult = ksnetlib.recvFileData(
    				//"177.200.3.79",			// 서버 아이피
    				"177.200.3.71",			                        // 실서버 아이피
    				20190,						// 서버 포트
    				5000,						// 서버 연결 및 송수신 타임아웃
    				"D:\\java\\batch\\Van_Data\\EDI_RCVAREA\\" +paramStrCd+"_"+paramReqDt+".rcv",	// 수신 받은 데이터를 저장할 경로를 포함한 파일명(*운영기*)
    				'F',						// 구분 코드 (문서 참고)
    				strDeviceId,
    				//"DPT0000199",				// 기관 코드
    				//"TESTMER001",				// 기관 코드
    				"REPLY",					// 입금 내역 코드 (문서 참고)
    				150,						// 입금 내역 코드에 따른 한 레코드 크기 (문서 참고)
    				paramReqDts					// 수신 일자 (YYMMDD)
    				);    
	
    		String sendMessage = ksnetlib.getErrorMessage(recvResult); 
    		
    		if (recvResult != 0) {    			
			    throw new Exception("[USER]"+sendMessage);			
			}else{
				procCnt = recvResult;
			} 
			
			
		} catch (Exception e) {
            //rollback();
            throw e;
        } 
		finally {
			//end();
		}
		
        return procCnt;
	}
}
