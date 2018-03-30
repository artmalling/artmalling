/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.Util;
/**
 * <p>협력사관리</p>
 * 
 * @created  on 1.0, 2010/02/11
 * @created  by 박종은(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod121DAO extends AbstractDAO {

	/**
	 * 협력사 마스터을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		// MARIO OUTLET START
		//String strBuySaleFlag   = String2.nvl(form.getParam("strBuySaleFlag"));
		// MARIO OUTLET END
		String strCompFlag      = String2.nvl(form.getParam("strCompFlag"));
		String strCompNo      	= String2.nvl(form.getParam("strCompNo"));
		String strBizType       = String2.nvl(form.getParam("strBizType"));
		String strVenCd         = String2.nvl(form.getParam("strVenCd"));
		String strRepVenCd      = String2.nvl(form.getParam("strRepVenCd"));
		// MARIO OUTLET START
		//String strAccCd         = String2.nvl(form.getParam("strAccCd"));
		//String strAccCd2        = String2.nvl(form.getParam("strAccCd2"));
		// MARIO OUTLET END
		String strUseYN         = String2.nvl(form.getParam("strUseYN"));
		String strVenName       = URLDecoder.decode(String2.nvl(form.getParam("strVenName")), "UTF-8");
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		// MARIO OUTLET START
		//sql.setString(i++, strBuySaleFlag);
		// MARIO OUTLET END
		sql.setString(i++, strCompFlag);
		sql.setString(i++, strCompNo);
		sql.setString(i++, strBizType);
		sql.setString(i++, strVenCd);
		sql.setString(i++, strRepVenCd);
		// MARIO OUTLET START
		//sql.setString(i++, strAccCd);
		//sql.setString(i++, strAccCd2);
		// MARIO OUTLET END
		sql.setString(i++, strUseYN);
		sql.setString(i++, strVenName);

		strQuery = svc.getQuery("SEL_VENMST");

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 점별협력사를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form) throws Exception {

		List ret = null;
		Util util = new Util();
	
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strVenCd = String2.nvl(form.getParam("strVenCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strVenCd);

		strQuery = svc.getQuery("SEL_STRVENMST");
		sql.put(strQuery);


		ret = select2List(sql);
		return ret;
	}

	/**
	 * 협력사담당자를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail2(ActionForm form) throws Exception {

		List ret = null;
		Util util = new Util();
	
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strVenCd = String2.nvl(form.getParam("strVenCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strVenCd);

		strQuery = svc.getQuery("SEL_VENEMP");
		sql.put(strQuery);


		ret = select2List(sql);
		return ret;
	}
	/**
	 * 혐력사 담당자 중 EDI 담당자 수를 조회한다.
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public Map getRegVenEDICharCnt(ActionForm form) throws Exception{
		Map map = null;

		SqlWrapper sql = null;
		Service svc = null;

		String strVenCd = String2.nvl(form.getParam("strVenCd"));
		
		if(strVenCd.equals(""))
			return map;
		int i = 0;
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(++i, strVenCd);
		sql.setString(++i, strVenCd);

		sql.put(svc.getQuery("SEL_EDI_VENEMP_CNT"));
		
		map = selectMap(sql);
		
		return map;
	}
	
	/**
	 * 사업자정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCompinfo(ActionForm form) throws Exception {

		List ret = null;
		Util util = new Util();
	
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strCompNo = String2.nvl(form.getParam("strCompNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strCompNo);

		strQuery = svc.getQuery("SEL_COMP_INFO");
		sql.put(strQuery);


		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 협력사 마스터, 점별 협력사, 협력사담당자   저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi[]
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strID)
			throws Exception {

		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		String newVenCD = "";
		String newSeqNo = "";


		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi[0].next()) {//DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
				sql.close();
				if (mi[0].IS_INSERT()) {
					
                    //협력사코드생성
					sql.close();
					sql.put(svc.getQuery("SEL_VEN_NEW_CD"));
					
					sql.setString(1, mi[0].getString("BIZ_TYPE"));	
					sql.setString(2, mi[0].getString("BIZ_TYPE"));
					
					Map map = selectMap( sql );
					
					newVenCD = String2.nvl((String)map.get("VEN_CD"));

					if( newVenCD.equals("")) {
						throw new Exception("[USER]"+"협력사코드가 존재하지 않아" + ""
								+ "데이터 입력을 하지 못했습니다.");
					}
                    
					
					sql.close();
					sql.put(svc.getQuery("INS_VENMST"));
					
					sql.setString(1, newVenCD);	
					sql.setString(2, mi[0].getString("VEN_NAME"));
					sql.setString(3, mi[0].getString("VEN_SHORT_NAME"));					
					sql.setString(4, mi[0].getString("BUY_SALE_FLAG"));
					sql.setString(5, mi[0].getString("BIZ_TYPE"));		
					sql.setString(6, mi[0].getString("BIZ_FLAG"));		
					sql.setString(7, mi[0].getString("BUY_ACC_VEN_CD"));		
					sql.setString(8, mi[0].getString("SALE_ACC_VEN_CD"));
					if (mi[0].getString("REP_VEN_CD").equals("")){
						sql.setString(9, newVenCD);	
					}
					else{
						sql.setString(9, mi[0].getString("REP_VEN_CD"));	
					}
					sql.setString(10, mi[0].getString("COMP_FLAG"));		
					sql.setString(11, mi[0].getString("ETAX_ISSUE_FLAG"));
					sql.setString(12, mi[0].getString("RVS_ISSUE_FLAG"));
					sql.setString(13, mi[0].getString("OCOMP_TAX_ID"));		
					sql.setString(14, mi[0].getString("USE_YN"));		
					sql.setString(15, mi[0].getString("BIZ_S_DT"));		
					sql.setString(16, mi[0].getString("BIZ_E_DT"));		
					sql.setString(17, mi[0].getString("COMP_NO"));		
					sql.setString(18, mi[0].getString("CORP_NO"));		
					sql.setString(19, mi[0].getString("COMP_NAME"));		
					sql.setString(20, mi[0].getString("REP_NAME"));
					sql.setString(21, mi[0].getString("BIZ_STAT"));		
					sql.setString(22, mi[0].getString("BIZ_CAT"));		
					sql.setString(23, mi[0].getString("POST_NO"));		
					sql.setString(24, mi[0].getString("ADDR"));		
					sql.setString(25, mi[0].getString("DTL_ADDR"));		
					sql.setString(26, mi[0].getString("PHONE1_NO"));		
					sql.setString(27, mi[0].getString("PHONE2_NO"));		
					sql.setString(28, mi[0].getString("PHONE3_NO"));		
					sql.setString(29, mi[0].getString("FAX1_NO"));		
					sql.setString(30, mi[0].getString("FAX2_NO"));		
					sql.setString(31, mi[0].getString("FAX3_NO"));
					sql.setString(32, strID);
					sql.setString(33, strID);	
					sql.setString(34, mi[0].getString("SAP_DEL_FLAG"));
					sql.setString(35, mi[0].getString("SAP_IF_DATE"));
					
					res = update(sql);
					ret += res;
					//변경이력의 seqno 구해오기
					sql.close();
					sql.put(svc.getQuery("SEL_VEN_SEQNO"));
					
					sql.setString(1, newVenCD);	
					
					Map map1 = selectMap( sql );
					
					newSeqNo = String2.nvl((String)map1.get("MOD_SEQ"));
					
					sql.close();
					sql.put(svc.getQuery("INS_VENHIST"));
					
					sql.setString(1, newVenCD);	
					sql.setString(2, mi[0].getString("VEN_NAME"));
					sql.setString(3, mi[0].getString("VEN_SHORT_NAME"));					
					sql.setString(4, mi[0].getString("BUY_SALE_FLAG"));
					sql.setString(5, mi[0].getString("BIZ_TYPE"));		
					sql.setString(6, mi[0].getString("BIZ_FLAG"));		
					sql.setString(7, mi[0].getString("BUY_ACC_VEN_CD"));		
					sql.setString(8, mi[0].getString("SALE_ACC_VEN_CD"));
					if (mi[0].getString("REP_VEN_CD").equals("")){
						sql.setString(9, newVenCD);	
					}
					else{
						sql.setString(9, mi[0].getString("REP_VEN_CD"));	
					}
					sql.setString(10, mi[0].getString("COMP_FLAG"));		
					sql.setString(11, mi[0].getString("ETAX_ISSUE_FLAG"));
					sql.setString(12, mi[0].getString("RVS_ISSUE_FLAG"));
					sql.setString(13, mi[0].getString("OCOMP_TAX_ID"));		
					sql.setString(14, mi[0].getString("USE_YN"));		
					sql.setString(15, mi[0].getString("BIZ_S_DT"));		
					sql.setString(16, mi[0].getString("BIZ_E_DT"));		
					sql.setString(17, mi[0].getString("COMP_NO"));		
					sql.setString(18, mi[0].getString("CORP_NO"));		
					sql.setString(19, mi[0].getString("COMP_NAME"));		
					sql.setString(20, mi[0].getString("REP_NAME"));
					sql.setString(21, mi[0].getString("BIZ_STAT"));		
					sql.setString(22, mi[0].getString("BIZ_CAT"));		
					sql.setString(23, mi[0].getString("POST_NO"));		
					sql.setString(24, mi[0].getString("ADDR"));		
					sql.setString(25, mi[0].getString("DTL_ADDR"));		
					sql.setString(26, mi[0].getString("PHONE1_NO"));		
					sql.setString(27, mi[0].getString("PHONE2_NO"));		
					sql.setString(28, mi[0].getString("PHONE3_NO"));		
					sql.setString(29, mi[0].getString("FAX1_NO"));		
					sql.setString(30, mi[0].getString("FAX2_NO"));		
					sql.setString(31, mi[0].getString("FAX3_NO"));
					sql.setString(32, strID);
					sql.setString(33, newSeqNo);
					sql.setString(34, mi[0].getString("SAP_DEL_FLAG"));
					sql.setString(35, mi[0].getString("SAP_IF_DATE"));
					
					res = update(sql);
					

				} else if (mi[0].IS_UPDATE()) {
					
					
					// MARIO OUTLET 2011.10.04
					if( mi[0].getString("USE_YN").equals("N")){

						sql.close();
						sql.put(svc.getQuery("SEL_STRVENMST_USED"));
						sql.setString(1, mi[0].getString("VEN_CD"));

						List list = select2List( sql );

						if( list.size() > 0 ) {
							throw new Exception("[USER]" + "점별 협력사관리에서 사용중인 협력사코드입니다."
									+ "점별 협력사 사용여부를 NO로 변경 저장한 후 협력사의 사용여부를 변경하십시요.");
						}
						
						sql.close();
						sql.put(svc.getQuery("SEL_PBNMST_USED"));
						sql.setString(1, mi[0].getString("VEN_CD"));

						List list2 = select2List( sql );

						if( list2.size() > 0 ) {
							throw new Exception("[USER]" + "품번 관리에서 사용중인 협력사코드입니다."
									+ "품번 사용여부를 NO로 변경 저장한 후 협력사의 사용여부를 변경하십시요.");
						}
						
						
						sql.close();
						sql.put(svc.getQuery("SEL_STRPBN_USED"));
						sql.setString(1, mi[0].getString("VEN_CD"));

						List list3 = select2List( sql );

						if( list3.size() > 0 ) {
							throw new Exception("[USER]" + "점별품번관리에서 사용중인 협력사코드입니다."
									+ "점별 품번 사용여부를 NO로 변경 저장한 후 협력사의 사용여부를 변경하십시요.");
						}
					}
					// MARIO OUTLET 2011.10.04
					
					sql.close();
					sql.put(svc.getQuery("UPD_VENMST"));
					
					sql.setString(1, mi[0].getString("VEN_NAME"));
					sql.setString(2, mi[0].getString("VEN_SHORT_NAME"));					
					sql.setString(3, mi[0].getString("REP_VEN_CD"));					
					sql.setString(4, mi[0].getString("COMP_FLAG"));					
					sql.setString(5, mi[0].getString("ETAX_ISSUE_FLAG"));					
					sql.setString(6, mi[0].getString("RVS_ISSUE_FLAG"));					
					sql.setString(7, mi[0].getString("OCOMP_TAX_ID"));					
					sql.setString(8, mi[0].getString("USE_YN"));					
					sql.setString(9, mi[0].getString("BIZ_S_DT"));					
					sql.setString(10, mi[0].getString("BIZ_E_DT"));					
					sql.setString(11, mi[0].getString("COMP_NAME"));					
					sql.setString(12, mi[0].getString("REP_NAME"));					
					sql.setString(13, mi[0].getString("BIZ_STAT"));					
					sql.setString(14, mi[0].getString("BIZ_CAT"));					
					sql.setString(15, mi[0].getString("POST_NO"));					
					sql.setString(16, mi[0].getString("ADDR"));					
					sql.setString(17, mi[0].getString("DTL_ADDR"));					
					sql.setString(18, mi[0].getString("PHONE1_NO"));					
					sql.setString(19, mi[0].getString("PHONE2_NO"));					
					sql.setString(20, mi[0].getString("PHONE3_NO"));					
					sql.setString(21, mi[0].getString("FAX1_NO"));					
					sql.setString(22, mi[0].getString("FAX2_NO"));					
					sql.setString(23, mi[0].getString("FAX3_NO"));			
					
					sql.setString(24, mi[0].getString("COMP_NO"));		
					sql.setString(25, mi[0].getString("CORP_NO"));	
					
					sql.setString(26, mi[0].getString("BUY_ACC_VEN_CD"));				
					sql.setString(27, mi[0].getString("SALE_ACC_VEN_CD"));
					sql.setString(28, strID);
					sql.setString(29, mi[0].getString("VEN_CD"));
					    
					
					res = update(sql);
					
					ret += res;
                    //변경이력의 seqno 구해오기
					sql.close();
					sql.put(svc.getQuery("SEL_VEN_SEQNO"));
					
					sql.setString(1, mi[0].getString("VEN_CD"));	
					
					Map map1 = selectMap( sql );
					
					newSeqNo = String2.nvl((String)map1.get("MOD_SEQ"));
					

					sql.close();
					sql.put(svc.getQuery("INS_VENHIST"));
					
					sql.setString(1, mi[0].getString("VEN_CD"));	
					sql.setString(2, mi[0].getString("VEN_NAME"));
					sql.setString(3, mi[0].getString("VEN_SHORT_NAME"));					
					sql.setString(4, mi[0].getString("BUY_SALE_FLAG"));
					sql.setString(5, mi[0].getString("BIZ_TYPE"));		
					sql.setString(6, mi[0].getString("BIZ_FLAG"));		
					sql.setString(7, mi[0].getString("BUY_ACC_VEN_CD"));		
					sql.setString(8, mi[0].getString("SALE_ACC_VEN_CD"));
					sql.setString(9, mi[0].getString("REP_VEN_CD"));	
					sql.setString(10, mi[0].getString("COMP_FLAG"));		
					sql.setString(11, mi[0].getString("ETAX_ISSUE_FLAG"));
					sql.setString(12, mi[0].getString("RVS_ISSUE_FLAG"));
					sql.setString(13, mi[0].getString("OCOMP_TAX_ID"));		
					sql.setString(14, mi[0].getString("USE_YN"));		
					sql.setString(15, mi[0].getString("BIZ_S_DT"));		
					sql.setString(16, mi[0].getString("BIZ_E_DT"));		
					sql.setString(17, mi[0].getString("COMP_NO"));		
					sql.setString(18, mi[0].getString("CORP_NO"));		
					sql.setString(19, mi[0].getString("COMP_NAME"));		
					sql.setString(20, mi[0].getString("REP_NAME"));
					sql.setString(21, mi[0].getString("BIZ_STAT"));		
					sql.setString(22, mi[0].getString("BIZ_CAT"));		
					sql.setString(23, mi[0].getString("POST_NO"));		
					sql.setString(24, mi[0].getString("ADDR"));		
					sql.setString(25, mi[0].getString("DTL_ADDR"));		
					sql.setString(26, mi[0].getString("PHONE1_NO"));		
					sql.setString(27, mi[0].getString("PHONE2_NO"));		
					sql.setString(28, mi[0].getString("PHONE3_NO"));		
					sql.setString(29, mi[0].getString("FAX1_NO"));		
					sql.setString(30, mi[0].getString("FAX2_NO"));		
					sql.setString(31, mi[0].getString("FAX3_NO"));
					sql.setString(32, strID);
					sql.setString(33, newSeqNo);
					sql.setString(34, mi[0].getString("SAP_DEL_FLAG"));
					sql.setString(35, mi[0].getString("SAP_IF_DATE"));
					
					res = update(sql);
				} 
			}
			
			//점별협력사정보 등록
			while (mi[1].next()) {//DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
				sql.close();
				if (mi[1].IS_INSERT()) {
					int i =0;
					sql.close();
					sql.put(svc.getQuery("INS_STRVENMST"));
					
					sql.setString(++i, mi[1].getString("VEN_CD"));
					sql.setString(++i, mi[1].getString("STR_CD"));
					sql.setString(++i, mi[1].getString("PAY_CYC"));					
					sql.setString(++i, mi[1].getString("SBNS_CAL_RATE"));	
					sql.setString(++i, mi[1].getString("PAY_DT_FLAG"));
					sql.setString(++i, mi[1].getString("PAY_WAY"));		
					sql.setString(++i, mi[1].getString("PAY_HOLI_FLAG"));		
					sql.setString(++i, mi[1].getString("ROUND_FLAG"));		
					sql.setString(++i, mi[1].getString("POS_CAL_FLAG"));		
					sql.setString(++i, mi[1].getString("BANK_CD"));		
					sql.setString(++i, mi[1].getString("BANK_ACC_NO"));		
					sql.setString(++i, mi[1].getString("ACC_NO_OWN"));		
					
					
					
					sql.setString(++i, mi[1].getString("USE_YN"));		
					sql.setString(++i, mi[1].getString("BIZ_S_DT"));		
					sql.setString(++i, mi[1].getString("BIZ_E_DT"));
					sql.setString(++i, strID);
					sql.setString(++i, mi[1].getString("TAX_ITG_ISSUE_FLAG"));
					sql.setString(++i, mi[1].getString("EDI_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, mi[1].getString("VEN_NAME"));
					sql.setString(++i, mi[1].getString("VEN_SHORT_NAME"));
					sql.setString(++i, mi[1].getString("BIZ_TYPE"));
					sql.setString(++i, mi[1].getString("BIZ_FLAG"));

					sql.setString(++i, mi[1].getString("MNTN_CHRG_FLAG"));
					sql.setString(++i, mi[1].getString("CARD_FEE_CHRG"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_1"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_1"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_1"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_2"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_2"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_2"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_3"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_3"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_3"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_4"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_4"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_4"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_5"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_5"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_5"));
					
					sql.setString(++i, mi[1].getString("ACC_VEN_CD"));
					
					res = update(sql);
					ret += res;
                    //변경이력의 seqno 구해오기
					sql.close();
					sql.put(svc.getQuery("SEL_STRVEN_SEQNO"));
					
					sql.setString(1, mi[1].getString("VEN_CD"));	
					sql.setString(2, mi[1].getString("STR_CD"));
					
					Map map1 = selectMap( sql );
					
					newSeqNo = String2.nvl((String)map1.get("MOD_SEQ"));

					sql.close();
					sql.put(svc.getQuery("INS_STRVENHIST"));
					
					i =0;
					
					sql.setString(++i, mi[1].getString("VEN_CD"));
					sql.setString(++i, mi[1].getString("STR_CD"));
					sql.setString(++i, mi[1].getString("PAY_CYC"));					
					sql.setString(++i, mi[1].getString("SBNS_CAL_RATE"));	
					sql.setString(++i, mi[1].getString("PAY_DT_FLAG"));
					sql.setString(++i, mi[1].getString("PAY_WAY"));		
					sql.setString(++i, mi[1].getString("PAY_HOLI_FLAG"));		
					sql.setString(++i, mi[1].getString("ROUND_FLAG"));		
					sql.setString(++i, mi[1].getString("POS_CAL_FLAG"));		
					sql.setString(++i, mi[1].getString("BANK_CD"));		
					sql.setString(++i, mi[1].getString("BANK_ACC_NO"));		
					sql.setString(++i, mi[1].getString("ACC_NO_OWN"));		
							
							
							
					sql.setString(++i, mi[1].getString("USE_YN"));		
					sql.setString(++i, mi[1].getString("BIZ_S_DT"));		
					sql.setString(++i, mi[1].getString("BIZ_E_DT"));
					sql.setString(++i, strID);
					sql.setString(++i, mi[1].getString("TAX_ITG_ISSUE_FLAG"));
					sql.setString(++i, mi[1].getString("EDI_YN"));
					sql.setString(++i, newSeqNo);
					sql.setString(++i, mi[1].getString("VEN_NAME"));
					sql.setString(++i, mi[1].getString("VEN_SHORT_NAME"));
					sql.setString(++i, mi[1].getString("BIZ_TYPE"));
					sql.setString(++i, mi[1].getString("BIZ_FLAG"));

					sql.setString(++i, mi[1].getString("MNTN_CHRG_FLAG"));
					sql.setString(++i, mi[1].getString("CARD_FEE_CHRG"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_1"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_1"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_1"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_2"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_2"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_2"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_3"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_3"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_3"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_4"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_4"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_4"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_5"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_5"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_5"));
					
					res = update(sql);


				} else if (mi[1].IS_UPDATE()) {
					
					
					// MARIO OUTLET 2011.10.04
					if( mi[1].getString("USE_YN").equals("N")){

						sql.close();
						sql.put(svc.getQuery("SEL_STRPBN_USED"));
						sql.setString(1, mi[1].getString("VEN_CD"));

						List list = select2List( sql );

						if( list.size() > 0 ) {
							throw new Exception("[USER]" + "점별품번관리에서 사용중인 협력사코드입니다."
									+ "점별 품번 사용여부를 NO로 변경 저장한 후 협력사의 사용여부를 변경하십시요.");
						}
					}
					
					if (mi[1].getString("USE_YN").equals("Y")) {
						sql.close();
						sql.put(svc.getQuery("SEL_VENMST_NOTUSED"));
						sql.setString(1, mi[1].getString("VEN_CD"));

						List list2 = select2List( sql );

						if( list2.size() > 0 ) {
							throw new Exception("[USER]" + "협력사관리에서 사용여부 NO인 협력사입니다."
									+ "협력사의 사용여부를 YES로 변경 저장한 후 점별 협력사의 사용여부를 변경하십시요.");
						}
					}
					// MARIO OUTLET 2011.10.04
					
					sql.close();
					sql.put(svc.getQuery("UPD_STRVENMST"));
					
					int i=0;
					sql.setString(++i, mi[1].getString("PAY_HOLI_FLAG"));
					sql.setString(++i, mi[1].getString("ROUND_FLAG"));					
					sql.setString(++i, mi[1].getString("BANK_CD"));					
					sql.setString(++i, mi[1].getString("BANK_ACC_NO"));					
					sql.setString(++i, mi[1].getString("ACC_NO_OWN"));					
					sql.setString(++i, mi[1].getString("EDI_YN"));					
					sql.setString(++i, mi[1].getString("USE_YN"));					
					sql.setString(++i, mi[1].getString("BIZ_S_DT"));					
					sql.setString(++i, mi[1].getString("BIZ_E_DT"));
					sql.setString(++i, mi[1].getString("SBNS_CAL_RATE"));	
					sql.setString(++i, strID);
					sql.setString(++i, mi[1].getString("PAY_WAY"));	
					sql.setString(++i, mi[1].getString("TAX_ITG_ISSUE_FLAG"));
					sql.setString(++i, mi[1].getString("VEN_NAME"));
					sql.setString(++i, mi[1].getString("VEN_SHORT_NAME"));
					sql.setString(++i, mi[1].getString("BIZ_TYPE"));
					sql.setString(++i, mi[1].getString("BIZ_FLAG"));

					sql.setString(++i, mi[1].getString("MNTN_CHRG_FLAG"));
					sql.setString(++i, mi[1].getString("CARD_FEE_CHRG"));
					sql.setString(++i, mi[1].getString("DZ_SLP_FLAG"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_1"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_1"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_1"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_2"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_2"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_2"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_3"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_3"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_3"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_4"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_4"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_4"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_5"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_5"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_5"));
					
					sql.setString(++i, mi[1].getString("ACC_VEN_CD"));
					
					sql.setString(++i, mi[1].getString("VEN_CD"));
					sql.setString(++i, mi[1].getString("STR_CD"));
					
					res = update(sql);
					ret += res;
                    //변경이력의 seqno 구해오기
					sql.close();
					sql.put(svc.getQuery("SEL_STRVEN_SEQNO"));
					
					sql.setString(1, mi[1].getString("VEN_CD"));	
					sql.setString(2, mi[1].getString("STR_CD"));
					
					Map map1 = selectMap( sql );
					
					newSeqNo = String2.nvl((String)map1.get("MOD_SEQ"));

					sql.close();
					sql.put(svc.getQuery("INS_STRVENHIST"));
					
					i=0;
					
					sql.setString(++i, mi[1].getString("VEN_CD"));
					sql.setString(++i, mi[1].getString("STR_CD"));
					sql.setString(++i, mi[1].getString("PAY_CYC"));					
					sql.setString(++i, mi[1].getString("SBNS_CAL_RATE"));	
					sql.setString(++i, mi[1].getString("PAY_DT_FLAG"));
					sql.setString(++i, mi[1].getString("PAY_WAY"));		
					sql.setString(++i, mi[1].getString("PAY_HOLI_FLAG"));		
					sql.setString(++i, mi[1].getString("ROUND_FLAG"));		
					sql.setString(++i, mi[1].getString("POS_CAL_FLAG"));		
					sql.setString(++i, mi[1].getString("BANK_CD"));		
					sql.setString(++i, mi[1].getString("BANK_ACC_NO"));		
					sql.setString(++i, mi[1].getString("ACC_NO_OWN"));		
							
							
							
					sql.setString(++i, mi[1].getString("USE_YN"));		
					sql.setString(++i, mi[1].getString("BIZ_S_DT"));		
					sql.setString(++i, mi[1].getString("BIZ_E_DT"));
					sql.setString(++i, strID);
					sql.setString(++i, mi[1].getString("TAX_ITG_ISSUE_FLAG"));
					sql.setString(++i, mi[1].getString("EDI_YN"));
					sql.setString(++i, newSeqNo);
					sql.setString(++i, mi[1].getString("VEN_NAME"));
					sql.setString(++i, mi[1].getString("VEN_SHORT_NAME"));
					sql.setString(++i, mi[1].getString("BIZ_TYPE"));
					sql.setString(++i, mi[1].getString("BIZ_FLAG"));

					sql.setString(++i, mi[1].getString("MNTN_CHRG_FLAG"));
					sql.setString(++i, mi[1].getString("CARD_FEE_CHRG"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_1"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_1"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_1"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_2"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_2"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_2"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_3"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_3"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_3"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_4"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_4"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_4"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEQTY_5"));
					sql.setDouble(++i, mi[1].getDouble("POS_DEPOSIT_5"));
					sql.setDouble(++i, mi[1].getDouble("POS_USEFEE_5"));
					res = update(sql);

				}
			}

			//협력사 담당자 등록
			while (mi[2].next()) {//DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
				sql.close();
				if (mi[2].IS_INSERT()) {
					sql.close();
					sql.put(svc.getQuery("INS_VENEMP"));
					
					if( mi[2].getString("VEN_CD").equals("")) {
						sql.setString(1, newVenCD);
						sql.setString(2, newVenCD);
					}
					else{
						sql.setString(1, mi[2].getString("VEN_CD"));
						sql.setString(2, mi[2].getString("VEN_CD"));
					}
					
					sql.setString(3, mi[2].getString("VEN_TASK_FLAG"));
					sql.setString(4, mi[2].getString("CHAR_NAME"));					
					sql.setString(5, mi[2].getString("PHONE1_NO"));
					sql.setString(6, mi[2].getString("PHONE2_NO"));		
					sql.setString(7, mi[2].getString("PHONE3_NO"));		
					sql.setString(8, mi[2].getString("HP1_NO"));		
					sql.setString(9, mi[2].getString("HP2_NO"));		
					sql.setString(10, mi[2].getString("HP3_NO"));		
					sql.setString(11, mi[2].getString("EMAIL"));		
					sql.setString(12, mi[2].getString("SMEDI_ID"));		
					sql.setString(13, mi[2].getString("USE_YN"));	
					sql.setString(14, strID);
					sql.setString(15, strID);
					res = update(sql);
					ret += res;
				} else if (mi[2].IS_UPDATE()) {
					sql.put(svc.getQuery("UPD_VENEMP"));
					
					sql.setString(1, mi[2].getString("CHAR_NAME"));
					sql.setString(2, mi[2].getString("PHONE1_NO"));					
					sql.setString(3, mi[2].getString("PHONE2_NO"));					
					sql.setString(4, mi[2].getString("PHONE3_NO"));					
					sql.setString(5, mi[2].getString("HP1_NO"));					
					sql.setString(6, mi[2].getString("HP2_NO"));					
					sql.setString(7, mi[2].getString("HP3_NO"));					
					sql.setString(8, mi[2].getString("EMAIL"));					
					sql.setString(9, mi[2].getString("SMEDI_ID"));					
					sql.setString(10, mi[2].getString("USE_YN"));
					sql.setString(11, strID);
					sql.setString(12, mi[2].getString("VEN_CD"));
					sql.setString(13, mi[2].getString("SEQ_NO"));
					res = update(sql);
					ret += res;
				} 
			}
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	

	public int sendvenemg(ActionForm form, String userId)
			throws Exception {

		SqlWrapper sql        = null;
		Service svc           = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		int resp    		  = 0;      //프로시저 리턴값
		
		try {
	
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();
			ProcedureResultSet prs = null;
			
			int i = 1;            
			psql.put("DPS.PR_PCVENPOS_EMG_IFS", 5);
			     
			psql.setString(i++, form.getParam("strProcDt")); 	// 처리일자
            psql.setString(i++, userId);		                // 사용자 
            psql.setString(i++, form.getParam("srtVenCd"));  // 품번           
            
            psql.registerOutParameter(i++, DataTypes.INTEGER);//4
            psql.registerOutParameter(i++, DataTypes.VARCHAR);//5
            //psql.registerOutParameter(i++, DataTypes.VARCHAR);//6

            prs = updateProcedure(psql);
            
            resp += prs.getInt(4);    

            if (resp < 0) {
                throw new Exception("[USER]"+ prs.getString(5));
            }
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return resp;
	}    
	
}
