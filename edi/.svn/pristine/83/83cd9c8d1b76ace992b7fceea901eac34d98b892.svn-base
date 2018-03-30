package sample.jstl.dao;

import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import sample.jstl.vo.BoardVO;

public class BoardDAO extends AbstractDAO2 {
	
    public StringBuffer selectDetail(ActionForm form) throws Exception {
        StringBuffer sb = null;
        SqlWrapper sql = null;
        try {
            sql = new SqlWrapper();
            connect("SAMPLE");
            sql.put("select title, writer, contents " +
                    "  from tutboard " +
                    " where no = ?");
            sql.setString(1,form.getParam("no") );
            
            sb = executeQueryByAjax(sql);
        } catch (Exception e) {
            throw e;
        }
        
        return sb;
    }
    public StringBuffer selectXML(ActionForm form) throws Exception {
        StringBuffer sb = null;
        SqlWrapper sql = null;
        
        try {
  
            sql = new SqlWrapper();
            connect("SAMPLE");
            sql.put("select no, title, writer, contents, wdate " +
                    "  from tutboard " +
                    " order by no desc");
            sb = executeQueryByAjax(sql);
        } catch (Exception e) {
            throw e;
        }
        
        return sb;
    }
    
    
	public BoardVO selectBoardBean(ActionForm form) throws Exception {
		BoardVO vo = null;
		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			sql.put(svc.getQuery("SEL_KEBBOARD_VIEW"));
			sql.setString(1, form.getString(1, "no"));
			
			connect("SAMPLE");
			
			vo = (BoardVO)super.executeQueryByBeanList(sql, BoardVO.class);
		} catch (Exception e) {
			throw e;
		}
		
		return vo;
	}
	
	
	public List selectKebBoard(ActionForm form) throws Exception {
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;

		try {
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			if (form.getParam("condition").equals("내용")) {
				sql.put(svc.getQuery("SEL_KEBBOARD_CONTENTS"));
				sql.setString(1, form.getParam("where"));
			} else if (form.getParam("condition").equals("작성자")) {
				sql.put(svc.getQuery("SEL_KEBBOARD_WRITER"));
				sql.setString(1, form.getParam("where"));
			} else if (form.getParam("condition").equals("제목")) {
				sql.put(svc.getQuery("SEL_KEBBOARD_TITLE"));
				sql.setString(1, form.getParam("where"));
			} else {
				sql.put(svc.getQuery("SEL_KEBBOARDS"));
			}

			connect("SAMPLE");
			
			list = executeQuery(sql);
		} catch (Exception e) {
			throw e;
		}

		return list;
	}
	
	public Map selectOneRow(ActionForm form) throws Exception {
		Map map = null;
		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			sql.put(svc.getQuery("SEL_KEBBOARD_VIEW"));
			sql.setString(1, form.getString(1, "no"));
			connect("SAMPLE");
			map = executeQueryByMap(sql);

		} catch (Exception e) {
			throw e;
		}

		return map;
	}
	
	
	public void insertKebBoard(ActionForm form, String writer, String contents,
			String title) throws Exception {
		SqlWrapper sql = null;
		Service svc = null;

		begin();
		try {
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			sql.put(svc.getQuery("INS_KEBBOARD"));
			sql.setString(1, writer);
			sql.setString(2, contents);
			sql.setString(3, title);
			connect("SAMPLE");
			
			executeUpdate(sql);

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
	}
	
	public void test(ActionForm form) throws Exception {
		SqlWrapper sql = null;
		Service svc = null;

		begin();
		try {
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			sql.put(svc.getQuery("INS_TEST2"));
			sql.setString(1, "2222");
			sql.setString(2, "홍콩이야");
		
			connect("SAMPLE");
			executeUpdate(sql);

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
	}
}
