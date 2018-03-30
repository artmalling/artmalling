<%@ page language="java" contentType="text/html;charset=euc-kr" %>

  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
					<tr>
            <th width="60">조회일자</th>
            <td width="190">
							<object id=EM classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1>
								<param name=Format		value="0000-00-00">
								<param name=PromptChar	value="_">							
							</object>
							<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"/> -
							<object id=EM classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1>
								<param name=Format		value="0000-00-00">
								<param name=PromptChar	value="_">									
							</object> <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"/>						
						</td>            
						<th width="80">주민등록번호</th>
						<td width="120">
								<object id=EM classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F width=90>
									<param name=Format		value="000000-0000000">
									<param name=PromptChar	value="_">
								</object>							
						</td>
            <th width="80" class="point">회원명</th>
            <td>
							<object id=EM classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1></object> 
							<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"/> 
							<object id=EM classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1></object>						
						</td> 
          </tr>
        </table>
				</td>
      </tr>
    </table></td>
  </tr>
