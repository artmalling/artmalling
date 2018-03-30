
package common.util;

import java.io.File;

/**
 * <p>테이블 페이징처리</p>
 * 
 * @created  on 1.0, 2010/07/15
 * @created  by HSEON(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */ 
public class PagingHelper{
	
	public static PagingHelper instance = new PagingHelper();
	
	private PagingHelper()
	{
	}
	 
	/** 
	 * @param string  totalCount	: 총게시물 건수
	 * @param string  currentPage	: 현재페이지
	 * @param string  pageSize		: 한페이지당 로우건수
	 * @param string  pageGroupSize : 페이지출력범위
	 */
	public String autoPaging(int totalCount, int currentPage, int pageSize, int pageGroupSize){

		StringBuffer tsRetVal = new StringBuffer();
		String pageStr = "";
		   
		int pageGroupCount = totalCount / (pageSize * pageGroupSize) + (totalCount % (pageSize * pageGroupSize) == 0 ? 0 :1); 
			
		int numPageGroup = (int)Math.ceil((double)currentPage / pageGroupSize);  
		   
		if (totalCount > 0)
		{
			int pageCount = (totalCount / pageSize) + (totalCount % pageSize == 0 ? 0 : 1);
		    int startPage = pageGroupSize * (numPageGroup - 1) + 1;
		    int endPage = startPage + pageGroupSize-1;
		   
		    //System.out.println("++ startPage " + startPage);
		    //System.out.println("++ endPage " + endPage);
		    
			if (endPage > pageCount )endPage = pageCount; 
				  
			tsRetVal.append("<table cellpadding=0 cellspacing=0 border=0>\n");
			tsRetVal.append("<tr><td>");
				
			// 총 페이지건수가 1보다 큰경우 << 표시
			if(pageCount != 1)
			{ 
				tsRetVal.append("<a onclick=\"javascript:goPage('1');\">");
				tsRetVal.append("<img src=\"/pot/imgs/btn/btn_page_first.gif\" border=0 >");
				tsRetVal.append("</a>\n");
			}
			else 
				tsRetVal.append("<img src=\"/pot/imgs/btn/btn_page_firstr.gif\" border=0 > \n"); 
			
			// < 표시
			//if(numPageGroup > 1)
			if(currentPage != 1)
			{
				//tsRetVal.append("<a onclick=\"goPage(" + ((numPageGroup-2) * pageGroupSize + 1) + ")\"  onfocus=\"this.blur();\">");
				tsRetVal.append("<a onclick=\"goPage(" + (currentPage-1) + ")\"  onfocus=\"this.blur();\">");
				tsRetVal.append("<img src=\"/pot/imgs/btn/btn_page_prev.gif\" border=0 >");
				tsRetVal.append("</a>\n"); 
			}
			else 
				tsRetVal.append("<img src=\"/pot/imgs/btn/btn_page_prevr.gif\" border=0  > \n"); 

		    
			for (int i = startPage; i <= endPage; i++)
			{ 
	 			 if (currentPage == i){  
	 	 			tsRetVal.append("<a onclick=\"goPage(" + i + ")\"  onfocus=\"this.blur();\" style=\"cursor:pointer\"><b>" + i + "</b></a>\n"); 
		         }else{
			 		tsRetVal.append("<a onclick=\"goPage(" + i + ")\"  onfocus=\"this.blur();\" style=\"cursor:pointer\">" + i + "</a>\n"); 
		         }
		   
			}  
			// > 표시
			//if (numPageGroup < pageGroupCount)
			if (currentPage != pageCount)
			{
				//tsRetVal.append("<a onclick=\"goPage(" + (numPageGroup * pageGroupSize + 1) + ")\" onfocus=\"this.blur();\" >");
				tsRetVal.append("<a onclick=\"goPage(" + (currentPage+ 1) + ")\" onfocus=\"this.blur();\" >");
				tsRetVal.append("<img src=\"/pot/imgs/btn/btn_page_next.gif\" border=0 >");
				tsRetVal.append("</a>\n"); 
			}
			else
				tsRetVal.append("<img src=\"/pot/imgs/btn/btn_page_nextr.gif\" border=0 > \n");

			// 총 페이지건수가 1보다 큰경우 << 표시(활성화/비활성화)
			if(pageCount>1)
			{ 
				tsRetVal.append("<a onclick=\"javascript:goPage('"+pageCount+"');\">");
				tsRetVal.append("<img src=\"/pot/imgs/btn/btn_page_end.gif\" border=0 >");
				tsRetVal.append("</a>\n");
			}
			else 
				tsRetVal.append("<img src=\"/pot/imgs/btn/btn_page_endr.gif\" border=0 > \n"); 

			tsRetVal.append("</td>");
			tsRetVal.append("</tr>");
			tsRetVal.append("</table>\n");
		}

		//System.out.println(tsRetVal.toString());
		return tsRetVal.toString();
	} 
}
