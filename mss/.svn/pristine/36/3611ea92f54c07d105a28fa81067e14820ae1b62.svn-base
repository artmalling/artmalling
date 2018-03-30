/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.util.ArrayList;
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
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCae203DAO extends AbstractDAO {
	/**
	 * 경품행사 응모자 조회 -MASTER
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1; 
		 
		String strStrCd		= String2.nvl(form.getParam("strStrCd"));
		String strSdt		= String2.nvl(form.getParam("strSdt"));   
		String strEdt		= String2.nvl(form.getParam("strEdt"));
		String strEventCd	= String2.nvl(form.getParam("strEventCd"));
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");  
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strSdt);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strEventCd);
		sql.put(strQuery);

		ret = select2List(sql);
 
		return ret;
	}
	
	/**
	 * 영수증번호에 대한 카드번호 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getRecpNo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1; 
		 
		String strRecpNo = String2.nvl(form.getParam("strRecpNo")); 
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");  
		//System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		strQuery = svc.getQuery("SEL_RESULT") + "\n";
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strRecpNo);
		sql.setString(i++, strRecpNo);
		sql.setString(i++, strRecpNo); 
		sql.put(strQuery);

		ret = select2List(sql);
 
		return ret;
	} 
	
	/**
	 * 카드번호에대한 고객정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */ 
	public List getCust(ActionForm form, String userId) throws Exception {
        ProcedureWrapper psql = null; 
        ProcedureResultSet prs = null; 
        Util util = new Util();
		int i = 1; 
		 
		String strGbn = String2.nvl(form.getParam("strGbn")); 
		String strMbshNo = String2.nvl(form.getParam("strMbshNo")); 
		 
        psql = new ProcedureWrapper();
        ArrayList<List> DSlist 	= new ArrayList<List>();
 		
        try {
    		begin();
    		connect("pot");  
    		
    		psql.put("DCS.PR_CUST_QUERY", 57);   
    		
     		psql.setString(i++, strGbn);                             // 			1 
     		psql.setString(i++, util.encryptedStr(strMbshNo));                          //  			2
     		psql.setString(i++, userId);          					 // 			3
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 회원성명           4
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 주민번호           5
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 외국인여부        6
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // I-PIN 번호      7
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 자택우편번호1  8  
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //              9  
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 자택주소1    10
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //             11
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 자택전화번호     12
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //				13     
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //				14     
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 이동전화번호    15
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //				16    
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //				17
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 직장명              18
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 직장우편번호1 19    
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //             20  
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 직장주소1    21
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //             22
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 직장전화번호    23
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //             24 
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //             25 
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 생일                 26
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 음력양력구분(L/S)  27 
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 회원ID           28
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 이메일수신동의         29
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 이메일수신동의일자   30
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // SMS수신동의             31
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // SMS수신동의일자      32 
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 가입일자                  33
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 회원탈퇴여부           34
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 회원탈퇴일시          35
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 회원가입경로          36
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 이메일주소 1     37  
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //               38
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //               39
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //               40 
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //               41
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //               42
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //               43
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //               44
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //               45
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //               46
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //               47
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //               48
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //               49
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //               50
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //               51
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //               52 
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 부서명             	  53
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 직위                 	  54  
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       // 성별(M/F)      55
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //               56
     		psql.registerOutParameter(i++, DataTypes.VARCHAR);       //               57
     		prs = selectProcedure(psql); 
 
     		List<String> prsList = new ArrayList<String>(); 
     		prsList.add(String2.nvl(strMbshNo));     //0
     		prsList.add(String2.nvl(prs.getString(4))); //1  
     		
     		prsList.add(String2.nvl(prs.getString(5)));  //2
     		 
     		prsList.add(String2.nvl(prs.getString(8))); //3 
     		prsList.add(String2.nvl(prs.getString(9))); //4 
     		 
     		prsList.add(String2.nvl(prs.getString(10))); //5 
     		prsList.add(String2.nvl(prs.getString(11))); //6  
     		
     		prsList.add(String2.nvl(prs.getString(12))); //7 
     		prsList.add(String2.nvl(prs.getString(13))); //8 
     		prsList.add(String2.nvl(prs.getString(14))); //9 
     		
     		prsList.add(String2.nvl(prs.getString(15)));   //10
     		prsList.add(String2.nvl(prs.getString(16)));   //11
     		prsList.add(String2.nvl(prs.getString(17)));   //12 
     		 
     		prsList.add(String2.nvl(prs.getString(37))); //13 
     		prsList.add(String2.nvl(prs.getString(38))); //14 
     		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + String2.nvl(prs.getString(4)));
     		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + String2.nvl(prs.getString(5)));
     		//List
     		DSlist.add(0, prsList);
     		
     		DSlist = (ArrayList<List>) util.decryptedStr(DSlist,2);		// 주민번호  
     		DSlist = (ArrayList<List>) util.decryptedStr(DSlist,7);		// 전화번호1  
     		DSlist = (ArrayList<List>) util.decryptedStr(DSlist,8);		// 전화번호2  
     		DSlist = (ArrayList<List>) util.decryptedStr(DSlist,9);		// 전화번호3 
     		DSlist = (ArrayList<List>) util.decryptedStr(DSlist,10);	// 핸드폰번호1
     		DSlist = (ArrayList<List>) util.decryptedStr(DSlist,11);	// 핸드폰번호2  
     		DSlist = (ArrayList<List>) util.decryptedStr(DSlist,12);	// 핸드폰번호3
     		DSlist = (ArrayList<List>) util.decryptedStr(DSlist,13);	// 이메일주소1  
     		DSlist = (ArrayList<List>) util.decryptedStr(DSlist,14);	// 이메일주소2
     		 
     		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+DSlist);
        } catch (Exception e) {
        	System.out.println("DAO : " + e);
        } finally {
    		end();
        }

		return DSlist;
	}  
	
	/**
	* 경품행사 응모자등록(영수증)
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int save(ActionForm form, MultiInput mi, String userId) throws Exception {
	
		int ret = 0;
		int res = 0;
        Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
        List	list 	 = null; 
					
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();	

			while (mi.next()) {				
				int i=0;
				sql.close();		
 
	        	String strEntry 	= String2.nvl(form.getParam("strEntry"));   
	        	String strStrCd 	= String2.nvl(form.getParam("strStrCd"));   
	        	String strEventCd 	= String2.nvl(form.getParam("strEventCd"));     
				
				if (mi.IS_INSERT()) { 			// 저장	  
						sql.put(svc.getQuery("INS_PRMMENTY")); 
						sql.setString(++i, strEntry);    
						sql.setString(++i, strStrCd);    
						sql.setString(++i, strEventCd);    
						sql.setString(++i, strEntry);    
						sql.setString(++i, strStrCd);    
						sql.setString(++i, strEventCd);  
						sql.setString(++i, mi.getString("P_CUST_NAME")); 	
						sql.setString(++i, mi.getString("P_SS_NO")); 
						sql.setString(++i, mi.getString("P_HOME_PH1")); 
						sql.setString(++i, mi.getString("P_HOME_PH2"));
						sql.setString(++i, mi.getString("P_HOME_PH3"));
						sql.setString(++i, mi.getString("P_MOBILE_PH1")); 
						sql.setString(++i, mi.getString("P_MOBILE_PH2"));
						sql.setString(++i, mi.getString("P_MOBILE_PH3"));
						sql.setString(++i, mi.getString("P_HOME_ADDR"));
						sql.setString(++i, mi.getString("P_EMAIL"));
						sql.setString(++i, mi.getString("P_MBSH_NO"));
						sql.setString(++i, userId);	 
						sql.setString(++i, userId);	 
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
