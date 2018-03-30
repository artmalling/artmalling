<%
/*****************************************************************************
 * 시스템명 : 
 * 작 성 일 : 2010.04.13
 * 작 성 자 : 정지인
 * 수 정 자 :
 * 파 일 명 : report.jsp
 * 버    전 : 1.0
 * 개    요 : 오즈리포트 공통부분
 * 이    력 :
*****************************************************************************/
%>
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo, 
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.*"%>
<%
    String ozSvrIP   = BaseProperty.get("oz.svr.ip");
    String ozSvrPort = BaseProperty.get("oz.svr.port");
    
    String loginInfo = reportodi[0].toUpperCase().substring(0,reportodi[0].length()-1) + "  "
                     + String2.replaceChars(Date2.makeDateTimeType(Date2.getThisDay("yyyymmddhhss")),"-","/")  
                     + "  " + Util.getUserNm(request);
%>
<html>
<head>
<title><%=reportname%></title>

<script>
function oz_activex_build(parent, tag, paramTag) {
    var OZViewerObjectElement = document.createElement(tag);
    for(var i = 0 ; i < paramTag.length; i++) {
        var OZViewerParamElement = document.createElement(paramTag[i]);
        OZViewerObjectElement.appendChild(OZViewerParamElement);
    }
    parent.appendChild(OZViewerObjectElement);
    
   	if (g_showFlag) {
   	    setTimeout("window.close()", 1250);
   	}
}
</script>

</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<object id="ZTransferX" width="0" height="0" CLASSID="CLSID:C7C7225A-9476-47AC-B0B0-FF3B79D55E67" codebase="http://<%=ozSvrIP%>:<%=ozSvrPort%>/oz/ozviewer/ZTransferX.CAB#version=2,2,2,2">
    <param name="download.Server"      value="http://<%=ozSvrIP%>/oz/ozviewer">
    <param name="download.Port"         value="<%=ozSvrPort%>">
    <param name="download.Instruction" value="ozrviewer.idf">
    <param name="install.Base" value="<PROGRAMS>/Forcs">
    <param name="install.NameSpace"    value="MARIO OUTLET">
</object>
<table style="width:100%" border="0">
    <tr><td><div id="OZEmbedControlLocation" style=""></td></tr>
</table>
<script LANGUAGE="Javascript">
    var sw         = document.body.clientWidth;
    var sh         = document.body.clientHeight;
    var obj_width  = sw;
    var obj_height = sh;

    var tag = '<object id="ozviewer" width="'+obj_width+'" height="'+obj_height+'" CLASSID="CLSID:0DEF32F8-170F-46f8-B1FF-4BF7443F5F25"></OBJECT>'; 
    var paramTag = new Array();
<%  
    if(ozReportCnt != 1){
%>
        //멀티 리포트 조회 후 처음 화면에 선택될 리포트를 지정 합니다. -1일 경우 기존 동작과 마찬가지로 마지막으로 조회된 리포트가 선택되어 표시됩니다.
        paramTag[paramTag.length] = '<param name="viewer.focus_doc_index" value="0">'; 
        //하나의 오즈 뷰어에 여러 개의 보고서를 보여줄 때 메인 보고서 외에 추가되는 차일드 보고서의 개수를 설정합니다.
        paramTag[paramTag.length] = '<param name="viewer.childcount" value="<%=ozReportCnt-1%>">';  
        //트리 보기 메뉴와 아이콘의 활성화 여부를 설정합니다.
        paramTag[paramTag.length] = '<param name="viewer.showtree" value="true">'; 
        //멀티문서 형식의 보고서를 한번에 모두 인쇄할지 여부를 설정합니다.
        paramTag[paramTag.length] = '<param name="print.alldocument" value="true">'; 
        //멀티폼을 하나의 리포트 처럼 이용할 지 여부를 설정합니다. True이면 멀티폼의 페이지 번호등이 연결됩니다.
        paramTag[paramTag.length] = '<param name="global.concatpage" value="<%=concatpage%>">';
        //첫번째 보고서에 프린트창에서 설정한 옵션이 child에도 적용되도록 합니다
        paramTag[paramTag.length] = '<param name="print.usedialogopt" value="true">'; 
<%
    }
    String tempValue = "";
    for(int y=0; y<ozReportCnt; y++){
        String child = "";
        if(y!=0) child = "child" + y + ".";
        tempValue = reportozr[y];
%>
    
        paramTag[paramTag.length] = '<param name="<%=child%>connection.servlet" value="http://<%=ozSvrIP%>:<%=ozSvrPort%>/oz/server">';
        paramTag[paramTag.length] = '<param name="<%=child%>connection.reportname" value="/<%=tempValue%>.ozr">';  
        paramTag[paramTag.length] = '<param name="<%=child%>connection.compresseddatamodule" value = "true">'; 
        paramTag[paramTag.length] = '<param name="<%=child%>connection.compressedForm" value = "true">';
        paramTag[paramTag.length] = '<param name="<%=child%>viewer.isframe"    value="false">';
        paramTag[paramTag.length] = '<param name="<%=child%>viewer.configmode" value="jsp">';
        paramTag[paramTag.length] = '<param name="<%=child%>print.alldocument" value="true">';
        paramTag[paramTag.length] = '<param name="<%=child%>viewer.mode"       value="<%=printMode%>">';
        
<%
        if(printMode.equals("preview")){
%>
            
            <%-- paramTag[paramTag.length] = '<param name="<%=child%>viewer.viewmode"         value="fittoframe">';  --%>
            <%-- Nomal , fittoframe , fittowidth , fittocontents , printsize --%>
			if(window.name == "OZPRINT") {
				paramTag[paramTag.length] = '<param name="<%=child%>viewer.zoom"         value="100">';
			}else if(window.name == "OZSEARCH") {
				paramTag[paramTag.length] = '<param name="<%=child%>viewer.zoom"         value="70">';
        	}else{	
            	paramTag[paramTag.length] = '<param name="<%=child%>viewer.viewmode"         value="printsize">';
        	}	
            paramTag[paramTag.length] = '<param name="<%=child%>viewer.showerrormessage" value="true">';
<%
        } else {
%>
            paramTag[paramTag.length] = '<param name="<%=child%>print.mode"        value="showprogress">'; 
<%
        }
%>
<%
        //form params.
        String formParamLength = formparams.length==0 ? "2" : "" + (formparams[y].length + 2);
%>
        paramTag[paramTag.length] = '<param name="<%=child%>connection.pcount" value="<%=formParamLength%>">';
        paramTag[paramTag.length] = '<param name="<%=child%>connection.args1"  value="LOGIN_INFO=<%=loginInfo%>">';
        paramTag[paramTag.length] = '<param name="<%=child%>connection.args2"  value="IMG_URL=http://<%=ozSvrIP%>:<%=ozSvrPort%>/pot/imgs/report/CI.gif">';
<%
        for(int i=2; i<Integer.parseInt(formParamLength); i++) {
            String index = ""+(i+1);
            String value = formparams[y][i-2];
%>
            paramTag[paramTag.length] = '<param name="<%=child%>connection.args<%=index%>" value="<%=value%>">';
<%
        }
        tempValue = reportodi[y];
%>
        //OZ odi setting 
        paramTag[paramTag.length] = '<param name="<%=child%>odi.odinames" value="<%=tempValue%>">';
<%
        //params
        String paramLength     = params.length == 0 ? "0" : "" + params[y].length;
%>
        paramTag[paramTag.length] = '<param name="<%=child%>odi.<%=tempValue%>.pcount" value="<%=paramLength%>">';
<%
        for(int i=0; i<Integer.parseInt(paramLength); i++) {
            String index = ""+(i+1);
            String value = params[y][i];
%>
            paramTag[paramTag.length] = '<param name="<%=child%>odi.<%=tempValue%>.args<%=index%>" value="<%=value%>">';       
<%
        }
    }
%>
    oz_activex_build(OZEmbedControlLocation, tag, paramTag);
    //window.close();
</script>
</body>
</html>
