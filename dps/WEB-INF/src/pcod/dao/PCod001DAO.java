/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>점정보관리</p>
 * 
 * @created  on 1.0, 2010/01/31
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod001DAO extends AbstractDAO {


	/**
	 * 점 마스터을 조회한다.
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
		
		String strFclFlag = String2.nvl(form.getParam("strFclFlag"));     //시설구분
		String strBstrFlag = String2.nvl(form.getParam("strBstrFlag"));   //지점구분
		String strStrFlag = String2.nvl(form.getParam("strStrFlag"));     //점구분

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_STRMST") + "\n";

		if( !strFclFlag.equals("%")){
			sql.setString(i++, strFclFlag);
			strQuery += svc.getQuery("SEL_STRMST_WHERE_FCL_FLAG") + "\n";
		}
		if( !strBstrFlag.equals("%")){
			sql.setString(i++, strBstrFlag);
			strQuery += svc.getQuery("SEL_STRMST_WHERE_BSTR_FLAG") + "\n";
		}
		if( !strStrFlag.equals("%")){
			sql.setString(i++, strStrFlag);
			strQuery += svc.getQuery("SEL_STRMST_WHERE_STR_FLAG") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_STRMST_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * <p>
	 * 점 마스터  저장, 수정  처리한다.
	 * (조직 정보를 신규 및 수정 처리 한다.)
	 * </p>
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
		String strCdCnt = "";
		
		String orgCd = "";
		String orgNm = "";
		boolean orgUseN = false;
		int i;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				sql.close();
				//조직코드
				orgCd = mi.getString("STR_CD")+"00000000";
				orgNm = mi.getString("STR_NAME");

				//신규 입력시
				if (mi.IS_INSERT()) {
					
					//점코드 중복체크
					sql.put(svc.getQuery("SEL_STRMST_STRCD_CNT"));
					sql.setString(1, mi.getString("STR_CD"));	
					Map map = selectMap( sql );
					strCdCnt = String2.nvl((String)map.get("CNT"));
					if( !strCdCnt.equals("0")) {
						throw new Exception("[USER]"+"중복되는 점코드 입니다.");
					}
					
					sql.close();

					//본사점 중복체크
					if(mi.getString("STR_FLAG").equals("0")){
						i = 0;					
						sql.put(svc.getQuery("SEL_STRMST_MAIN_STR_CNT"));
						sql.setString(++i, mi.getString("CORP_FLAG"));	
						sql.setString(++i, mi.getString("FCL_FLAG"));						
						map = selectMap( sql );
						strCdCnt = String2.nvl((String)map.get("CNT"));
						if( !strCdCnt.equals("0")) {
							throw new Exception("[USER]"+"동일 법인, 동일 시설내의 본사점은 하나만 등록 가능합니다.");
						}
						sql.close();
					}

					i = 0;					
					
					sql.put(svc.getQuery("INS_STRMST"));					
					
					sql.setString(++i, mi.getString("STR_CD"));					
					sql.setString(++i, mi.getString("STR_NAME"));					
					sql.setString(++i, mi.getString("CORP_FLAG"));					
					sql.setString(++i, mi.getString("FCL_FLAG"));					
					sql.setString(++i, mi.getString("STR_FLAG"));					
					sql.setString(++i, mi.getString("AREA_FLAG"));					
					sql.setString(++i, mi.getString("MNG_FLAG"));					
					sql.setString(++i, mi.getString("BSTR_FLAG"));					
					sql.setString(++i, mi.getString("COMP_NO"));					
					sql.setString(++i, mi.getString("CORP_NO"));					
					sql.setString(++i, mi.getString("COMP_NAME"));					
					sql.setString(++i, mi.getString("REP_NAME"));					
					sql.setString(++i, mi.getString("BIZ_STAT"));					
					sql.setString(++i, mi.getString("BIZ_CAT"));					
					sql.setString(++i, mi.getString("POST_NO"));					
					sql.setString(++i, mi.getString("ADDR"));					
					sql.setString(++i, mi.getString("DTL_ADDR"));					
					sql.setString(++i, mi.getString("REP_TEL1_NO"));					
					sql.setString(++i, mi.getString("REP_TEL2_NO"));					
					sql.setString(++i, mi.getString("REP_TEL3_NO"));					
					sql.setString(++i, mi.getString("FAX1_NO"));					
					sql.setString(++i, mi.getString("FAX2_NO"));					
					sql.setString(++i, mi.getString("FAX3_NO"));					
					sql.setString(++i, mi.getString("DISP_NO"));					
					sql.setString(++i, mi.getString("OPEN_TIME"));					
					sql.setString(++i, mi.getString("CLOSE_TIME"));					
					sql.setString(++i, mi.getString("BAL_CHK_TIME"));					
					sql.setString(++i, mi.getString("BSK_RFD_AMT"));					
					sql.setString(++i, mi.getString("BSK_RFD_CNT"));					
					sql.setString(++i, mi.getString("CASH_RECP_SELF_YN"));					
					sql.setString(++i, mi.getString("CASH_RECP_PSBL_AMT"));					
					sql.setString(++i, mi.getString("SMEDI_ID"));					
					sql.setString(++i, mi.getString("SMEDI_EMAIL"));					
					sql.setString(++i, mi.getString("SMEDI_CHAR_ID"));					
					sql.setString(++i, mi.getString("APP_S_DT"));					
					sql.setString(++i, mi.getString("APP_E_DT"));					
					sql.setString(++i, mi.getString("USE_YN"));				
					sql.setString(++i, mi.getString("PACKET_CRYPT_YN"));					
					sql.setString(++i, mi.getString("PACKET_CRYPT_KEY"));	
					sql.setString(++i, mi.getString("BUPLA"));
					sql.setString(++i, mi.getString("GSBER"));
					sql.setString(++i, mi.getString("BUY_ACC_VEN_CD"));
					sql.setString(++i, mi.getString("SALE_ACC_VEN_CD"));
					sql.setString(++i, strID);					
					sql.setString(++i, strID); 

					sql.setString(++i, mi.getString("SMEDI_TEL1_NO"));					
					sql.setString(++i, mi.getString("SMEDI_TEL2_NO"));					
					sql.setString(++i, mi.getString("SMEDI_TEL3_NO"));	
					
					// 점정보를 신규추가한다.
					res = update(sql);
					
					//백화점 시설만 조직을 추가한다. -- 모두허용 2010.06.08
					//if(mi.getString("FCL_FLAG").equals("1")){
						
						sql.close();											
						i = 0;				
						sql.put(svc.getQuery("INS_ORGMST"));
						sql.setString(++i, orgCd);
						sql.setString(++i, orgNm);
						sql.setString(++i, orgNm);
						sql.setString(++i, "1");      // 기본(판매조직) 
						sql.setString(++i, "1");      // 기본(점)
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, "00");
						sql.setString(++i, "00");
						sql.setString(++i, "00");
						sql.setString(++i, "00");
						sql.setString(++i, "0");     // 기본(0);
						sql.setString(++i, orgCd);
						sql.setString(++i, null);
						sql.setString(++i, null);
						sql.setString(++i, "N");
						sql.setString(++i, null);
						sql.setString(++i, null);
						sql.setString(++i, mi.getString("APP_S_DT"));
						sql.setString(++i, mi.getString("APP_E_DT"));
						sql.setString(++i, mi.getString("USE_YN"));
						sql.setString(++i, strID);
						sql.setString(++i, strID);
						
						//조직정보 신규입력
						update(sql);
					//}

				//수정 입력시
				} else if (mi.IS_UPDATE()) {

					//백화점 시설만 조직을 수정한다.
					//if(mi.getString("FCL_FLAG").equals("1")){
						
						i = 0;						
						sql.put(svc.getQuery("UPD_ORGMST"));					
						sql.setString(++i, orgNm);					
						sql.setString(++i, orgNm);									
						sql.setString(++i, mi.getString("USE_YN"));				
						sql.setString(++i, strID);					
						sql.setString(++i, orgCd);					
						orgUseN = mi.getString("USE_YN").equals("N");	
						
						//조직 정보를 수정한다.
						update(sql);
						
						//점의 사용여부가 'N'일 경우						
						if( orgUseN ){
							
							sql.close();
							i = 0;				
							sql.put(svc.getQuery("UPD_ORGMST_USE_YN"));
							sql.setString(++i, mi.getString("USE_YN"));
							sql.setString(++i, strID);
							sql.setString(++i, orgCd);
							//하위 조직정보 사용여부 변경	
							update(sql);
	
							sql.close();
							i = 0;				
							sql.put(svc.getQuery("UPD_BUYERMST_USE_YN"));
							sql.setString(++i, mi.getString("USE_YN"));
							sql.setString(++i, strID);
							sql.setString(++i, orgCd);
							//바이어정보 사용여부변경							
							update(sql);
							
							sql.close();
							i = 0;				
							sql.put(svc.getQuery("UPD_BUYERORG_USE_YN"));
							sql.setString(++i, mi.getString("USE_YN"));
							sql.setString(++i, strID);
							sql.setString(++i, orgCd);
							//바어이조직정보 사용여부변경
							update(sql);
						}
	
						sql.close();
					//}
					
					i = 0;
					
					sql.put(svc.getQuery("UPD_STRMST"));
					
					sql.setString(++i, mi.getString("STR_NAME"));
					sql.setString(++i, mi.getString("CORP_FLAG"));
					sql.setString(++i, mi.getString("FCL_FLAG"));
					sql.setString(++i, mi.getString("STR_FLAG"));
					sql.setString(++i, mi.getString("AREA_FLAG"));
					sql.setString(++i, mi.getString("MNG_FLAG"));
					sql.setString(++i, mi.getString("BSTR_FLAG"));
					sql.setString(++i, mi.getString("COMP_NO"));
					sql.setString(++i, mi.getString("CORP_NO"));
					sql.setString(++i, mi.getString("COMP_NAME"));
					sql.setString(++i, mi.getString("REP_NAME"));
					sql.setString(++i, mi.getString("BIZ_STAT"));
					sql.setString(++i, mi.getString("BIZ_CAT"));
					sql.setString(++i, mi.getString("POST_NO"));
					sql.setString(++i, mi.getString("ADDR"));
					sql.setString(++i, mi.getString("DTL_ADDR"));
					sql.setString(++i, mi.getString("REP_TEL1_NO"));
					sql.setString(++i, mi.getString("REP_TEL2_NO"));
					sql.setString(++i, mi.getString("REP_TEL3_NO"));
					sql.setString(++i, mi.getString("FAX1_NO"));
					sql.setString(++i, mi.getString("FAX2_NO"));
					sql.setString(++i, mi.getString("FAX3_NO"));
					sql.setString(++i, mi.getString("DISP_NO"));
					sql.setString(++i, mi.getString("OPEN_TIME"));
					sql.setString(++i, mi.getString("CLOSE_TIME"));
					sql.setString(++i, mi.getString("BAL_CHK_TIME"));
					sql.setString(++i, mi.getString("BSK_RFD_AMT"));
					sql.setString(++i, mi.getString("BSK_RFD_CNT"));
					sql.setString(++i, mi.getString("CASH_RECP_SELF_YN"));
					sql.setString(++i, mi.getString("CASH_RECP_PSBL_AMT"));
					sql.setString(++i, mi.getString("SMEDI_ID"));
					sql.setString(++i, mi.getString("SMEDI_EMAIL"));
					sql.setString(++i, mi.getString("SMEDI_CHAR_ID"));
					sql.setString(++i, mi.getString("APP_S_DT"));
					sql.setString(++i, mi.getString("APP_E_DT"));		
					sql.setString(++i, mi.getString("USE_YN"));	
					sql.setString(++i, mi.getString("PACKET_CRYPT_YN"));					
					sql.setString(++i, mi.getString("PACKET_CRYPT_KEY"));	
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("BUPLA"));
					sql.setString(++i, mi.getString("GSBER"));
					sql.setString(++i, mi.getString("BUY_ACC_VEN_CD"));
					sql.setString(++i, mi.getString("SALE_ACC_VEN_CD"));
					
					sql.setString(++i, mi.getString("SMEDI_TEL1_NO"));
					sql.setString(++i, mi.getString("SMEDI_TEL2_NO"));
					sql.setString(++i, mi.getString("SMEDI_TEL3_NO"));
					
					sql.setString(++i, mi.getString("STR_CD"));	

					res = update(sql);
				} else {
				}


				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
					
				//데이터 신규 입력 및 수정 입력 시 
				}else {

					
					sql.close();
					//조직정보 사용여부 변경시 History 입력
					if( orgUseN ){
						sql.put(svc.getQuery("SEL_ORGMSG"));
						sql.setString(1, orgCd);

						List list = select2List( sql );						
						
						if( list.size() > 0 ) {
							
							for( int j = 0; j < list.size(); j++){

								sql.close();
								Map keys = new HashMap();
								keys.put("ORG_CD", ((List)list.get(j)).get(0));
								///조직정보  History 입력
								update(Util.getHistorySQL("PC_ORGMST", "PC_ORGHIST", "DPS", keys, "ORG_CD", strID));
							}
							
						}
						sql.close();
						sql.put(svc.getQuery("SEL_BUYERORG"));
						sql.setString(1, orgCd);

						list = select2List( sql );
						
						if( list.size() > 0 ) {
							
							for( int j = 0; j < list.size(); j++){

								sql.close();
								Map keys = new HashMap();
								keys.put("BUYER_CD", ((List)list.get(j)).get(0));
								keys.put("APP_S_DT", ((List)list.get(j)).get(1));
								///바이어 조직정보  History 입력
								update(Util.getHistorySQL("PC_BUYERORG", "PC_BUYERORGHIST", "DPS", keys, "BUYER_CD", strID));
							}
							
						}
					//조직정보  변경시 History 입력
					}else{

						sql.close();
						Map keys = new HashMap();
						keys.put("ORG_CD", orgCd);
						///조직정보  History 입력
						update(Util.getHistorySQL("PC_ORGMST", "PC_ORGHIST", "DPS", keys, "ORG_CD", strID));
					}
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
