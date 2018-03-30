package epro.dao;

import java.util.List;
import java.util.Map;



import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import ecom.util.*;

public class EPro104DAO extends AbstractDAO2 {
	public StringBuffer getList(ActionForm form)throws Exception {
		String sb2 = null;
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service  svc = null;
		int i = 0;
		List returnList = null;
		Util util = new Util();
	    AjaxUtil Ajax = new AjaxUtil();
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb2 = new String();
			sb = new StringBuffer();
			
			String strStrcd = String2.nvl(form.getParam("strcd"));
			String strVencd = String2.nvl(form.getParam("strVencd"));
			String strPumbuncd = String2.nvl(form.getParam("strPumbuncd"));
			String strSchFlag = String2.nvl(form.getParam("strSchFlag"));
			String sDate = String2.nvl(form.getParam("sDate"));
			String eDate = String2.nvl(form.getParam("eDate"));
			String strCustNm = String2.nvl(form.getParam("strCustNm"));
			String strPromTy = String2.nvl(form.getParam("strPromTy")); 
			
			
			connect("pot");
			
			if (strSchFlag.equals("01")) {			//접수일자
            	sql.put(svc.getQuery("SEL_TAKE_DT"));
            } else if (strSchFlag.equals("02")) {	//입고예정일
            	sql.put(svc.getQuery("SEL_IN_DELI_DT"));
            } else {								//약속일자
            	sql.put(svc.getQuery("SEL_FRST_PROM_DT"));
            }
			
			sql.setString(++i, strPumbuncd);              
            sql.setString(++i, strVencd);
            sql.setString(++i, strPromTy);        
            sql.setString(++i, strCustNm);   
            sql.setString(++i, strStrcd);
            sql.setString(++i, sDate);   
            sql.setString(++i, eDate);
            
            
            returnList = executeQuery(sql);
            
            returnList = util.decryptedStrByMap(returnList, "PHONE1");
            returnList = util.decryptedStrByMap(returnList, "PHONE2");
            returnList = util.decryptedStrByMap(returnList, "PHONE3");
            
            sb.append(Ajax.list2AjaxXml(returnList));
            
			
		}catch(Exception e){
			throw e;
		}
		
		
		
		return sb;
	}
	
	
	public StringBuffer getMaster(ActionForm form)throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service  svc = null;
		int i = 0;
		
	    
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sb = new StringBuffer();
			
			String strStrcd = String2.nvl(form.getParam("strStrcd"));      //점코드
			String strTakeDt = String2.nvl(form.getParam("strTakeDt"));	   //접수일자
			String strTakeSeq = String2.nvl(form.getParam("strTakeSeq"));   //접수순번
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_CALLMRG"));
			
			sql.setString(++i, strTakeSeq);              
            sql.setString(++i, strStrcd);
            sql.setString(++i, strTakeDt);        
            
            
            sb = executeQueryByAjax(sql);
            
            
            
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
	public StringBuffer getMasterContent(ActionForm form)throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service  svc = null;
		int i = 0;
		
	    
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			
			String strCallDt = String2.nvl(form.getParam("strCallDt"));      //통화일자
			String strSeqno = String2.nvl(form.getParam("strSeqno"));	   //통화순번
			
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_CALLMRGCAll"));
			
			sql.setString(++i, strCallDt);              
            sql.setString(++i, strSeqno);
            
            sb = executeQueryByAjax(sql);
            
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
	public StringBuffer delete(ActionForm form)throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service  svc = null;
		int i = 0;
		int ret = 0;
		
	    
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			
			String strCallDt = String2.nvl(form.getParam("strCallDt"));      //통화일자
			String strSeqno = String2.nvl(form.getParam("strSeqno"));	   //통화순번
			
			
			connect("pot");
			begin();

			sql.put(svc.getQuery("DEL_CALLMRG")); //삭제
			sql.setString(1, strSeqno);			
			sql.setString(2, strCallDt);
			
			ret = executeUpdate(sql);
			
			
			if( ret > 0 ){
				sb.append("<?xml version='1.0' encoding='utf-8'?>");
				sb.append("<t>");
				sb.append("<r id='1'>");
				sb.append("<c id='RET'>").append(ret);
				sb.append("</c>");
				sb.append("</r>");
				sb.append("</t>");
			}else {
				sb.append("<?xml version='1.0' encoding='utf-8'?>");
				sb.append("<t>");
				sb.append("<r id='1'>");
				sb.append("<c id='RET'>").append("데이터의 적합성 문제로 인하여 \n데이터 입력을 하지 못했습니다.");
				sb.append("</c>");
				sb.append("</r>");
				sb.append("</t>");
			}
			
		}catch(Exception e){
			rollback();
			throw e;
		} finally {
			end();
		}
		
		return sb;

	}
	
	
	public StringBuffer insert(ActionForm form, String userid)throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service  svc = null;
		int i = 0;
		int ret = 0;
		String SlipNO = "";
		
	    
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			
			String strStrcd = String2.nvl(form.getParam("g_master_strcd"));      	  //점코드
			String strTakeDt = String2.nvl(form.getParam("g_master_strTakeDt"));      //접수일자
			String strTakeSeq = String2.nvl(form.getParam("g_master_strTakeSeq"));    //접수순번
			String strCallDt = String2.nvl(form.getParam("in_callDt"));      		  //전화통화일자
			String strCallHH = String2.nvl(form.getParam("in_call_hh"));              //통화일자 시간
			String strCallMM = String2.nvl(form.getParam("in_call_mm"));              //통화일자 분
			String strSendNM = String2.nvl(form.getParam("in_sendNm"));               //발신자
			String strRecvNM = String2.nvl(form.getParam("in_recvNm"));               //수신자
			String strCall_Flag = String2.nvl(form.getParam("in_callFlag"));          //통화구분
			String strCallDesc = String2.nvl(form.getParam("in_callDesc"));           //통화내역
			String strCallTime = strCallHH + strCallMM;								//통화일자 시간 분
			
			connect("pot");
			begin();
			
			
			sql.put(svc.getQuery("SEL_SEQNO"));
			Map mapSilpNO = (Map) executeQueryByMap(sql);
			SlipNO = mapSilpNO.get("SEQ_NO").toString();
			sql.close();

			 sql.put(svc.getQuery("INT_CALLMRG"));                    
             
             sql.setString(++i, SlipNO);
             sql.setString(++i, strCallDt);
             sql.setString(++i, strTakeDt);
             sql.setString(++i, strStrcd);
             sql.setString(++i, strTakeSeq);
             sql.setString(++i, strCallTime);
             sql.setString(++i, strSendNM);
             sql.setString(++i, strRecvNM); 
             sql.setString(++i, strCall_Flag);
             sql.setString(++i, strCallDesc);
             sql.setString(++i, userid);
             
			 ret = executeUpdate(sql);
			 sql.close();
			
			if( ret > 0 ){
				sb.append("<?xml version='1.0' encoding='utf-8'?>");
				sb.append("<t>");
				sb.append("<r id='1'>");
				sb.append("<c id='RET'>").append(ret);
				sb.append("</c>");
				sb.append("</r>");
				sb.append("</t>");
			}else {
				sb.append("<?xml version='1.0' encoding='utf-8'?>");
				sb.append("<t>");
				sb.append("<r id='1'>");
				sb.append("<c id='RET'>").append("데이터의 적합성 문제로 인하여 \n데이터 입력을 하지 못했습니다.");
				sb.append("</c>");
				sb.append("</r>");
				sb.append("</t>");
			}
			
		}catch(Exception e){
			rollback();
			throw e;
		} finally {
			end();
		}
		
		return sb;

	}
	
	
	
public StringBuffer Modify(ActionForm form, String userid)throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service  svc = null;
		int i = 0;
		int ret = 0;
		String SlipNO = "";
		
	    
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			
			String strSeqNo = String2.nvl(form.getParam("mo_seqNo"));      	      //통화순번
			String strCallDt = String2.nvl(form.getParam("mo_callDt"));           //통화일자
			String strCallHH = String2.nvl(form.getParam("mo_call_hh"));         //통화시간 
			String strCallMM = String2.nvl(form.getParam("mo_call_mm"));          //통화 분
			String strSendNM = String2.nvl(form.getParam("mo_sendNm"));           //수신자
			String strRecvNM = String2.nvl(form.getParam("mo_recvNm"));           //발신자
			String strCallFlag = String2.nvl(form.getParam("mo_callFlag"));         //통화구분
			String strCallDesc = String2.nvl(form.getParam("mo_callDesc"));         //통화내역
			
			
			connect("pot");
			begin();

			sql.put(svc.getQuery("UPD_CALLMRG"));
        	
        	sql.setString(1, strSendNM);
        	sql.setString(2, strRecvNM);
        	sql.setString(3, strCallFlag);
        	sql.setString(4, strCallDesc);
        	sql.setString(5, userid);
        	sql.setString(6, strSeqNo);
        	sql.setString(7, strCallDt);
             
			ret = executeUpdate(sql);
			sql.close();
			
			if( ret > 0 ){
				sb.append("<?xml version='1.0' encoding='utf-8'?>");
				sb.append("<t>");
				sb.append("<r id='1'>");
				sb.append("<c id='RET'>").append(ret);
				sb.append("</c>");
				sb.append("</r>");
				sb.append("</t>");
			}else {
				sb.append("<?xml version='1.0' encoding='utf-8'?>");
				sb.append("<t>");
				sb.append("<r id='1'>");
				sb.append("<c id='RET'>").append("데이터의 적합성 문제로 인하여 \n데이터 입력을 하지 못했습니다.");
				sb.append("</c>");
				sb.append("</r>");
				sb.append("</t>");
			}
			
		}catch(Exception e){
			rollback();
			throw e;
		} finally {
			end();
		}
		
		return sb;

	}
	
	
	
	
}
