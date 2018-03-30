/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.dao;

import java.net.URLDecoder;
import java.util.List;


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


/**
 * <p>공통으로 사용되는  DAO</p>
 * 
 * @created  on 1.0, 2010/02/15
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom912DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
     
    /**
     * 조직코드 조회
     *
     * @param  : 
     * @return :
     */
    public List searchOnPop(ActionForm form, MultiInput mi) throws Exception {
        List list = null;
        SqlWrapper sql = null;
        Service svc = null;
        boolean authYn = false;
        int i;
        try {
          connect("pot");
          
          svc = (Service) form.getService();
          sql = new SqlWrapper();
          
          i=0;
          mi.next();
          
		if(("DEPT_CD").equals(mi.getString("GBN"))) 
            sql.put(svc.getQuery("SEL_DEPT_LIST")); 
		else if (("TEAM_CD").equals(mi.getString("GBN")))
            sql.put(svc.getQuery("SEL_TEAM_LIST")); 
		else if (("PC_CD").equals(mi.getString("GBN")))
            sql.put(svc.getQuery("SEL_PC_LIST")); 
		

        String addCondition = mi.getString("ADD_CONDITION");
  		if (!"".equals(addCondition)) 
  		{
  			String[] addConds = addCondition.split("#G#");

				System.out.println("--------------- =   길이	" +  addConds.length +"   " + addCondition	);//사용여부   
  			for (int idx = 0; idx < addConds.length; idx++) 
  			{  
				switch(idx)
				{
			    	case 0: //조직
			            sql.put(svc.getQuery("SEL_WHERE_ORG_FLAG"));
			    		System.out.println(sql.get() 	);//사용여부  
  						sql.setString(++i, addConds[idx]);  
				    	break;

			    	case 1: //점
			            sql.put(svc.getQuery("SEL_WHERE_STR_CD")); 
  						sql.setString(++i, addConds[idx]);  
				    	break;

			    	case 2: //부문
			            sql.put(svc.getQuery("SEL_WHERE_DEPT_CD")); 
  						sql.setString(++i, addConds[idx]);  
				    	break;

			    	case 3: //팀
			            sql.put(svc.getQuery("SEL_WHERE_TEAM_CD")); 
  						sql.setString(++i, addConds[idx]);  
				    	break;

			    	case 4: //PC
			            sql.put(svc.getQuery("SEL_WHERE_PC_CD")); 
  						sql.setString(++i, addConds[idx]);    
				    	break;

			    	case 5: //사용여부
			            sql.put(svc.getQuery("SEL_WHERE_USE_YN")); 
  						sql.setString(++i, addConds[idx]);  
				    	break;  

			    	case 6: //명
			            sql.put(svc.getQuery("SEL_WHERE_ORG_NAME")); 
  						sql.setString(++i, URLDecoder.decode(String2.nvl(addConds[idx]), "UTF-8") );   
				    	break;
				} 
  			}
  		}  
		sql.put(svc.getQuery("SEL_ORDER")); 


		//System.out.println(sql.get() 	);//사용여부  
		connect("pot");	
		
        list = select2List(sql);
    } catch (Exception e) {
        throw e;
    }
    return list;
    }
}
