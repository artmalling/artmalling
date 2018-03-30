/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.dao;

import java.util.List;

import common.util.Util;
    
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
    
/**
 * <p>법인명 조회 팝업</p>
 * 
 * @created on 1.0, 2010/02/28
 * @created by 김영진(FUJITSU KOREA LTD.)
 *
 * @modified on    
 * @modified by
 * @caused by
 */

public class CCom420DAO extends AbstractDAO {

    /**
     * 조회조건으로 법인 코드 조회
     * 
     * @param form
     * @param mi
     *            : 코드/코드명
     * @return List : 분류 코드 조회 결과
     */
    public List getCustomer(ActionForm form, MultiInput mi) throws Exception {
        
        List       ret = null;
        SqlWrapper sql = null;
        Service    svc = null;
        Util      util = new Util();
        String strQuery = "";

        if (!mi.next())
            throw new Exception(
                    "# CCom420DAO.getOneWithoutPop] MuiltiInput is null");
        connect("pot");
        svc = (Service) form.getService(); 
        sql = new SqlWrapper();
        int i = 1; 
        String strCompPersFlag = mi.getString("COMP_PERS_FLAG");
        String strCustName     = mi.getString("CUST_NAME");
        String strMphone1      = mi.getString("OFFI_PH1");
        String strMphone2      = mi.getString("OFFI_PH2");
        String strMphone3      = mi.getString("OFFI_PH3");
        String strHphone1      = mi.getString("HOME_PH1");
        String strHphone2      = mi.getString("HOME_PH2");
        String strHphone3      = mi.getString("HOME_PH3");
        String strEmail1       = mi.getString("EMAIL1");
        String strEmail2       = mi.getString("EMAIL2");
        String strScrId        = mi.getString("SCR_ID");
        
        sql.put(svc.getQuery(mi.getString("SERVICE_ID")));  
        sql.setString(i++, "P"); 
        if(!strScrId.equals("DCTM111")){
            if(!strScrId.equals("DCTM110")){
                sql.put("AND SCED_REQ_DT IS NULL ");
            }else{
                sql.put("AND SCED_REQ_DT IS NOT NULL ");
            }
        }
    	if (!String2.isEmpty(String2.trim(strCustName))){
            sql.setString(i++, strCustName);
            sql.put(" AND CUST_NAME LIKE  ? || '%' ");
        }
        if (!String2.isEmpty(String2.trim(strMphone1)) && !String2.isEmpty(String2.trim(strMphone2)) 
        		&& !String2.isEmpty(String2.trim(strMphone3))){
            sql.setString(i++, strMphone1);
            sql.setString(i++, strMphone2);
            sql.setString(i++, strMphone3);
            sql.put(" AND OFFI_PH1 = ? AND OFFI_PH2 = ? AND OFFI_PH3 = ? ");
        }
        if (!String2.isEmpty(String2.trim(strHphone1)) && !String2.isEmpty(String2.trim(strHphone2)) 
        		&& !String2.isEmpty(String2.trim(strHphone3))){
            sql.setString(i++, strHphone1);
            sql.setString(i++, strHphone2);
            sql.setString(i++, strHphone3);   
            sql.put(" AND HOME_PH1 = DCS.SC_Crypto_FUN('ENC', ?) "
            		+"AND HOME_PH2 = DCS.SC_Crypto_FUN('ENC', ?) "
            		+"AND HOME_PH3 = DCS.SC_Crypto_FUN('ENC', ?) ");
        } 
        if (!String2.isEmpty(String2.trim(strEmail1)) && !String2.isEmpty(String2.trim(strEmail2))){
            sql.setString(i++, strEmail1);
            sql.setString(i++, strEmail2);
            sql.put(" AND EMAIL1 = DCS.SC_Crypto_FUN('ENC', ?) "
            		+"AND EMAIL2 = DCS.SC_Crypto_FUN('ENC', ?) ");
        }  
        sql.put(" ORDER BY CUST_NAME, CUST_ID"); 
        ret = select2List(sql);
/*      ret = util.decryptedStr(ret,5);     //대표전화1 복호화.
		ret = util.decryptedStr(ret,6);     //대표전화2 복호화.
		ret = util.decryptedStr(ret,7);     //대표전화3 복호화.
		ret = util.decryptedStr(ret,8);     //EMAIL1 복호화.
		ret = util.decryptedStr(ret,9);     //EMAIL2 복호화.
		ret = util.decryptedStr(ret,11);    //사업자번호 복호화.*/
        return ret;
    }
}
