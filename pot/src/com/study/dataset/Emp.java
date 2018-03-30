
package com.study.dataset;

import com.shift.framework.model.Model;

/**
 * GauceDataSet[Emp]에서 GauceDataRow의 proxy 인터페이스
 */
public interface Emp extends Model {	

	/**
	 * GauceDataRow에서[EMP_NO] 컬럼에 String 값을 저장한다.
	 * @param arg 저장할 String 값
	 */
	public void setEmp_no(String arg);
	
	/**
	 * GauceDataRow에서[EMP_NO] 컬럼의  String 값을 반환한다.
	 * @return String 값
	 */
	public String getEmp_no(); 

	/**
	 * GauceDataRow에서[EMP_NM] 컬럼에 String 값을 저장한다.
	 * @param arg 저장할 String 값
	 */
	public void setEmp_nm(String arg);
	
	/**
	 * GauceDataRow에서[EMP_NM] 컬럼의  String 값을 반환한다.
	 * @return String 값
	 */
	public String getEmp_nm(); 

	/**
	 * GauceDataRow에서[BIRTH_DATE] 컬럼에 String 값을 저장한다.
	 * @param arg 저장할 String 값
	 */
	public void setBirth_date(String arg);
	
	/**
	 * GauceDataRow에서[BIRTH_DATE] 컬럼의  String 값을 반환한다.
	 * @return String 값
	 */
	public String getBirth_date(); 

	/**
	 * GauceDataRow에서[GRADE_CD] 컬럼에 String 값을 저장한다.
	 * @param arg 저장할 String 값
	 */
	public void setGrade_cd(String arg);
	
	/**
	 * GauceDataRow에서[GRADE_CD] 컬럼의  String 값을 반환한다.
	 * @return String 값
	 */
	public String getGrade_cd(); 

	/**
	 * GauceDataRow에서[DEPT_CD] 컬럼에 String 값을 저장한다.
	 * @param arg 저장할 String 값
	 */
	public void setDept_cd(String arg);
	
	/**
	 * GauceDataRow에서[DEPT_CD] 컬럼의  String 값을 반환한다.
	 * @return String 값
	 */
	public String getDept_cd(); 

	/**
	 * GauceDataRow에서[LEVEL_CD] 컬럼에 String 값을 저장한다.
	 * @param arg 저장할 String 값
	 */
	public void setLevel_cd(String arg);
	
	/**
	 * GauceDataRow에서[LEVEL_CD] 컬럼의  String 값을 반환한다.
	 * @return String 값
	 */
	public String getLevel_cd(); 

}