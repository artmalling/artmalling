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
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>임대을B수수료관리 </p>
 * 
 * @created  on 1.0, 2010/05/18   
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod303DAO extends AbstractDAO {


	/**
	 * 협력사의 품번을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;
		
		String strStrCd 		 = String2.nvl(form.getParam("strStrCd"));
		String strVenCd 		 = String2.nvl(form.getParam("strVenCd"));
		String strVenName 		 = URLDecoder.decode(String2.nvl(form.getParam("strVenName")), "UTF-8");
		String strPumbunCd 		 = String2.nvl(form.getParam("strPumbunCd"));
		String strPumbunName     = URLDecoder.decode(String2.nvl(form.getParam("strPumbunName")), "UTF-8");
		String strRentbMgappFlag = String2.nvl(form.getParam("strRentbMgappFlag"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_MASTER") + "\n";		
		sql.setString(i++, strStrCd);
		
		if( !strVenCd.equals("")){
			sql.setString(i++, strVenCd);
			strQuery += svc.getQuery("SEL_MASTER_WHERE_VEN_CD") + "\n";			
		}
		if( !strVenName.equals("")){
			sql.setString(i++, strVenName);
			strQuery += svc.getQuery("SEL_MASTER_WHERE_VEN_NAME") + "\n";			
		}
		if( !strPumbunCd.equals("")){
			sql.setString(i++, strPumbunCd);
			strQuery += svc.getQuery("SEL_MASTER_WHERE_PUMBUN_CD") + "\n";			
		}
		if( !strPumbunName.equals("")){
			sql.setString(i++, strPumbunName);
			strQuery += svc.getQuery("SEL_MASTER_WHERE_PUMBUN_NAME") + "\n";			
		}
		if( !strRentbMgappFlag.equals("%")){
			sql.setString(i++, strRentbMgappFlag);
			strQuery += svc.getQuery("SEL_MASTER_WHERE_RENTB_MGAPP_FLAG") + "\n";		
		}	
		strQuery += svc.getQuery("SEL_MASTER_ORDER");			

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 마진정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMargin(ActionForm form) throws Exception {

		List ret 	= null;
		Util util 	= new Util();
	
		SqlWrapper sql 	= null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;

		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd 	= String2.nvl(form.getParam("strPumbunCd"));
		String strAppSDt 	= String2.nvl(form.getParam("strAppSDt"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_MARGIN") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);

		if( !strAppSDt.equals("")){
			sql.setString(i++, strAppSDt);
			strQuery += svc.getQuery("SEL_MARGIN_WHERE_APP_S_DT") + "\n";	
			
			strQuery += svc.getQuery("SEL_MARGIN_ORDER_AMT");		
		}else{
			strQuery += svc.getQuery("SEL_MARGIN_ORDER");				
		}		


		sql.put(strQuery);


		ret = select2List(sql);
		return ret;
	}

	/**
	 * 마진 적용일자 를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMarginDt(ActionForm form) throws Exception {

		List ret 	= null;
		Util util 	= new Util();
	
		SqlWrapper sql 	= null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;

		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd 	= String2.nvl(form.getParam("strPumbunCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_MARGIN_DT");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);

		sql.put(strQuery);


		ret = select2List(sql);
		return ret;
	}

	/**
	 * 기간 마진마스터   저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveNormal(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int ret 		= 0;
		int res 		= 0;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi.next()) {//DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
				sql.close();
				if (mi.IS_INSERT()) {
					// 마진코드 중복체크
					i = 1;
					sql.put(svc.getQuery("SEL_MARGIN_CNT"));
					
					sql.setString(i++, mi.getString("STR_CD"));	
					sql.setString(i++, mi.getString("PUMBUN_CD"));
					sql.setString(i++, mi.getString("EVENT_FLAG"));			
					sql.setString(i++, mi.getString("APP_S_DT"));	

					Map map = selectMap( sql );
					String cnt = String2.nvl((String)map.get("CNT"));
					
					if( !cnt.equals("0")) {
						throw new Exception("[USER]" + "["+mi.getString("EVENT_FLAG")+"] 중복되는 데이터가 존재합니다.");
					}
					sql.close();
					// 마진코드 시작일보다 큰 시작일 조회
					i = 1;
					sql.put(svc.getQuery("SEL_MARGINMST_APPSDATE_CNT"));
					sql.put(svc.getQuery("SEL_MARGINMST_APPSDATE_CNT_WHERE_EVENT_FLAG"));
					sql.setString(i++, mi.getString("STR_CD"));	
					sql.setString(i++, mi.getString("PUMBUN_CD"));	
					sql.setString(i++, mi.getString("APP_S_DT"));	
					sql.setString(i++, mi.getString("EVENT_FLAG"));		
					map = selectMap( sql );
					String appSDtCnt = String2.nvl((String)map.get("CNT"));
					
					if( !appSDtCnt.equals("0")){
						throw new Exception("[USER]" + "["+mi.getString("APP_S_DT")+"] 최종 시작일 아닙니다.");
					}
					
					sql.close();
					i = 1;
					sql.put(svc.getQuery("SEL_MARGINMST_APPSDATE"));
					sql.put(svc.getQuery("SEL_MARGINMST_APPSDATE_WHERE_EVENT_FLAG"));
					sql.setString(i++, mi.getString("STR_CD"));	
					sql.setString(i++, mi.getString("PUMBUN_CD"));	
					sql.setString(i++, mi.getString("APP_S_DT"));	
					sql.setString(i++, mi.getString("EVENT_FLAG"));	
					map = selectMap( sql );
					String lastAppSDt = String2.nvl((String)map.get("APP_S_DT"));
					
					if( !lastAppSDt.equals("")){
						sql.close();
						i = 1;
						sql.put(svc.getQuery("UPD_MARGINMST_APPEDATE"));
						sql.put(svc.getQuery("UPD_MARGINMST_APPEDATE_WHERE_EVENT_FLAG"));
						sql.setString(i++, mi.getString("APP_S_DT"));	
						sql.setString(i++, strID);		
						sql.setString(i++, mi.getString("STR_CD"));	
						sql.setString(i++, mi.getString("PUMBUN_CD"));	
						sql.setString(i++, lastAppSDt);	
						sql.setString(i++, mi.getString("EVENT_FLAG"));
						
						update(sql);           
					}     
					sql.close();    
					i = 1;
					sql.put(svc.getQuery("INS_MARGINMST"));           

					sql.setString(i++, mi.getString("STR_CD"));	
					sql.setString(i++, mi.getString("PUMBUN_CD"));	
					sql.setString(i++, mi.getString("EVENT_FLAG"));	
					sql.setString(i++, mi.getString("EVENT_RATE"));		
					sql.setString(i++, mi.getString("APP_S_DT"));	
					sql.setString(i++, mi.getString("APP_E_DT"));	
					sql.setString(i++, mi.getString("NORM_MG_RATE"));	
					sql.setString(i++, mi.getString("BAS_AMT"));
					sql.setString(i++, mi.getString("REMARK"));	
					sql.setString(i++, strID);		
					sql.setString(i++, strID);		
					
					res = update(sql);

				} else if (mi.IS_UPDATE()) {

					// 마진코드 시작일이 변경 되었을 겨우 시작일보다 큰 시작일 수 조회
					if( !mi.getString("APP_S_DT").equals(mi.getString("ORG_APP_S_DT"))){
						i = 1;
						sql.put(svc.getQuery("SEL_MARGINMST_APPSDATE_CNT"));
						sql.put(svc.getQuery("SEL_MARGINMST_APPSDATE_CNT_WHERE_EVENT_FLAG"));
						sql.put(svc.getQuery("SEL_MARGINMST_APPSDATE_CNT_WHERE_NO_ORG_DATA"));
						sql.setString(i++, mi.getString("STR_CD"));	
						sql.setString(i++, mi.getString("PUMBUN_CD"));	
						sql.setString(i++, mi.getString("APP_S_DT"));	
						sql.setString(i++, mi.getString("EVENT_FLAG"));		
						sql.setString(i++, mi.getString("ORG_APP_S_DT"));		
						Map map = selectMap( sql );
						String appSDtCnt = String2.nvl((String)map.get("CNT"));
						
						if( !appSDtCnt.equals("0") ){
							throw new Exception("[USER]" + "["+mi.getString("APP_S_DT")+"] 최종 시작일 아닙니다.");
						}
						
						sql.close();
					}
					i = 1;
					sql.put(svc.getQuery("SEL_MARGINMST_APPSDATE"));
					sql.put(svc.getQuery("SEL_MARGINMST_APPSDATE_WHERE_EVENT_FLAG"));
					sql.put(svc.getQuery("SEL_MARGINMST_APPSDATE_WHERE_NO_ORG_DATA"));
					sql.setString(i++, mi.getString("STR_CD"));	
					sql.setString(i++, mi.getString("PUMBUN_CD"));	
					sql.setString(i++, mi.getString("APP_S_DT"));	
					sql.setString(i++, mi.getString("EVENT_FLAG"));	
					sql.setString(i++, mi.getString("ORG_APP_S_DT"));		
					Map map = selectMap( sql );
					String lastAppSDt = String2.nvl((String)map.get("APP_S_DT"));
					
					if( !lastAppSDt.equals("")){
						sql.close();
						i = 1;
						sql.put(svc.getQuery("UPD_MARGINMST_APPEDATE"));
						sql.put(svc.getQuery("UPD_MARGINMST_APPEDATE_WHERE_EVENT_FLAG"));
						sql.setString(i++, mi.getString("APP_S_DT"));	
						sql.setString(i++, strID);		
						sql.setString(i++, mi.getString("STR_CD"));	
						sql.setString(i++, mi.getString("PUMBUN_CD"));	
						sql.setString(i++, lastAppSDt);	
						sql.setString(i++, mi.getString("EVENT_FLAG"));
						
						update(sql);
					}
					sql.close();
					i = 1;
					
					sql.put(svc.getQuery("UPD_MARGINMST"));
					sql.setString(i++, mi.getString("NORM_MG_RATE"));	
					sql.setString(i++, mi.getString("APP_S_DT"));	
					sql.setString(i++, mi.getString("BAS_AMT"));	
					sql.setString(i++, mi.getString("REMARK"));	
					sql.setString(i++, strID);		
					sql.setString(i++, mi.getString("STR_CD"));	
					sql.setString(i++, mi.getString("PUMBUN_CD"));	
					sql.setString(i++, mi.getString("ORG_APP_S_DT"));	
					sql.setString(i++, mi.getString("EVENT_FLAG"));	
					
					res = update(sql);
				}

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
	 * 마진마스터   저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi[]
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strID)
			throws Exception {

		int ret 		= 0;
		int res 		= 0;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		String appSDt   = "";
		String appEDt   = "";
		String orgAppSDt   = "";
		int i;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			if(mi[1].next()){
				appSDt = mi[1].getString("APP_S_DT");
				appEDt = mi[1].getString("APP_E_DT");
				orgAppSDt = mi[1].getString("ORG_APP_S_DT");
				if(mi[1].IS_INSERT()){

					sql.close();
					// 마진코드 시작일보다 큰 시작일 조회
					i = 1;
					sql.put(svc.getQuery("SEL_MARGINMST_APPSDATE_CNT"));
					sql.setString(i++, mi[1].getString("STR_CD"));	
					sql.setString(i++, mi[1].getString("PUMBUN_CD"));	
					sql.setString(i++, appSDt);	
					Map map = selectMap( sql );
					String appSDtCnt = String2.nvl((String)map.get("CNT"));
					
					if( !appSDtCnt.equals("0")){
						throw new Exception("[USER]" + "["+appSDt+"] 최종 시작일 아닙니다.");
					}
					sql.close();
					i = 1;
					sql.put(svc.getQuery("SEL_MARGINMST_APPSDATE"));
					sql.setString(i++, mi[1].getString("STR_CD"));	
					sql.setString(i++, mi[1].getString("PUMBUN_CD"));	
					sql.setString(i++, appSDt);	
					map = selectMap( sql );
					String lastAppSDt = String2.nvl((String)map.get("APP_S_DT"));
					
					if( !lastAppSDt.equals("")){
						sql.close();
						i = 1;
						sql.put(svc.getQuery("UPD_MARGINMST_APPEDATE"));
						sql.setString(i++, appSDt);	
						sql.setString(i++, strID);		
						sql.setString(i++, mi[1].getString("STR_CD"));	
						sql.setString(i++, mi[1].getString("PUMBUN_CD"));	
						sql.setString(i++, lastAppSDt);	
						
						update(sql);
					}
				}else if(mi[1].IS_UPDATE()){

					// 마진코드 시작일이 변경 되었을 겨우 시작일보다 큰 시작일 수 조회
					i = 1;
					sql.put(svc.getQuery("SEL_MARGINMST_APPSDATE_CNT"));
					sql.put(svc.getQuery("SEL_MARGINMST_APPSDATE_CNT_WHERE_NO_ORG_DATA"));
					sql.setString(i++, mi[1].getString("STR_CD"));	
					sql.setString(i++, mi[1].getString("PUMBUN_CD"));	
					sql.setString(i++, appSDt);		
					sql.setString(i++, orgAppSDt);		
					Map map = selectMap( sql );
					String appSDtCnt = String2.nvl((String)map.get("CNT"));
					
					if( !appSDtCnt.equals("0") ){
						throw new Exception("[USER]" + "["+appSDt+"] 최종 시작일 아닙니다.");
					}
					sql.close();
					i = 1;
					sql.put(svc.getQuery("SEL_MARGINMST_APPSDATE"));
					sql.put(svc.getQuery("SEL_MARGINMST_APPSDATE_WHERE_NO_ORG_DATA"));
					sql.setString(i++, mi[1].getString("STR_CD"));	
					sql.setString(i++, mi[1].getString("PUMBUN_CD"));	
					sql.setString(i++, appSDt);	
					sql.setString(i++, orgAppSDt);		
					map = selectMap( sql );
					String lastAppSDt = String2.nvl((String)map.get("APP_S_DT"));
					
					if( !lastAppSDt.equals("")){
						sql.close();
						i = 1;
						sql.put(svc.getQuery("UPD_MARGINMST_APPEDATE"));
						sql.setString(i++, appSDt);	
						sql.setString(i++, strID);		
						sql.setString(i++, mi[1].getString("STR_CD"));	
						sql.setString(i++, mi[1].getString("PUMBUN_CD"));	
						sql.setString(i++, lastAppSDt);	
						
						update(sql);
					}
					sql.close();
					i = 1;
					sql.put(svc.getQuery("UPD_MARGINMST_ONLY_APPSDT"));
					sql.setString(i++, appSDt);	
					sql.setString(i++, strID);		
					sql.setString(i++, mi[1].getString("STR_CD"));	
					sql.setString(i++, mi[1].getString("PUMBUN_CD"));	
					sql.setString(i++, orgAppSDt);	
					
					update(sql);
					
				}
			}
			
			while (mi[0].next()) {//DateSet의 현제 appEDt_UPDATE, IS_DELETE
				appSDt = appSDt.equals("")?mi[0].getString("APP_S_DT"):appSDt;
				appEDt = appEDt.equals("")?mi[0].getString("APP_E_DT"):appEDt;
				orgAppSDt = orgAppSDt.equals("")?mi[0].getString("ORG_APP_S_DT"):orgAppSDt;
				sql.close();
				if (mi[0].IS_INSERT()) {
					// 마진코드 중복체크
					i = 1;
					sql.put(svc.getQuery("SEL_MARGIN_CNT"));

					sql.setString(i++, mi[0].getString("STR_CD"));	
					sql.setString(i++, mi[0].getString("PUMBUN_CD"));
					sql.setString(i++, mi[0].getString("EVENT_FLAG"));	
					sql.setString(i++, appSDt);	

					Map map = selectMap( sql );
					String cnt = String2.nvl((String)map.get("CNT"));
					
					if( !cnt.equals("0")) {
						throw new Exception("[USER]" + "["+mi[0].getString("EVENT_FLAG")+"] 중복되는 데이터가 존재합니다.");
					}
					
					sql.close();
					i = 1;
					sql.put(svc.getQuery("INS_MARGINMST"));

					sql.setString(i++, mi[0].getString("STR_CD"));	
					sql.setString(i++, mi[0].getString("PUMBUN_CD"));	
					sql.setString(i++, mi[0].getString("EVENT_FLAG"));	
					sql.setString(i++, mi[0].getString("EVENT_RATE"));		
					sql.setString(i++, appSDt);	
					sql.setString(i++, appEDt);	
					sql.setString(i++, mi[0].getString("NORM_MG_RATE"));	
					sql.setString(i++, mi[0].getString("BAS_AMT"));	
					sql.setString(i++, mi[0].getString("REMARK"));	
					sql.setString(i++, strID);		
					sql.setString(i++, strID);		
					
					res = update(sql);

				} else if (mi[0].IS_UPDATE()) {

					sql.close();
					i = 1;
					
					sql.put(svc.getQuery("UPD_MARGINMST"));

					sql.setString(i++, mi[0].getString("NORM_MG_RATE"));		
					sql.setString(i++, appSDt);	
					sql.setString(i++, mi[0].getString("BAS_AMT"));
					sql.setString(i++, mi[0].getString("REMARK"));	
					sql.setString(i++, strID);		
					sql.setString(i++, mi[0].getString("STR_CD"));	
					sql.setString(i++, mi[0].getString("PUMBUN_CD"));	
					sql.setString(i++, appSDt);	
					sql.setString(i++, mi[0].getString("EVENT_FLAG"));	
					
					res = update(sql);
				}

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
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
}
