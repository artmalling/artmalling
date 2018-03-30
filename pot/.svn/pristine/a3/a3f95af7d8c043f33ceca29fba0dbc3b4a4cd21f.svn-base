<!-- 
/*******************************************************************************
 * 시스템명 : 행사코드 조회  팝업 ( 행사 마스터 외부조인)
 * 작 성 일 : 2010.05.16
 * 작 성 자 : 김성미
 * 수 정 자 : 
 * 파 일 명 : ccom2170.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 행사코드 코드 조회 팝업  ( 행사 마스터 외부조인)
 * 이    력 :
 ******************************************************************************/
--> 
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<title>행사-POPUP</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 var returnMap      = dialogArguments[0];
 var serviceId      = dialogArguments[1];
 var eventCd        = dialogArguments[2];
 var strStrCd       = dialogArguments[3];
 var strEventType    = dialogArguments[4]; //행사 구분
 var strEvtGiftType  = dialogArguments[5]; //사은품종류
 var addCondition   = dialogArguments[6];

/**
* doInit()
* 작 성 자 : 김성미
* 작 성 일 : 2010-01-25
* 개    요 : initialize
* return값 : void
*/
 function doInit() 
 {   
     // Input Data Set Header 초기화 
     DS_I_COND.setDataHeader  ('<gauce:dataset name="H_EVENT_COND"/>');
           
     //그리드 초기화
     gridCreate1();
     
     // EMedit 초기화
     initEmEdit(EM_SEARCH, "GEN", PK);
     
     initEmEdit(EM_EVENT_S_DT, "SYYYYMMDD", PK); // 조회 시작기간    
     initEmEdit(EM_EVENT_E_DT, "TODAY", PK); // 조회 종료기간
     
     var conditions = addCondition.split('#G#');
     
     if(conditions.length == 2){
    	 EM_EVENT_S_DT.Text = conditions[0];
    	 EM_EVENT_E_DT.Text = conditions[1];
     }
     EM_SEARCH.Text = eventCd;
     EM_SEARCH.Focus();
     if(eventCd.length > 0){
         btn_Search();
     }
 } 

function gridCreate1(){
    var showBoolean = "TRUE";
    var hdrProperies = '<FC>ID="EVENT_CD"    name="행사코드" width=100,   edit=none,  align="left" </FC>'
                     + '<FC>ID="EVENT_NM"    name="행사명"   width=180,  edit=none,   align="left"  </FC>'
                    + '<FC>ID="EVENT_S_DT"    name="행사시작일"   width=75,  edit=none,   align="center"  </FC>'
                    + '<FC>ID="EVENT_E_DT"    name="행사종료일"   width=75,  edit=none,   align="center"  </FC>';
    initGridStyle(GD_SEARCH, "common", hdrProperies, false);
}    

/*************************************************************************
 * 2. 공통버튼
    (1) 조회       - btn_Search(), subQuery()
    (2) 신규       - btn_New()
    (3) 삭제       - btn_Delete()
    (4) 저장       - btn_Save()
    (5) 엑셀       - btn_Excel()
    (6) 출력       - btn_Print()
    (7) 확정       - btn_Conf()
 *************************************************************************/ 
 /**
  * btn_Search()
  * 작 성 자 : 
  * 작 성 일 : 2010-01-25
  * 개    요  : 점별 행사 코드 조회
  * return값 : void
  */
  function btn_Search() 
  { 
      DS_I_COND.ClearData();
      DS_I_COND.Addrow();
       
      DS_I_COND.NameValue(DS_I_COND.RowPosition, "SERVICE_ID"   ) = serviceId; 
      DS_I_COND.NameValue(DS_I_COND.RowPosition, "STR_CD"    ) = strStrCd;
      DS_I_COND.NameValue(DS_I_COND.RowPosition, "EVENT_S_DT"    ) = EM_EVENT_S_DT.Text;
      DS_I_COND.NameValue(DS_I_COND.RowPosition, "EVENT_E_DT"    ) = EM_EVENT_E_DT.Text;
      DS_I_COND.NameValue(DS_I_COND.RowPosition, "COND_TXT"     ) = EM_SEARCH.text;
      DS_I_COND.NameValue(DS_I_COND.RowPosition, "EVENT_TYPE"     ) = strEventType;
      DS_I_COND.NameValue(DS_I_COND.RowPosition, "EVENT_GIFT_TYPE"     ) = strEvtGiftType;
      DS_I_COND.NameValue(DS_I_COND.RowPosition, "ADD_CONDITION"    ) = addCondition; 
      
      TR_MAIN.Action="/pot/ccom217.cc?goTo=getList";
      TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_COND,O:DS_O_RESULT=DS_O_RESULT)";
      TR_MAIN.Post();  
      
     // endTR("R", TR_MAIN, DS_O_RESULT);//R(RETRIEVE), C(INSERT), U(UPDATE), D(DELETE), B(BATCH)
  }       
/*************************************************************************
 * 3. 함수
*************************************************************************/

   /**
    * btn_Close()
    * 작 성 자 : ckj
    * 작 성 일 : 2006.07.12
    * 개    요 : Close
    * return값 : void
    */  
    function btn_Close()
    {
        window.close();
    }
    
    /**
    * doDoubleClick()
    * 작 성 자 : ckj
    * 작 성 일 : 2006.08.10
    * 개    요 : 더블클릭 처리
    * return값 : void
    */  
    function doDoubleClick(row)
    {
        if( row == undefined ) 
            row = DS_O_RESULT.RowPosition;
        
        if (row > 0) 
        {
            var strColumnId = "";
            
            for(var i=1;i<=DS_O_RESULT.CountColumn;i++)
            {
                returnMap.put(DS_O_RESULT.ColumnID(i), DS_O_RESULT.NameValue(row, DS_O_RESULT.ColumnID(i)));
            }
            
            window.returnValue = true;
            window.close();
        }
        return false;         
    }
    
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
 <script language=JavaScript for=GD_SEARCH event=OnDblClick(row,colid)>
<!--// 그리드 double 클릭이벤트에서 처리 할 내역 추가        
    doDoubleClick(row);    
//-->
</script> 
 <script language=JavaScript for=GD_SEARCH event=OnClick(row,colid)>
 if(row == 0) sortColId( eval(this.DataID), row , colid );   
</script> 
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<comment id="_NSID_"><object id=DS_I_COND classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== Output용 -->
<comment id="_NSID_"><object id=DS_O_RESULT classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
    <object id="TR_MAIN"        classid="<%=Util.CLSID_TRANSACTION%>">
      <param name="KeyName"   value="Toinb_dataid4">
    </object>
</comment>
<script> _ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body  onLoad="doInit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="pop01"></td>
		<td class="pop02"></td>
		<td class="pop03"></td>
	</tr>
	<tr>
		<td class="pop04"></td>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="" class="title"><img
							src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13"
							align="absmiddle" class="popR05 PL03" /><SPAN id="title1"
							class="PL03">행사코드조회</SPAN></td>
						<td>
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="/<%=dir%>/imgs/btn/search.gif" width="50"
									height="22" onClick="btn_Search();" /></td>
								<td><img src="/<%=dir%>/imgs/btn/confirm.gif" width="50"
									height="22" onClick="doDoubleClick()" /></td>
								<td><img src="/<%=dir%>/imgs/btn/close.gif" width="50"
									height="22" onClick="btn_Close();" /></td>

							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="popT01 PB03">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="o_table">
					<tr>
						<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="s_table">
							<tr>
								<th width="50" class="point"><span id="title2">코드/명</span></th>
								<td><comment id="_NSID_"> <object id=EM_SEARCH
									classid=<%=Util.CLSID_EMEDIT%> height=20 width=100
									onKeyDown="if(event.keyCode == 13) btn_Search();"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
                                <th width="50" class="point">기간</th>
                                <td align="absmiddle"><comment id="_NSID_">
                                <object id=EM_EVENT_S_DT classid=<%=Util.CLSID_EMEDIT%> width=70
                                    onblur="javascript:checkDateTypeYMD(this);" tabindex=1
                                    align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
                                    src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                                    onclick="javascript:openCal('G',EM_EVENT_S_DT)" /> ~ <comment
                                    id="_NSID_"> <object id=EM_EVENT_E_DT
                                    classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                                    onblur="javascript:checkDateTypeYMD(this);" align="absmiddle">
                                </object> </comment><script>_ws_(_NSID_);</script> <img
                                    src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                                    onclick="javascript:openCal('G',EM_EVENT_E_DT)" /></td>
                            </tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="g_table">
					<tr>
						<td><!-- 마스터 --> <comment id="_NSID_"><OBJECT
							id=GD_SEARCH height="285px" width="100%"
							classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_O_RESULT">
						</OBJECT></comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
		<td class="pop06"></td>
	</tr>
	<tr>
		<td class="pop07"></td>
		<td class="pop08"></td>
		<td class="pop09"></td>
	</tr>
</table>
</body>
</html>
