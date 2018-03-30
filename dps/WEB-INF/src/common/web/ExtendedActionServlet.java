package common.web;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.fujitsu.ffw.control.ActionServlet;

public class ExtendedActionServlet extends ActionServlet {
	public void process(HttpServletRequest req, HttpServletResponse res) {
		String isReload = "";
		isReload = nvl(req.getParameter("reload"));
		if (isReload.equals("true")) {
			try {
				super.init();
				PrintWriter out = res.getWriter();
				out.println("ActionServlet is reloaded...");
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		try {
			super.process(req, res);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static String nvl(String param) {
		return param != null ? param : "";
	}
}
