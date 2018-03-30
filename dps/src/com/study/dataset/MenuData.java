
package com.study.dataset;

import com.shift.framework.model.Model;

/**
 * GauceDataSet[MENUDATA]���� GauceDataRow�� proxy �������̽�
 */
public interface MenuData extends Model {	

	/**
	 * GauceDataRow����[TEXT] �÷��� String ���� �����Ѵ�.
	 * @param arg ������ String ��
	 */
	public void setText(String arg);
	
	/**
	 * GauceDataRow����[TEXT] �÷���  String ���� ��ȯ�Ѵ�.
	 * @return String ��
	 */
	public String getText(); 

	/**
	 * GauceDataRow����[LEVEL] �÷��� String ���� �����Ѵ�.
	 * @param arg ������ String ��
	 */
	public void setLevel(String arg);
	
	/**
	 * GauceDataRow����[LEVEL] �÷���  String ���� ��ȯ�Ѵ�.
	 * @return String ��
	 */
	public String getLevel(); 

	/**
	 * GauceDataRow����[CODE] �÷��� String ���� �����Ѵ�.
	 * @param arg ������ String ��
	 */
	public void setCode(String arg);
	
	/**
	 * GauceDataRow����[CODE] �÷���  String ���� ��ȯ�Ѵ�.
	 * @return String ��
	 */
	public String getCode(); 

	/**
	 * GauceDataRow����[ENABLE] �÷��� String ���� �����Ѵ�.
	 * @param arg ������ String ��
	 */
	public void setEnable(String arg);
	
	/**
	 * GauceDataRow����[ENABLE] �÷���  String ���� ��ȯ�Ѵ�.
	 * @return String ��
	 */
	public String getEnable(); 

	/**
	 * GauceDataRow����[IMAGE_ID] �÷��� String ���� �����Ѵ�.
	 * @param arg ������ String ��
	 */
	public void setImage_id(String arg);
	
	/**
	 * GauceDataRow����[IMAGE_ID] �÷���  String ���� ��ȯ�Ѵ�.
	 * @return String ��
	 */
	public String getImage_id(); 

}