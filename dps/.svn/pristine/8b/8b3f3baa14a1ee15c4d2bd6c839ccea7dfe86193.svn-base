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
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.base.BaseProperty;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
import ksnetlib.filedatacomm.KSNetLib;

import org.apache.log4j.Logger;

import common.edi.service.Psal930EDI;
import common.vo.SessionInfo;

/**
 * <p>
 * 청구대상데이터 가져오기 DAO
 * </p>
 * 
 * @created on 1.0, 2010/05/23
 * @created by 조형욱
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal930DAO extends AbstractDAO {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal930DAO.class);

	/**
	 * <p>
	 * 청구대상데이터 목록 조회
	 * </p>
	 * 
	 */
	public List searchMaster(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";

		int i = 1;
		String paramStrCd 	= String2.nvl(form.getParam("paramStrCd"));
		String paramReqDt 	= String2.nvl(form.getParam("paramReqDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService(); 

		connect("pot");

		query = svc.getQuery("SEL_MASTER"); // + "\n";
//		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramReqDt);
		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramReqDt);
		sql.setString(i++, paramReqDt);
		sql.setString(i++, paramStrCd);
		
		sql.put(query);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * <p>
	 * 청구대상데이터 목록 조회
	 * </p>
	 * 
	 */
	public List searchDetail(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";

		int i = 1;
		String paramStrCd 	= String2.nvl(form.getParam("paramStrCd"));
		String paramReqDt 	= String2.nvl(form.getParam("paramReqDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		query = svc.getQuery("SEL_DETAIL"); // + "\n";
//		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramReqDt);
		sql.put(query);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * <p>
	 * CHRG_SEQ 조회
	 * </p>
	 * 
	 */
	public List searchSeq(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";

		int i = 1;
		
		String paramReqDt 	= String2.nvl(form.getParam("paramReqDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		query = svc.getQuery("SEL_CHRGSEQ"); // + "\n";
//		sql.setString(i++, paramStrCd);
		sql.setString(i++, paramReqDt);
		sql.put(query);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * <p>
	 * 청구대상데이터 청구
	 * </p>
	 * 
	 */
	public List save(ActionForm form, HttpServletRequest request) throws Exception {
		String paramStrCd 	= String2.nvl(form.getParam("paramStrCd"));
		String paramReqDt 	= String2.nvl(form.getParam("paramReqDt"));

		ProcedureWrapper psql = new ProcedureWrapper();
		SqlWrapper sql = new SqlWrapper();
		Service svc = (Service) form.getService();
		
		HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        String strUserId = sessionInfo.getUSER_ID();
        //
        System.out.println("paramStrCd:" + paramStrCd);
        System.out.println("paramReqDt:" + paramReqDt);
        System.out.println("strUserId:" + strUserId);
		//
		List list = null;
		int procCnt = 0;
		String procMsg = "";
		int io = 1;
		try {
			connect("pot");
			begin();
			/**/
			String query = svc.getQuery("SEL_MASTER"); // + "\n";
			sql.setString(io++, paramReqDt);
			sql.setString(io++, paramStrCd);
			sql.setString(io++, paramReqDt);
			sql.setString(io++, paramReqDt);
			sql.setString(io++, paramStrCd);
			
			sql.put(query);
			list = select2List(sql);
			
			//if (list.size() > 0) {
			ProcedureResultSet prs = null;
			String code 	= "";
			int result 		= 0;
			int presult 	= 0;
			
            /**
             * Code:1 ,작업: POS신용카드매출데이터, Procedure: DPS.PR_PSAL923
             */
            io = 1;
            psql.close();
            psql.put("DPS.PR_PSAL923", 8);    
            psql.setString(io++, paramStrCd);               	//점포
            psql.setString(io++, paramReqDt);                   //청구일자
            psql.setString(io++, strUserId);                    //작업자ID
            psql.registerOutParameter(io++, DataTypes.INTEGER); //PROC_CNT
            psql.registerOutParameter(io++, DataTypes.VARCHAR); //청구처리일자
            psql.registerOutParameter(io++, DataTypes.INTEGER); //처리처리순번            
            psql.registerOutParameter(io++, DataTypes.INTEGER); //RETURN
            psql.registerOutParameter(io++, DataTypes.VARCHAR); //MESSAGE
            /**/
            prs = updateProcedure(psql);
            /**/
            int pcount = prs.getInt(4);        
            logger.info("PROC_CNT:" + pcount);
            System.out.println("PROC_CNT:" + pcount);
            System.out.println("RETURN:" + prs.getInt(7));
            System.out.println("MESSAGE:" + prs.getString(8));
            
            result = pcount;
            presult = prs.getInt(7);
            
            
            String chrgDt = (String) prs.getString(5);
            String chrgSeq = (String) prs.getString(6);
            System.out.println("chrgDt:" + chrgDt);
            
            procCnt = pcount;
            procMsg = prs.getString(8);
            
			/* test중 result >0 변경예정*/
			if (pcount > 0) {	
				/* 매입상세 조회*/				
				System.out.println("paramReqDt:"+ paramReqDt);
				
				/*// 1일전
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				Date date = sdf.parse(paramReqDt);
				date.setTime(date.getTime() + ((long) -1 * 1000 * 60 * 60 * 24));
				paramReqDt = sdf.format(date);
				*/
				System.out.println("paramReqDt:"+ paramReqDt);
				
				/* 매입상세 조회*/
				int i = 1;
				sql = new SqlWrapper();
				query = svc.getQuery("SEL_DETAIL"); // + "\n";
				logger.debug("query: ["+ query +"]");				
				sql.setString(i++, chrgDt);
				sql.setString(i++, chrgSeq);
				sql.put(query);
				
				List<List<String>> dList = select2List(sql);
				logger.debug("detailList:["+ dList.size() +"]");
				
				/* 매입헤더 조회*/
				i = 1;
				sql = new SqlWrapper();
				query = svc.getQuery("SEL_HEADER"); // + "\n";
				sql.setString(i++, chrgDt);
				sql.setString(i++, chrgSeq);
				sql.put(query);
				
//				List<List<String>> hList = select2List(sql); 
				Map<String,String> hmap = this.selectMap(sql);
				logger.debug("hmap:["+ hmap.size() +"]");
				
				
				/* 매입요청 청구 EDI 송신 
				if (hmap.size()>0 && dList.size()>0) {
					result = this.callEDIService(dList, hmap);
				}*/
			}
			else {
				result = -1;
			}
			
			/* commit */
			if (result > 0) {
				end();
				System.out.println("매입요청 정상처리!");
			}
			else {
				rollback();
				System.out.println("처리된 건수 없음!");
			}
			
		} catch (Exception e) {
            rollback();
            throw e;
        } 
		finally {
			end();
		}
        
		if (list != null && list.size() > 0) {
			List tmpList = (List) list.get(0);
			tmpList.set(3, String.valueOf(procCnt));
			tmpList.set(4, String.valueOf(procMsg));
		}
		
        return list;
	}
	
	/**
	 * <p>
	 * 청구대상데이터 청구
	 * </p>
	 * 
	 */
	public int sendData(ActionForm form, HttpServletRequest request) throws Exception {
		
		String paramStrCd 	= String2.nvl(form.getParam("paramStrCd"));
		String paramReqDt 	= String2.nvl(form.getParam("paramReqDt"));
		String strToday 	= String2.nvl(form.getParam("strToday"));
		String strChrgSeq 	= String2.nvl(form.getParam("strChrgSeq"));
		String paramReqDts  = strToday.substring(2,8);
		String strQuery = "";
		String strDeviceId = "";

		ProcedureWrapper psql = new ProcedureWrapper();
		SqlWrapper sql = new SqlWrapper();
		Service svc = (Service) form.getService();
		//
		List list = null;
		int procCnt = 0;
		//String procMsg = "";
		//int io = 1;
		System.out.println("senddata 시작");
		try {
			connect("pot");
			begin();
			
			System.out.println("파일:"+paramStrCd+"_"+paramReqDt+".req");
			System.out.println("디렉토리:"+"D:\\java\\batch\\Van_Data\\EDI_SNDAREA\\");
			
			// 청구시 단말기id 조회 
			sql.put(svc.getQuery("SEL_DEVICEID"));
			sql.setString(1, paramStrCd);
			System.out.println("paramStrCd : "+ paramStrCd);
			
			Map mapDeviceId = (Map)selectMap(sql);
			System.out.println("sql : "+ sql);
			strDeviceId = mapDeviceId.get("DEVICE_ID").toString();
			System.out.println("strDeviceId : "+ strDeviceId);
			if (strDeviceId.equals("") || strDeviceId==null ){
				throw new Exception("[USER-단말기ID오류]"+"해당점에 KSNET 단말기ID가 정의되지 않았습니다.");
			}
	
			// 모듈 클래스 생성
    		KSNetLib ksnetlib = new KSNetLib();
    		// 파일 데이터 송신
    		
    		/*
    		int sendResult = ksnetlib.sendFileData(
    				"210.181.29.21",			                        // 서버 아이피
    				20189,						                        // 서버 포트
    				5000,						                        // 연결, 송수신 타임아웃
    				"D:\\java\\batch\\Van_Data\\EDI_SNDAREA\\" +paramStrCd+"_"+paramReqDt+".req",		// 경로를 포함한 보낼 파일명(*운영기*)
    				//"C:\\POSsever\\FTPROOT\\Van_Data\\EDI_SNDAREA\\" +paramStrCd+"_"+strToday+".req",		// 경로를 포함한 보낼 파일명(*개발기*)
    				//"C:\\POSsever\\FTPROOT\\Van_Data\\EDI_SNDAREA\\02_20110828.req",		// 경로를 포함한 보낼 파일명
    				'H',						                        // 구분 코드 (문서 참고)
    				200,						                        // 구분 코드에 따른 한 레코드 크기 (문서 참고)
    				strDeviceId,
    				//"DPT0000199",				                        // 기관 코드
    				//"TESTMER001",				                        // 기관 코드
    				1,							                        // 순번
    				paramReqDts					                        // 작업 일자 (YYMMDD) 
    				);
    		*/
    		int sendResult = ksnetlib.sendFileData(
    				"210.181.29.21",			                        // 서버 아이피
    				20189,						                        // 서버 포트
    				5000,						                        // 연결, 송수신 타임아웃
    				"D:\\java\\batch\\Van_Data\\EDI_SNDAREA\\" +paramStrCd+"_"+paramReqDt+".req",		// 경로를 포함한 보낼 파일명(*운영기*)
    				//"C:\\POSsever\\FTPROOT\\Van_Data\\EDI_SNDAREA\\" +paramStrCd+"_"+strToday+".req",		// 경로를 포함한 보낼 파일명(*개발기*)
    				//"C:\\POSsever\\FTPROOT\\Van_Data\\EDI_SNDAREA\\02_20110828.req",		// 경로를 포함한 보낼 파일명
    				'H',						                        // 구분 코드 (문서 참고)
    				200,						                        // 구분 코드에 따른 한 레코드 크기 (문서 참고)
    				strDeviceId,
    				//"DPT0000199",				                        // 기관 코드
    				//"TESTMER001",				                        // 기관 코드
    				1,							                // 순번
    				paramReqDts					                        // 작업 일자 (YYMMDD) 
    				);    		
/*     		
    		String lsKsnIP 			= BaseProperty.get("ksnet.ip");								//IP
    		int liKsnPort 			= Integer.parseInt(BaseProperty.get("ksnet.port"));			//포트번호
    		String lsKsnetSdnDir 	= BaseProperty.get("ksnet.snd.dir");						//디렉토리
    		String lsKsnetOrgcd 	= BaseProperty.get("ksnet.orgcd");							//기관코드
    		int lsKsnetSeq 			= Integer.parseInt(BaseProperty.get("ksnet.seq"));			//순번
   		
    		logger.debug("lsKsnIP : " + lsKsnIP);
    		logger.debug("liKsnPort : " + liKsnPort);
    		logger.debug("lsKsnetSdnDir : " + lsKsnetSdnDir);
    		logger.debug("lsKsnetOrgcd : " + lsKsnetOrgcd);
    		logger.debug("lsKsnetSeq : " + lsKsnetSeq);
    		logger.debug("file Name : " + lsKsnetSdnDir+paramStrCd+"_"+paramReqDt+".req");
    		
    		System.out.println("lsKsnIP : " + lsKsnIP);
    		System.out.println("liKsnPort : " + liKsnPort);
    		System.out.println("lsKsnetSdnDir : " + lsKsnetSdnDir);
    		System.out.println("lsKsnetOrgcd : " + lsKsnetOrgcd);
    		System.out.println("lsKsnetSeq : " + lsKsnetSeq);
    		
    		System.out.println("file Name : " + lsKsnetSdnDir+paramStrCd+"_"+paramReqDt+".req");
    		
    		int sendResult = ksnetlib.sendFileData(
    				lsKsnIP,			                        // 서버 아이피
    				liKsnPort,						                        // 서버 포트
    				5000,						                        // 연결, 송수신 타임아웃
    				lsKsnetSdnDir+paramStrCd+"_"+paramReqDt+".req",		// 경로를 포함한 보낼 파일명(*운영기*)
    				//"C:\\POSsever\\FTPROOT\\Van_Data\\EDI_SNDAREA\\" +paramStrCd+"_"+strToday+".req",		// 경로를 포함한 보낼 파일명(*개발기*)
    				//"C:\\POSsever\\FTPROOT\\Van_Data\\EDI_SNDAREA\\02_20110828.req",		// 경로를 포함한 보낼 파일명
    				'H',						                        // 구분 코드 (문서 참고)
    				200,						                        // 구분 코드에 따른 한 레코드 크기 (문서 참고)
    				lsKsnetOrgcd,				                        // 기관 코드
    				//"TESTMER001",				                        // 기관 코드
    				lsKsnetSeq,							                // 순번
    				paramReqDts					                        // 작업 일자 (YYMMDD) 
    				);
*/
    		String sendMessage = ksnetlib.getErrorMessage(sendResult);
    		
    		if (sendResult != 0) {    		
    			System.out.println("Psal930:sendResult : " + sendResult);
    			System.out.println("Psal930:sendMessage : " + sendMessage);
			    throw new Exception("[USER]"+sendMessage);			
			}else{
				procCnt = sendResult;
				//전송완료시 EDI_SEND_DATE = SYSDATE  -> UPDATE
				int i = 1;
				sql.close();
				sql.put(svc.getQuery("UPD_BUYREQH"));
                
				sql.setString(i++, paramReqDt); 
				sql.setString(i++, strChrgSeq); 
				update(sql);
			}			
			
		} catch (Exception e) {
            rollback();
            throw e;
        } 
		finally {
			end();
		}
		
        return procCnt;
	}
	
	/**
	 * 
	 * @param dList
	 */
	public int callEDIService(List<List<String>> dList, Map<String,String> hmap) {
		String dColumns[] = { 
				 "CHRG_DT"
				,"CHRG_SEQ"
				,"SEQ_NO"
				,"REC_FLAG"
				,"DEVICE_ID"
				,"WORK_FLAG"
				,"COMP_NO"
				,"CARD_NO"
				,"EXP_DT"
				,"DIV_MONTH"
				,"APPR_AMT"
				,"SVC_AMT"
				,"APPR_NO"
				,"APPR_DT"
				,"APPR_TIME"
				,"CAN_DT"
				,"CAN_TIME"
				,"CCOMP_CD"
				,"BCOMP_CD"
				,"JBRCH_ID"
				,"DOLLAR_FLAG"
				,"FILLER"
				,"REG_DATE"
				,"REG_ID"
		};
		
//		String hColumns[] = { 
//				  "CHRG_DT"      
//				, "CHRG_SEQ"     
//				, "REC_FLAG"     
//				, "REC_CNT"      
//				, "SUM_AMT"      
//				, "FILLER"       
//				, "EDI_SEND_DATE"
//				, "REG_DATE"     
//				, "REG_ID"    
//		};
		
		int result = 0;
		try {
			Psal930EDI esvc = new Psal930EDI();
			result = esvc.FTService(dColumns, dList, hmap);
		}
		catch (Exception e) {
			
		}
		return result;
	}
	
public int sendData_first(ActionForm form, HttpServletRequest request) throws Exception {
		
		String paramStrCd 	= String2.nvl(form.getParam("paramStrCd"));
		String paramReqDt 	= String2.nvl(form.getParam("paramReqDt"));
		String strToday 	= String2.nvl(form.getParam("strToday"));
		String strChrgSeq 	= String2.nvl(form.getParam("strChrgSeq"));
		String paramReqDts  = strToday.substring(2,8);
		String strQuery = "";
		String strDeviceId = "";

		ProcedureWrapper psql = new ProcedureWrapper();
		SqlWrapper sql = new SqlWrapper();
		Service svc = (Service) form.getService();
		//
		List list = null;
		int procCnt = 0;
		//String procMsg = "";
		//int io = 1;
		System.out.println("sendData_first 시작");
		try {
			connect("pot");
			begin();
			
			System.out.println("파일:"+paramStrCd+"_"+paramReqDt+".req");
			System.out.println("디렉토리:"+"D:\\java\\batch\\Van_Data\\EDI_SNDAREA\\");
			
			// 청구시 단말기id 조회 
			sql.put(svc.getQuery("SEL_DEVICEID"));
			sql.setString(1, paramStrCd);
			System.out.println("paramStrCd : "+ paramStrCd);
			
			Map mapDeviceId = (Map)selectMap(sql);
			System.out.println("sql : "+ sql);
			strDeviceId = mapDeviceId.get("DEVICE_ID").toString();
			System.out.println("strDeviceId : "+ strDeviceId);
			if (strDeviceId.equals("") || strDeviceId==null ){
				throw new Exception("[USER-단말기ID오류]"+"해당점에 KSNET 단말기ID가 정의되지 않았습니다.");
			}
	
			// 모듈 클래스 생성
    		KSNetLib ksnetlib = new KSNetLib();
    		// 파일 데이터 송신
    		
    		int sendResult = ksnetlib.sendFileData(
    				//"177.200.3.79",			                        // 테스트 서버 아이피
    				"177.200.3.71",			                        // 실서버 아이피
    				20190,						                        // 서버 포트
    				5000,						                        // 연결, 송수신 타임아웃
    				"D:\\java\\batch\\Van_Data\\EDI_SNDAREA\\" +paramStrCd+"_"+paramReqDt+".req",		// 경로를 포함한 보낼 파일명(*운영기*)
    				'F',						                        // 구분 코드 (문서 참고)
    				200,						                        // 구분 코드에 따른 한 레코드 크기 (문서 참고)
    				strDeviceId,
    				//"DPT0000199",				                        // 기관 코드 
    				//"TESTMER001",				                        // 기관 코드 
    				1,							                // 순번
    				paramReqDts					                        // 작업 일자 (YYMMDD) 
    				);    		

    		String sendMessage = ksnetlib.getErrorMessage(sendResult);
    		
    		if (sendResult != 0) {    		
    			System.out.println("Psal930:send_fd_Result : " + sendResult);
    			System.out.println("Psal930:send_fd_Message : " + sendMessage);
			    throw new Exception("[USER]"+sendMessage);			
			}else{
				procCnt = sendResult;
			}			
			
		} catch (Exception e) {
            rollback();
            throw e;
        } 
		finally {
			end();
		}
		
        return procCnt;
	}
}
