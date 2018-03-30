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
import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>주거세대마스터관리</p>
 * 
 * @created  on 1.0, 2010.03.28
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen107DAO extends AbstractDAO {

	/**
    * <p>주거세대마스터관리 내역조회</p>
    */
   @SuppressWarnings("rawtypes")
   public List getMaster(ActionForm form) throws Exception {

	   List       list = null;
       SqlWrapper  sql = null;
       Service     svc = null;
       
       Util util = new Util();
       try {
           connect("pot");
           svc  = (Service)form.getService();
           sql  = new SqlWrapper();
           int i = 0;
           //parameters
           String strFlcFlag	= String2.nvl(form.getParam("strFlcFlag"));	// [조회용]시설구분(점코드)
           String strDong		= String2.nvl(form.getParam("strDong"));	// [조회용]동호
           String strHo			= String2.nvl(form.getParam("strHo"));		// [조회용]동호
           String strHHName		= String2.nvl(form.getParam("strHHName"));	// [조회용]세대주명
           String strIOFlag		= String2.nvl(form.getParam("strIOFlag"));	// [조회용]조회기간구분
           String strSdt		= String2.nvl(form.getParam("strSdt"));		// [조회용]기간S
           String strEdt		= String2.nvl(form.getParam("strEdt"));		// [조회용]기간E
           String strStayNow	= String2.nvl(form.getParam("strStayNow"));	// [조회용]현거주여부
           sql.put(svc.getQuery("SEL_MR_HHOLDMST"));
           sql.setString(++i, strHHName);
           sql.setString(++i, strDong);
           sql.setString(++i, strHo);
           sql.setString(++i, strFlcFlag);

           // 1:전입일, 2:전출일
           if (strIOFlag.equals("1")) {
        	   sql.put(svc.getQuery("SEL_MR_HHOLDMST_WHERE_MIN"));
        	   sql.setString(++i, strSdt);
        	   sql.setString(++i, strEdt);
           } else if (strIOFlag.equals("2")) {
        	   sql.put(svc.getQuery("SEL_MR_HHOLDMST_WHERE_MOUT"));
        	   sql.setString(++i, strSdt);
        	   sql.setString(++i, strEdt);
           } 
           
           // 현거주여부
           if (strStayNow.equals("Y")) {
        	   sql.put(svc.getQuery("SEL_MR_HHOLDMST_WHERE_STAY_NOW"));
           }
           
           sql.put(svc.getQuery("SEL_MR_HHOLDMST_ORDER_BY"));
           list = select2List(sql);
           //복호화
           //list = util.decryptedStr(list,8);	// 전화번호1
           //list = util.decryptedStr(list,9);	// 전화번호2
           //list = util.decryptedStr(list,10);	// 전화번호3
       } catch (Exception e) {
           throw e;
       }
       return list;
   }
   
   /**
    * <p>주거세대마스터관리 저장</p>
    */
   public int save(ActionForm form, MultiInput mi, String userID)
   throws Exception {
       int ret = 0;
       int res = 0;
       SqlWrapper sql = null;
       Service svc = null;
       
       Util util = new Util();
       try {
           connect("pot");
           begin(); //DB트렌젝션 시작
           sql = new SqlWrapper();
           svc = (Service) form.getService();
           
           while (mi.next()) {
               sql.close();
               if (mi.IS_INSERT()) {
					sql.put(svc.getQuery("INS_MR_HHOLDMST"));
					int i = 0;
					sql.setString(++i, mi.getString("HUSE_ID"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("DONG"));
					sql.setString(++i, mi.getString("HO"));
					sql.setString(++i, mi.getString("HEAT_AREA"));
					sql.setString(++i, mi.getString("CNTR_AREA"));
					sql.setString(++i, mi.getString("HHOLD_NAME"));
                    // 암호화[전화번호]
                    sql.setString(++i, mi.getString("PHONE1_NO"));
                    sql.setString(++i, mi.getString("PHONE2_NO"));
                    sql.setString(++i, mi.getString("PHONE3_NO"));
					sql.setString(++i, mi.getString("MOVE_IN_DT"));
					sql.setString(++i, mi.getString("MOVE_OUT_DT"));
					sql.setString(++i, mi.getString("MNTN_CAL_YN"));
					sql.setString(++i, mi.getString("PWR_KIND_CD"));
					sql.setString(++i, mi.getString("PWR_TYPE"));
					sql.setString(++i, mi.getString("PWR_SEL_CHARGE"));
					sql.setString(++i, mi.getString("PWR_CNTR_QTY"));
					sql.setString(++i, mi.getString("PWR_REVER_RATE"));
					sql.setString(++i, mi.getString("PWR_DC_TYPE"));
					sql.setString(++i, mi.getString("PWR_REDU_TYPE"));
					sql.setString(++i, mi.getString("WWTR_KIND_CD"));
					sql.setString(++i, mi.getString("WWTR_CHARGE_YN"));
					sql.setString(++i, mi.getString("STM_KIND_CD"));
					sql.setString(++i, mi.getString("CWTR_KIND_CD"));
					sql.setString(++i, mi.getString("GAS_KIND_CD"));
					sql.setString(++i, mi.getString("GAS_REDU_TYPE"));
					sql.setString(++i, mi.getString("WTR_KIND_CD"));
					sql.setString(++i, mi.getString("CHARG_YN"));
					sql.setString(++i, mi.getString("PAY_YN"));
					sql.setString(++i, mi.getString("TV_CNT"));
					sql.setString(++i, mi.getString("MNTN_PAY_KIND"));
					sql.setString(++i, userID); 
					sql.setString(++i, userID); 
					res = update(sql);
               } else if (mi.IS_UPDATE()) {
					sql.put(svc.getQuery("UPD_MR_HHOLDMST"));
					int i = 0;
					sql.setString(++i, mi.getString("HUSE_ID"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("DONG"));
					sql.setString(++i, mi.getString("HO"));
					sql.setString(++i, mi.getString("HEAT_AREA"));
					sql.setString(++i, mi.getString("CNTR_AREA"));
					sql.setString(++i, mi.getString("HHOLD_NAME"));
                    // 암호화[전화번호]
                    sql.setString(++i, mi.getString("PHONE1_NO"));
                    sql.setString(++i, mi.getString("PHONE2_NO"));
                    sql.setString(++i, mi.getString("PHONE3_NO"));
					sql.setString(++i, mi.getString("MOVE_IN_DT"));
					sql.setString(++i, mi.getString("MOVE_OUT_DT"));
					sql.setString(++i, mi.getString("MNTN_CAL_YN"));
					sql.setString(++i, mi.getString("PWR_KIND_CD"));
					sql.setString(++i, mi.getString("PWR_TYPE"));
					sql.setString(++i, mi.getString("PWR_SEL_CHARGE"));
					sql.setString(++i, mi.getString("PWR_CNTR_QTY"));
					sql.setString(++i, mi.getString("PWR_REVER_RATE"));
					sql.setString(++i, mi.getString("PWR_DC_TYPE"));
					sql.setString(++i, mi.getString("PWR_REDU_TYPE"));
					sql.setString(++i, mi.getString("WWTR_KIND_CD"));
					sql.setString(++i, mi.getString("WWTR_CHARGE_YN"));
					sql.setString(++i, mi.getString("STM_KIND_CD"));
					sql.setString(++i, mi.getString("CWTR_KIND_CD"));
					sql.setString(++i, mi.getString("GAS_KIND_CD"));
					sql.setString(++i, mi.getString("GAS_REDU_TYPE"));
					sql.setString(++i, mi.getString("WTR_KIND_CD"));
					sql.setString(++i, mi.getString("CHARG_YN"));
					sql.setString(++i, mi.getString("PAY_YN"));
					sql.setString(++i, mi.getString("TV_CNT"));
					sql.setString(++i, mi.getString("MNTN_PAY_KIND"));
					sql.setString(++i, userID); 
					sql.setString(++i, mi.getString("HHOLD_ID"));
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
