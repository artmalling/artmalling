package esal.action;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import ecom.vo.SessionInfo2; 
import esal.dao.Esal106DAO;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.util.String2;

public class Esal106Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(Esal106Action.class);

	/**
	 * <p>메뉴를 보여준다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String strGoto = form.getParam("goTo");
		
		try {
			
			HttpSession session = request.getSession();
            SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
          
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
        
		return mapping.findForward(strGoto);
	}
	
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String strGoto = form.getParam("goTo");
		Esal106DAO dao = null;
		String json = null;
		
		try{
			dao = new Esal106DAO();
			json = (String) dao.getMaster(form);
		}catch(Exception e){
			e.printStackTrace();
		}
		ActionUtil.sendAjaxResponse(response, json);
		return mapping.findForward(strGoto);
	} 
	
	/**
	 * 엑셀다운로드화면 호출
	 */
	public ActionForward getExcel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		List rt = null;
		Esal106DAO dao = null;
		
		//Excel 저장시간
		Date today = new Date();
		SimpleDateFormat dateTime = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		SimpleDateFormat dateTime2 = new SimpleDateFormat("yyyyMMddHHmmss");
		String nowTime = dateTime.format(today);
		String nowTimeFileNm = dateTime2.format(today);
		
		StringBuffer sb =  new StringBuffer();
		response.setCharacterEncoding("ISO-8859-1");  //클라이언트가 서버에보내는 문자 인코딩
		response.setHeader("Content-Disposition", "attachment;filename=기간별단품매출현황_"+nowTimeFileNm+".xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setContentType("application/vnd.ms-excel");
		//response.setContentType("text/html;charset=utf-8");  //텍스트나 HTML문서이면서 문자인코딩은 uft8로 전송
		response.setContentType("text/html;charset=ISO-8859-1");  //텍스트나 HTML문서이면서 문자인코딩은 ISO-8859-1 전송
		try{ 
			
			String strcd 		= String2.nvl(form.getParam("strcd"));			//점코드
			String strVencd 	= String2.nvl(form.getParam("vencd"));			//협력사코드
			String strPumbuncd 	= String2.nvl(form.getParam("strPumbuncd"));	//품번코드
			String sDate 		= String2.nvl(form.getParam("sDate"));			//기간FROM 
			String eDate 		= String2.nvl(form.getParam("eDate"));			//기간TO
			
			dao = new Esal106DAO();
			rt = dao.getExcel(form);
			
			if (rt.size() < 1) {
				/*
				sb.append("<script> ");
				sb.append("alert('조회된 내역이 없습니다.');");
				sb.append("</script>");
				 */
			} else {
				sb.append("<%@ page language=\"java\" contentType=\"text/html;charset=utf-8\"%>");
				sb.append("<html>");
				sb.append("<head>");
				sb.append("<title></title>");
				//sb.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
				//sb.append("<meta http-equiv=\"Content-Type\" content=\"application/vnd.ms-excel; charset=utf-8\">");
				sb.append("<body>");
				sb.append("    <table border=1 width='1070'>");
				sb.append("        <tr style='color:black; font-weight:bold;' bgcolor=#CACACA>");
				sb.append("            <td colspan=10 align='center'><H3>기간별단품매출현황</H3></td> ");
				sb.append("        </tr> ");
				sb.append("        <tr style='color:black; font-weight:bold;' bgcolor=#CACACA>");
				sb.append("            <td colspan=10 align='left'>*점코드 : "+strcd+" |  *협력사코드 : "+strVencd+" |  *품번코드 : "+strPumbuncd+" |  *기간FROM : "+sDate+" |  *기간TO : "+eDate+" |  *저장일자 : "+nowTime+" </td> ");
				sb.append("        </tr> ");
				sb.append("        <tr style='color:black; font-weight:bold;'>");
				sb.append("            <td width='40'>NO</td>");
				sb.append("            <td width='100'>일자</td>");
				sb.append("            <td width='80'>품목코드</td>");
				sb.append("            <td width='210'>품목명</td>");
				sb.append("            <td width='110'>단품코드</td>");
				sb.append("            <td width='210'>단품명</td>");
				sb.append("            <td width='80'>매출수량</td>");
				sb.append("            <td width='80'>총매출</td>");
				sb.append("            <td width='80'>할인</td>");
				sb.append("            <td width='80'>매출</td>");
				sb.append("        </tr> ");
				List colRt = null;
				
				int SaleQty = 0;
				int SaleAmt = 0;
				int DCAmt 	= 0;
				int SaleSAmt= 0;
				for (int i=0; i<rt.size(); i++) {
					sb.append("        <tr>");
					colRt = (List) rt.get(i);
					sb.append("            <td>"+(i+1)+"</td>");
					for (int r=0; r<colRt.size(); r++) {
						if (5<=r) {
							sb.append("            <td>"+colRt.get(r)+"</td>");
						} else {
							sb.append("            <td style='mso-number-format:\\@'>"+colRt.get(r)+"</td>");
						}
					}
					//합계계산
					SaleQty += Integer.parseInt((String) colRt.get(5));	//매출수량
					SaleAmt += Integer.parseInt((String) colRt.get(6));	//총매출
					DCAmt 	+= Integer.parseInt((String) colRt.get(7));	//할인
					SaleSAmt+= Integer.parseInt((String) colRt.get(8));	//매출
					sb.append("        </tr> ");
				}
				sb.append("        <tr bgcolor=#b9d9ea> ");
				sb.append("            <td colspan='6' align='center' >합계</td>");
				sb.append("            <td>"+SaleQty+"</td>");
				sb.append("            <td>"+SaleAmt+"</td>");
				sb.append("            <td>"+DCAmt+"</td>");
				sb.append("            <td>"+SaleSAmt+"</td>");
				sb.append("        </tr> ");
				sb.append("    </table> ");
				sb.append("</body> ");
				sb.append("</html>");
			}
			//response.getWriter().println(sb.toString());
			response.getWriter().println(new String(sb.toString().getBytes(), "iso-8859-1"));
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return mapping.findForward("excelDowns");
	}
}
