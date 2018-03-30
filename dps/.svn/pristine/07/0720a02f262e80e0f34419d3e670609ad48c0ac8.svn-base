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
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>POS단축키관리</p>
 * 
 * @created  on 1.0, 2010/05/24
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod808DAO extends AbstractDAO {

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
	 * POS 단축키를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strPosNo = String2.nvl(form.getParam("strPosNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_POSSHORTKEY") ;
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPosNo);
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	/**
	 * POS 단축키,
	 * 저장, 수정, 삭제  처리한다.
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
					
					sql.put(svc.getQuery("SEL_POSSHORTKEY_SHORTCUT_NO_CNT"));							
					sql.setString(1,  mi.getString("STR_CD"));								
					sql.setString(2,  mi.getString("POS_NO"));								
					sql.setString(3,  mi.getString("SHORTCUT_NO"));								
					Map map = selectMap( sql );							
					String posCnt = String2.nvl((String)map.get("CNT"));
					if( !posCnt.equals("0")) {
						throw new Exception("[USER]"+"["+mi.getString("SHORTCUT_NO")+"] 중복되는POS 단축번호 입니다.");
					}
					// 단축구분이 품번+품목 또는 품번+품목+상품구분 일 경우 존재하는 코드인지 조회 
					String shortCutFlag = mi.getString("SHORTCUT_FLAG"     );
					if(shortCutFlag.equals("2") || shortCutFlag.equals("3") ){
						String itemCd = mi.getString("ITEM_CD");
						String pumbun = itemCd.substring(0, 6);
						String pummok = itemCd.substring(6, 10);
						// 품번코드 존재여부
						sql.close();
						sql.put(svc.getQuery("SEL_STRPBN_CNT"));							
						sql.setString(1,  mi.getString("STR_CD"));								
						sql.setString(2,  pumbun);												
						map = selectMap( sql );							
						String cnt = String2.nvl((String)map.get("CNT"));
						if( !cnt.equals("1")) {
							throw new Exception("[USER]"+"["+pumbun+"] 존재하지 않는 품번입니다.");
						} 
						// 품목단축코드 존재여부
						sql.close();
						sql.put(svc.getQuery("SEL_PMKMST_CNT"));								
						sql.setString(1,  pumbun);												
						sql.setString(2,  pummok);												
						map = selectMap( sql );							
						cnt = String2.nvl((String)map.get("CNT"));
						if( !cnt.equals("1")) {
							throw new Exception("[USER]"+"["+pummok+"] 존재하지 않는 품목단축코드입니다.");
						}
						if(shortCutFlag.equals("3")){
							String eventFlag = itemCd.substring(10, 12);
							// 행사구분코드 존재여부
							sql.close();
							sql.put(svc.getQuery("SEL_MARGINMST_CNT"));							
							sql.setString(1,  mi.getString("STR_CD"));								
							sql.setString(2,  pumbun);												
							sql.setString(3,  eventFlag);												
							map = selectMap( sql );							
							cnt = String2.nvl((String)map.get("CNT"));
							if( !cnt.equals("1")) {
								throw new Exception("[USER]"+"["+eventFlag+"] 존재하지 않는 상품구분입니다.");
							}
						}
					}
					
					sql.close();
					i = 0;							
					sql.put(svc.getQuery("INS_POSSHORTKEY"));
					sql.setString( ++i, mi.getString("STR_CD"            ));
					sql.setString( ++i, mi.getString("POS_NO"            ));
					sql.setString( ++i, mi.getString("SHORTCUT_NO"       ));
					sql.setString( ++i, mi.getString("SHORTCUT_FLAG"     ));
					sql.setString( ++i, mi.getString("ITEM_CD"           ));
					sql.setString( ++i, mi.getString("ITEM_NAME"         ));
					sql.setString( ++i, mi.getString("ITEM_CD"           ));
					sql.setString( ++i, mi.getString("SALE_PRC"          ));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					
				} else if (mi.IS_UPDATE()){

					// 단축구분이 품번+품목 또는 품번+품목+상품구분 일 경우 존재하는 코드인지 조회 
					String shortCutFlag = mi.getString("SHORTCUT_FLAG"     );
					if(shortCutFlag.equals("2") || shortCutFlag.equals("3") ){
						String itemCd = mi.getString("ITEM_CD");
						String pumbun = itemCd.substring(0, 6);
						String pummok = itemCd.substring(6, 10);
						// 품번코드 존재여부
						sql.close();
						sql.put(svc.getQuery("SEL_STRPBN_CNT"));							
						sql.setString(1,  mi.getString("STR_CD"));								
						sql.setString(2,  pumbun);												
						Map map = selectMap( sql );							
						String cnt = String2.nvl((String)map.get("CNT"));
						if( !cnt.equals("1")) {
							throw new Exception("[USER]"+"["+pumbun+"] 존재하지 않는 품번입니다.");
						}
						// 품목단축코드 존재여부
						sql.close();
						sql.put(svc.getQuery("SEL_PMKMST_CNT"));							
						sql.setString(1,  pumbun);													
						sql.setString(2,  pummok);												
						map = selectMap( sql );							
						cnt = String2.nvl((String)map.get("CNT"));
						if( !cnt.equals("1")) {
							throw new Exception("[USER]"+"["+pummok+"] 존재하지 않는 품목단축코드입니다.");
						}
						if(shortCutFlag.equals("3")){
							String eventFlag = itemCd.substring(10, 12);
							// 행사구분코드 존재여부
							sql.close();
							sql.put(svc.getQuery("SEL_MARGINMST_CNT"));							
							sql.setString(1,  mi.getString("STR_CD"));								
							sql.setString(2,  pumbun);												
							sql.setString(3,  eventFlag);												
							map = selectMap( sql );							
							cnt = String2.nvl((String)map.get("CNT"));
							if( !cnt.equals("1")) {
								throw new Exception("[USER]"+"["+eventFlag+"] 존재하지 않는 상품구분입니다.");
							}
						}
					}
					sql.close();					
					i = 0;							
					sql.put(svc.getQuery("UPD_POSSHORTKEY"));
					sql.setString( ++i, mi.getString("SHORTCUT_FLAG"     ));
					sql.setString( ++i, mi.getString("ITEM_CD"           ));
					sql.setString( ++i, mi.getString("ITEM_NAME"         ));
					sql.setString( ++i, mi.getString("ITEM_CD"           ));
					sql.setString( ++i, mi.getString("SALE_PRC"          ));
					sql.setString(++i, strID);
					sql.setString( ++i, mi.getString("STR_CD"            ));
					sql.setString( ++i, mi.getString("POS_NO"            ));
					sql.setString( ++i, mi.getString("SHORTCUT_NO"       ));
				} else if (mi.IS_DELETE()){
					i = 0;							
					sql.put(svc.getQuery("DEL_POSSHORTKEY"));
					sql.setString( ++i, mi.getString("STR_CD"            ));
					sql.setString( ++i, mi.getString("POS_NO"            ));
					sql.setString( ++i, mi.getString("SHORTCUT_NO"       ));
				}else{
					continue;
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
	
	/**
	 * 행사구분 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMgHs(ActionForm form, String userid) throws Exception {
		try{
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 0;

		String strStrCd     = String2.nvl(form.getParam("strStrCd"));
		String strPumBunCd  = String2.nvl(form.getParam("strPumBunCd"));
		String strSaleDt    = String2.nvl(form.getParam("strSaleDt"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_HS_MG"));
		sql.setString(++i, strStrCd);
		sql.setString(++i, strPumBunCd);
		sql.setString(++i, strSaleDt);
		
		ret = select2List(sql);
		
		return ret;
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
	}


}
