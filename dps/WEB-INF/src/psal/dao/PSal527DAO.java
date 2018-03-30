/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.util.Util;
import common.vo.SessionInfo;

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
 * <p>단품엑셀업로드</p>
 * 
 * @created  on 1.0, 2010/03/29
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal527DAO extends AbstractDAO {

	/**
	 * 규격단품 데이터를 검증한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List deleteData(ActionForm form, MultiInput mi) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		
		
		String strStrCd=String2.nvl(form.getParam("strStrCd"));
		String strStrDt=String2.nvl(form.getParam("strStrDt"));
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		int check=0;
		while (mi.next()) {
			
			sql.close();
		i = 0;
		
		sql.put(svc.getQuery("UPD_DELETE"));;  
	       
		sql.setString(i++, strStrCd); 
		sql.setString(i++, strStrDt); 
		sql.setString(i++, String2.trimToEmpty(mi.getString("ORDERER_NM")));    
		sql.setString(i++, String2.trimToEmpty(mi.getString("PUMBUN_CD")));    
		sql.setString(i++, String2.trimToEmpty(mi.getString("PUMBUN_NAME")));
		sql.setString(i++, String2.trimToEmpty(mi.getString("PUMBUN_NAME")));
		sql.setString(i++, String2.trimToEmpty(mi.getString("ORDER_SEQ")));
		
		
		}
		ret = select2List(sql);
		
		return ret;
	}
	/**
	 * 조직마스터를  조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchOrgMst(ActionForm form, String OrgFlag) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		try{
			
			  
			  String strOrdererNm  =         URLDecoder.decode(String2.nvl(form.getParam("strOrdererNm")), "UTF-8");    
			  String strOrderNo    =         URLDecoder.decode(String2.nvl(form.getParam("strOrderNo")), "UTF-8"); 
			  String strPumbunNm   =         URLDecoder.decode(String2.nvl(form.getParam("strPumbunNm")), "UTF-8"); 
			  String strReleaseDt  =         URLDecoder.decode(String2.nvl(form.getParam("strReleaseDt")), "UTF-8"); 
			  String strOrderSeq   =         URLDecoder.decode(String2.nvl(form.getParam("strOrderSeq")), "UTF-8");     
			  String strStrCd      =         String2.nvl(form.getParam("strStrCd"));
			  String strPumbunCd   =         URLDecoder.decode(String2.nvl(form.getParam("strPumbunCd")), "UTF-8");
			  			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
	
		
		i = 0;
		
		connect("pot");
		sql.put(svc.getQuery("SEL_STN_SKU"));
		
		sql.setString(++i, strOrdererNm);
		sql.setString(++i, strPumbunNm);
		sql.setString(++i, strOrderNo);
		sql.setString(++i, strOrderNo);
		/*
		sql.setString(++i, strStrCd);
		sql.setString(++i, strReleaseDt);
		sql.setString(++i, strOrdererNm);
		sql.setString(++i, strOrderNo);
		sql.setString(++i, strPumbunCd);
		*/
		
		}catch(Exception e){
			e.printStackTrace();
		}
		//sql.close();
		ret = select2List(sql);
		
		return ret;
	}

	
	/**
	 *  <p>
	 *  규격단품마스터정보를 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveStnSkumst(ActionForm form, MultiInput mi, String strID) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		Util utilMaster = null;
		
		String strStrCd=String2.nvl(form.getParam("strStrCd"));
		String strStrDt=String2.nvl(form.getParam("strStrDt"));
		int i;
		try {
			connect("pot");
			begin();
			String newSkuCd = "";
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			
			String dualTable = "";		
			Map rtnMap = null;
			i = 0;
			while (mi.next()) {
				sql.close();
				if ( mi.IS_INSERT()) {
					/*if(!mi.getString("SEL").equals("T")){
						continue; 
					}*/
					sql = new SqlWrapper();
					
					//핸드폰 번호 나누기
					//mi.getString("RECIEVER_HP");
					utilMaster = new Util();
					String ponNumber=mi.getString("RECIEVER_HP");
					String ponNo1="";
					String ponNo2="";
					String ponNo3="";
					//String[] test1=test.split("-");
					/*
					 // 왜 쓸때없는거는 주석 
					if(ponNumber.equals("")||ponNumber.equals(null)||ponNumber.equals("")){
						
						ponNo1="";
						ponNo2="";
						ponNo3="";
						
					}else{
					
						if(ponNumber.indexOf("-")!=-1){
							String[] ponNumber1=ponNumber.split("-");
							
							if(ponNumber.length()<=11){
								if(ponNumber1.length==3){
									String reciever_hp1=ponNumber1[0];
									String reciever_hp2=ponNumber1[1];
									String reciever_hp3=ponNumber1[2];
									 ponNo1=utilMaster.encryptedStr(reciever_hp1);
									 ponNo2=utilMaster.encryptedStr(reciever_hp2);
									 ponNo3=utilMaster.encryptedStr(reciever_hp3);
									
									
								}else {
									if(ponNumber1[1].length()<=4){
										
										String reciever_hp1=ponNumber1[0].substring(0, 3);
										String reciever_hp2=ponNumber1[0].substring(3);
										String reciever_hp3=ponNumber1[1];
										 ponNo1=utilMaster.encryptedStr(reciever_hp1);
										 ponNo2=utilMaster.encryptedStr(reciever_hp2);
										 ponNo3=utilMaster.encryptedStr(reciever_hp3);
										
									}else {
										String reciever_hp1=ponNumber1[0];
										String reciever_hp2=ponNumber1[1].substring(0,3);
										String reciever_hp3=ponNumber1[1].substring(3);
										
										 ponNo1=utilMaster.encryptedStr(reciever_hp1);
										 ponNo2=utilMaster.encryptedStr(reciever_hp2);
										 ponNo3=utilMaster.encryptedStr(reciever_hp3);
										
									}
								}
							}else {
								
								if(ponNumber1.length==3){
									String reciever_hp1=ponNumber1[0];
									String reciever_hp2=ponNumber1[1];
									String reciever_hp3=ponNumber1[2];
									
									 ponNo1=utilMaster.encryptedStr(reciever_hp1);
									 ponNo2=utilMaster.encryptedStr(reciever_hp2);
									 ponNo3=utilMaster.encryptedStr(reciever_hp3);
									
									
								}else{
									if(ponNumber1[1].length()<=4){
										String reciever_hp1=ponNumber1[0].substring(0, 3);
										String reciever_hp2=ponNumber1[0].substring(3);
										String reciever_hp3=ponNumber1[1];
										
										 ponNo1=utilMaster.encryptedStr(reciever_hp1);
										 ponNo2=utilMaster.encryptedStr(reciever_hp2);
										 ponNo3=utilMaster.encryptedStr(reciever_hp3);
										
									}else {
										String reciever_hp1=ponNumber1[0];
										String reciever_hp2=ponNumber1[1].substring(0,4);
										String reciever_hp3=ponNumber1[1].substring(4);
										
										 ponNo1=utilMaster.encryptedStr(reciever_hp1);
										 ponNo2=utilMaster.encryptedStr(reciever_hp2);
										 ponNo3=utilMaster.encryptedStr(reciever_hp3);
										
									}
								}
							}
						}else{
							//String test="0102102340";
							if(ponNumber.length()<=10){
								String reciever_hp1=ponNumber.substring(0, 3);
								String reciever_hp2=ponNumber.substring(3, 6);
								String reciever_hp3=ponNumber.substring(6);
								
								 ponNo1=utilMaster.encryptedStr(reciever_hp1);
								 ponNo2=utilMaster.encryptedStr(reciever_hp2);
								 ponNo3=utilMaster.encryptedStr(reciever_hp3);
								
							}else{
								String reciever_hp1=ponNumber.substring(0, 3);
								String reciever_hp2=ponNumber.substring(3, 7);
								String reciever_hp3=ponNumber.substring(7);
								
								 ponNo1=utilMaster.encryptedStr(reciever_hp1);
								 ponNo2=utilMaster.encryptedStr(reciever_hp2);
								 ponNo3=utilMaster.encryptedStr(reciever_hp3);
								
							}
						}
					}
					*/
					
					String fullHpNo=mi.getString("RECIEVER_HP");
					
					sql.put(svc.getQuery("SEL_SEQNO"));
					
					Map mapSeqNo = (Map)selectMap(sql);
					String strSeqNo= mapSeqNo.get("SEQ_NO").toString();
					mi.setString("SEQ_NO", strSeqNo);
					
					
					sql.close();
					i = 1;
					sql.put(svc.getQuery("INS_ONLINE"));;  
					
					sql.setString(i++, strStrDt);
					sql.setString(i++, strStrCd);  //점코드                               
					sql.setString(i++, strSeqNo);                                         
					sql.setString(i++, String2.trimToEmpty(mi.getString("BARCODE")));     
					sql.setString(i++, String2.trimToEmpty(mi.getString("RECIEVER")));    
					sql.setString(i++, String2.trimToEmpty(mi.getString("PUCHASER")));    
					sql.setString(i++, fullHpNo);                                           
					sql.setString(i++, ponNo1);                                           
					sql.setString(i++, ponNo2);                                           
					sql.setString(i++, ponNo3);                                           
					sql.setString(i++, String2.trimToEmpty(mi.getString("ORDERER_NM")));
					sql.setString(i++, String2.trimToEmpty(mi.getString("ORDERER_NM")));
					sql.setString(i++, String2.trimToEmpty(mi.getString("ORDERER_NM")));
					sql.setString(i++, String2.trimToEmpty(mi.getString("ORDER_NO")));    
					sql.setString(i++, String2.trimToEmpty(mi.getString("FLOR")));        
					sql.setString(i++, String2.trimToEmpty(mi.getString("PUMBUN_NAME"))); 
					sql.setString(i++, String2.trimToEmpty(mi.getString("PUMBUN_NAME")));
					sql.setString(i++, String2.trimToEmpty(mi.getString("ORDER_DT")));    
					sql.setString(i++, String2.trimToEmpty(mi.getString("STOCK_DT")));    
					sql.setString(i++, strStrDt);     
					//sql.setString(i++, String2.trimToEmpty(mi.getString("NORM_FLAG")));   
					sql.setString(i++, String2.trimToEmpty(mi.getString("WAYBILL")));     
					sql.setString(i++, strStrDt);
					sql.setString(i++, String2.trimToEmpty(mi.getString("CS1")));         
					sql.setString(i++, String2.trimToEmpty(mi.getString("CS2")));         
					sql.setString(i++, String2.trimToEmpty(mi.getString("BOX_NO")));      
					sql.setString(i++, String2.trimToEmpty(mi.getString("ORDER_SEQ")));  
					sql.setString(i++, String2.trimToEmpty(mi.getString("PUMBUN_CD")));   
					sql.setString(i++, String2.trimToEmpty(mi.getString("COLOR_NM")));    
					sql.setString(i++, String2.trimToEmpty(mi.getString("SIZE_NM")));     
					sql.setString(i++, String2.trimToEmpty(mi.getString("PRICE")));       
					sql.setString(i++, String2.trimToEmpty(mi.getString("QTY")));         
					sql.setString(i++, String2.trimToEmpty(mi.getString("AMT")));         
					sql.setString(i++, String2.trimToEmpty(mi.getString("PRODUCT_NM")));  
				    sql.setString(i++, String2.trimToEmpty(mi.getString("ETC")));
				    
				    sql.setString(i++, String2.trimToEmpty(mi.getString("ERR_YN")));
				   
				    
				    sql.setString(i++, String2.trimToEmpty(mi.getString("ERR_MSG")));
				    sql.setString(i++, String2.trimToEmpty(mi.getString("PROC_FLAG")));
					sql.setString(i++, strID);                                            
					sql.setString(i++, strID);                                            
                   

					i=0;
					
					}else if ( mi.IS_UPDATE()) {
					System.out.println("-----------SEL---------- : "+mi.getString("SEL"));
					if(!mi.getString("SEL").equals("T")){
						continue; 
					}
					utilMaster = new Util();
					String ponNumber=mi.getString("RECIEVER_HP");
					String ponNo1="";
					String ponNo2="";
					String ponNo3="";
					/*
					if(ponNumber.indexOf("-")!=-1){
						String[] ponNumber1=ponNumber.split("-");
						
						if(ponNumber.length()<=11){
							if(ponNumber1.length==3){
								String reciever_hp1=ponNumber1[0];
								String reciever_hp2=ponNumber1[1];
								String reciever_hp3=ponNumber1[2];
								 ponNo1=utilMaster.encryptedStr(reciever_hp1);
								 ponNo2=utilMaster.encryptedStr(reciever_hp2);
								 ponNo3=utilMaster.encryptedStr(reciever_hp3);
								
								
							}else {
								if(ponNumber1[1].length()<=4){
									
									String reciever_hp1=ponNumber1[0].substring(0, 3);
									String reciever_hp2=ponNumber1[0].substring(3);
									String reciever_hp3=ponNumber1[1];
									 ponNo1=utilMaster.encryptedStr(reciever_hp1);
									 ponNo2=utilMaster.encryptedStr(reciever_hp2);
									 ponNo3=utilMaster.encryptedStr(reciever_hp3);
									
								}else {
									String reciever_hp1=ponNumber1[0];
									String reciever_hp2=ponNumber1[1].substring(0,3);
									String reciever_hp3=ponNumber1[1].substring(3);
									
									 ponNo1=utilMaster.encryptedStr(reciever_hp1);
									 ponNo2=utilMaster.encryptedStr(reciever_hp2);
									 ponNo3=utilMaster.encryptedStr(reciever_hp3);
									
								}
							}
						}else {
							
							if(ponNumber1.length==3){
								String reciever_hp1=ponNumber1[0];
								String reciever_hp2=ponNumber1[1];
								String reciever_hp3=ponNumber1[2];
								
								 ponNo1=utilMaster.encryptedStr(reciever_hp1);
								 ponNo2=utilMaster.encryptedStr(reciever_hp2);
								 ponNo3=utilMaster.encryptedStr(reciever_hp3);
								
								
							}else{
								if(ponNumber1[1].length()<=4){
									String reciever_hp1=ponNumber1[0].substring(0, 3);
									String reciever_hp2=ponNumber1[0].substring(3);
									String reciever_hp3=ponNumber1[1];
									
									 ponNo1=utilMaster.encryptedStr(reciever_hp1);
									 ponNo2=utilMaster.encryptedStr(reciever_hp2);
									 ponNo3=utilMaster.encryptedStr(reciever_hp3);
									
								}else {
									String reciever_hp1=ponNumber1[0];
									String reciever_hp2=ponNumber1[1].substring(0,4);
									String reciever_hp3=ponNumber1[1].substring(4);
									
									 ponNo1=utilMaster.encryptedStr(reciever_hp1);
									 ponNo2=utilMaster.encryptedStr(reciever_hp2);
									 ponNo3=utilMaster.encryptedStr(reciever_hp3); 
									
									
								}
							}
						} 
						
					}else{
						
						if(ponNumber.length()<=10){
							String reciever_hp1=ponNumber.substring(0, 3);
							String reciever_hp2=ponNumber.substring(3, 6);
							String reciever_hp3=ponNumber.substring(6);
							
							 ponNo1=utilMaster.encryptedStr(reciever_hp1);
							 ponNo2=utilMaster.encryptedStr(reciever_hp2);
							 ponNo3=utilMaster.encryptedStr(reciever_hp3);
							
						}else{
							String reciever_hp1=ponNumber.substring(0, 3);
							String reciever_hp2=ponNumber.substring(3, 7);
							String reciever_hp3=ponNumber.substring(7);
							
							 ponNo1=utilMaster.encryptedStr(reciever_hp1);
							 ponNo2=utilMaster.encryptedStr(reciever_hp2);
							 ponNo3=utilMaster.encryptedStr(reciever_hp3);
							
						}
					}
					*/
					 
					String fullHpNo=mi.getString("RECIEVER_HP");
					
					
					
					
					sql.close();
					i = 1;
					sql.put(svc.getQuery("UPD_ONLINE"));;  
					       
					sql.setString(i++, String2.trimToEmpty(mi.getString("BARCODE")));     
					sql.setString(i++, String2.trimToEmpty(mi.getString("RECIEVER")));    
					sql.setString(i++, String2.trimToEmpty(mi.getString("PUCHASER")));    
					sql.setString(i++, fullHpNo);                                           
					sql.setString(i++, ponNo1);                                           
					sql.setString(i++, ponNo2);                                           
					sql.setString(i++, ponNo3);                                           
					sql.setString(i++, String2.trimToEmpty(mi.getString("ORDERER_NM")));
					sql.setString(i++, String2.trimToEmpty(mi.getString("ORDER_NO")));    
					sql.setString(i++, String2.trimToEmpty(mi.getString("FLOR")));        
					sql.setString(i++, String2.trimToEmpty(mi.getString("PUMBUN_NAME"))); 
					sql.setString(i++, String2.trimToEmpty(mi.getString("ORDER_DT")));    
					sql.setString(i++, String2.trimToEmpty(mi.getString("STOCK_DT")));    
					sql.setString(i++, strStrDt);     
					//sql.setString(i++, String2.trimToEmpty(mi.getString("NORM_FLAG")));   
					sql.setString(i++, String2.trimToEmpty(mi.getString("WAYBILL")));     
					sql.setString(i++, strStrDt);
					sql.setString(i++, String2.trimToEmpty(mi.getString("CS1")));         
					sql.setString(i++, String2.trimToEmpty(mi.getString("CS2")));         
					sql.setString(i++, String2.trimToEmpty(mi.getString("BOX_NO")));      
					sql.setString(i++, String2.trimToEmpty(mi.getString("ORDER_SEQ")));  
					sql.setString(i++, String2.trimToEmpty(mi.getString("PUMBUN_CD")));   
					sql.setString(i++, String2.trimToEmpty(mi.getString("COLOR_NM")));    
					sql.setString(i++, String2.trimToEmpty(mi.getString("SIZE_NM")));     
					sql.setString(i++, String2.trimToEmpty(mi.getString("PRICE")));       
					sql.setString(i++, String2.trimToEmpty(mi.getString("QTY")));         
					sql.setString(i++, String2.trimToEmpty(mi.getString("AMT")));         
					sql.setString(i++, String2.trimToEmpty(mi.getString("PRODUCT_NM")));  
				    sql.setString(i++, String2.trimToEmpty(mi.getString("ETC")));
				    sql.setString(i++, String2.trimToEmpty(mi.getString("ERR_YN")));  
				    sql.setString(i++, String2.trimToEmpty(mi.getString("ERR_MSG")));  
					sql.setString(i++, strID);                                            
					sql.setString(i++, strStrCd); 
					sql.setString(i++, strStrDt);
					sql.setString(i++, String2.trimToEmpty(mi.getString("SEQ_NO"))); 
					sql.setString(i++, String2.trimToEmpty(mi.getString("ORDERER_NM")));    
					sql.setString(i++, String2.trimToEmpty(mi.getString("PUMBUN_CD"))); 
					sql.setString(i++, String2.trimToEmpty(mi.getString("PUMBUN_NAME")));
					sql.setString(i++, String2.trimToEmpty(mi.getString("ORDER_SEQ")));

					i=0;
				}else if(mi.IS_DELETE()){
					if(!mi.getString("SEL").equals("F")){
						continue; 
					}
					sql.close();
					
					i=1;
					
					sql.put(svc.getQuery("DEL_MASTER"));;  
					
					sql.setString(i++, strStrCd); 
					sql.setString(i++, strStrDt);
					sql.setString(i++, String2.trimToEmpty(mi.getString("SEQ_NO"))); 
					sql.setString(i++, String2.trimToEmpty(mi.getString("ORDERER_NM")));    
					sql.setString(i++, String2.trimToEmpty(mi.getString("PUMBUN_CD"))); 
					sql.setString(i++, String2.trimToEmpty(mi.getString("PUMBUN_NAME")));
					sql.setString(i++, String2.trimToEmpty(mi.getString("ORDER_SEQ")));
					
				}
				
				res = update(sql);
				
				sql.close();

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
				ret += res;
			}

		} catch (Exception e) {
			e.printStackTrace();
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}

	/**
	 * 당초팀별년계획을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag, String userId) {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		Util util = new Util();
		
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPlanYear 		= String2.nvl(form.getParam("strPlanYear"));
		String strErrYN         = String2.nvl(form.getParam("strErrYN"));
		String strProcYN         = String2.nvl(form.getParam("strProcYN"));
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
	
			connect("pot");
			sql.put(svc.getQuery("SEL_PLANTEAMYY"));
			
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPlanYear);
			sql.setString(i++, strErrYN);
			sql.setString(i++, strProcYN);
			
			ret = select2List(sql);
			//ret = util.decryptedStr(ret, 4);     //핸드폰번호 복호화
		}catch(Exception e){
			e.printStackTrace();
		}
		return ret;
	}
	/**
	 *  확정처리
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public String valCheck(ActionForm form, MultiInput mi1, String userId, String org_flag)
			throws Exception {

		int resp    		= 0;     //프로시저 리턴값
		String res			= "";
		int i   			= 0;
		
		SqlWrapper sql        = null;
		Service svc           = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strStrDt = String2.nvl(form.getParam("strStrDt"));
		
		
		
		try {
	
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			
			while (mi1.next()){
				if(mi1.getString("PROC_FLAG").equals("Y")){
					continue;
				}else{
					
					i = 1;    
					psql.put("DPS.PR_PSDAYONLINE", 6); 
					psql.setString(i++, strStrCd); 		// 점코드
					psql.setString(i++, strStrDt); 		// 지불년월
					psql.setString(i++, userId);		// 지불주기
					psql.setString(i++, mi1.getString("SEQ_NO"));		// 지불회차
					psql.registerOutParameter(i++, DataTypes.INTEGER);//5
					psql.registerOutParameter(i++, DataTypes.VARCHAR);//6
					
					prs = updateProcedure(psql);
				}
			}
            resp += prs.getInt(5);         
            
			
            if (resp != 0) {
                throw new Exception("[USER]"+ prs.getString(6));
            }else{
            	res = prs.getString(6);
            }
            
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return res;
	}
}