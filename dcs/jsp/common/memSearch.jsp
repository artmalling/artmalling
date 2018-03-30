<%@ page language="java" contentType="text/html;charset=utf-8"%>
<tr>
	<td class="PT01 PB03">
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="o_table">
		<tr>
			<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				class="s_table">
				<tr>
					<th width="77">카드번호</th>
					<td width="160"><comment id="_NSID_"> <object
						id=EM_CARD_NO_H classid=<%=Util.CLSID_EMEDIT%> tabindex=1
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
						id="_NSID_"> <object id=EM_CARD_NO_S
						classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
						onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CARD_NO_S','');">
					</object> </comment> <script> _ws_(_NSID_);</script></td>
					<th width="80">주민등록번호</th>
					<td width="160"><comment id="_NSID_"> <object
						id=EM_SS_NO_H classid=<%=Util.CLSID_EMEDIT%> tabindex=1
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
						id="_NSID_"> <object id=EM_SS_NO_S
						classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
						onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_SS_NO_S','');">
					</object> </comment> <script> _ws_(_NSID_);</script></td>
					<th width="80">회원명</th>
					<td><comment id="_NSID_"> <object id=EM_CUST_ID_H
						classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object>
					</comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_"> <object
						id=EM_CUST_ID_S classid=<%=Util.CLSID_EMEDIT%> width=66 tabindex=1
						onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CUST_ID_S','%');"
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
						src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
						onclick="getCompPop(EM_CUST_ID_S,EM_CUST_NAME_S,'%')" /> <comment
						id="_NSID_"> <object id=EM_CUST_NAME_S
						classid=<%=Util.CLSID_EMEDIT%> width=81 align="absmiddle"></object>
					</comment> <script> _ws_(_NSID_);</script></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	</td>
</tr>
