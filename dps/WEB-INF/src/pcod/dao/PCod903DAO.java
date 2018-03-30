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
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>F&B코너관리 </p>
 * 
 * @created  on 1.0, 2010/05/13
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod903DAO extends AbstractDAO {

	/**
	 * F&B매장메뉴분류  마스터 을 조회한다.
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

		String strStrCd        = String2.nvl(form.getParam("strStrCd"));
		String strFnbShopCd    = String2.nvl(form.getParam("strFnbShopCd"));
		String strMenuFlagCd   = String2.nvl(form.getParam("strMenuFlagCd"));
		String strMenuFlagName = URLDecoder.decode( String2.nvl(form.getParam("strMenuFlagName")), "UTF-8");
		String strUseYn        = String2.nvl(form.getParam("strUseYn"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_FNBMENUKIND") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strFnbShopCd);
		
		if( !strMenuFlagCd.equals("")){
			sql.setString(i++, strMenuFlagCd);
			strQuery += svc.getQuery("SEL_FNBMENUKIND_WHERE_MENU_FLAG_CD") + "\n";
			
		}
		if( !strMenuFlagName.equals("") ){
			sql.setString(i++, strMenuFlagName);
			strQuery += svc.getQuery("SEL_FNBMENUKIND_WHERE_MENU_FLAG_NAME") + "\n";
		}
		if( !strUseYn.equals("%") ){
			sql.setString(i++, strUseYn);
			strQuery += svc.getQuery("SEL_FNBMENUKIND_WHERE_USE_YN") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_FNBMENUKIND_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * F&B매장메뉴분류 마스터,
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
		SqlWrapper sql = null;
		Service svc = null;
		
		int i;
		try {
			connect("pot");
			begin();
			String flag = "";
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				sql.close();				
				if ( mi.IS_INSERT()) {
					flag = "I";
					sql.put(svc.getQuery("SEL_FNBSHOPMST_USE_YN"));							
					sql.setString(1,  mi.getString("STR_CD"));										
					sql.setString(2,  mi.getString("FNB_SHOP_CD"));									
					Map map = selectMap( sql );							
					String mstUseYn = String2.nvl((String)map.get("USE_YN"));
					if( !mstUseYn.equals("Y")) {
						throw new Exception("[USER]"+"[ "+ mi.getString("FNB_SHOP_CD")+"] 는 사용되지 않는 매장 코드 입니다.");
					}
					sql.close();
					
					sql.put(svc.getQuery("SEL_FNBMENUKIND_MENU_FLAG_CD_CNT"));							
					sql.setString(1,  mi.getString("STR_CD"));										
					sql.setString(2,  mi.getString("FNB_SHOP_CD"));										
					sql.setString(3,  mi.getString("MENU_FLAG_CD"));								
					map = selectMap( sql );							
					String cnt = String2.nvl((String)map.get("CNT"));
					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"[ "+ mi.getString("MENU_FLAG_CD")+"] 이미 등록된 코너코드 입니다.");
					}
					sql.close();
					i = 0;
					sql.put(svc.getQuery("INS_FNBMENUKIND"));
					sql.setString( ++i, mi.getString("STR_CD"          ));
					sql.setString( ++i, mi.getString("FNB_SHOP_CD"     ));
					sql.setString( ++i, mi.getString("MENU_FLAG_CD"    ));
					sql.setString( ++i, mi.getString("MENU_FLAG_NAME"  ));
					sql.setString( ++i, mi.getString("SORT_NO"         ));
					sql.setString( ++i, mi.getString("ORD_PRT"         ));
					sql.setString( ++i, mi.getString("USE_YN"          ));
					sql.setString( ++i, strID);
					sql.setString( ++i, strID);
					
				} else if (mi.IS_UPDATE()){
					flag = "U";
					if( mi.getString("USE_YN").equals("N")){
						// 사용여부를 'N'로 변경시 상세 데이터도 모두  'N'로 변경
						i = 0;
						sql.put(svc.getQuery("UPD_FNBMENUMST_USE_N"));
						sql.setString( ++i, mi.getString("USE_YN"          ));
						sql.setString( ++i, strID);
						sql.setString( ++i, mi.getString("STR_CD"          ));
						sql.setString( ++i, mi.getString("FNB_SHOP_CD"     ));
						sql.setString( ++i, mi.getString("MENU_FLAG_CD"    ));
						update(sql);
						sql.close();
					}else{
						sql.put(svc.getQuery("SEL_FNBSHOPMST_USE_YN"));							
						sql.setString(1,  mi.getString("STR_CD"));										
						sql.setString(2,  mi.getString("FNB_SHOP_CD"));									
						Map map = selectMap( sql );							
						String mstUseYn = String2.nvl((String)map.get("USE_YN"));
						if( !mstUseYn.equals("Y")) {
							throw new Exception("[USER]"+"[ "+ mi.getString("FNB_SHOP_CD")+"] 는 사용되지 않는 매장 코드 입니다.");
						}
						sql.close();
					}
					i = 0;						
					sql.put(svc.getQuery("UPD_FNBMENUKIND"));
					sql.setString( ++i, mi.getString("MENU_FLAG_NAME"  ));
					sql.setString( ++i, mi.getString("SORT_NO"         ));
					sql.setString( ++i, mi.getString("ORD_PRT"         ));
					sql.setString( ++i, mi.getString("USE_YN"          ));
					sql.setString( ++i, strID);
					sql.setString( ++i, mi.getString("STR_CD"          ));
					sql.setString( ++i, mi.getString("FNB_SHOP_CD"     ));
					sql.setString( ++i, mi.getString("MENU_FLAG_CD"    ));
				} else if (mi.IS_DELETE()){
					flag = "D";
					i = 0;							
					sql.put(svc.getQuery("DEL_FNBMENUKIND"));		
					sql.setString( ++i, mi.getString("STR_CD"          ));
					sql.setString( ++i, mi.getString("FNB_SHOP_CD"     ));
					sql.setString( ++i, mi.getString("MENU_FLAG_CD"    ));
				} else {
					continue;
				}
				
				res = update(sql);

				if (res != 1) {
					String tmpMsg = "데이터 입력을 하지 못했습니다.";
					if(flag.equals("D"))
						tmpMsg = "데이터 삭제를 하지 못했습니다.";
						
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ tmpMsg);
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