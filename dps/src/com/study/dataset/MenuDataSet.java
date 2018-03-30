
package com.study.dataset;

import com.shift.framework.model.ModelSet;

/**
 * GauceDataSet [MENUDATA] �� proxy�� �������̽�
 */
public interface MenuDataSet extends ModelSet{

    /**
	 * GauceDataSet�� �̸��� �����ϴ� ����
	 */
	public static final String SET_NAME = "MENUDATA";
		
	/**
	 * GauceDataRow�� [TEXT]�÷��� �̸��� �����ϴ� ����
	 */
	public static final String TEXT = "TEXT";
		
	/**
	 * GauceDataRow�� [LEVEL]�÷��� �̸��� �����ϴ� ����
	 */
	public static final String LEVEL = "LEVEL";
		
	/**
	 * GauceDataRow�� [CODE]�÷��� �̸��� �����ϴ� ����
	 */
	public static final String CODE = "CODE";
		
	/**
	 * GauceDataRow�� [ENABLE]�÷��� �̸��� �����ϴ� ����
	 */
	public static final String ENABLE = "ENABLE";
		
	/**
	 * GauceDataRow�� [IMAGE_ID]�÷��� �̸��� �����ϴ� ����
	 */
	public static final String IMAGE_ID = "IMAGE_ID";
	
	
	/**
	 * GauceDataRow�� �÷� ����Ʈ�� �����ϴ� ����
	 */
	public static final String[] PROPERTY_LIST = {

		TEXT,

		LEVEL,

		CODE,

		ENABLE,

		IMAGE_ID,

	};	

    /**
	 * GauceDataRow�� �÷�Ÿ�� ����Ʈ�� �����ϴ� ����
	 */
	public static final int[] TYPE_LIST = {

		STRING_TYPE,

		STRING_TYPE,

		STRING_TYPE,

		STRING_TYPE,

		STRING_TYPE,

	};	

    /**
	 * GauceDataRow�� �÷�ũ�� ����Ʈ�� �����ϴ� ����
	 */
	public static final double[] SIZE_LIST = {

		255,

		2,

		10,

		1,

		10,

	};	
		
	/**
	 * GauceDataRow�� �÷� ŰŸ�� ����Ʈ�� �����ϴ� ����
	 */
	public static final int[] KEY_TYPE_LIST = {
		
		NORMAL_TYPE,
		
		NORMAL_TYPE,
		
		NORMAL_TYPE,
		
		NORMAL_TYPE,
		
		NORMAL_TYPE,
	
	};
	
	/**
	 * GauceDataRow proxy�������̽��� Proxy��ü�� �����Ѵ�.
	 * @return GauceDataRow proxy�������̽� ��ü
	 */
	public MenuData newMenuData();

	/**
	 * GauceDataSet���� GauceDataRow���� Proxy��ü�迭�� ��ȯ�Ͽ� ��ȯ�Ѵ�. 
	 * @return GauceDataRow proxy�������̽� ��ü
	 */
	public MenuData[] getMenuDatas();
	
	/**
	 * GauceDataSet���� �ε����� �ش��ϴ� GauceDataRow�� Proxy��ü�� ��ȯ�Ͽ� ��ȯ�Ѵ�.
	 * @param index GauceDataRow �ε���
	 * @return GauceDataRow proxy�������̽� ��ü
	 */
	public MenuData getMenuData(int index);
	
	/**
	 * GauceDataSet�� GauceDataRow�� Proxy��ü�� �߰��Ѵ�.
	 * @param arg GauceDataRow�� Proxy��ü
	 */
	public void appendMenuData(MenuData arg);
}

