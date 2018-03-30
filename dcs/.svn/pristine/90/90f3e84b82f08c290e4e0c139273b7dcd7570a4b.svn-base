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
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gauce.GauceDataSet;

import common.util.Util;
import common.vo.SessionInfo;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>세대원정보</p>
 * 
 * @created  on 1.0, 2010/02/24
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DCtm106DAO extends AbstractDAO { 

	/**
	 * <p>세대원정보 조회</p>
	 *
	 */
	public List searchMaster(ActionForm form) throws Exception {
		List ret       = null;
		SqlWrapper sql = null;
		Service svc    = null;
        Map map        = null;
        String strQuery = "";
		Util util = new Util();
		int i = 1;
		
		String strSsno    = String2.nvl(form.getParam("strSsno"));
		String strCustid  = String2.nvl(form.getParam("strCustid"));
		String strCardno  = String2.nvl(form.getParam("strCardno"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
        strQuery = svc.getQuery("SEL_COMP_PERS_FLAG") + "\n";
		
		if(!strSsno.equals("")){			
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SS_NO") + "\n";
			sql.setString(i++, strSsno);    //주민번호  암호화.
		}
		if(!strCustid.equals("")){			
			strQuery += svc.getQuery("SEL_MASTER_WHERE_CUST_ID") + "\n";
			sql.setString(i++, strCustid);
		}
		if(!strCardno.equals("")){			
			strQuery += svc.getQuery("SEL_MASTER_WHERE_CARD_NO") + "\n";
			sql.setString(i++, strCardno);  //카드번호 암호화.
		}
		
        strQuery += svc.getQuery("SEL_MASTER_END");
		
		sql.put(strQuery);
		
        //sql.put(svc.getQuery("SEL_COMP_PERS_FLAG"));
        //sql.setString(i++, util.encryptedStr(strSsno));    //주민번호  암호화.
		//sql.setString(i++, strCustid);
		//sql.setString(i++, util.encryptedStr(strCardno));  //카드번호 암호화.
        map = selectMap(sql);
        if(!map.isEmpty()){
            String strCompPersFlag = map.get("COMP_PERS_FLAG").toString();
            sql.close();            
            sql.clearParameter();
            if(strCompPersFlag.equals("C")){
            	throw new Exception("[USER]"+"법인회원은 세대 이동이 불가합니다.");
            }
        }else{
            throw new Exception("[USER]"+"조회 정보가 존재하지 않습니다.");
        }
        
        i = 1;
        sql = new SqlWrapper();
        strQuery = "";
        
		sql.setString(i++, strCustid);
		//sql.setString(i++, util.encryptedStr(strSsno));    //주민번호  암호화.
		//sql.setString(i++, strCustid);
		//sql.setString(i++, util.encryptedStr(strCardno));  //카드번호 암호화.
		
		strQuery = svc.getQuery("searchMaster") + "\n";
		
		if(!strSsno.equals("")){			
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SS_NO") + "\n";
			sql.setString(i++, strSsno);    //주민번호  암호화.
		}
		if(!strCustid.equals("")){			
			strQuery += svc.getQuery("SEL_MASTER_WHERE_CUST_ID") + "\n";
			sql.setString(i++, strCustid);
		}
		if(!strCardno.equals("")){			
			strQuery += svc.getQuery("SEL_MASTER_WHERE_CARD_NO") + "\n";
			sql.setString(i++, strCardno);  //카드번호 암호화.
		}
		
		strQuery += svc.getQuery("SEL_MASTER_ORDER");
		
		sql.put(strQuery);
		
         
		//sql.put(svc.getQuery("searchMaster"));
		ret = select2List(sql);
		//ret = util.decryptedStr(ret,5);     //카드번호 복호화.
		return ret;
	}
	
	/**
	 * <p>세대주 정보 조회</p>
	 *
	 */	
	public List searchMaster2(ActionForm form) throws Exception {
		List ret       = null;
		SqlWrapper sql = null;
		Service svc    = null;
		Map map        = null;
		String strQuery = "";
		int i = 1;
		Util util = new Util();
		
		String strSsno    = String2.nvl(form.getParam("strSsno2"));
		String strCustid  = String2.nvl(form.getParam("strCustid2"));
		String strCardno  = String2.nvl(form.getParam("strCardno2"));
		
	    sql = new SqlWrapper();
	    svc = (Service) form.getService();
        
	    connect("pot");
	    
        strQuery = svc.getQuery("SEL_COMP_PERS_FLAG") + "\n";
		
		if(!strSsno.equals("")){			
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SS_NO") + "\n";
			sql.setString(i++, strSsno);    //주민번호  암호화.
		}
		if(!strCustid.equals("")){			
			strQuery += svc.getQuery("SEL_MASTER_WHERE_CUST_ID") + "\n";
			sql.setString(i++, strCustid);
		}
		if(!strCardno.equals("")){			
			strQuery += svc.getQuery("SEL_MASTER_WHERE_CARD_NO") + "\n";
			sql.setString(i++, strCardno);  //카드번호 암호화.
		}
		
        strQuery += svc.getQuery("SEL_MASTER_END");
		
		sql.put(strQuery);
	    
		/*
	    sql.put(svc.getQuery("SEL_COMP_PERS_FLAG"));
        sql.setString(i++, util.encryptedStr(strSsno));    //주민번호  암호화.
		sql.setString(i++, strCustid);
		sql.setString(i++, util.encryptedStr(strCardno));  //카드번호 암호화.
		*/
        map = selectMap(sql);
        if(!map.isEmpty()){
            String strCompPersFlag = map.get("COMP_PERS_FLAG").toString();
            sql.close();
            sql.clearParameter();
            if(strCompPersFlag.equals("C")){
            	throw new Exception("[USER]"+"법인회원은 세대 이동이 불가합니다.");
            }
        }else{
            throw new Exception("[USER]"+"조회 정보가 존재하지 않습니다.");
        }
        
        i = 1;
        sql = new SqlWrapper();
        strQuery = "";
	    sql.setString(i++, strCustid); 
	    /*
	    sql.setString(i++, util.encryptedStr(strSsno));	    //주민번호 암호화.
	    sql.setString(i++, strCustid);
	    sql.setString(i++, util.encryptedStr(strCardno));	//카드번호 암호화.
	    */
	    
        strQuery = svc.getQuery("searchMaster") + "\n";
		
		if(!strSsno.equals("")){			
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SS_NO") + "\n";
			sql.setString(i++, strSsno);    //주민번호  암호화.
		}
		if(!strCustid.equals("")){			
			strQuery += svc.getQuery("SEL_MASTER_WHERE_CUST_ID") + "\n";
			sql.setString(i++, strCustid);
		}
		if(!strCardno.equals("")){			
			strQuery += svc.getQuery("SEL_MASTER_WHERE_CARD_NO") + "\n";
			sql.setString(i++, strCardno);  //카드번호 암호화.
		}
		
		strQuery += svc.getQuery("SEL_MASTER_ORDER");
		
		sql.put(strQuery);
        
	    //sql.put(svc.getQuery("searchMaster2"));
	    
	    ret = select2List(sql);
	    //ret = util.decryptedStr(ret,5);     //카드번호 복호화.
	    return ret;
	}

	/**
	 * <p>세대구성 저장</p>
	 *
	 */	
    public String saveData(ActionForm form, GauceDataSet dSet, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
    	String ret = "";
        Service svc = null;
        Map map     = null;
        SqlWrapper sql = null;
        ProcedureWrapper psql = null;
        Util util = new Util();
        
        String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date()); 
        String strChksave   = String2.nvl(form.getParam("strChksave"));
        
        try {
        	connect("pot");
    	    begin();
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            psql = new ProcedureWrapper();
            
            int i=1;        
            String strCustid   = String2.nvl(form.getParam("strCustid"));
            String strCustid2  = String2.nvl(form.getParam("strCustid2"));
            String strNewYn    = String2.nvl(form.getParam("strNewYn"));

            ProcedureResultSet prs = null;
            
            HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");

            sql.put(svc.getQuery("SEL_HHOLD_MAN_ID_CHK"));
            sql.setString(i++, strCustid);
            map = selectMap(sql);
            String strHholdManId = map.get("HHOLD_MAN_ID").toString();
            sql.close();
            if(strHholdManId.equals(strCustid2)){
            	throw new Exception("[USER]"+"이미 등록 된 세대주와 동일합니다.");
            }
            
            psql.put("DCS.PR_DCTM106", 6);             
            i=1; 
            psql.setString(i++, strCustid);        
            psql.setString(i++, strCustid2);        
            psql.setString(i++, strNewYn);   
            psql.setString(i++, sessionInfo.getUSER_ID());
            
            psql.registerOutParameter(i++, DataTypes.INTEGER);
            psql.registerOutParameter(i++, DataTypes.VARCHAR);
            
            prs = updateProcedure(psql);
            ret = prs.getString(6); 
            return ret;
                    
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }        
    }        	
}
