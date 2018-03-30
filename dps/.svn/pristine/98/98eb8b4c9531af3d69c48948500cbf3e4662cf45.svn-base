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
/**
 * <p>F&B매장관리</p>
 * 
 * @created  on 1.0, 2010/05/02
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod901DAO extends AbstractDAO {

	/**
	 * F&B매장 마스터 을 조회한다.
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
		String strVenCd        = String2.nvl(form.getParam("strVenCd"));
		String strVenName      = URLDecoder.decode( String2.nvl(form.getParam("strVenName")), "UTF-8");
		String strFnbShopCd    = String2.nvl(form.getParam("strFnbShopCd"));
		String strFnbShopName  = URLDecoder.decode( String2.nvl(form.getParam("strFnbShopName")), "UTF-8");
		String strUseYn        = String2.nvl(form.getParam("strUseYn"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_FNBSHOPMST") + "\n";
		sql.setString(i++, strStrCd);
		
		if( !strVenCd.equals("")){
			sql.setString(i++, strVenCd);
			strQuery += svc.getQuery("SEL_FNBSHOPMST_WHERE_VEN_CD") + "\n";
			
		}
		if( !strVenName.equals("") ){
			sql.setString(i++, strVenName);
			strQuery += svc.getQuery("SEL_FNBSHOPMST_WHERE_VEN_NAME") + "\n";
		}
		if( !strFnbShopCd.equals("") ){
			sql.setString(i++, strFnbShopCd);
			strQuery += svc.getQuery("SEL_FNBSHOPMST_WHERE_FNB_SHOP_CD") + "\n";
		}
		if( !strFnbShopName.equals("") ){
			sql.setString(i++, strFnbShopName);
			strQuery += svc.getQuery("SEL_FNBSHOPMST_WHERE_FNB_SHOP_NAME") + "\n";
		}
		if( !strUseYn.equals("%") ){
			sql.setString(i++, strUseYn);
			strQuery += svc.getQuery("SEL_FNBSHOPMST_WHERE_USE_YN") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_FNBSHOPMST_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * F&B매장 마스터,
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
					sql.put(svc.getQuery("SEL_FNBSHOPMST_NEW_FNB_SHOP_CD"));							
					sql.setString(1,  mi.getString("STR_CD"));								
					Map map = selectMap( sql );							
					String newFnbShopCd = String2.nvl((String)map.get("NEW_FNB_SHOP_CD"));
					if( newFnbShopCd.equals("")) {
						throw new Exception("[USER]"+"매장코드를 생성할 수 없습니다.");
					}
					sql.close();
					i = 0;
					sql.put(svc.getQuery("INS_FNBSHOPMST"));
					sql.setString( ++i, mi.getString("STR_CD"          ));
					sql.setString( ++i, newFnbShopCd                    );
					sql.setString( ++i, mi.getString("FNB_SHOP_NAME"   ));
					sql.setString( ++i, mi.getString("FNB_SHOP_FLAG"   ));
					sql.setString( ++i, mi.getString("VEN_CD"          ));
					sql.setString( ++i, mi.getString("CHNAL_FLAG"      ));
					sql.setString( ++i, mi.getString("FNB_FLAG"        ));
					sql.setString( ++i, mi.getString("FNB_BIZ_KIND_CD" ));
					
					if(mi.getString("REP_SHOP_CD").equals("")){
						sql.setString( ++i, newFnbShopCd                );						
					}else{
						sql.setString( ++i, mi.getString("REP_SHOP_CD" ));
					}
					
					sql.setString( ++i, mi.getString("USE_YN"          ));
					sql.setString( ++i, strID);
					sql.setString( ++i, strID);
					
				} else if (mi.IS_UPDATE()){
					flag = "U";
					if( mi.getString("USE_YN").equals("N")){
						// 사용여부를 'N'로 변경시 상세 데이터도 모두  'N'로 변경
						i = 0;
						sql.put(svc.getQuery("UPD_FNBMENUKIND_USE_N"));
						sql.setString( ++i, mi.getString("USE_YN"          ));
						sql.setString( ++i, strID);
						sql.setString( ++i, mi.getString("STR_CD"          ));
						sql.setString( ++i, mi.getString("FNB_SHOP_CD"     ));
						update(sql);
						sql.close();
						i = 0;
						sql.put(svc.getQuery("UPD_FNBMENUMST_USE_N"));
						sql.setString( ++i, mi.getString("USE_YN"          ));
						sql.setString( ++i, strID);
						sql.setString( ++i, mi.getString("STR_CD"          ));
						sql.setString( ++i, mi.getString("FNB_SHOP_CD"     ));
						update(sql);
						sql.close();
					}
					i = 0;
					sql.put(svc.getQuery("UPD_FNBSHOPMST"));
					sql.setString( ++i, mi.getString("FNB_SHOP_NAME"   ));
					sql.setString( ++i, mi.getString("FNB_SHOP_FLAG"   ));
					sql.setString( ++i, mi.getString("VEN_CD"          ));
					sql.setString( ++i, mi.getString("CHNAL_FLAG"      ));
					sql.setString( ++i, mi.getString("FNB_FLAG"        ));
					sql.setString( ++i, mi.getString("FNB_BIZ_KIND_CD" ));
					if(mi.getString("REP_SHOP_CD").equals("")){
						sql.setString( ++i, mi.getString("FNB_SHOP_CD" ));						
					}else{
						sql.setString( ++i, mi.getString("REP_SHOP_CD" ));
					}
					sql.setString( ++i, mi.getString("USE_YN"          ));
					sql.setString( ++i, strID);
					sql.setString( ++i, mi.getString("STR_CD"          ));
					sql.setString( ++i, mi.getString("FNB_SHOP_CD"     ));
				} else if (mi.IS_DELETE()){
					flag = "D";
					sql.put(svc.getQuery("SEL_FNBSHOPMST_DETAIL_CNT"));							
					sql.setString(1,  mi.getString("STR_CD"));							
					sql.setString(2,  mi.getString("FNB_SHOP_CD"));								
					Map map = selectMap( sql );							
					String cnt = String2.nvl((String)map.get("CNT"));
					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"[ "+ mi.getString("FNB_SHOP_CD")+" ] 상세데이터가  존재합니다.");
					}
					sql.close();
					i = 0;					
					
					sql.put(svc.getQuery("DEL_FNBSHOPMST"));		
					sql.setString( ++i, mi.getString("STR_CD"          ));
					sql.setString( ++i, mi.getString("FNB_SHOP_CD"     ));
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

	public int sendfnbshopemg(ActionForm form, String userId)
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
			psql.put("DPS.PR_PCFNBSHOPPOS_EMG_IFS", 5);
			     
			psql.setString(i++, form.getParam("strProcDt")); 	// 처리일자
            psql.setString(i++, userId);		                // 사용자 
            psql.setString(i++, form.getParam("strFnbShopCd"));     //            
            
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
