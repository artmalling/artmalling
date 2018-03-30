
package com.study.dataset;

import com.shift.framework.model.Model;

/**
 * GauceDataSet[MENUDATA]에서 GauceDataRow의 proxy 인터페이스
 */
public interface MenuData extends Model {	

	/**
	 * GauceDataRow에서[TEXT] 컬럼에 String 값을 저장한다.
	 * @param arg 저장할 String 값
	 */
	public void setText(String arg);
	
	/**
	 * GauceDataRow에서[TEXT] 컬럼의  String 값을 반환한다.
	 * @return String 값
	 */
	public String getText(); 

	/**
	 * GauceDataRow에서[LEVEL] 컬럼에 String 값을 저장한다.
	 * @param arg 저장할 String 값
	 */
	public void setLevel(String arg);
	
	/**
	 * GauceDataRow에서[LEVEL] 컬럼의  String 값을 반환한다.
	 * @return String 값
	 */
	public String getLevel(); 

	/**
	 * GauceDataRow에서[CODE] 컬럼에 String 값을 저장한다.
	 * @param arg 저장할 String 값
	 */
	public void setCode(String arg);
	
	/**
	 * GauceDataRow에서[CODE] 컬럼의  String 값을 반환한다.
	 * @return String 값
	 */
	public String getCode(); 

	/**
	 * GauceDataRow에서[ENABLE] 컬럼에 String 값을 저장한다.
	 * @param arg 저장할 String 값
	 */
	public void setEnable(String arg);
	
	/**
	 * GauceDataRow에서[ENABLE] 컬럼의  String 값을 반환한다.
	 * @return String 값
	 */
	public String getEnable(); 

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

}