/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import kr.fujitsu.ffw.base.BaseProperty;

/**
 * @created  on 1.0, 2010.04.25
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class FileControlMgr {
	
	/* DIR경로  */ 
	public static final String FILE_DIR = BaseProperty.get("mss.file.upload.dir")+"upload/";
	public static final String WEB_DIR = BaseProperty.get("mss.file.upload.web");
	
	/* DB에 저장할 경로를 포함한 파일명 반환 */
	public String fileReNameDB(String strPath, String strKey) {
		String file_name = "";
		file_name = strPath.substring((strPath.lastIndexOf("\\")+1),strPath.lastIndexOf(".")); //기존파일명
		file_name += "_" + strKey;
		file_name += strPath.substring(strPath.lastIndexOf("."));  //확장자
		file_name = WEB_DIR+""+file_name;	//DB저장(ContextPath)
		
		return file_name;
	}
	
	/* 실제 저장할 경로를 포함한 파일명 반환 */
	public String fileReNameSave(String strPath, String strKey) {
		String file_name = "";
		file_name = strPath.substring((strPath.lastIndexOf("\\")+1),strPath.lastIndexOf(".")); //기존파일명
		file_name += "_" + strKey;
		file_name += strPath.substring(strPath.lastIndexOf("."));  //확장자
		file_name = FILE_DIR +""+file_name;	//파일저장(RealPath)
		
		return file_name;
	}
	
	/* 실제 삭제되어야 할 경로를 포함한 파일명 반환 */
	public String fileReNameDel(String strPath) {
		String file_name = "";
		
		if (strPath.lastIndexOf("/") != -1) {
			file_name = strPath.substring((strPath.lastIndexOf("/")+1)); //기존파일명 
		} else if (strPath.lastIndexOf("/") != -1) {
			file_name = strPath.substring((strPath.lastIndexOf("\\")+1)); //기존파일명 
		} else {
			file_name = strPath;
		}
		
		file_name = strPath.substring((strPath.lastIndexOf("/")+1)); //기존파일명 
		file_name = FILE_DIR +""+file_name;	//파일저장(RealPath)
		return file_name;
	}
	
    /**
     * <p> 파일저장  </p>
     * @param String strPath 			: WAS저장파일명(파일명포함)        
     *        String strKey 			: WAS저장파일명 변경에 필요한 키문자열
     *        InputStream inFile 		: 실제파일명/경로
     *        String strOldPath 		: 삭제할 파일명(이전파일명)
     *        int maxSize 				: 제한할 용량 1(Mbyte단위)
     * @return Boolean
     * @throws Exception
     */
	public Boolean fileSave(String strPath, String strKey, InputStream inFile, String strOldPath, int maxSize)
    throws Exception {
		OutputStream out	= null;
        try {
        	System.out.println("파일 저장중... ");
        	// 이전 파일삭제
        	if (!strOldPath.equals("") || !strOldPath.equals(null)) {
    			fileDelete(strOldPath);
        	}
        	
			// 파일저장
        	System.out.println("파일 저장 (경로): " +  fileReNameSave(strPath, strKey) );
        	
        	//경로없을 시 생성
        	File filePath =  new File(FILE_DIR);
        	if (!filePath.exists()) {
        		filePath.mkdirs();
        	}
        	
			out = new FileOutputStream( fileReNameSave(strPath, strKey) );
			long size = 0;
			int read;
			byte[] buf = new byte[1024*maxSize];
			while ((read = inFile.read(buf)) != -1) {
				out.write(buf, 0, read);
				size += read;
				if (size >= 1024 * 1024 * maxSize) {
					throw new Exception(
							"업로드되는 파일의 사이즈는 "+maxSize+"메가를 넘길 수 없습니다.");
				}
			}
        } catch (Exception e) {
            throw e;
        } finally {
        	out.close();
        }
        
        return true;
    }
	
	/**
	 * <p> 파일삭제  </p>
     * @param String strOldPath 		: 삭제할 파일명/경로
     * @return Boolean
     * @throws Exception
	 */
	public Boolean fileDelete(String strOldPath)
	throws Exception {
		try {
			System.out.println("파일 삭제중...");
			/* 파일삭제 */
			if (!strOldPath.equals("") || !strOldPath.equals(null)) {
	        	// 이전 파일삭제
	        	System.out.println("파일 삭제(경로): " +  fileReNameDel(strOldPath) );
				File old_file = new File( fileReNameDel(strOldPath) );
				System.gc();
				if (old_file.exists()) {
					old_file.delete();
				} 
			} else {
				System.out.println("삭제할 파일경로가 없습니다.");
			}

		} catch (Exception e) {
            throw e;
		} 
		
		return true;
	}
}
