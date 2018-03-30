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

import javax.servlet.http.HttpServletRequest;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>VAN사 승인내역 조회</p>
 * 
 * @created  on 1.1, 2010/06/02
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * @caused   by VAN사 승인내역 조회
 *
 */

public class PSal948DAO extends AbstractDAO {

    /**
     * <p>VAN사 승인내역 조회 </p>
     * 
     */        
    public List searchMaster(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;

        connect("pot");
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();
        
        String strStrCd    = String2.nvl(form.getParam("strStrCd"));
        String strSapprDt  = String2.nvl(form.getParam("strSapprDt"));
        String strEapprDt  = String2.nvl(form.getParam("strEapprDt"));
        String strBcomp    = String2.nvl(form.getParam("strBcomp"));
        String strJbrchId  = String2.nvl(form.getParam("strJbrchId"));
        String strApprNo   = String2.nvl(form.getParam("strApprNo"));   
        String strVanGubun = String2.nvl(form.getParam("strVanGubun"));   
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSapprDt);
        sql.setString(i++, strEapprDt);
        sql.setString(i++, strBcomp);
        sql.setString(i++, strJbrchId);
        sql.setString(i++, strApprNo);
        sql.setString(i++, strVanGubun);
        
        if(!strVanGubun.equals("99")){
        	 strQuery += svc.getQuery("SEL_MASTER2") + "\n";
            if(strVanGubun.equals("01")){
                strQuery += "                       AND A.DEVICE_ID IN                                  \n";
                strQuery += "                                          ( SELECT COMM_NAME2              \n";
                strQuery += "                                              FROM COM.TC_COMMCODE         \n";
                strQuery += "                                             WHERE COMM_PART = 'D070'      \n";
                strQuery += "                                          )                                \n";
            }else if(strVanGubun.equals("02")){
                strQuery += "                       AND A.DEVICE_ID NOT IN                               \n";
                strQuery += "                                             ( SELECT COMM_NAME2            \n";
                strQuery += "                                                 FROM COM.TC_COMMCODE       \n";
                strQuery += "                                                WHERE COMM_PART = 'D070'    \n";
                strQuery += "                                             )                              \n";
            }
            strQuery += "                       GROUP BY A.APPR_DT, A.BCOMP_CD, A.JBRCH_ID               \n";
            
            sql.setString(i++, strStrCd);
            sql.setString(i++, strSapprDt.substring(2));
            sql.setString(i++, strEapprDt.substring(2));
            sql.setString(i++, strBcomp);
            sql.setString(i++, strJbrchId);
            sql.setString(i++, strApprNo);   
        }
        strQuery += "                       ) X                                                      \n";
        strQuery += "                  GROUP BY X.APPR_DT, X.BCOMP_CD, X.JBRCH_ID                    \n";
        strQuery += "                  ORDER BY X.APPR_DT, X.BCOMP_CD, X.JBRCH_ID                    \n";
         
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
    
    /**
     * <p>VAN사 승인내역  상세 조회</p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        String     strQuery = "";
        int i = 1;
        
        String strApprDt   = String2.nvl(form.getParam("strApprDt"));
        String strStrCd    = String2.nvl(form.getParam("strStrCd"));
        String strApprNo   = String2.nvl(form.getParam("strApprNo"));
        String strBcompCd  = String2.nvl(form.getParam("strBcompCd"));
        String strJbrchId  = String2.nvl(form.getParam("strJbrchId"));
        String strVanGubun = String2.nvl(form.getParam("strVanGubun"));   

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strStrCd);
        sql.setString(i++, strApprDt);
        sql.setString(i++, strApprNo);
        sql.setString(i++, strBcompCd);
        sql.setString(i++, strJbrchId);
        sql.setString(i++, strVanGubun);     

        strQuery = svc.getQuery("SEL_DETAIL") + "\n";
        
        if(!strVanGubun.equals("99")){
   	        strQuery += svc.getQuery("SEL_DETAIL2") + "\n";
   	        
            if(strVanGubun.equals("01")){
                strQuery += "                       AND A.DEVICE_ID IN                                  \n";
                strQuery += "                                          ( SELECT COMM_NAME2              \n";
                strQuery += "                                              FROM COM.TC_COMMCODE         \n";
                strQuery += "                                             WHERE COMM_PART = 'D070'      \n";
                strQuery += "                                          )                                \n";
            }else if(strVanGubun.equals("02")){
                strQuery += "                       AND A.DEVICE_ID NOT IN                              \n";
                strQuery += "                                              ( SELECT COMM_NAME2          \n";
                strQuery += "                                                  FROM COM.TC_COMMCODE     \n";
                strQuery += "                                                 WHERE COMM_PART = 'D070'  \n";
                strQuery += "                                              )                            \n";
            }
            
            sql.setString(i++, strStrCd);
            sql.setString(i++, strApprDt.substring(2)); 
            sql.setString(i++, strApprNo);
            sql.setString(i++, strBcompCd);
            sql.setString(i++, strJbrchId);    
        }
        
        strQuery += "                       ) X                                                         \n";
        strQuery += "                  GROUP BY X.POS_ANO                                               \n";
        strQuery += "                  ORDER BY X.POS_ANO                                               \n";

        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }        
}
