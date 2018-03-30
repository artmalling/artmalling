/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.dao;

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
/**
 * <p>업무배너관리</p>
 *  
 * @created  on 1.0, 2010/07/19
 * @created  by HSEON(FKL)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class TCom404DAO extends AbstractDAO { 
	
	private final static String FILE_PATH = BaseProperty.get("pot.upload.dir")+"banner/"; 

	/**
	 * 배너리스트를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectBannerList(ActionForm form) throws Exception {
		
		List 		list 	= null;
		SqlWrapper 	sql 	= null;
		Service 	svc 	= null; 

		
        try {  
			sql = new SqlWrapper();
			svc = (Service) form.getService();
	
			connect("pot");
			sql.put(svc.getQuery("SEL_BANNER_LIST")); 
			
			list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}

	/**
	 *  사용자 로그인이력을 보여준다.
	 *  POPUP
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectLogHistory(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	 

        try { 
			String strUserId = String2.nvl(form.getParam("strUserId"));	//사용자id 
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
	
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper(); 

			sql.put(svc.getQuery("SEL_LOG_HISTORY"));
			sql.setString(1, strUserId);  
			
			list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}
	

    /**
	 * <p>
	 * 배너정보를 등록/수정한다. 
	 * </p>
	 * 
	 */
	public int saveBanner(ActionForm form, MultiInput mi, String userId)  throws Exception {
		
        SqlWrapper  sql = null;
        Service     svc = null; 
		int 		res = 0;
		int 		ret = 0; 
		int		 	insRet = 0; 

		int i = 0;
		InputStream	is      = null; 
		String fileReName	= null;
		
		
        try {

			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			boolean bl = false;
			while (mi.next()) 
			{ 
				sql.close();
				if (mi.IS_INSERT())
				{
			    	sql.close(); 
					fileReName = Date2.getDateWithMillisecond() + "_" + mi.getString("FILE_NM") ;
					i = 0;
					
					sql.put(svc.getQuery("INS_BANNER")); 
					
					sql.setString(++i, mi.getString("BAN_NO"));  
					sql.setString(++i, mi.getString("BAN_NAME"));  
					sql.setString(++i, mi.getString("BAN_LINK"));  
					sql.setString(++i, fileReName );  
					sql.setString(++i, mi.getString("USE_YN"));  
					sql.setString(++i, userId); 
					sql.setString(++i, userId); 

					ret = update(sql); 
					
					// FILE UPLOAD
					is = (InputStream)mi.get("FILE_PATH");  
					if(ret > 0)  
					{
						bl = saveFile(is, fileReName);  
						if(!bl)
							throw new Exception("File Upload를 실패하였습니다."); 
					}
					insRet++;

				} else if (mi.IS_UPDATE()) {
			    	sql.close();

					is = (InputStream)mi.get("FILE_PATH");
					
					if(!(mi.getString("FILE_NM")).equals(mi.getString("ORG_FILE_NM"))) 
						fileReName = Date2.getDateWithMillisecond() + "_" + mi.getString("FILE_NM") ;
					else
						fileReName = mi.getString("FILE_NM") ;
					
					i = 0;
					sql.put(svc.getQuery("MERGE_BANNER")); 
					sql.setString(++i, mi.getString("BAN_NO"));  
					sql.setString(++i, mi.getString("BAN_NAME"));  
					sql.setString(++i, mi.getString("BAN_LINK"));
					sql.setString(++i, fileReName);    
					sql.setString(++i, mi.getString("USE_YN"));  
					sql.setString(++i, userId);  
					

					ret = update(sql);  

					if(ret > 0 && !(mi.getString("FILE_NM")).equals(mi.getString("ORG_FILE_NM")) ) 
					{
						bl = saveFile(is, fileReName);  
						if(!bl)
							throw new Exception("File Upload를 실패하였습니다."); 
					}

					insRet++;
				} else if (mi.IS_DELETE()) {  

			    	sql.close();
					i = 0;						
					sql.put(svc.getQuery("SEL_BANNER_CNT"));	 
		        	sql.setString(++i, mi.getString("BAN_NO"));
					
					Map map = selectMap(sql);	
					String cnt = String2.nvl((String)map.get("CNT")); 
					
					if(!"0".equals(cnt))
					{
				    	sql.close();
						i = 0;
						sql.put(svc.getQuery("DEL_BANNER")); 
						sql.setString(++i, mi.getString("BAN_NO"));  

						update(sql);  
						
						// FILE 삭제
						File f = new File(FILE_PATH + mi.getString("ORG_FILE_NM"));
						if(f != null){ 
							f.delete();
						}
					} 
				}  
			}

			if (ret < 1) {
				throw new Exception("데이터의 정합성 문제로 인하여  데이터 처리하지 못했습니다.");
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return insRet;
		
	}


    /**
	 * <p>
	 * FILE UPLOAD
	 * </p>
	 * 
	 */
	public static boolean saveFile(InputStream is, String strFileName) throws Exception
	{
		OutputStream fout 	= null; 
		int maxFileSize     = 5;
		try{

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
	
	
}
