package epro.dao;

import java.util.List;
import java.util.Map;

import ecom.util.Util;



import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import ecom.util.*;

public class EPro101DAO extends AbstractDAO2 {
	public StringBuffer getMaster(ActionForm form)throws Exception {
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service  svc = null;
		int i = 1;
	    AjaxUtil Ajax = new AjaxUtil();
		String strQuery = "";
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
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
			
			strQuery = svc.getQuery("SEL_MASTER") + "\n";
			sql.setString(i++, strStrcd);
			sql.setString(i++, strVencd);
			sql.setString(i++, strPumbuncd);
			sql.setString(i++, strCustNm);
			sql.setString(i++, strPromTy);
			if (strSchFlag.equals("01")) {			//접수일자
            	strQuery += svc.getQuery("ADD_TAKE_DT") + "\n";
            } else if (strSchFlag.equals("02")) {	//입고예정일
            	strQuery += svc.getQuery("ADD_IN_DELI_DT") + "\n";
            } else {								//약속일자
            	strQuery += svc.getQuery("ADD_PROM_DT") + "\n";
            }
			sql.setString(i++, sDate);
			sql.setString(i++, eDate);
            sql.put(strQuery);
            sb = executeQueryByAjax(sql);
		}catch(Exception e){
			throw e;
		}
		return sb;
	}

	
	public StringBuffer getDetail(ActionForm form)throws Exception {
		StringBuffer sb = null;
		List returnList = null;
		Util util = new Util();
		AjaxUtil Ajax = new AjaxUtil();
		SqlWrapper sql = null;
		Service  svc = null;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			String strStrcd = String2.nvl(form.getParam("strStrcd"));
			String strTakeDt = String2.nvl(form.getParam("strTakeDt")); 
			String strTakeSeq = String2.nvl(form.getParam("strTakeSeq"));
			
			
			connect("pot");
			sql.put(svc.getQuery("SEL_DETAIL"));
			
			sql.setString(++i, strStrcd);              
            sql.setString(++i, strTakeDt);
            sql.setString(++i, strTakeSeq);        
            
            returnList = executeQuery(sql);
            returnList = util.decryptedStrByMap(returnList, "MOBILE_PH1");
            returnList = util.decryptedStrByMap(returnList, "MOBILE_PH2");
            returnList = util.decryptedStrByMap(returnList, "MOBILE_PH3");
            returnList = util.decryptedStrByMap(returnList, "HOME_PH1");
            returnList = util.decryptedStrByMap(returnList, "HOME_PH2");
            returnList = util.decryptedStrByMap(returnList, "HOME_PH3");
            returnList = util.decryptedStrByMap(returnList, "COUR_MOBILE_PH1");
            returnList = util.decryptedStrByMap(returnList, "COUR_MOBILE_PH2");
            returnList = util.decryptedStrByMap(returnList, "COUR_MOBILE_PH3");
            returnList = util.decryptedStrByMap(returnList, "COUR_HOME_PH1");
            returnList = util.decryptedStrByMap(returnList, "COUR_HOME_PH2");
            returnList = util.decryptedStrByMap(returnList, "COUR_HOME_PH3");
            sb.append(Ajax.list2AjaxXml(returnList));
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	

	public StringBuffer save(ActionForm form, String userid) throws Exception {
		
		StringBuffer sb = null;
		int ret 	= 0;
		int res 	= 0;
		
		try{
			String strTakeSeq = String2.nvl(form.getParam("strTakeSeq"));
			sb = new StringBuffer();
			
			if(strTakeSeq.equals("")){			// 약속내용 등록
				ret = insert(form, userid);
			} else {							// 약속내용 수정
				res = update(form, userid);
			}
			
			if( ret > 0 || res > 0 ){	
				sb.append("<?xml version='1.0' encoding='utf-8'?>");
				sb.append("<t>");
				sb.append("<r id='1'>");
				sb.append("<c id='RET'>").append((ret+res));
				sb.append("</c>");
				sb.append("</r>");
				sb.append("</t>");
			}else {
				rollback();
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
	
	
	public int insert(ActionForm form, String userid)throws Exception {
		SqlWrapper sql = null;
		Service  svc = null;
		int i = 0;
		int ret = 0;
		Util util = new Util();
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			connect("pot");
			begin();
			sql.put(svc.getQuery("INS_PROMISECERT"));                    
	        sql.setString(++i, String2.nvl(form.getParam("strTakeDt").replaceAll("/","")));
	        sql.setString(++i, String2.nvl(form.getParam("strStrCd")));
	        sql.setString(++i, String2.nvl(form.getParam("strTakeUserId")));
	        sql.setString(++i, String2.nvl(form.getParam("strCustNm")));
	        sql.setString(++i, String2.nvl(form.getParam("strPostNo")).replaceAll("-", ""));
	        sql.setString(++i, String2.nvl(form.getParam("strAddr")));
	        sql.setString(++i, String2.nvl(form.getParam("strDtaAddr")));
	        sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strMobileNo1"))));
	        sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strMobileNo2"))));
	        sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strMobileNo3"))));
	        sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strHomeNo1"))));
	        sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strHomeNo2"))));
	        sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strHomeNo3")))); 
	        sql.setString(++i, String2.nvl(form.getParam("strFrstPromDt").replaceAll("/","")));
	        sql.setString(++i, String2.nvl(form.getParam("strFrstPromTime")));
	        sql.setString(++i, String2.nvl(form.getParam("strFrstPromDt").replaceAll("/",""))); //최초 등록시 : 최초약속일
	        sql.setString(++i, String2.nvl(form.getParam("strFrstPromTime")));					//최초 등록시 : 최초약속시간
	        sql.setString(++i, String2.nvl(form.getParam("strPromType")));
	        sql.setString(++i, String2.nvl(form.getParam("strPromDtl")));
	        sql.setString(++i, String2.nvl(form.getParam("strDeliType")));
	        sql.setString(++i, String2.nvl(form.getParam("strDeliStr")));
	        sql.setString(++i, String2.nvl(form.getParam("strPumbunCd")));
	        sql.setString(++i, String2.nvl(form.getParam("strSkuNm")));
	        sql.setString(++i, String2.nvl(form.getParam("strInDeliDt").replaceAll("/","")));
	        sql.setString(++i, String2.nvl(form.getParam("strSmsYn")));
	        sql.setString(++i, String2.nvl(form.getParam("strCourCustNm")));
	        sql.setString(++i, String2.nvl(form.getParam("strCourPostNo")).replaceAll("-", "")); 
	        sql.setString(++i, String2.nvl(form.getParam("strCourAddr")));
	        sql.setString(++i, String2.nvl(form.getParam("strCourDtaAddr")));
	        sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strCourMobileNo1"))));
	        sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strCourMobileNo2"))));
	        sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strCourMobileNo3"))));
	        sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strCourHomeNo1"))));
	        sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strCourHomeNo2"))));
	        sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strCourHomeNo3"))));
	        sql.setString(++i, String2.nvl(form.getParam("strCourCompNm")));
	        sql.setString(++i, String2.nvl(form.getParam("strCourSendNo")));
	        sql.setString(++i, String2.nvl(form.getParam("strProcStat")));
	        sql.setString(++i, userid);
	        sql.setString(++i, userid);
			 ret = executeUpdate(sql);
		}catch(Exception e){
			rollback();
			throw e;
		} finally {
			end();
		}
		
		return ret;

	}
	
	
	
	public int update(ActionForm form, String userid)throws Exception {
			SqlWrapper sql = null;
			Service  svc = null;
			int i = 0;
			int ret = 0;
			Util util = new Util();
			try{
				sql = new SqlWrapper();
				svc = (Service) form.getService();
				connect("pot");
				begin();
	
				sql.put(svc.getQuery("UPD_PROMISECERT"));
	 
	 			sql.setString(++i, String2.nvl(form.getParam("strCustNm")));
	            sql.setString(++i, String2.nvl(form.getParam("strPostNo").replaceAll("-", "")));         
	            sql.setString(++i, String2.nvl(form.getParam("strAddr")));         
	            sql.setString(++i, String2.nvl(form.getParam("strDtaAddr")));      
	            sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strMobileNo1"))));   
	            sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strMobileNo2"))));                                   
	            sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strMobileNo3"))));                                   
	            sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strHomeNo1"))));                                     
	            sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strHomeNo2"))));                      
	            sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strHomeNo3"))));                                                
	            sql.setString(++i, String2.nvl(form.getParam("strFrstPromDt").replaceAll("/","")));                                                                    
	            sql.setString(++i, String2.nvl(form.getParam("strFrstPromTime")));                                                                                                       
	            sql.setString(++i, String2.nvl(form.getParam("strPromType")));                                                                                 
	            sql.setString(++i, String2.nvl(form.getParam("strPromDtl")));                                                                                            
	            sql.setString(++i, String2.nvl(form.getParam("strDeliType")));                                                                                           
	            sql.setString(++i, String2.nvl(form.getParam("strDeliStr")));                                                                                            
	            sql.setString(++i, String2.nvl(form.getParam("strPumbunCd")));                                                                                           
	            sql.setString(++i, String2.nvl(form.getParam("strSkuNm")));                                                                                              
	            sql.setString(++i, String2.nvl(form.getParam("strInDeliDt").replaceAll("/","")));                                                      
	            sql.setString(++i, String2.nvl(form.getParam("strSmsYn")));                                                                    
	            sql.setString(++i, String2.nvl(form.getParam("strCourCustNm")));                                                             
	            sql.setString(++i, String2.nvl(form.getParam("strCourPostNo").replaceAll("-", "")));                                                             
	            sql.setString(++i, String2.nvl(form.getParam("strCourAddr")));                                                               
	            sql.setString(++i, String2.nvl(form.getParam("strCourDtaAddr")));                                                                               
	            sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strCourMobileNo1"))));                                                           
	            sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strCourMobileNo2"))));                                                           
	            sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strCourMobileNo3"))));                                                           
	            sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strCourHomeNo1"))));                                                             
	            sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strCourHomeNo2"))));                                                             
	            sql.setString(++i, util.encryptedStr(String2.nvl(form.getParam("strCourHomeNo3"))));                                                             
	            sql.setString(++i, String2.nvl(form.getParam("strCourCompNm")));                                                                                 
	            sql.setString(++i, String2.nvl(form.getParam("strCourSendNo")));                                                                                 
	            sql.setString(++i, String2.nvl(form.getParam("strProcStat")));                                                                                   
	            sql.setString(++i, userid);                                                                                                                      
	            sql.setString(++i, String2.nvl(form.getParam("strTakeDt").replaceAll("/","")));                                                   
	            sql.setString(++i, String2.nvl(form.getParam("strStrCd")));                                                                             
	            sql.setString(++i, String2.nvl(form.getParam("strTakeSeq")));                                                                             
				ret = executeUpdate(sql);                                                                 
				sql.close();                                                                              
			}catch(Exception e){                                                      
				rollback();                                                                                  
				throw e;                                                                                     
			} finally {                                                               
				end();                                                                                    
			}                                                                                                      
			return ret;
		}   


	public StringBuffer getPromise(ActionForm form)throws Exception {
		StringBuffer sb = null;
		AjaxUtil Ajax = new AjaxUtil();
		SqlWrapper sql = null;
		Service  svc = null;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			connect("pot");
			sql.put(svc.getQuery("SEL_PROMISEHIS"));
			
			sql.setString(++i, String2.nvl(form.getParam("strTakeDt")));
			sql.setString(++i, String2.nvl(form.getParam("strStrCd")));              
	        sql.setString(++i, String2.nvl(form.getParam("strTakeSeq")));        
            sb = executeQueryByAjax(sql);
		}catch(Exception e){
			throw e;
		}
		return sb;
	}
	
	public StringBuffer getHistory(ActionForm form)throws Exception {
		StringBuffer sb = null;
		AjaxUtil Ajax = new AjaxUtil();
		SqlWrapper sql = null;
		Service  svc = null;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			connect("pot");
			sql.put(svc.getQuery("SEL_HIS_MASTER"));
			
			sql.setString(++i, String2.nvl(form.getParam("strTakeDt")));
	        sql.setString(++i, String2.nvl(form.getParam("strTakeSeq")));        
	        sql.setString(++i, String2.nvl(form.getParam("strStrcd")));            
            sb = executeQueryByAjax(sql);
		}catch(Exception e){
			throw e;
		}
		return sb;
	}
	
	public StringBuffer saveHistory(ActionForm form, String userid) throws Exception {
		
		StringBuffer sb = null;
		int ret 	= 0;
		int res 	= 0;
		
		try{
			sb = new StringBuffer();
			
			ret = insertHistory(form, userid);
			
			if( ret > 0 || res > 0 ){	
				sb.append("<?xml version='1.0' encoding='utf-8'?>");
				sb.append("<t>");
				sb.append("<r id='1'>");
				sb.append("<c id='RET'>").append((ret+res));
				sb.append("</c>");
				sb.append("</r>");
				sb.append("</t>");
			}else {
				rollback();
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
	
	public int insertHistory(ActionForm form, String userid)throws Exception {
		SqlWrapper sql = null;
		Service  svc = null;
		int i = 1;
		int ret = 0;
		Util util = new Util();
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			connect("pot");
			begin();
			for(int j=0;j<5;j++){
				if(!form.getParam("strChgPromDt").equals("") 
						&& !form.getParam("strChgPromHH").equals("") 
						&& !form.getParam("strChgPromMM").equals("") && j == 0){ // 약속일
					sql.close();
					i = 1;
					sql.put(svc.getQuery("INS_PROMISEHIS01")); 
					sql.setString(i++, form.getParam("strTakeDt"));
					sql.setString(i++, form.getParam("strStrCd"));
					sql.setString(i++, form.getParam("strTakeSeq"));
					sql.setString(i++, "01");
					sql.setString(i++, form.getParam("strChgReason01"));
					sql.setString(i++, form.getParam("strChgReasonDtl01"));
					sql.setString(i++, form.getParam("strTakeDt01").replaceAll("/", ""));
					sql.setString(i++, form.getParam("strLastPromDt").replaceAll("/", ""));
					sql.setString(i++, form.getParam("strChgPromDt").replaceAll("/", ""));
					sql.setString(i++, form.getParam("strLastPRomTime").replaceAll(":", ""));
					sql.setString(i++, form.getParam("strChgPromHH")+form.getParam("strChgPromMM"));
					sql.setString(i++, userid);
					ret = executeUpdate(sql);   
					
					sql.close();
					i = 1;
					sql.put(svc.getQuery("UPD_PROMISECERT_HEAD")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_01")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_TAIL")); 
					sql.setString(i++, form.getParam("strChgPromDt").replaceAll("/", ""));
					sql.setString(i++, form.getParam("strChgPromHH")+form.getParam("strChgPromMM"));
					sql.setString(i++, userid);
					sql.setString(i++, form.getParam("strTakeDt"));
					sql.setString(i++, form.getParam("strStrCd"));
					sql.setString(i++, form.getParam("strTakeSeq"));
					ret = executeUpdate(sql);   
					
				}else if(!form.getParam("strChgInDt").equals("") && j == 1){ // 입고예정일
					sql.close();
					i = 1;
					sql.put(svc.getQuery("INS_PROMISEHIS02")); 
					sql.setString(i++, form.getParam("strTakeDt"));
					sql.setString(i++, form.getParam("strStrCd"));
					sql.setString(i++, form.getParam("strTakeSeq"));
					sql.setString(i++, "02");
					sql.setString(i++, form.getParam("strChgReason02"));
					sql.setString(i++, form.getParam("strChgReasonDtl02"));
					sql.setString(i++, form.getParam("strTakeDt02").replaceAll("/", ""));
					sql.setString(i++, form.getParam("strInDeliDt").replaceAll("/", ""));
					sql.setString(i++, form.getParam("strChgInDt").replaceAll("/", ""));
					sql.setString(i++, userid);
					ret = executeUpdate(sql);   
					
					sql.close();
					i = 1;
					sql.put(svc.getQuery("UPD_PROMISECERT_HEAD")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_02")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_TAIL")); 
					sql.setString(i++, form.getParam("strChgInDt").replaceAll("/", ""));
					sql.setString(i++, userid);
					sql.setString(i++, form.getParam("strTakeDt"));
					sql.setString(i++, form.getParam("strStrCd"));
					sql.setString(i++, form.getParam("strTakeSeq"));
					ret = executeUpdate(sql);   
				}else if(!form.getParam("strChgDeliStr").equals("") && j == 2){ // 인도점
					sql.close();
					i = 1;
					sql.put(svc.getQuery("INS_PROMISEHIS03")); 
					sql.setString(i++, form.getParam("strTakeDt"));
					sql.setString(i++, form.getParam("strStrCd"));
					sql.setString(i++, form.getParam("strTakeSeq"));
					sql.setString(i++, "03");
					sql.setString(i++, form.getParam("strChgReason03"));
					sql.setString(i++, form.getParam("strChgReasonDtl03"));
					sql.setString(i++, form.getParam("strTakeDt03").replaceAll("/", ""));
					sql.setString(i++, form.getParam("strDeliStr"));
					sql.setString(i++, form.getParam("strChgDeliStr"));
					sql.setString(i++, userid);
					ret = executeUpdate(sql);   
					
					sql.close();
					i = 1;
					sql.put(svc.getQuery("UPD_PROMISECERT_HEAD")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_03")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_TAIL")); 
					sql.setString(i++, form.getParam("strChgDeliStr"));
					sql.setString(i++, userid);
					sql.setString(i++, form.getParam("strTakeDt"));
					sql.setString(i++, form.getParam("strStrCd"));
					sql.setString(i++, form.getParam("strTakeSeq"));
					String aa= sql.toString();
					ret = executeUpdate(sql);   
				}else if(!form.getParam("strChgDelType").equals("") && j == 3){ // 인도방식
					sql.close();
					i = 1;
					sql.put(svc.getQuery("INS_PROMISEHIS04")); 
					sql.setString(i++, form.getParam("strTakeDt"));
					sql.setString(i++, form.getParam("strStrCd"));
					sql.setString(i++, form.getParam("strTakeSeq"));
					sql.setString(i++, "04");
					sql.setString(i++, form.getParam("strChgReason04"));
					sql.setString(i++, form.getParam("strChgReasonDtl04"));
					sql.setString(i++, form.getParam("strTakeDt04").replaceAll("/", ""));
	
					sql.setString(i++, form.getParam("strDeliType"));
					sql.setString(i++, form.getParam("strChgDelType"));
					sql.setString(i++, userid);
					ret = executeUpdate(sql);   
					
					sql.close();
					i = 1;
					sql.put(svc.getQuery("UPD_PROMISECERT_HEAD")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_04")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_TAIL")); 
					sql.setString(i++, form.getParam("strChgDelType"));
					sql.setString(i++, userid);
					sql.setString(i++, form.getParam("strTakeDt"));
					sql.setString(i++, form.getParam("strStrCd"));
					sql.setString(i++, form.getParam("strTakeSeq"));
					ret = executeUpdate(sql);   
				}else if(form.getParam("strChkCancel").equals("T") && j == 4){ // 취소
					sql.close();
					i = 1;
					sql.put(svc.getQuery("INS_PROMISEHIS05")); 
					sql.setString(i++, form.getParam("strTakeDt"));
					sql.setString(i++, form.getParam("strStrCd"));
					sql.setString(i++, form.getParam("strTakeSeq"));
					sql.setString(i++, "05");
					sql.setString(i++, form.getParam("strChgReason05"));
					sql.setString(i++, form.getParam("strChgReasonDtl05"));
					sql.setString(i++, form.getParam("strTakeDt05").replaceAll("/", ""));
					sql.setString(i++, userid);
					ret = executeUpdate(sql);   
					
					sql.close();
					i = 1;
					sql.put(svc.getQuery("UPD_PROMISECERT_HEAD")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_05")); 
					sql.put(svc.getQuery("UPD_PROMISECERT_TAIL")); 
					sql.setString(i++, "4");
					sql.setString(i++, userid);
					sql.setString(i++, form.getParam("strTakeDt"));
					sql.setString(i++, form.getParam("strStrCd"));
					sql.setString(i++, form.getParam("strTakeSeq"));
					ret = executeUpdate(sql);   
				}
			}
		}catch(Exception e){
			rollback();
			throw e;
		} finally {
			end();
		}
		
		return ret;
	}
}
