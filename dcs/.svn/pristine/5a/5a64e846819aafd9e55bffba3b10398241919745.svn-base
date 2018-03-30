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
 * <p>기부적립금기부등록 조회</p>
 * 
 * @created  on 1.0, 2010/02/23
 * @created  by 장형욱
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMtc703DAO extends AbstractDAO {

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
        //String strDonNm     = String2.nvl(form.getParam("strDonNm"));
        String strDonId     = String2.nvl(form.getParam("strDonId"));
        String strStatus    = String2.nvl(form.getParam("strStatus"));
        
        String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date()); 
             
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strEdt); 
        sql.setString(i++, strSdt); 
        sql.setString(i++, strDonId);        
        
        strQuery = svc.getQuery("SEL_DC_DON_PLAN"); 
         
        if (!"".equals(strStatus)) {
            if ("0".equals(strStatus))    // 활성
                strQuery += "        AND B.E_DT >= " + toDate + "\n";
            else if ("1".equals(strStatus))    // 비활성
                strQuery += "        AND B.E_DT < "  + toDate + "\n";
        }        
        strQuery += "         GROUP BY B.DON_NAME, A.DON_ID, B.S_DT, B.E_DT, B.DON_TARGET \n";
        strQuery += "         ORDER BY A.DON_ID, B.S_DT \n";
    
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
            
            String strSdt       = String2.nvl(form.getParam("strSdt"));
            String strEdt       = String2.nvl(form.getParam("strEdt"));    
            
            while (mi.next()) {
                
                psql.close();
                
                if (mi.IS_INSERT()){// 수정
                    int i=1;
                  
                    psql.put("DCS.PR_DMTC703", 8);    
                    psql.setString(i++, mi.getString("DON_ID"));          //기부ID
                    psql.setString(i++, strSdt);                          //시작일
                    psql.setString(i++, strEdt);                          //종료일
                    psql.setString(i++, mi.getString("TRG_DON_POINT"));   //기부처기부금액
                    psql.setString(i++, mi.getString("TRG_DON_DT"));      //기부처 기부일                     
                    psql.setString(i++, userId);                          //로그인ID

                    psql.registerOutParameter(i++, DataTypes.INTEGER);//7
                    psql.registerOutParameter(i++, DataTypes.VARCHAR);//8
                    prs = updateProcedure(psql);
                    
                    //res += prs.getInt(5);       
                    //res += prs.getInt(7);   
                    
                    if (prs.getInt(7) != 0) {
                        throw new Exception("" + prs.getString(8));
                    }
                }
               
                if (res != 0) {
                    throw new Exception("" + "데이터의 적합성 문제로 인하여"
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
