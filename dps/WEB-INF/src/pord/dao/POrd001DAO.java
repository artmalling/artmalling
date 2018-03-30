/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.dao;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.base.BaseProperty;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.Date2;
import kr.fujitsu.ffw.util.String2;

import common.util.Util;





/**   
 * <p>   DAO </p>
 *           
 * @created  on 1.0, 2010/02/16  
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class POrd001DAO extends AbstractDAO {
    
	//private final static String FILE_PATH = BaseProperty.get("pot.upload.dir")+"slipfile/";
	/**
	 * 
	 *       
	 * @param form
	 * @return
	 * @throws Exception          
	 */
	public List searchMaster(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;       
		
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));			// 점
		String strSlipNo  = String2.nvl(form.getParam("strSlipNo"));		// 전표번호
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		
		strQuery = svc.getQuery("SEL_MASTER");
		sql.put(strQuery); 		
		ret = select2List(sql);
		return ret;
	}
	
	
	public List searchFile(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;       
		
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));			// 점
		String strSlipNo  = String2.nvl(form.getParam("strSlipNo"));		// 전표번호
		String strOrdSeqNo  = String2.nvl(form.getParam("strOrdSeqNo"));		// 전표번호
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		sql.setString(i++, strOrdSeqNo);
		
		strQuery = svc.getQuery("SEL_FILE");
		sql.put(strQuery); 		
		ret = select2List(sql);
		return ret;
	}
	
	public int saveFile(ActionForm form, MultiInput mi, String strID)
	throws Exception {

		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		Map map = null;
		
		InputStream	is      = null;
		OutputStream fout   = null;
		String strFilePath  = null;
		String strFileName  = null; 
		int maxFileSize     = 5;
		
		int i;
		try {
			connect("pot");
			begin();
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi.next()) {
				sql.close();				
				if ( mi.IS_INSERT()) {
					System.out.println("!!!!!!!"+BaseProperty.get("dps.upload.dir"));
					strFilePath = BaseProperty.get("dps.upload.dir")+ "slipfile/"; ;
					
					File filePath =  new File(strFilePath);
		        	if (!filePath.exists()) {
		        		filePath.mkdirs();
		        	}
		        	is = (InputStream)mi.get("FILE_PATH");
		        	strFileName = mi.getString("FILE_NAME");
		        	
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
					i = 0;							
					sql.put(svc.getQuery("INS_SLIPDTLFILE"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("SLIP_NO"));
					sql.setString(++i, mi.getString("ORD_SEQ_NO"));
					sql.setString(++i, mi.getString("FILE_NAME"));
					sql.setString(++i, mi.getString("O_FILE_NAME"));
					sql.setString(++i, mi.getString("FILE_COMMENT"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					
					
					
				} else if (mi.IS_UPDATE()){
		
					i = 0;							
					sql.put(svc.getQuery("UPD_SLIPDTLFILE"));
					sql.setString(++i, mi.getString("FILE_COMMENT"));
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("SLIP_NO"));
					sql.setString(++i, mi.getString("ORD_SEQ_NO"));
					sql.setString(++i, mi.getString("FILE_NAME"));
					
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
			end();
		}
	
		return ret;
	
	}
	
	public int deleteFile(ActionForm form, MultiInput mi)
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
				if ( mi.IS_DELETE()) {	
					
					i = 0;								
					sql.put(svc.getQuery("DEL_SLIPDTLFILE"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("SLIP_NO"));
					sql.setString(++i, mi.getString("ORD_SEQ_NO"));
					sql.setString(++i, mi.getString("FILE_NAME"));
					
				} else {
					continue;	
				}
				res = update(sql);
		
				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 삭제을 하지 못했습니다.");
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
	
	/*
	public static boolean saveFile(InputStream is, String strFileName) throws Exception
	{
		OutputStream fout 	= null; 
		int maxFileSize     = 20;
		try{
			
			System.out.println("--" + FILE_PATH);

			// File Upload    
			File filePath = new File(FILE_PATH);
			if(!filePath.exists()) filePath.mkdir(); 
			
			fout = new FileOutputStream(FILE_PATH + strFileName); 
			
			int read;
			long logSize = 0;
			byte[] buf = new byte[512]; 

			while ((read = is.read(buf)) != -1) {
				fout.write(buf, 0, read);
				logSize += read;
				if (logSize >= 1024 * 1024 * maxFileSize) {
					throw new Exception(
							"업로드되는 파일의 사이즈는 "+maxFileSize+"메가를 넘길 수 없습니다.");
				}
			} 
			 
	    } catch (Exception e) {
	        throw e;
	    } finally {
	    	fout.close();
	    }
		return true;
	}
	*/
}
