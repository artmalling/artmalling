
package com.study.dataset;

import com.shift.framework.model.Model;

/**
 * GauceDataSet[Image2Data]에서 GauceDataRow의 proxy 인터페이스
 */
public interface Image2Data extends Model {	

	/**
	 * GauceDataRow에서[IMAGE_ID] 컬럼에 String 값을 저장한다.
	 * @param arg 저장할 String 값
	 */
	public void setImage_id(String arg);
	
	/**
	 * GauceDataRow에서[IMAGE_ID] 컬럼의  String 값을 반환한다.
	 * @return String 값
	 */
	public String getImage_id(); 

	/**
	 * GauceDataRow에서[IMAGE] 컬럼에 java.io.InputStream 값을 저장한다.
	 * @param arg 저장할 java.io.InputStream 값
	 */
	public void setImage(java.io.InputStream arg);
	
	/**
	 * GauceDataRow에서[IMAGE] 컬럼의  java.io.InputStream 값을 반환한다.
	 * @return java.io.InputStream 값
	 */
	public java.io.InputStream getImage(); 

	/**
	 * GauceDataRow에서[IMAGE_SIZE] 컬럼에 int 값을 저장한다.
	 * @param arg 저장할 int 값
	 */
	public void setImage_size(int arg);
	
	/**
	 * GauceDataRow에서[IMAGE_SIZE] 컬럼의  int 값을 반환한다.
	 * @return int 값
	 */
	public int getImage_size(); 

}