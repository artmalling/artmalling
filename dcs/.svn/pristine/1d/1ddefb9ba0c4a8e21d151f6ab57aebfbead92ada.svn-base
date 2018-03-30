/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmtc.dao;

import java.util.List;
//import java.util.Map;

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
 * @created  on 1.0, 2010/03/03
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMtc705DAO extends AbstractDAO {

    /**
     * <p>기부적립금기부등록 조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strSdt       = String2.nvl(form.getParam("strSdt"));
        String strEdt       = String2.nvl(form.getParam("strEdt"));      
        String strDonId     = String2.nvl(form.getParam("strDonId"));
        String strStatus    = String2.nvl(form.getParam("strStatus"));
        
        String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date()); 
             
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strSdt);
        sql.setString(i++, strEdt);
        sql.setString(i++, strDonId);        
        //sql.setString(i++, strDonNm);
        
        strQuery = svc.getQuery("SEL_DC_DON_TARGET"); // + "\n";
        
        if (!"".equals(strStatus)) {
            if ("2".equals(strStatus)) {
                strQuery += "\n AND A.ACCNT_MIG_DT IS NOT NULL ";
            } else if ("1".equals(strStatus)) {
                strQuery += "\n AND A.ACCNT_MIG_DT IS NULL ";
            }
        } 
        strQuery += "\n ORDER BY A.DON_ID \n";
        
    
        sql.put(strQuery);
        ret = select2List(sql);
        
        return ret;
    }   	

    public int saveData(ActionForm form, MultiInput mi, String userId) throws Exception {
        ProcedureWrapper psql = null;
        Service svc           = null;
        int ret = 0;
        int res = 0;
 
        try {
            connect("pot");
            begin();
            psql = new ProcedureWrapper();
            svc = (Service) form.getService();
            
            ProcedureResultSet prs = null;
            
            String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
            
            while (mi.next()) {
                
                psql.close();
                
                if (mi.IS_INSERT()) {
                    int i=1;
                    
                    psql.put("DCS.PR_DMTC705_INSERT", 6);    
                    psql.setString(i++, mi.getString("DON_ID"));          //기부ID
                    psql.setString(i++, mi.getString("DON_DT"));          //시작일
                    psql.setString(i++, toDate);    //종료일
                    psql.setString(i++, userId);                          //로그인ID

                    psql.registerOutParameter(i++, DataTypes.INTEGER);//7
                    psql.registerOutParameter(i++, DataTypes.VARCHAR);//8
                    prs = updateProcedure(psql);
                    
                    //res += prs.getInt(5);       
                    //res += prs.getInt(7);       
                } else if (mi.IS_DELETE()) {
                    int i=1;
                    
                    psql.put("DCS.PR_DMTC705_DELETE", 6);    
                    psql.setString(i++, mi.getString("DON_ID"));          //기부ID
                    psql.setString(i++, mi.getString("DON_DT"));          //시작일
                    psql.setString(i++, toDate);    //종료일
                    psql.setString(i++, userId);                          //로그인ID

                    psql.registerOutParameter(i++, DataTypes.INTEGER);//7
                    psql.registerOutParameter(i++, DataTypes.VARCHAR);//8
                    prs = updateProcedure(psql);                	
                }
               
                if (res != 0) {
                	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                            + "데이터 입력을 하지 못했습니다.");
                }
                ret = mi.getRowNum();        
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
