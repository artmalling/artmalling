
package com.study.dataset;

import com.shift.framework.model.Model;

/**
 * GauceDataSet[IMAGE]에서 GauceDataRow의 proxy 인터페이스
 */
public interface Image extends Model {	

	/**
	 * GauceDataRow에서[IMG_ID] 컬럼에 String 값을 저장한다.
	 * @param arg 저장할 String 값
	 */
	public void setImg_id(String arg);
	
	/**
	 * GauceDataRow에서[IMG_ID] 컬럼의  String 값을 반환한다.
	 * @return String 값
	 */
	public String getImg_id(); 

	/**
	 * GauceDataRow에서[IMG] 컬럼에 java.io.InputStream 값을 저장한다.
	 * @param arg 저장할 java.io.InputStream 값
	 */
	public void setImg(java.io.InputStream arg);
	
	/**
	 * GauceDataRow에서[IMG] 컬럼의  java.io.InputStream 값을 반환한다.
	 * @return java.io.InputStream 값
	 */
	public java.io.InputStream getImg(); 

	/**
	 * GauceDataRow에서[IMG_SIZE] 컬럼에 int 값을 저장한다.
	 * @param arg 저장할 int 값
	 */
	public void setImg_size(int arg);
	
	/**
	 * GauceDataRow에서[IMG_SIZE] 컬럼의  int 값을 반환한다.
	 * @return int 값
	 */
	public int getImg_size(); 

}