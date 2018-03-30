package com.study.bean;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;

import com.shift.framework.common.DefaultIbatisBean;
import com.shift.framework.conf.BeaverConfigManager;
import com.shift.framework.model.Model;
import com.shift.framework.model.ModelSet;

public class SampleBean extends DefaultIbatisBean {

	public SampleBean() throws Exception {
		
	}

	/**
	 * 파일 업로드 처리용 메소드 (InputStream을 파일로 생성한다)
	 * @param is	InputStream
	 * @param os	OutputStream
	 * @param bufsize
	 */
	private void copy( InputStream 	is, OutputStream os, int bufsize	) {
	    try {
	        synchronized (is) {
	            synchronized (os) {
	                byte[] buf = new byte[bufsize];
	                while (true) {
	                    int bread = is.read(buf);
	                    if (bread == -1) break;
	                    os.write(buf, 0, bread);
	                }
	            }
	        }
	    } catch (IOException ioe) {
			ioe.fillInStackTrace();
	    } finally {
	    	try {
				is.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    	try {
				os.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    }
	}
	
	/**
	 * FILE UPLOAD
	 * @param rows
	 * @throws Exception
	 */
	public void fileUpload(List rows) throws Exception {
		String uploadPath = BeaverConfigManager.getUserProperty("UPLOAD_PATH");
		for (int i=0; i<rows.size(); i++) {
			HashMap row = (HashMap)rows.get(i);
			System.out.println(row);
			String fileName = (String)row.get("FILE_NAME");
			fileName = fileName.substring(fileName.lastIndexOf("\\"));

			
			FileOutputStream fos = new FileOutputStream(uploadPath + fileName + System.currentTimeMillis());
			
			InputStream is = (InputStream)row.get("FILE_URL");
			
			
			copy(is, fos, 1024);
			
		}
	}
	
	/**
	 * LogicalTR Multi Select Sample
	 * @param set
	 * @param set2
	 * @param param
	 * @throws Exception
	 */
	public void selectMultiList( ModelSet set, ModelSet set2, HashMap param ) throws Exception {
		this.sqlMapper.queryForModelSet("SAMPLE.SELECT", param, set);
		this.sqlMapper.queryForModelSet("SAMPLE.SELECT_DEPT", param, set2);
	}
	
	
	/**
	 * Retrieve Emp Info
	 * @param param		Parameter's
	 * @return
	 * @throws Exception
	 */
	public void selectEmpList( ModelSet set, HashMap param ) throws Exception {
		this.sqlMapper.queryForModelSet("SAMPLE.SELECT", param, set);
	}
	
	/**
	 * Save Emp
	 * @param rows
	 * @throws Exception
	 */
	public void saveEmpList(List rows) throws Exception {
		
		try {
			this.sqlMapper.startTransaction();
			for (int i=0; i<rows.size(); i++) {
				HashMap row = (HashMap)rows.get(i);
				System.out.println(row);
				
				switch(Integer.parseInt((String)row.get("JOB_TYPE_CODE"))) {
					case Model.JOBTYPE_INSERT:
						this.sqlMapper.insert("SAMPLE.INSERT", row);
						break;
					case Model.JOBTYPE_UPDATE:
						System.out.println(row);
						this.sqlMapper.update("SAMPLE.UPDATE", row);
						break;
					case Model.JOBTYPE_DELETE:
						this.sqlMapper.delete("SAMPLE.DELETE", row);
						break;
				}
			}	
			this.sqlMapper.commitTransaction();
		} finally {
			this.sqlMapper.endTransaction();
		}

	}
}
