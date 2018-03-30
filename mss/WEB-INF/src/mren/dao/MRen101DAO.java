/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mren.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>시설구분별관리기준</p>
 * 
 * @created  on 1.0, 2010.03.15
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen101DAO extends AbstractDAO {

	/**
    * <p>시설구분별관리기준 내역조회</p>
    */
   @SuppressWarnings("rawtypes")
   public List getMaster(ActionForm form) throws Exception {

   	List       list = null;
       SqlWrapper  sql = null;
       Service     svc = null;
       try {
           connect("pot");
           svc  = (Service)form.getService();
           sql  = new SqlWrapper();
           int i = 0;
            
           //parameters
           String strFlcFlag	= String2.nvl(form.getParam("strFlcFlag"));	// [조회용]시설구분(점코드)
           String strSelGbn		= String2.nvl(form.getParam("strSelGbn"));	// [조회용]조회구분값(신규등록시 시설구분 변경 저리 S:단순조회, N:신규등록시)
           // S:단순조회, N:신규등록시
           if (strSelGbn.equals("S")) {
        	   sql.put(svc.getQuery("SEL_MR_FCLMST"));
           } else {
        	   sql.put(svc.getQuery("SEL_MR_FCLMST_NEW"));
           }
           
           sql.setString(++i, strFlcFlag);              
           list = select2List(sql);
       } catch (Exception e) {
           throw e;
       }
       return list;
   }
   
   /**
    * <p>시설구분별관리기준 저장</p>
    */
   public int save(ActionForm form, MultiInput mi, String userID)
   throws Exception {
       int ret = 0;
       int res = 0;
       SqlWrapper sql = null;
       Service svc = null;
       try {
           connect("pot");
           begin(); //DB트렌젝션 시작
           sql = new SqlWrapper();
           svc = (Service) form.getService();

           while (mi.next()) {
               sql.close();
               if (mi.IS_UPDATE()) {
					sql.put(svc.getQuery("UPD_MR_FCLMST"));
					int i = 0;
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("HUSE_FLAG"));
					sql.setString(++i, mi.getString("AREA"));
					sql.setString(++i, mi.getString("EXCL_AREA"));
					sql.setString(++i, mi.getString("SHR_AREA"));
					sql.setString(++i, mi.getString("AREA_FLAG"));
					sql.setString(++i, mi.getString("ORG_CD"));
					sql.setString(++i, mi.getString("USE_YN"));
					sql.setString(++i, mi.getString("PWR_CAL_YN"));
					sql.setString(++i, mi.getString("WARMWTR_CAL_YN"));
					sql.setString(++i, mi.getString("STEAM_CAL_YN"));
					sql.setString(++i, mi.getString("COLDWTR_CAL_YN"));
					sql.setString(++i, mi.getString("WTRWORKS_CAL_YN"));
					sql.setString(++i, mi.getString("GRAYWTR_CAL_YN"));
					sql.setString(++i, mi.getString("GAS_CAL_YN"));
					sql.setString(++i, mi.getString("PUB_DIV_RATE"));
					//session의 사용자 ID
					sql.setString(++i, userID); 
					sql.setString(++i, userID); 
					res = update(sql);
               } 
               
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
