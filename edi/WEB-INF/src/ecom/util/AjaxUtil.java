package ecom.util;

import java.util.Iterator;

import java.util.List;

import java.util.Map;



public class AjaxUtil {
	 public String list2AjaxXml(List rows) throws Exception {

		 StringBuffer sb = new StringBuffer();

		 Map cols = null;

		 int cnt =0;

		 sb.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");

		          sb.append("<t>\n");

		        

		        String keys[] = null;

		 for (int i=0; i < rows.size(); i++) {

		             sb.append("\t<r id=\"" + ++cnt + "\">\n");
		             cols = (Map)rows.get(i);
		             if (keys == null) keys = getMapKeys(cols);

		             for (int j=0; j < keys.length; j++) {

		                 sb.append("\t\t<c id=\"" + keys[j] + "\">");

		                 sb.append("<![CDATA[" + (String)cols.get(keys[j]) + "]]>");

		                 sb.append("</c>\n");

		             }

		             sb.append("\t</r>\n");

		 }

		        sb.append("</t>");

		        

		        return sb.toString();

		        }

		       

		       

		        static String nvl(String param) {

		              return param != null ? param : "";

		        }

		    

		     static String[] getMapKeys(Map map) {

		         if (map == null) {

		             return null;

		         }

		         String[] ret = new String[map.size()];

		         int inc = 0;

		         for (Iterator i = map.keySet().iterator(); i.hasNext();) {

		             ret[inc++] = (String) i.next();

		         }

		  

		         return ret;

		     }


}
