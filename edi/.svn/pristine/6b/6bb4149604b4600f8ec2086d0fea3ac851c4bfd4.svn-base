package ecom.vo;

/**
 * ValueObject.java
 * 
 * Version 1.0
 * 
 * Created on 2004. 11. 25.
 *
 * Copyright(c) 2004 ~ 2005 Shinsegae I&C
 * All rights reserved.
 * 
 */
//package ssg.dept.db;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

/**
 * java.sql.ResultSet의 하나의 Row정보를 기록합니다. 
 * <br>Executioner.convertValueObject(java.sql.ResultSet);내부에서 사용됩니다.
 * @version 1.0
 * @author 홍성호(Intellicube)
 *  
 */
public class ValueObject implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 5299445231921913656L;
	/**
	 * 
	 */
	
	protected List list = null;

    /**
     * 생성자
     *
     */
    public ValueObject() {
        this.list = new ArrayList();
    }

    /**
     * 주어진 Object 를 List 에 담는다.
     * 
     * @param obj
     */
    public void add(Object obj) {
        this.list.add(obj);
    }

    /**
     * 주어진 인덱스에 Object를 담는다.
     * @param index
     * @param obj
     */
    public void add(int index, Object obj) {
        this.list.add(index, obj);
    }

    /**
     * 주어진 값을 Collection으로 가져와 이를 모두 Object에 담는다.
     * @param col
     */
    public void addAll(Collection col) {
        list.addAll(col);
    }

    /**
     * 주어진 값을 Collection으로 가져와 이를 모두 Object에 담는다.
     * @param index
     * @param col
     */
    public void addAll(int index, Collection col) {
        list.addAll(index, col);
    }

    /**
     * 담겨진 Object들 중 index에 대당하는 오브젝트를 반환한다.
     * @param index
     * @return java.lang.Object
     */
    public Object get(int index) {
        if (index < 0) {
            throw new IndexOutOfBoundsException("index < 0");
        } else if (index >= this.list.size()) {
            throw new IndexOutOfBoundsException(index + " >= "
                    + this.list.size());
        }

        return this.list.get(index);
    }

    /**
     * 주어진 Object를 인덱스 값을 담는다.
     * @param index
     * @param obj
     */
    public void set(int index, Object obj) {
        list.set(index, obj);
    }

    /**
     * 인덱스에 담겨진 오브젝트를 주어진 오브젝트로 변환한다.
     * @param index
     * @param obj
     */
    public void change(int index, Object obj) {
        remove(index);
        add(index, obj);
    }

    public void remove(int index) {
        if (index < 0) {
            throw new IndexOutOfBoundsException("index < 0");
        } else if (index >= this.list.size()) {
            throw new IndexOutOfBoundsException(index + " >= "
                    + this.list.size());
        }

        this.list.remove(index);
    }

    /**
     * 일정 사이의 Object를 삭제 한다.
     * 
     * @param start
     *            시작 위치의 길이가 아니라 인덱스 값
     * @param end
     *            끝 위치의 길이가 아니라 인덱스 값
     */
    public void removeRange(int start, int end) {
        if (start > end)
            return;
        else if (start > size() || start < 0)
            return;
        else if (end > size() || end < 0)
            return;
        for (int i = start; i <= end - start; i++) {
            this.list.remove(i);
        }
    }

    /**
     * ValueObject 가 담고 있는 List 의 크기를 리턴한다.
     * 
     * @return
     */
    public int size() {
        return list.size();
    }

    /**
     * 오브젝트의 값을 스트링으로 변환한다.
     */
    public String toString() {
        StringBuffer sb = new StringBuffer();
        sb.append("[");

        Iterator i = list.iterator();

        boolean hasNext = i.hasNext();
        while (hasNext) {
            Object o = i.next();
            sb.append(o == this ? "[this ValueObject...]" : String.valueOf(o));
            hasNext = i.hasNext();
            if (hasNext)
                sb.append(", ");
        }

        sb.append("]");

        return sb.toString();
    }

    /**
     * ValueObject내부에 선언된 List의 iterator를 반환한다.
     * @return
     */
    public Iterator iterator() {
        return list.iterator();
    }

    /**
     * ValueObject내부에 선언된 List를 1차원 배열로 반환한다.
     * @return
     */
    public Object[] getObjectArray() {
        return list.toArray();
    }

    /**
     * 현재의 ValueObject가 널인지 체크한다.
     * @return
     */
    public boolean isEmpty() {
    	
        if (list == null || list.size() <= 0) {
            return true;
        } else {
            return false;
        }
    }
}
