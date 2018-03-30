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

import common.util.Util;

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
 * <p>POS관리</p>
 * 
 * @created  on 1.0, 2010/02/08
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod801DAO extends AbstractDAO {

	/**
	 * POS 마스터 을 조회한다.
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
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strPosNo = String2.nvl(form.getParam("strPosNo"));
		String strPosName = URLDecoder.decode( String2.nvl(form.getParam("strPosName")), "UTF-8");
		String strShopName = URLDecoder.decode( String2.nvl(form.getParam("strShopName")), "UTF-8");

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_POSMST") + "\n";
		sql.setString(i++, strStrCd);
		
		if( !strPosNo.equals("") ){
			sql.setString(i++, strPosNo);
			strQuery += svc.getQuery("SEL_POSMST_WHERE_POS_NO") + "\n";
		}
		if( !strPosName.equals("") ){
			sql.setString(i++, strPosName);
			strQuery += svc.getQuery("SEL_POSMST_WHERE_POS_NAME") + "\n";
		}
		if( !strShopName.equals("") ){
			sql.setString(i++, strShopName);
			strQuery += svc.getQuery("SEL_POSMST_WHERE_SHOP_NAME") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_POSMST_ORDER") + "\n";
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * POS 마스터,
	 * 저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		
		int i;
		try {
			connect("pot");
			begin();
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				sql.close();				
				if ( mi.IS_INSERT()) {
					
					sql.put(svc.getQuery("SEL_POSMST_POS_NO_CNT"));							
					sql.setString(1,  mi.getString("STR_CD"));								
					sql.setString(2,  mi.getString("POS_NO"));								
					Map map = selectMap( sql );							
					String posCnt = String2.nvl((String)map.get("CNT"));
					if( !posCnt.equals("0")) {
						throw new Exception("[USER]"+"중복되는POS번호 입니다.");
					}
					sql.close();
					i = 0;							
					sql.put(svc.getQuery("INS_POSMST"));
					sql.setString( ++i, mi.getString("STR_CD"            ));
					sql.setString( ++i, mi.getString("POS_NO"            ));
					sql.setString( ++i, mi.getString("SHOP_NAME"         ));
					sql.setString( ++i, mi.getString("EVENT_PLACE_CD"    ));
					sql.setString( ++i, mi.getString("POS_NAME"          ));
					sql.setString( ++i, mi.getString("POS_FLAG"          ));
					sql.setString( ++i, mi.getString("FLOR_CD"           ));
					sql.setString( ++i, mi.getString("HALL_CD"           ));
					sql.setString( ++i, mi.getString("MST_POS_NO"        ));
					sql.setString( ++i, mi.getString("FNB_SHOP_CD"       ));
					sql.setString( ++i, mi.getString("ITEM_REG_TYPE"     ));
					sql.setString( ++i, mi.getString("MIX_REG_YN"        ));
					sql.setString( ++i, mi.getString("POS_IP_ADDR1"      ));
					sql.setString( ++i, mi.getString("MAIN_SRVR_IP_ADDR" ));
					sql.setString( ++i, mi.getString("MAIN_SRVR_PORT_NO" ));
					sql.setString( ++i, mi.getString("BACK_SRVR_IP_ADDR" ));
					sql.setString( ++i, mi.getString("BACK_SRVR_PORT_NO" ));
					sql.setString( ++i, mi.getString("AD_FILE_URL1"      ));
					sql.setString( ++i, mi.getString("AD_FILE_URL2"      ));
					sql.setString( ++i, mi.getString("UPER_MSG_ID"       ));
					sql.setString( ++i, mi.getString("MIDL_MSG_ID"       ));
					sql.setString( ++i, mi.getString("LWER_MSG_ID"       ));
					sql.setString( ++i, mi.getString("CASH_RECP_MSG_ID"  ));
					sql.setString( ++i, mi.getString("PHONE1_NO"         ));
					sql.setString( ++i, mi.getString("PHONE2_NO"         ));
					sql.setString( ++i, mi.getString("PHONE3_NO"         ));
					sql.setString( ++i, mi.getString("RSPNS_NAME"        ));
					sql.setString( ++i, mi.getString("RSPNS_TEL_NO_1"    ));
					sql.setString( ++i, mi.getString("RSPNS_TEL_NO_2"    ));
					sql.setString( ++i, mi.getString("RSPNS_TEL_NO_3"    ));
					sql.setString( ++i, mi.getString("OPTN_01"           ));
					sql.setString( ++i, mi.getString("OPTN_02"           ));
					sql.setString( ++i, mi.getString("OPTN_03"           ));
					sql.setString( ++i, mi.getString("OPTN_04"           ));
					sql.setString( ++i, mi.getString("OPTN_05"           ));
					sql.setString( ++i, mi.getString("OPTN_06"           ));
					sql.setString( ++i, mi.getString("OPTN_07"           ));
					sql.setString( ++i, mi.getString("OPTN_08"           ));
					sql.setString( ++i, mi.getString("OPTN_09"           ));
					sql.setString( ++i, mi.getString("OPTN_10"           ));
					sql.setString( ++i, mi.getString("OPTN_11"           ));
					sql.setString( ++i, mi.getString("OPTN_12"           ));
					sql.setString( ++i, mi.getString("OPTN_13"           ));
					sql.setString( ++i, mi.getString("OPTN_14"           ));
					sql.setString( ++i, mi.getString("OPTN_15"           ));
					sql.setString( ++i, mi.getString("OPTN_16"           ));
					sql.setString( ++i, mi.getString("OPTN_17"           ));
					sql.setString( ++i, mi.getString("OPTN_18"           ));
					sql.setString( ++i, mi.getString("OPTN_19"           ));
					sql.setString( ++i, mi.getString("OPTN_20"           ));
					sql.setString( ++i, mi.getString("OPTN_21_FROM"      ));
					sql.setString( ++i, mi.getString("OPTN_21_TO"        ));
					sql.setString( ++i, mi.getString("OPTN_22"           ));
					sql.setString( ++i, mi.getString("OPTN_23"           ));
					sql.setString( ++i, mi.getString("OPTN_24"           ));
					sql.setString( ++i, mi.getString("OPTN_25"           ));
					sql.setString( ++i, mi.getString("USE_YN"            ));
					sql.setString( ++i, mi.getString("OPTN_26"           ));
					sql.setString( ++i, mi.getString("OPTN_27"           ));
					sql.setString( ++i, mi.getString("OPTN_28"           ));
					sql.setString( ++i, mi.getString("OPTN_29"           ));   
					sql.setString( ++i, mi.getString("OPTN_30"           ));
					sql.setString( ++i, mi.getString("OPTN_31"           ));  
					sql.setString( ++i, mi.getString("OPTN_32"           ));  
					sql.setString( ++i, mi.getString("OPTN_33"           ));  
					sql.setString( ++i, mi.getString("OPTN_34"           ));  
					sql.setString( ++i, mi.getString("OPTN_35"           ));  
					sql.setString( ++i, mi.getString("OPTN_36"           ));  
					sql.setString( ++i, mi.getString("OPTN_37"           ));  
					sql.setString( ++i, mi.getString("OPTN_38"           ));  
					sql.setString( ++i, mi.getString("OPTN_39"           ));  
					sql.setString( ++i, mi.getString("OPTN_40"           ));  
					sql.setString( ++i, mi.getString("OPTN_41"           ));  
					sql.setString( ++i, mi.getString("OPTN_42"           ));  
					sql.setString( ++i, mi.getString("OPTN_43"           ));  
					sql.setString( ++i, mi.getString("OPTN_44"           ));  
					sql.setString( ++i, mi.getString("OPTN_45"           ));  
					sql.setString( ++i, mi.getString("OPTN_46"           ));  
					sql.setString( ++i, mi.getString("OPTN_47"           ));  
					sql.setString( ++i, mi.getString("OPTN_48"           ));  
					sql.setString( ++i, mi.getString("OPTN_49"           ));  
					sql.setString( ++i, mi.getString("OPTN_50"           ));  
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					sql.setString( ++i, mi.getString("REMARK"            ));
					sql.setString( ++i, mi.getString("POS_IP_ADDR2"      ));
					sql.setString( ++i, mi.getString("VEN_CD"            ));
					
				} else if (mi.IS_UPDATE()){

					i = 0;							
					sql.put(svc.getQuery("UPD_POSMST"));
					sql.setString( ++i, mi.getString("SHOP_NAME"         ));
					sql.setString( ++i, mi.getString("EVENT_PLACE_CD"    ));
					sql.setString( ++i, mi.getString("POS_NAME"          ));
					sql.setString( ++i, mi.getString("POS_FLAG"          ));
					sql.setString( ++i, mi.getString("FLOR_CD"           ));
					sql.setString( ++i, mi.getString("HALL_CD"           ));
					sql.setString( ++i, mi.getString("MST_POS_NO"        ));
					sql.setString( ++i, mi.getString("FNB_SHOP_CD"       ));
					sql.setString( ++i, mi.getString("ITEM_REG_TYPE"     ));
					sql.setString( ++i, mi.getString("MIX_REG_YN"        ));
					sql.setString( ++i, mi.getString("POS_IP_ADDR1"      ));
					sql.setString( ++i, mi.getString("MAIN_SRVR_IP_ADDR" ));
					sql.setString( ++i, mi.getString("MAIN_SRVR_PORT_NO" ));
					sql.setString( ++i, mi.getString("BACK_SRVR_IP_ADDR" ));
					sql.setString( ++i, mi.getString("BACK_SRVR_PORT_NO" ));
					sql.setString( ++i, mi.getString("AD_FILE_URL1"      ));
					sql.setString( ++i, mi.getString("AD_FILE_URL2"      ));
					sql.setString( ++i, mi.getString("UPER_MSG_ID"       ));
					sql.setString( ++i, mi.getString("MIDL_MSG_ID"       ));
					sql.setString( ++i, mi.getString("LWER_MSG_ID"       ));
					sql.setString( ++i, mi.getString("CASH_RECP_MSG_ID"  ));
					sql.setString( ++i, mi.getString("PHONE1_NO"         ));
					sql.setString( ++i, mi.getString("PHONE2_NO"         ));
					sql.setString( ++i, mi.getString("PHONE3_NO"         ));
					sql.setString( ++i, mi.getString("RSPNS_NAME"        ));
					sql.setString( ++i, mi.getString("RSPNS_TEL_NO_1"    ));
					sql.setString( ++i, mi.getString("RSPNS_TEL_NO_2"    ));
					sql.setString( ++i, mi.getString("RSPNS_TEL_NO_3"    ));
					sql.setString( ++i, mi.getString("OPTN_01"           ));
					sql.setString( ++i, mi.getString("OPTN_02"           ));
					sql.setString( ++i, mi.getString("OPTN_03"           ));
					sql.setString( ++i, mi.getString("OPTN_04"           ));
					sql.setString( ++i, mi.getString("OPTN_05"           ));
					sql.setString( ++i, mi.getString("OPTN_06"           ));
					sql.setString( ++i, mi.getString("OPTN_07"           ));
					sql.setString( ++i, mi.getString("OPTN_08"           ));
					sql.setString( ++i, mi.getString("OPTN_09"           ));
					sql.setString( ++i, mi.getString("OPTN_10"           ));
					sql.setString( ++i, mi.getString("OPTN_11"           ));
					sql.setString( ++i, mi.getString("OPTN_12"           ));
					sql.setString( ++i, mi.getString("OPTN_13"           ));
					sql.setString( ++i, mi.getString("OPTN_14"           ));
					sql.setString( ++i, mi.getString("OPTN_15"           ));
					sql.setString( ++i, mi.getString("OPTN_16"           ));
					sql.setString( ++i, mi.getString("OPTN_17"           ));
					sql.setString( ++i, mi.getString("OPTN_18"           ));
					sql.setString( ++i, mi.getString("OPTN_19"           ));
					sql.setString( ++i, mi.getString("OPTN_20"           ));
					sql.setString( ++i, mi.getString("OPTN_21_FROM"      ));
					sql.setString( ++i, mi.getString("OPTN_21_TO"        ));
					sql.setString( ++i, mi.getString("OPTN_22"           ));
					sql.setString( ++i, mi.getString("OPTN_23"           ));
					sql.setString( ++i, mi.getString("OPTN_24"           ));
					sql.setString( ++i, mi.getString("OPTN_25"           ));
					sql.setString( ++i, mi.getString("USE_YN"            ));
					sql.setString( ++i, mi.getString("OPTN_26"           ));
					sql.setString( ++i, mi.getString("OPTN_27"           ));
					sql.setString( ++i, mi.getString("OPTN_28"           ));
					sql.setString( ++i, mi.getString("OPTN_29"           ));
					sql.setString( ++i, mi.getString("OPTN_30"           ));
					sql.setString( ++i, mi.getString("OPTN_31"           ));  
					sql.setString( ++i, mi.getString("OPTN_32"           ));  
					sql.setString( ++i, mi.getString("OPTN_33"           ));  
					sql.setString( ++i, mi.getString("OPTN_34"           ));  
					sql.setString( ++i, mi.getString("OPTN_35"           ));  
					sql.setString( ++i, mi.getString("OPTN_36"           ));  
					sql.setString( ++i, mi.getString("OPTN_37"           ));  
					sql.setString( ++i, mi.getString("OPTN_38"           ));  
					sql.setString( ++i, mi.getString("OPTN_39"           ));  
					sql.setString( ++i, mi.getString("OPTN_40"           ));  
					sql.setString( ++i, mi.getString("OPTN_41"           ));  
					sql.setString( ++i, mi.getString("OPTN_42"           ));  
					sql.setString( ++i, mi.getString("OPTN_43"           ));  
					sql.setString( ++i, mi.getString("OPTN_44"           ));  
					sql.setString( ++i, mi.getString("OPTN_45"           ));  
					sql.setString( ++i, mi.getString("OPTN_46"           ));  
					sql.setString( ++i, mi.getString("OPTN_47"           ));  
					sql.setString( ++i, mi.getString("OPTN_48"           ));  
					sql.setString( ++i, mi.getString("OPTN_49"           ));  
					sql.setString( ++i, mi.getString("OPTN_50"           ));  
					sql.setString(++i, strID);
					sql.setString( ++i, mi.getString("REMARK"            ));
					sql.setString( ++i, mi.getString("POS_IP_ADDR2"      ));
					sql.setString( ++i, mi.getString("VEN_CD"            ));
					
					sql.setString( ++i, mi.getString("STR_CD"            ));
					sql.setString( ++i, mi.getString("POS_NO"            ));
				} else {
						
				}
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
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


	public int sendposemg(ActionForm form, String userId)
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
			psql.put("DPS.PR_PCPOSMST_EMG_IFS", 5);
			     
			psql.setString(i++, form.getParam("strProcDt")); 	// 처리일자
            psql.setString(i++, userId);		                // 사용자 
            psql.setString(i++, form.getParam("strPosNo"));     //            
            
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
