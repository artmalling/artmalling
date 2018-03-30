/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dbri.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>회원 매출 객단가 현황(월)</p>
 * 
 * @created  on 1.0, 2010.05.30
 * @created  by 강진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DBri333DAO extends AbstractDAO {

    /**
     * <p>회원 매출 객단가 현황(월)</p>
     * 
     */
    public List searchAge(ActionForm form) throws Exception {
    	try{
    	List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strStrCd			= String2.nvl(form.getParam("strStrCd"));
        String strSaleDtFr		= String2.nvl(form.getParam("strSaleDtFr"));
        String strSaleDtTo		= String2.nvl(form.getParam("strSaleDtTo"));
        String strPumbunCd		= String2.nvl(form.getParam("strPumbunCd"));
        String strSelGubun		= String2.nvl(form.getParam("strSelGubun"));
 
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        
        strQuery = svc.getQuery("SEL_PUMB_CUST") + "\n";

        sql.setString(i++, strStrCd);			/*점코드*/
        sql.setString(i++, strSaleDtFr);		/*매출일자(시작)*/
        sql.setString(i++, strSaleDtTo);		/*매출일자(종료)*/
        sql.setString(i++, strPumbunCd);		/*브랜드코드*/

        if (strSelGubun.equals("1")) 
        	strQuery = strQuery + svc.getQuery("SEL_CUST_CNT_TOP5") + "\n";
        else if (strSelGubun.equals("2"))
        	strQuery = strQuery + svc.getQuery("SEL_CUST_AMT_TOP5") + "\n";
        
        sql.setString(i++, strStrCd);			/*점코드*/
        sql.setString(i++, strSaleDtFr);		/*매출일자(시작)*/
        sql.setString(i++, strSaleDtTo);		/*매출일자(종료)*/
        sql.setString(i++, strPumbunCd);		/*브랜드코드*/
        
        strQuery = strQuery + svc.getQuery("SEL_AGE_SEX_STATSTC") + "\n";
        
        sql.setString(i++, strStrCd);			/*점코드*/
        sql.setString(i++, strSaleDtFr);		/*매출일자(시작)*/
        sql.setString(i++, strSaleDtTo);		/*매출일자(종료)*/
        
        strQuery = strQuery + svc.getQuery("SEL_AGE_SEX_QUERY") + "\n";
        
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    	} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
    }
    
    public List searchAddr(ActionForm form) throws Exception {
    	try{
    	List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strStrCd			= String2.nvl(form.getParam("strStrCd"));
        String strSaleDtFr		= String2.nvl(form.getParam("strSaleDtFr"));
        String strSaleDtTo		= String2.nvl(form.getParam("strSaleDtTo"));
        String strPumbunCd		= String2.nvl(form.getParam("strPumbunCd"));
        String strSelGubun		= String2.nvl(form.getParam("strSelGubun"));
        String strAddr1			= String2.nvl(form.getParam("strAddr1"));
        String strAddr2			= String2.nvl(form.getParam("strAddr2"));
        String strAddr3			= String2.nvl(form.getParam("strAddr3"));
        String strAddr4			= String2.nvl(form.getParam("strAddr4"));
        String strAddr5			= String2.nvl(form.getParam("strAddr5"));
        String strAddr6			= String2.nvl(form.getParam("strAddr6"));
        String strAddr7			= String2.nvl(form.getParam("strAddr7"));
        String strAddr8			= String2.nvl(form.getParam("strAddr8"));
        String strAddr9			= String2.nvl(form.getParam("strAddr9"));
        String strAddr10		= String2.nvl(form.getParam("strAddr10"));
        String strAddrSet		= String2.nvl(form.getParam("strAddrSet"));
        
 
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        
        strQuery = svc.getQuery("SEL_PUMB_CUST") + "\n";

        sql.setString(i++, strStrCd);			/*점코드*/
        sql.setString(i++, strSaleDtFr);		/*매출일자(시작)*/
        sql.setString(i++, strSaleDtTo);		/*매출일자(종료)*/
        sql.setString(i++, strPumbunCd);		/*브랜드코드*/

        if (strSelGubun.equals("1")) 
        	strQuery = strQuery + svc.getQuery("SEL_CUST_CNT_TOP5") + "\n";
        else if (strSelGubun.equals("2"))
        	strQuery = strQuery + svc.getQuery("SEL_CUST_AMT_TOP5") + "\n";
        
        sql.setString(i++, strStrCd);			/*점코드*/
        sql.setString(i++, strSaleDtFr);		/*매출일자(시작)*/
        sql.setString(i++, strSaleDtTo);		/*매출일자(종료)*/
        sql.setString(i++, strPumbunCd);		/*브랜드코드*/
        
        strQuery = strQuery + svc.getQuery("SEL_ADDR_SEX_STATSTC") + "\n";

        sql.setString(i++, strAddr1);			/*주소1*/
        sql.setString(i++, strAddr1);			/*주소1*/
        sql.setString(i++, strAddr1);			/*주소1*/
        sql.setString(i++, strAddr1);			/*주소1*/

        sql.setString(i++, strAddr2);			/*주소2*/
        sql.setString(i++, strAddr2);			/*주소2*/
        sql.setString(i++, strAddr2);			/*주소2*/
        sql.setString(i++, strAddr2);			/*주소2*/
        
        sql.setString(i++, strAddr3);			/*주소3*/
        sql.setString(i++, strAddr3);			/*주소3*/
        sql.setString(i++, strAddr3);			/*주소3*/
        sql.setString(i++, strAddr3);			/*주소3*/
        
        sql.setString(i++, strAddr4);			/*주소4*/
        sql.setString(i++, strAddr4);			/*주소4*/
        sql.setString(i++, strAddr4);			/*주소4*/
        sql.setString(i++, strAddr4);			/*주소4*/
        
        sql.setString(i++, strAddr5);			/*주소5*/
        sql.setString(i++, strAddr5);			/*주소5*/
        sql.setString(i++, strAddr5);			/*주소5*/
        sql.setString(i++, strAddr5);			/*주소5*/
        
        sql.setString(i++, strAddr6);			/*주소6*/
        sql.setString(i++, strAddr6);			/*주소6*/
        sql.setString(i++, strAddr6);			/*주소6*/
        sql.setString(i++, strAddr6);			/*주소6*/
       
        sql.setString(i++, strAddr7);			/*주소7*/
        sql.setString(i++, strAddr7);			/*주소7*/
        sql.setString(i++, strAddr7);			/*주소7*/
        sql.setString(i++, strAddr7);			/*주소7*/
        
        sql.setString(i++, strAddr8);			/*주소8*/
        sql.setString(i++, strAddr8);			/*주소8*/
        sql.setString(i++, strAddr8);			/*주소8*/
        sql.setString(i++, strAddr8);			/*주소8*/
        
        sql.setString(i++, strAddr9);			/*주소9*/
        sql.setString(i++, strAddr9);			/*주소9*/
        sql.setString(i++, strAddr9);			/*주소9*/
        sql.setString(i++, strAddr9);			/*주소9*/
        
        sql.setString(i++, strAddr10);			/*주소10*/
        sql.setString(i++, strAddr10);			/*주소10*/
        sql.setString(i++, strAddr10);			/*주소10*/
        sql.setString(i++, strAddr10);			/*주소10*/
        
        sql.setString(i++, strStrCd);			/*점코드*/
        sql.setString(i++, strSaleDtFr);		/*매출일자(시작)*/
        sql.setString(i++, strSaleDtTo);		/*매출일자(종료)*/
        sql.setString(i++, strAddrSet);			/*지역 묶음*/
        
        strQuery = strQuery + svc.getQuery("SEL_ADDR_SEX_QUERY") + "\n";
        
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    	} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
    }
}
