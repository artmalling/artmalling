/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mren.dao;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import common.util.FileControlMgr;
import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>계약마스터관리 </p>
 * 
 * @created  on 1.0, 2010.04.14
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen201DAO extends AbstractDAO {

	/**
	 * <p>
	 * 계약마스터 조회
	 * </p>
	 */
	@SuppressWarnings("rawtypes")
	public List getMaster(ActionForm form) throws Exception {

		List list = null;
		SqlWrapper sql = null;
		Service svc = null;

		Util util = new Util();
		try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			int i = 0;
			// parameters
			String strFlcFlag 	= String2.nvl(form.getParam("strFlcFlag")); 		// [조회용]시설구분(점코드)
			String strVenCd 	= String2.nvl(form.getParam("strVenCd")); 			// [조회용]협력사
			String strStayNow 	= String2.nvl(form.getParam("strStayNow")); 		// [조회용]현거주여부
			String strRentType	= String2.nvl(form.getParam("strRentType")); 		// [조회용]임대형태
			String strRentFlag 	= String2.nvl(form.getParam("strRentFlag")); 		// [조회용]임대구분
			String strCntrType 	= String2.nvl(form.getParam("strCntrType")); 		// [조회용]계약유형
			String strIOFlag	= String2.nvl(form.getParam("strIOFlag")); 			// [조회용]조회기간구분
			String strSdt 		= String2.nvl(form.getParam("strSdt")); 			// [조회용]기간S
			String strEdt 		= String2.nvl(form.getParam("strEdt")); 			// [조회용]기간E
			
/*			String strNoVat 	= String2.nvl(form.getParam("strNoVat")); 			// [임대료]제외
			String strVat 		= String2.nvl(form.getParam("strVat")); 			// [임대료]금액
			String strYesVat 	= String2.nvl(form.getParam("strYesVat")); 			// [임대료]포함
*/			
			sql.put(svc.getQuery("SEL_MR_CNTRMST"));
			sql.setString(++i, strVenCd);
			sql.setString(++i, strRentType);
			sql.setString(++i, strRentFlag);
			sql.setString(++i, strCntrType);
			sql.setString(++i, strFlcFlag);
			
			// 1:계약시작일, 2:계약종료일
			if (strIOFlag.equals("1")) {
				sql.put(svc.getQuery("SEL_MR_CNTRMST_WHERE_SDT"));
				sql.setString(++i, strSdt);
				sql.setString(++i, strEdt);
			} else if (strIOFlag.equals("2")) {
				sql.put(svc.getQuery("SEL_MR_CNTRMST_WHERE_EDT"));
				sql.setString(++i, strSdt);
				sql.setString(++i, strEdt);
			}
			// 현거주여부
			if (strStayNow.equals("Y")) {
				sql.put(svc.getQuery("SEL_MR_CNTRMST_WHERE_STAY_NOW"));
			}

			sql.put(svc.getQuery("SEL_MR_CNTRMST_ORDER_BY"));
			list = select2List(sql);
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	/**
	 * <p>
	 * 계약마스터관리 저장
	 * </p>
	 */
	public int save(ActionForm form, MultiInput mi, String userID)
			throws Exception {
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;

		FileControlMgr fileMgr	= null;
		try {
			connect("pot");
			begin(); // DB트렌젝션 시작
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			fileMgr = new FileControlMgr();
			while (mi.next()) {
				sql.close();
				
				if (mi.IS_INSERT()) {
					int i = 0;
					if (mi.getString("CNTR_ID").equals("")) { //신규(계약ID가 빈값일 경우)
						//신규계약번호 발번
												
						sql.close();
				        sql.put(svc.getQuery("SEL_GET_NEW_CNTR_ID"));        
						Map mapCntrId = (Map)selectMap(sql);
						String strCntrId = mapCntrId.get("CNTR_ID").toString();		
						
						//DB저장경로
						//08.02
						String db_file_path = "";
						if (mi.getString("FILE_GB").equals("Y")) {
							db_file_path = fileMgr.fileReNameDB(mi.getString("FILE_PATH"), strCntrId);
						} else {
							db_file_path = "";
						}
						
						System.out.println(db_file_path + "INSERT");
						
						//계약마스터 등록
						sql.close();						
						sql.put(svc.getQuery("INS_MR_CNTRMST"));
						i = 0;
						sql.setString(++i, strCntrId);
						sql.setString(++i, strCntrId);	//원계약ID : ORG_CNTR_ID
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, mi.getString("VEN_CD"));
						sql.setString(++i, mi.getString("BELONG_STR_CD"));
						sql.setString(++i, mi.getString("CHAR_NAME"));
						sql.setString(++i, mi.getString("PHONE1_NO"));
						sql.setString(++i, mi.getString("PHONE2_NO"));
						sql.setString(++i, mi.getString("PHONE3_NO"));
						sql.setString(++i, mi.getString("CNTR_TYPE"));
						sql.setString(++i, mi.getString("SAP_CNTR_ID"));
						sql.setString(++i, mi.getString("CNTR_S_DT"));
						sql.setString(++i, mi.getString("CNTR_E_DT"));
						sql.setString(++i, mi.getString("RENT_TYPE"));
						sql.setString(++i, mi.getString("RENT_FLAG"));
						sql.setString(++i, mi.getString("CNTR_AREA"));
						sql.setString(++i, mi.getString("RENT_DEPOSIT"));
						sql.setDouble(++i, mi.getDouble("EXCL_AREA"));
						sql.setString(++i, mi.getString("MM_RENTFEE_NOVAT"));
						sql.setDouble(++i, mi.getDouble("SHR_AREA"));
						sql.setString(++i, mi.getString("MM_RENTFEE_VAT"));
						sql.setString(++i, mi.getString("DONG"));
						sql.setString(++i, mi.getString("FLOOR_FLAG"));
						sql.setString(++i, mi.getString("HO"));
						System.out.println(mi.getString("HO"));
						sql.setString(++i, mi.getString("MM_RENTFEE"));
						//sql.setString(++i, mi.getString("FILE_PATH"));						
						sql.setString(++i, db_file_path);
						
						sql.setString(++i, mi.getString("FCL_TYPE"));
						sql.setString(++i, mi.getString("MNTN_CAL_YN"));
						sql.setString(++i, mi.getString("CHRG_YN"));
						sql.setString(++i, mi.getString("ARR_CAL_YN"));
						sql.setString(++i, mi.getString("ARR_RATE"));
						sql.setString(++i, mi.getString("PAY_TERM_TYPE"));
						sql.setString(++i, mi.getString("PAY_TERM_DD"));
						sql.setString(++i, mi.getString("OFFICE_PAY_AMT"));
						sql.setString(++i, mi.getString("RENT_CAL_YN"));
						sql.setString(++i, mi.getString("RENT_ARR_CAL_YN"));
						sql.setString(++i, mi.getString("RENT_ARR_RATE"));
						sql.setString(++i, mi.getString("RENT_PAY_TERM_TYPE"));
						sql.setString(++i, mi.getString("RENT_PAY_TERM_DD"));						
						
						//sql.setString(++i, mi.getString("PWR_KIND_CD"));
						//sql.setString(++i, mi.getString("PWR_TYPE"));
						//sql.setString(++i, mi.getString("PWR_SEL_CHARGE"));
						//sql.setDouble(++i, mi.getDouble("PWR_CNTR_QTY"));
						//sql.setDouble(++i, mi.getDouble("PWR_REVER_RATE"));
						//sql.setString(++i, mi.getString("WWTR_KIND_CD"));
						//sql.setDouble(++i, mi.getDouble("WWTR_QTY"));
						//sql.setString(++i, mi.getString("WWTR_CHARGE_YN"));
						//sql.setString(++i, mi.getString("STM_KIND_CD"));
						//sql.setDouble(++i, mi.getDouble("STM_QTY"));
						//sql.setString(++i, mi.getString("CWTR_KIND_CD"));
						//sql.setDouble(++i, mi.getDouble("CWTR_QTY"));
						//sql.setString(++i, mi.getString("GAS_KIND_CD"));
						//sql.setString(++i, mi.getString("GAS_REDU_TYPE"));
						//sql.setString(++i, mi.getString("WTR_KIND_CD"));
						//sql.setDouble(++i, mi.getDouble("DIV_RATE"));
						//sql.setDouble(++i, mi.getDouble("TV_CNT"));
						//sql.setString(++i, mi.getString("WTR_CAL_SIZE"));
						//sql.setString(++i, mi.getString("REMARK"));
						sql.setString(++i, userID);
						sql.setString(++i, userID);						
						res = update(sql);						
						//이력등록
						sql.close();
						sql.put(svc.getQuery("INS_MR_CNTRHST"));
						i = 0;
						sql.setString(++i, strCntrId);
						sql.setString(++i, mi.getString("CNTR_TYPE"));
						sql.setString(++i, userID);
						sql.setString(++i, userID);
						sql.setString(++i, strCntrId);
						res = update(sql);	
						
						//파일컨트롤
                		addFileContlor(mi, strCntrId);
					} else { // 파일변경으로 일어난 INSERT
						//DB저장경로
						/*08.02*/
						String db_file_path = "";
						if (mi.getString("FILE_GB").equals("Y")) {
							db_file_path = fileMgr.fileReNameDB(mi.getString("FILE_PATH"), mi.getString("CNTR_ID"));
						} else {
							db_file_path = mi.getString("FILE_PATH");
						}
						
						System.out.println(db_file_path + "UPDATE");
						
						//계약정보변경
						sql.close();						
						sql.put(svc.getQuery("UPD_MR_CNTRMST"));
						i = 0;
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, mi.getString("VEN_CD"));
						sql.setString(++i, mi.getString("BELONG_STR_CD"));
						sql.setString(++i, mi.getString("CHAR_NAME"));
						sql.setString(++i, mi.getString("PHONE1_NO"));
						sql.setString(++i, mi.getString("PHONE2_NO"));
						sql.setString(++i, mi.getString("PHONE3_NO"));
						sql.setString(++i, mi.getString("CNTR_TYPE"));
						sql.setString(++i, mi.getString("SAP_CNTR_ID"));
						sql.setString(++i, mi.getString("CNTR_S_DT"));
						sql.setString(++i, mi.getString("CNTR_E_DT"));
						sql.setString(++i, mi.getString("RENT_TYPE"));
						sql.setString(++i, mi.getString("RENT_FLAG"));
						sql.setString(++i, mi.getString("CNTR_AREA"));
						sql.setString(++i, mi.getString("RENT_DEPOSIT"));
						sql.setDouble(++i, mi.getDouble("EXCL_AREA"));
						sql.setString(++i, mi.getString("MM_RENTFEE_NOVAT"));
						sql.setDouble(++i, mi.getDouble("SHR_AREA"));
						sql.setString(++i, mi.getString("MM_RENTFEE_VAT"));
						sql.setString(++i, mi.getString("DONG"));
						sql.setString(++i, mi.getString("FLOOR_FLAG"));
						sql.setString(++i, mi.getString("HO"));
						sql.setString(++i, mi.getString("MM_RENTFEE"));
						//sql.setString(++i, mi.getString("FILE_PATH"));
						sql.setString(++i, db_file_path);
						
						sql.setString(++i, mi.getString("FCL_TYPE"));						
						sql.setString(++i, mi.getString("MNTN_CAL_YN"));
						sql.setString(++i, mi.getString("CHRG_YN"));
						sql.setString(++i, mi.getString("ARR_CAL_YN"));
						sql.setString(++i, mi.getString("ARR_RATE"));
						sql.setString(++i, mi.getString("PAY_TERM_TYPE"));
						sql.setString(++i, mi.getString("PAY_TERM_DD"));
						sql.setString(++i, mi.getString("OFFICE_PAY_AMT"));
						sql.setString(++i, mi.getString("RENT_CAL_YN"));
						sql.setString(++i, mi.getString("RENT_ARR_CAL_YN"));
						sql.setString(++i, mi.getString("RENT_ARR_RATE"));
						sql.setString(++i, mi.getString("RENT_PAY_TERM_TYPE"));
						sql.setString(++i, mi.getString("RENT_PAY_TERM_DD"));						
						
						//sql.setString(++i, mi.getString("PWR_KIND_CD"));
						//sql.setString(++i, mi.getString("PWR_TYPE"));
						//sql.setString(++i, mi.getString("PWR_SEL_CHARGE"));
						//sql.setDouble(++i, mi.getDouble("PWR_CNTR_QTY"));
						//sql.setDouble(++i, mi.getDouble("PWR_REVER_RATE"));
						//sql.setString(++i, mi.getString("WWTR_KIND_CD"));
						//sql.setDouble(++i, mi.getDouble("WWTR_QTY"));
						//sql.setString(++i, mi.getString("WWTR_CHARGE_YN"));
						//sql.setString(++i, mi.getString("STM_KIND_CD"));
						//sql.setDouble(++i, mi.getDouble("STM_QTY"));
						//sql.setString(++i, mi.getString("CWTR_KIND_CD"));
						//sql.setDouble(++i, mi.getDouble("CWTR_QTY"));
						//sql.setString(++i, mi.getString("GAS_KIND_CD"));
						//sql.setString(++i, mi.getString("GAS_REDU_TYPE"));
						//sql.setString(++i, mi.getString("WTR_KIND_CD"));
						//sql.setDouble(++i, mi.getDouble("DIV_RATE"));
						//sql.setDouble(++i, mi.getDouble("TV_CNT"));
						//sql.setString(++i, mi.getString("WTR_CAL_SIZE"));
						//sql.setString(++i, mi.getString("REMARK"));
						sql.setString(++i, userID);
						sql.setString(++i, mi.getString("CNTR_ID"));
						res = update(sql);
						
						//이력등록
						sql.close();
						sql.put(svc.getQuery("INS_MR_CNTRHST"));
						i = 0;
						sql.setString(++i, mi.getString("CNTR_ID"));
						sql.setString(++i, mi.getString("CNTR_TYPE"));
						sql.setString(++i, userID);
						sql.setString(++i, userID);
						sql.setString(++i, mi.getString("CNTR_ID"));
						res = update(sql);
						
						//파일컨트롤
                		addFileContlor(mi, mi.getString("CNTR_ID"));
					}
				} else if (mi.IS_UPDATE()) {					
					int i = 0;
					//CHANGED_FLAG == Y [계약변경]
					if (mi.getString("CHANGED_FLAG").equals("Y")) {
					//if (mi.getString("CNTR_TYPE").equals("03")) {  //계약유형이 03:계약변경
						//이전계약수정
						sql.close();
						sql.put(svc.getQuery("UPD_MR_CNTRMST_CHG"));
						i = 0;
						sql.setString(++i, mi.getString("CNTR_S_DT"));
						sql.setString(++i, mi.getString("CNTR_S_DT"));
						sql.setString(++i, mi.getString("CNTR_S_DT"));
						sql.setString(++i, mi.getString("CNTR_S_DT"));
						sql.setString(++i, userID);
						sql.setString(++i, mi.getString("CNTR_ID"));
						res = update(sql);
						
						//이력등록
						sql.close();
						sql.put(svc.getQuery("INS_MR_CNTRHST"));
						i = 0;
						sql.setString(++i, mi.getString("CNTR_ID"));
						sql.setString(++i, mi.getString("CNTR_TYPE"));
						sql.setString(++i, userID);
						sql.setString(++i, userID);
						sql.setString(++i, mi.getString("CNTR_ID"));
						res = update(sql);
						
						//변경계약번호 발번
						sql.close();
				        sql.put(svc.getQuery("SEL_GET_NEW_CNTR_ID"));        
						Map mapCntrId = (Map)selectMap(sql);
						String strCntrId = mapCntrId.get("CNTR_ID").toString();	
						
						//DB저장경로
						/*08.02*/
						String db_file_path = "";
						if (mi.getString("FILE_GB").equals("Y")) {
							db_file_path = fileMgr.fileReNameDB(mi.getString("FILE_PATH"), strCntrId);
						} else {
							db_file_path = mi.getString("FILE_PATH");
						}
						
						//변경계약등록
						sql.close();
						sql.put(svc.getQuery("INS_MR_CNTRMST"));
						i = 0;
						sql.setString(++i, strCntrId);
						sql.setString(++i, mi.getString("CNTR_ID")); //원계약ID : ORG_CNTR_ID
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, mi.getString("VEN_CD"));
						sql.setString(++i, mi.getString("BELONG_STR_CD"));
						sql.setString(++i, mi.getString("CHAR_NAME"));
						sql.setString(++i, mi.getString("PHONE1_NO"));
						sql.setString(++i, mi.getString("PHONE2_NO"));
						sql.setString(++i, mi.getString("PHONE3_NO"));
						sql.setString(++i, mi.getString("CNTR_TYPE"));
						sql.setString(++i, mi.getString("SAP_CNTR_ID"));
						sql.setString(++i, mi.getString("CNTR_S_DT"));
						sql.setString(++i, mi.getString("CNTR_E_DT"));
						sql.setString(++i, mi.getString("RENT_TYPE"));
						sql.setString(++i, mi.getString("RENT_FLAG"));
						sql.setString(++i, mi.getString("CNTR_AREA"));
						sql.setString(++i, mi.getString("RENT_DEPOSIT"));
						sql.setDouble(++i, mi.getDouble("EXCL_AREA"));
						sql.setString(++i, mi.getString("MM_RENTFEE_NOVAT"));
						sql.setDouble(++i, mi.getDouble("SHR_AREA"));
						sql.setString(++i, mi.getString("MM_RENTFEE_VAT"));
						sql.setString(++i, mi.getString("DONG"));
						sql.setString(++i, mi.getString("FLOOR_FLAG"));
						sql.setString(++i, mi.getString("HO"));
						sql.setString(++i, mi.getString("MM_RENTFEE"));
						//sql.setString(++i, mi.getString("FILE_PATH"));
						sql.setString(++i, db_file_path);
						
						sql.setString(++i, mi.getString("FCL_TYPE"));
						sql.setString(++i, mi.getString("MNTN_CAL_YN"));
						sql.setString(++i, mi.getString("CHRG_YN"));
						sql.setString(++i, mi.getString("ARR_CAL_YN"));
						sql.setString(++i, mi.getString("ARR_RATE"));
						sql.setString(++i, mi.getString("PAY_TERM_TYPE"));
						sql.setString(++i, mi.getString("PAY_TERM_DD"));
						sql.setString(++i, mi.getString("OFFICE_PAY_AMT"));
						sql.setString(++i, mi.getString("RENT_CAL_YN"));
						sql.setString(++i, mi.getString("RENT_ARR_CAL_YN"));
						sql.setString(++i, mi.getString("RENT_ARR_RATE"));
						sql.setString(++i, mi.getString("RENT_PAY_TERM_TYPE"));
						sql.setString(++i, mi.getString("RENT_PAY_TERM_DD"));
						
						//sql.setString(++i, mi.getString("PWR_KIND_CD"));
						//sql.setString(++i, mi.getString("PWR_TYPE"));
						//sql.setString(++i, mi.getString("PWR_SEL_CHARGE"));
						//sql.setDouble(++i, mi.getDouble("PWR_CNTR_QTY"));
						//sql.setDouble(++i, mi.getDouble("PWR_REVER_RATE"));
						//sql.setString(++i, mi.getString("WWTR_KIND_CD"));
						//sql.setDouble(++i, mi.getDouble("WWTR_QTY"));
						//sql.setString(++i, mi.getString("WWTR_CHARGE_YN"));
						//sql.setString(++i, mi.getString("STM_KIND_CD"));
						//sql.setDouble(++i, mi.getDouble("STM_QTY"));
						//sql.setString(++i, mi.getString("CWTR_KIND_CD"));
						//sql.setDouble(++i, mi.getDouble("CWTR_QTY"));
						//sql.setString(++i, mi.getString("GAS_KIND_CD"));
						//sql.setString(++i, mi.getString("GAS_REDU_TYPE"));
						//sql.setString(++i, mi.getString("WTR_KIND_CD"));
						//sql.setDouble(++i, mi.getDouble("DIV_RATE"));
						//sql.setDouble(++i, mi.getDouble("TV_CNT"));
						//sql.setString(++i, mi.getString("WTR_CAL_SIZE"));
						//sql.setString(++i, mi.getString("REMARK"));
						sql.setString(++i, userID);
						sql.setString(++i, userID);
						res = update(sql);
						
						//이력등록
						sql.close();
						sql.put(svc.getQuery("INS_MR_CNTRHST"));
						i = 0;
						sql.setString(++i, strCntrId);
						sql.setString(++i, mi.getString("CNTR_TYPE"));
						sql.setString(++i, userID);
						sql.setString(++i, userID);
						sql.setString(++i, strCntrId);
						res = update(sql);
						
						//임대보증금 입금내역 복사
						sql.close();
						sql.put(svc.getQuery("INS_MR_DEPOSPAY"));
						i = 0;
						sql.setString(++i, strCntrId);
						sql.setString(++i, userID);
						sql.setString(++i, userID);
						sql.setString(++i, mi.getString("CNTR_ID"));
						res = update(sql);
						
						//파일컨트롤
                		addFileContlor(mi, strCntrId);
					} else {
						//DB저장경로
						/*08.02*/
						String db_file_path = "";
						if (mi.getString("FILE_GB").equals("Y")) {
							db_file_path = fileMgr.fileReNameDB(mi.getString("FILE_PATH"), mi.getString("CNTR_ID"));
						} else {
							db_file_path = mi.getString("FILE_PATH");
						}
						
						//계약정보변경
						sql.close();
						sql.put(svc.getQuery("UPD_MR_CNTRMST"));
						i = 0;
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, mi.getString("VEN_CD"));
						sql.setString(++i, mi.getString("BELONG_STR_CD"));
						sql.setString(++i, mi.getString("CHAR_NAME"));
						sql.setString(++i, mi.getString("PHONE1_NO"));
						sql.setString(++i, mi.getString("PHONE2_NO"));
						sql.setString(++i, mi.getString("PHONE3_NO"));
						sql.setString(++i, mi.getString("CNTR_TYPE"));
						sql.setString(++i, mi.getString("SAP_CNTR_ID"));
						sql.setString(++i, mi.getString("CNTR_S_DT"));
						sql.setString(++i, mi.getString("CNTR_E_DT"));
						sql.setString(++i, mi.getString("RENT_TYPE"));
						sql.setString(++i, mi.getString("RENT_FLAG"));
						sql.setString(++i, mi.getString("CNTR_AREA"));
						sql.setString(++i, mi.getString("RENT_DEPOSIT"));
						sql.setDouble(++i, mi.getDouble("EXCL_AREA"));
						sql.setString(++i, mi.getString("MM_RENTFEE_NOVAT"));
						sql.setDouble(++i, mi.getDouble("SHR_AREA"));
						sql.setString(++i, mi.getString("MM_RENTFEE_VAT"));
						sql.setString(++i, mi.getString("DONG"));
						sql.setString(++i, mi.getString("FLOOR_FLAG"));
						sql.setString(++i, mi.getString("HO"));
						sql.setString(++i, mi.getString("MM_RENTFEE"));
						//sql.setString(++i, mi.getString("FILE_PATH"));
						sql.setString(++i, db_file_path);
						
						sql.setString(++i, mi.getString("FCL_TYPE"));
						sql.setString(++i, mi.getString("MNTN_CAL_YN"));
						sql.setString(++i, mi.getString("CHRG_YN"));
						sql.setString(++i, mi.getString("ARR_CAL_YN"));
						sql.setString(++i, mi.getString("ARR_RATE"));
						sql.setString(++i, mi.getString("PAY_TERM_TYPE"));
						sql.setString(++i, mi.getString("PAY_TERM_DD"));
						sql.setString(++i, mi.getString("OFFICE_PAY_AMT"));
						sql.setString(++i, mi.getString("RENT_CAL_YN"));
						sql.setString(++i, mi.getString("RENT_ARR_CAL_YN"));
						sql.setString(++i, mi.getString("RENT_ARR_RATE"));
						sql.setString(++i, mi.getString("RENT_PAY_TERM_TYPE"));
						sql.setString(++i, mi.getString("RENT_PAY_TERM_DD"));
						
						//sql.setString(++i, mi.getString("PWR_KIND_CD"));
						//sql.setString(++i, mi.getString("PWR_TYPE"));
						//sql.setString(++i, mi.getString("PWR_SEL_CHARGE"));
						//sql.setDouble(++i, mi.getDouble("PWR_CNTR_QTY"));
						//sql.setDouble(++i, mi.getDouble("PWR_REVER_RATE"));
						//sql.setString(++i, mi.getString("WWTR_KIND_CD"));
						//sql.setDouble(++i, mi.getDouble("WWTR_QTY"));
						//sql.setString(++i, mi.getString("WWTR_CHARGE_YN"));
						//sql.setString(++i, mi.getString("STM_KIND_CD"));
						//sql.setDouble(++i, mi.getDouble("STM_QTY"));
						//sql.setString(++i, mi.getString("CWTR_KIND_CD"));
						//sql.setDouble(++i, mi.getDouble("CWTR_QTY"));
						//sql.setString(++i, mi.getString("GAS_KIND_CD"));
						//sql.setString(++i, mi.getString("GAS_REDU_TYPE"));
						//sql.setString(++i, mi.getString("WTR_KIND_CD"));
						//sql.setDouble(++i, mi.getDouble("DIV_RATE"));
						//sql.setDouble(++i, mi.getDouble("TV_CNT"));
						//sql.setString(++i, mi.getString("WTR_CAL_SIZE"));
						//sql.setString(++i, mi.getString("REMARK"));
						sql.setString(++i, userID);
						sql.setString(++i, mi.getString("CNTR_ID"));
						res = update(sql);
						
						//이력등록
						sql.close();
						sql.put(svc.getQuery("INS_MR_CNTRHST"));
						i = 0;
						sql.setString(++i, mi.getString("CNTR_ID"));
						sql.setString(++i, mi.getString("CNTR_TYPE"));
						sql.setString(++i, userID);
						sql.setString(++i, userID);
						sql.setString(++i, mi.getString("CNTR_ID"));
						res = update(sql);
						
						//파일컨트롤
                		Boolean retnn = addFileContlor(mi, mi.getString("CNTR_ID"));
                		if (!retnn)  {
                			throw new Exception("" + "첨부파일 저장이 정상적으로 이루어 지지 않았습니다.");
                		}
					}
					
				} 
				ret += res;
			}
		} catch (Exception e) {
			System.out.println(">>>> DAO  : " + e);
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	/**
	 * <p> 파일컨트롤  </p>
	 * @param form, mi, strID
	 * @return ret
	 * @throws Exception
	 */
	public Boolean addFileContlor(MultiInput mi, String strCntrId)
	throws Exception {
        InputStream in 	= null;
        
        FileControlMgr fileMgr	= null;
		try {
			fileMgr = new FileControlMgr();
			in = (InputStream) mi.get("REAL_FILE_PATH");
    		if (mi.getString("FILE_GB").equals("Y")) {
        		Boolean retnn = fileMgr.fileSave(mi.getString("FILE_PATH"), strCntrId, in, mi.getString("OLD_FILE_PATH"), 5);
        		if (!retnn)  {
        			throw new Exception("" + "파일저장이 정상적으로 이루어 지지 않았습니다.");
        		}
    		} else if (mi.getString("FILE_GB").equals("D")) {
        		Boolean retnn = fileMgr.fileDelete(mi.getString("OLD_FILE_PATH"));
        		if (!retnn)  {
        			throw new Exception("" + "파일삭제가 정상적으로 이루어 지지 않았습니다.");
        		}
    		}
    		
		} catch (Exception e) {
			throw e;
		} 
		return true;
	}
	
	/**
	 * 계약변경이력 POPUP - 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getVenInfo(ActionForm form) throws Exception {
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;
		try {
			String strVenCd 	= String2.nvl(form.getParam("strVenCd"));
			String strStrCd	 	= String2.nvl(form.getParam("strStrCd"));
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			connect("pot");
			sql.put(svc.getQuery("SEL_VEN_INFO"));
			sql.setString(i++, strVenCd);
			sql.setString(i++, strStrCd);

			list = select2List(sql);
		} catch (Exception e) {
			throw e;
		} 
		return list;
	}
	
	/**
	 * 계약변경이력 POPUP - 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMrenStory(ActionForm form) throws Exception {
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;
		try {
			String strCntrId	 	= String2.nvl(form.getParam("strCntrId"));
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			connect("pot");
			sql.put(svc.getQuery("SEL_MASTER_SELECT"));
			sql.setString(i++, strCntrId);

			list = select2List(sql);
		} catch (Exception e) {
			throw e;
		} 
		return list;
	}
}	
