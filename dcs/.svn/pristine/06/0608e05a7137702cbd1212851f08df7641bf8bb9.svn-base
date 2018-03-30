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

import javax.servlet.http.HttpServletRequest;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.Util;

/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/03/30
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * @caused   by 데이터변경이력조회
 * 
 * @modified on 
 * @modified by 
 */

public class DCtm433DAO extends AbstractDAO {
	/**
     * <p>데이터조회 이력 조회</p>
     * 
     */        
    public List searchList(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        Util util = new Util();
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        
        String strFlag = String2.nvl(form.getParam("strFlag"));
        
        if(strFlag.equals("A")){
        	strQuery = svc.getQuery("SEL_MASTER") + "\n"; 
        }else{
        	strQuery = svc.getQuery("SEL_MASTER_CARD") + "\n"; 
        }
        
        //strQuery = svc.getQuery("SEL_MASTER") + "\n"; 
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }
    
    /**
	 * 수정  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi)
			throws Exception {

		int ret = 0;
		int res = 0;		
		SqlWrapper sql = null;
		Service svc = null;	
		String orgCdCnt = "";
		String strQuery = "";
		Util util = new Util();	
		
		int i;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strFlag = String2.nvl(form.getParam("strFlag"));

			while (mi.next()) {
				sql.close();
				
				if (mi.IS_UPDATE()) {
					i = 0;					
					
					if(strFlag.equals("A")){
						sql.put(svc.getQuery("UPD_MIG_CUST")); 
						
						sql.setString(++i, mi.getString("SS_NO_ORG"));
						sql.setString(++i, mi.getString("CARD_NO_ORG"));
						sql.setString(++i, mi.getString("PWD_NO_ORG"));
						sql.setString(++i, mi.getString("SS_NO_ORG"));
						sql.setString(++i, mi.getString("CARD_NO_ORG"));
						sql.setString(++i, mi.getString("PWD_NO_ORG"));
			        }else{
			        	sql.put(svc.getQuery("UPD_MIG_CUST_CARD"));
			        	
			        	sql.setString(++i, mi.getString("SS_NO_ORG"));
						sql.setString(++i, mi.getString("CARD_NO_ORG"));
						sql.setString(++i, mi.getString("PWD_NO_ORG"));
						sql.setString(++i, mi.getString("HOME_PH1_ORG"));    //자택전화번호1 //암호화          
						sql.setString(++i, mi.getString("HOME_PH2_ORG"));    //자택전화번호2 //암호화          
						sql.setString(++i, mi.getString("HOME_PH3_ORG"));    //자택전화번호3 //암호화          
						sql.setString(++i, mi.getString("MOBILE_PH1_ORG"));  //휴대폰1 //암호화             
						sql.setString(++i, mi.getString("MOBILE_PH2_ORG"));  //휴대폰2 //암호화             
						sql.setString(++i, mi.getString("MOBILE_PH3_ORG"));  //휴대폰3 //암호화             
						sql.setString(++i, mi.getString("EMAIL1_ORG"));      //이메일1 //암호화             
						sql.setString(++i, mi.getString("EMAIL2_ORG"));      //이메일2 //암호화 
						sql.setString(++i, mi.getString("SS_NO_ORG"));
						//sql.setString(++i, mi.getString("CARD_NO_ORG"));
						//sql.setString(++i, mi.getString("PWD_NO_ORG"));						
						//sql.setString(++i, mi.getString("HOME_PH1_ORG"));
						//sql.setString(++i, mi.getString("HOME_PH2_ORG"));
						//sql.setString(++i, mi.getString("HOME_PH3_ORG"));						
						//sql.setString(++i, mi.getString("MOBILE_PH1_ORG"));
						//sql.setString(++i, mi.getString("MOBILE_PH2_ORG"));
						//sql.setString(++i, mi.getString("MOBILE_PH3_ORG"));						
						//sql.setString(++i, mi.getString("EMAIL1_ORG"));
						//sql.setString(++i, mi.getString("EMAIL2_ORG"));
			        }
				} 
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
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
