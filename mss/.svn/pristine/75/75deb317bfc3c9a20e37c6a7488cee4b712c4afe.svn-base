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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.FileControlMgr;

/**
 * <p>계량기관리 </p>
 * 
 * @created  on 1.0, 2010.04.01
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen108DAO extends AbstractDAO {
	
	/**
	 * <p>계량기관리조회</p>
	 */
	@SuppressWarnings("rawtypes")
	public List getMaster(ActionForm form) throws Exception {
		
		List       list = null;
		SqlWrapper  sql = null;
		Service     svc = null;
		try {
			connect("pot");
			svc  = (Service)form.getService();
			sql  = new SqlWrapper(); 
			String strFlcFlag	= String2.nvl(form.getParam("strFlcFlag"));	// 시설구분
			String strGaugType	= String2.nvl(form.getParam("strGaugType"));// 계량기구분
			String strGaugID	= String2.nvl(form.getParam("strGaugID"));	// 계량기ID
			int i = 0;
			sql.put(svc.getQuery("SEL_MR_GAUGMST"));
			sql.setString(++i, strGaugID);
			sql.setString(++i, strGaugType);
			sql.setString(++i, strFlcFlag);
			list = select2List(sql);	         
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	/**
	 * <p>계량기관리조회(상세)</p>
	 */
	@SuppressWarnings("rawtypes")
	public List getDetail(ActionForm form) throws Exception {
		
		List       list = null;
		SqlWrapper  sql = null;
		Service     svc = null;
		try {
			connect("pot");
			svc  = (Service)form.getService();
			sql  = new SqlWrapper(); 
			String strFlcFlag	= String2.nvl(form.getParam("strFlcFlag"));	// 시설구분
			String strGaugID	= String2.nvl(form.getParam("strGaugID"));	// 계량기ID
			int i = 0;
			sql.put(svc.getQuery("SEL_MR_GAUGMST_DTL"));
			sql.setString(++i, strGaugID);
			sql.setString(++i, strFlcFlag);
			list = select2List(sql);	
			
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	/**
	 * <p>
	 * 계량기관리 저장
	 * </p>
	 */
	public int save(ActionForm form, MultiInput miMst, MultiInput miDtl, String userID)
			throws Exception {
		int ret = 0;
		int resMst = 0;
		int resDtl = 0;
		SqlWrapper sql = null;
		Service svc = null;
        InputStream in	= null;
        
        FileControlMgr fileMgr	= null;
		try {
			connect("pot");
			begin(); // DB트렌젝션 시작
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			//마스터 계량기 정보
			while (miMst.next()) {
				
				sql.close();
				fileMgr = new FileControlMgr();
				//신규 저장에 사용 할 파일명
				
				if (miMst.IS_INSERT()) {					
					//in = (InputStream) miMst.get("FILE_PATH_REAL");
					
					//String db_file_path = fileMgr.fileReNameDB(miMst.getString("FILE_PATH"), miMst.getString("GAUG_ID"));
					
					sql.put(svc.getQuery("INS_MR_GAUGMST"));
					int i = 0;
					sql.setString(++i, miMst.getString("GAUG_TYPE"));
					sql.setString(++i, miMst.getString("INST_PLC"));
					sql.setString(++i, miMst.getString("GAUG_LVL"));
					sql.setString(++i, miMst.getString("GAUG_USE_FLAG"));
					sql.setString(++i, miMst.getString("DIV_RULE_TYPE"));
					sql.setString(++i, miMst.getString("GAUG_KIND_CD"));
					sql.setString(++i, miMst.getString("PWR_TYPE"));
					sql.setString(++i, miMst.getString("PWR_SEL_CHARGE"));
					sql.setString(++i, miMst.getString("PWR_CNTR_QTY"));
					sql.setString(++i, miMst.getString("GAUG_MULTIPLE"));
					sql.setString(++i, miMst.getString("WWTR_CHARGE_YN"));
					sql.setString(++i, miMst.getString("WTR_CAL_SIZE"));
					sql.setString(++i, miMst.getString("VALID_S_DT"));
					sql.setString(++i, miMst.getString("VALID_E_DT"));
					sql.setString(++i, "");	// 변경된 파일명(PATH)
					sql.setString(++i, miMst.getString("STR_CD"));
					sql.setString(++i, miMst.getString("INST_STR_CD"));
					sql.setString(++i, miMst.getString("HIGH_GAUG_ID"));
					sql.setString(++i, userID);					
					resMst = update(sql);
					
					if (resMst != 1) {
						throw new Exception("" + "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					} else {
						//DB저장이 정상적으로 이뤄졌을경우 파일처리
                		addFileContlor(miMst.getString("FILE_GB"), in, miMst.getString("FILE_PATH"), miMst.getString("GAUG_ID"), miMst.getString("OLD_FILE_PATH"));
					}
				} else if (miMst.IS_DELETE()) {
					// 파일삭제
					addFileContlor(miMst.getString("FILE_GB"), in, miMst.getString("FILE_PATH"), miMst.getString("GAUG_ID"), miMst.getString("OLD_FILE_PATH"));
				} else if (miMst.IS_UPDATE()) {
					
        			//변경내역 저장
					sql.put(svc.getQuery("UPD_MR_GAUGMST"));
					int i = 0;
					sql.setString(++i, miMst.getString("GAUG_TYPE"));
					sql.setString(++i, miMst.getString("INST_PLC"));
					sql.setString(++i, miMst.getString("GAUG_LVL"));
					sql.setString(++i, miMst.getString("GAUG_USE_FLAG"));
					sql.setString(++i, miMst.getString("DIV_RULE_TYPE"));
					sql.setString(++i, miMst.getString("GAUG_KIND_CD"));
					sql.setString(++i, miMst.getString("PWR_TYPE"));
					sql.setString(++i, miMst.getString("PWR_SEL_CHARGE"));
					sql.setString(++i, miMst.getString("PWR_CNTR_QTY"));
					sql.setString(++i, miMst.getString("GAUG_MULTIPLE"));
					sql.setString(++i, miMst.getString("WWTR_CHARGE_YN"));
					sql.setString(++i, miMst.getString("WTR_CAL_SIZE"));
					sql.setString(++i, miMst.getString("VALID_S_DT"));
					sql.setString(++i, miMst.getString("VALID_E_DT"));
					sql.setString(++i, miMst.getString("FILE_PATH"));
					sql.setString(++i, miMst.getString("STR_CD"));
					sql.setString(++i, miMst.getString("INST_STR_CD"));
					sql.setString(++i, miMst.getString("HIGH_GAUG_ID"));
					sql.setString(++i, userID);
					sql.setString(++i, miMst.getString("GAUG_ID"));
					resMst = update(sql);
					
					if (resMst != 1) {
						throw new Exception("" + "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					} else {
						// 파일처리(삭제)
						addFileContlor(miMst.getString("FILE_GB"), in, miMst.getString("FILE_PATH"), miMst.getString("GAUG_ID"), miMst.getString("OLD_FILE_PATH"));
					}
				}
			}
			//서브계량기 정보
			while (miDtl.next()) {
				sql.close();
				if (miDtl.IS_UPDATE()||miDtl.IS_INSERT()) {
					sql.put(svc.getQuery("UPD_MR_GAUGMST_DTL"));
					int i = 0;
					sql.setString(++i, miDtl.getString("HIGH_GAUG_ID"));
					sql.setString(++i, userID);
					sql.setString(++i, miDtl.getString("GAUG_ID"));
					resDtl += update(sql);
				} else if (miDtl.IS_DELETE()) {
					sql.put(svc.getQuery("UPD_MR_GAUGMST_DTL"));
					int i = 0;
					sql.setString(++i, "");
					sql.setString(++i, userID);
					sql.setString(++i, miDtl.getString("GAUG_ID"));
					resDtl += update(sql);
				}
			}
			//마스터변경내역이 있을땐 마스터 처리내역만 마스터처리내역이 없을땐 디테일 처리내역반환
			if (resMst > 0) { 
				ret = resMst;
			} else {
				ret = resDtl;
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
	 * <p> 파일컨트롤  </p>
	 * @param form, mi, strID
	 * @return ret
	 * @throws Exception
	 */
	public Boolean addFileContlor(String file_gbn, InputStream in, String strPath, String strKey, String strOldPath )
	throws Exception {
		
		FileControlMgr fileMgr	= null;
		try {
			fileMgr = new FileControlMgr();
			
    		if (file_gbn.equals("Y")) {
        		Boolean retnn = fileMgr.fileSave(strPath, strKey, in, strOldPath, 5);
        		if (!retnn)  {
        			throw new Exception("" + "파일저장이 정상적으로 이루어 지지 않았습니다.");
        		}
    		} else if (file_gbn.equals("D")) {
        		Boolean retnn = fileMgr.fileDelete(strOldPath);
        		if (!retnn)  {
        			throw new Exception("" + "파일삭제가 정상적으로 이루어 지지 않았습니다.");
        		}
    		}
		} catch (Exception e) {
			throw e;
		} 
		
		return true;
	}
}	

