/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.base.BaseProperty;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.Date2;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>영업관리 > 매출관리 > 도면매출 > 도면관리</p>
 * 
 * @created  on 1.0, 2010/06/27
 * @created  by 정진영(FKSS)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal438DAO extends AbstractDAO {

	/**
	 * 마스터 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 1;

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strFloorCd 		= String2.nvl(form.getParam("strFloorCd"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_MASTER"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strFloorCd);
		

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 도면을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchFloorPlan(ActionForm form) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 1;		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strFloorCd 		= String2.nvl(form.getParam("strFloorCd"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_FLOOR_PLAN"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strFloorCd);
		
		// MARIO OUTLET 2011.08.17
		sql.setString(i++, strStrCd);
		sql.setString(i++, strFloorCd);
		
		

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 도면정보
	 * 도면품번정보,
	 * 
	 * 저장, 수정  , 삭제 처리한다.
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
		try {
			connect("pot");
			begin();
			
			// 도면 정보
			ret += saveFloorPlan(form, mi[0], strID);
			// 도면품번 정보
			ret += saveFloorPosition(form, mi[1], strID);

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	/**
	 *  <p>
	 *  도면정보를 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveFloorPlan(ActionForm form, MultiInput mi, String strID) 
						throws Exception {

		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		
		InputStream	is      = null;
		OutputStream fout   = null;
		String strFilePath  = null;
		String strFileName  = null; 
		int maxFileSize     = 5;
		
		int i;
		try {
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				sql.close();
				
				if (!mi.IS_DELETE()) {
					strFilePath = BaseProperty.get("dps.upload.dir") + "floorPlan/"; 
					strFileName = Date2.getDateWithMillisecond() + "_" ;
					System.out.println(strFilePath + strFileName);
					File filePath =  new File(strFilePath);
		        	if (!filePath.exists()) {
		        		filePath.mkdirs();
		        	}
		        	is = (InputStream)mi.get("FILE_PATH");
		        	strFileName += mi.getString("FILENAME");
		        	
		        	if(is.available() != 0){
		        		fout = new FileOutputStream(strFilePath + strFileName);
						int read;
						long longSize = 0;
						byte[] buf = new byte[512];
						
						while ((read = is.read(buf)) != -1) {
							fout.write(buf, 0, read);
							longSize += read;
							if (longSize >= 1024 * 1024 * maxFileSize) {
								throw new Exception(
										"[USER] "+maxFileSize+" 업로드 용량을 초가 하였습니다.");
							}
						} 
						fout.close();
		        	}
		        	if( mi.getString("ROW_STATUS").equals("I")){
						i = 0;							
						sql.put(svc.getQuery("INS_FLOOR_PLAN"));
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, mi.getString("FLOOR_CD"));
						sql.setString(++i, strFileName);
						sql.setString(++i, strID);
						sql.setString(++i, strID);
		        	}else{
						i = 0;							
						sql.put(svc.getQuery("UPD_FLOOR_PLAN"));
						sql.setString(++i, strFileName);
						sql.setString(++i, strID);
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, mi.getString("FLOOR_CD"));		        		
		        	}
					
				} else {
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
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}

	/**
	 * <p>
	 * 도면 품번 정보 저장
	 * </p>
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveFloorPosition(ActionForm form, MultiInput mi, String strID) 
						throws Exception {

		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		try {
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				sql.close();
				//신규입력된데이터
				if ( mi.IS_INSERT()) {
					//신규입력
					i = 0;							
					sql.put(svc.getQuery("INS_FLOOR_POSITION"));	
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("FLOOR_CD"));
					sql.setString(++i, mi.getString("PUMBUN_CD"));
					sql.setInt(   ++i, mi.getInt(   "SPOT_X"));
					sql.setInt(   ++i, mi.getInt(   "SPOT_Y"));
					sql.setString(++i, mi.getString("VIRE_YN"));
					sql.setString(++i, mi.getString("RETAIL_VIEW_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					
				//수정된 데이터
				} else if (mi.IS_UPDATE()){
					i = 0;							
					sql.put(svc.getQuery("UPD_FLOOR_POSITION"));	
					sql.setInt(   ++i, mi.getInt(   "SPOT_X"));
					sql.setInt(   ++i, mi.getInt(   "SPOT_Y"));
					sql.setString(++i, mi.getString("VIRE_YN"));
					sql.setString(++i, mi.getString("RETAIL_VIEW_YN"));
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("FLOOR_CD"));
					sql.setString(++i, mi.getString("PUMBUN_CD"));
					
					
				} else if (mi.IS_DELETE()) {
					i = 0;							
					sql.put(svc.getQuery("DEL_FLOOR_POSITION"));	
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("FLOOR_CD"));
					sql.setString(++i, mi.getString("PUMBUN_CD"));
				}

				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 처리를 하지 못했습니다.");
				}

				ret += res;
			}


		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}

	/**
	 *  <p>
	 *  도면정보를삭제한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, MultiInput mi) 
						throws Exception {

		int ret = 0;
		int res = 0;
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
				
				if (mi.IS_DELETE()) {
					i = 0;							
					sql.put(svc.getQuery("DEL_FLOOR_POSITION_NOT_PUMBUN"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("FLOOR_CD"));
					update(sql);
					sql.close();
					i = 0;							
					sql.put(svc.getQuery("DEL_FLOOR_PLAN"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("FLOOR_CD"));		        		
		        	
					
				} else {
					continue;	
				}
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 삭제를 하지 못했습니다.");
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
