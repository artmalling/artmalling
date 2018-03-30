<!-- 
/*******************************************************************************
 * 시스템명 : OFFER SHEET 조회  팝업
 * 작 성 일 : 2010.03.24
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : ccom0230.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : OFFER SHEET 조회 팝업
 * 이    력 :
 ******************************************************************************/
--> 
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
 <%
 	request.setCharacterEncoding("utf-8");
 %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<title>OFFER SHEET -POPUP</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 var returnParam    = dialogArguments[0];
 var strCd          = dialogArguments[1];
 
 var strYYYYMM      = "";

/**
 * doInit()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-16
 * 개    요 : initialize
 * return값 : void
**/
function doInit() 
{   

    strYYYYMM =   getTodayFormat("yyyymm");  
    
	// Input Data Set Header 초기화 
	var headerCond =  'STR_CD:STRING(2)'
                   + ',OFFER_FROM_DT:STRING(8)'
                   + ',OFFER_TO_DT:STRING(8)'
                   + ',OFFER_SHEET_NO:STRING(30)'
                   + ',PUMBUN_CD:STRING(6)'
                   + ',PUMBUN_NAME:STRING(40)'
                   + ',VEN_CD:STRING(6)'
                   + ',VEN_NAME:STRING(40)';	    
	DS_I_COND.setDataHeader(headerCond);
	
    //그리드 초기화
    gridCreate1();
            
    // EMedit 초기화
    initEmEdit(EM_OFFER_FROM_DT , "YYYYMMDD", PK);                                      // OFFER 기간
    initEmEdit(EM_OFFER_TO_DT   , "YYYYMMDD", PK);                                      // OFFER 기간
    initEmEdit(EM_OFFER_NO      , "CODE^30" , NORMAL);                                  // OFFER NO
    initEmEdit(EM_PUMBUN_CD     , "CODE^6^0", NORMAL);                                  // 단품명
    initEmEdit(EM_PUMBUN_NAME   , "GEN^40"  , NORMAL);                                  // 관리항목1
    initEmEdit(EM_VEN_CD        , "CODE^6"  , NORMAL);                                  // 관리항목명1
    initEmEdit(EM_VEN_NAME      , "GEN^40"  , NORMAL);                                  // 관리항목2
    //COMBO 초기화
    initComboStyle(LC_STR_CD   , DS_STR_CD   , "CODE^0^30,NAME^0^90", 1, READ);         // 점


    //점콤보 가져오기 ( popup_dps.js )
    getStore("DS_STR_CD", "N", "", "N");
    
    DS_I_COND.ClearData();
    DS_I_COND.Addrow();

    DS_I_COND.NameValue(DS_I_COND.RowPosition, "STR_CD") = strCd; 
    DS_I_COND.NameValue(DS_I_COND.RowPosition, "OFFER_FROM_DT") = getTodayFormat("YYYYMMDD"); 
    DS_I_COND.NameValue(DS_I_COND.RowPosition, "OFFER_TO_DT") = getTodayFormat("YYYYMMDD");


    LC_STR_CD.Focus();
    
    EM_OFFER_FROM_DT.Text = strYYYYMM + '01';
} 

function gridCreate1(){

    var hdrProperies = '<FC>ID="STR_CD"          name="점"           width=60   align="left"    EditStyle=Lookup   data="DS_STR_CD:CODE:NAME" </FC>'
                     + '<FC>ID="OFFER_DT"        name="OFFER 일자"   width=90   align="center"  mask="XXXX/XX/XX"  SORT=TRUE </FC>'
                     + '<FC>ID="OFFER_SHEET_NO"  name="OFFER NO"     width=120  align="left" </FC>'
                     + '<FC>ID="OFFER_TOT_QTY"   name="OFFER 수량"   width=80   align="right" </FC>'
                     + '<FC>ID="OFFER_TOT_AMT"   name="OFFER 금액"   width=80   align="right" </FC>'
                     + '<FC>ID="PUMBUN_CD"       name="브랜드"         width=70   align="left" </FC>'
                     + '<FC>ID="PUMBUN_NAME"     name="브랜드명"       width=90   align="left" </FC>'
                     + '<FC>ID="VEN_CD"          name="협력사"       width=70   align="left" </FC>'
                     + '<FC>ID="VEN_NAME"        name="협력사명"     width=90   align="left" </FC>';
    initGridStyle(GD_OFFMST, "common", hdrProperies, false);
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
 * 작 성 일 : 2010-03-21
 * 개    요  : 점별 행사 코드 조회
 * return값 : void
**/
function btn_Search() 
{
	if( EM_OFFER_FROM_DT.Text == ''){
        showMessage(EXCLAMATION, OK, "USER-1003", "OFFER기간");
		EM_OFFER_FROM_DT.Focus();
		return;
	}
    if( !checkDateTypeYMD(EM_OFFER_FROM_DT,''))
    	return; 
    if( EM_OFFER_TO_DT.Text == ''){
        showMessage(EXCLAMATION, OK, "USER-1003", "OFFER기간");
        EM_OFFER_TO_DT.Focus();
        return;
    }
    if( !checkDateTypeYMD(EM_OFFER_TO_DT,''))
        return; 
    if( EM_OFFER_FROM_DT.Text > EM_OFFER_TO_DT.Text){
    	showMessage(EXCLAMATION, OK, "USER-0015");
        EM_OFFER_FROM_DT.Focus();
        return;
    }
    	
	DS_I_COND.UserStatus(1) = '1';
	
    TR_MAIN.Action="/pot/ccom023.cc?goTo=searchOffmst";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_COND,O:DS_O_OFFMST=DS_O_OFFMST)";
    TR_MAIN.Post();  
      
}       
/*************************************************************************
 * 3. 함수
*************************************************************************/

/**
 * btn_Close()
 * 작 성 자 : ckj
 * 작 성 일 : 2010.03.21
 * 개    요 : Close
 * return값 : void
**/  
function btn_Close()
{
    window.close();
}

/**
 * btn_Conf()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010.03.21
 * 개    요 : 확인버튼 클릭 처리
 * return값 : void
**/  
function btn_Conf()
{
    doDoubleClick();
}    

/**
 * doDoubleClick()
 * 작 성 자 : ckj
 * 작 성 일 : 2010.03.21
 * 개    요 : 더블클릭 처리
 * return값 : void
**/  
function doDoubleClick(row)
{
    if( row == undefined ) 
        row = DS_O_OFFMST.RowPosition;
        
    if (row < 1)
        return false;
    
    var strStrCd      = DS_O_OFFMST.NameValue(row,"STR_CD");
    var strOfferYm    = DS_O_OFFMST.NameValue(row,"OFFER_YM");
    var strOfferSeqNo = DS_O_OFFMST.NameValue(row,"OFFER_SEQ_NO");
    var parameter = "&strStrCd="+encodeURIComponent(strStrCd)
                  + "&strOfferYm="+encodeURIComponent(strOfferYm)
                  + "&strOfferSeqNo="+encodeURIComponent(strOfferSeqNo);
    
    TR_MAIN.Action="/pot/ccom023.cc?goTo=searchOffdtl"+parameter;
    TR_MAIN.KeyValue="SERVLET(O:DS_O_OFFDTL=DS_O_OFFDTL)";
    TR_MAIN.Post();
    
    if(DS_O_OFFDTL.CountRow < 1 ){
        var objJson = "[{";
        for(var j=1;j<=DS_O_OFFMST.CountColumn;j++)
        {
            if(j>1) objJson +=  ",";
            objJson += "'"+DS_O_OFFMST.ColumnID(j)+"':'"+DS_O_OFFMST.NameValue(row, DS_O_OFFMST.ColumnID(j))+"'";
        }
        objJson += "}]"; 
        returnParam[0] = eval(objJson)[0];
    }else{
    	var idx = 0;
        for( var i = 1; i<=DS_O_OFFDTL.CountRow; i++){
            var objJson = "[{";
            for(var j=1;j<=DS_O_OFFMST.CountColumn;j++)
            {
                if(j>1) objJson +=  ",";
                objJson += "'"+DS_O_OFFMST.ColumnID(j)+"':'"+DS_O_OFFMST.NameValue( row, DS_O_OFFMST.ColumnID(j))+"'";
            }
            for(var j=1;j<=DS_O_OFFDTL.CountColumn;j++)
            {
                objJson +=  ",";
                objJson += "'"+DS_O_OFFDTL.ColumnID(j)+"':'"+DS_O_OFFDTL.NameValue( i, DS_O_OFFDTL.ColumnID(j))+"'";
            }
            objJson += "}]"; 
            returnParam[idx++] = eval(objJson)[0]; 
        }
    }
            
    window.returnValue = true;
    window.close();    
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
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
 <script language=JavaScript for=GD_OFFMST event=OnDblClick(row,colid)>
<!--// 그리드 double 클릭이벤트에서 처리 할 내역 추가        
    doDoubleClick(row);    
//-->
</script> 
<script language=JavaScript for=EM_OFFER_FROM_DT event=OnKillFocus()>
    checkDateTypeYMD(this,''); 
</script> 
<script language=JavaScript for=EM_OFFER_TO_DT event=OnKillFocus()>
    checkDateTypeYMD(this,''); 
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
<comment id="_NSID_"><object id=DS_I_COND             classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_STR_CD"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== Output용 -->
<comment id="_NSID_"><object id="DS_O_OFFMST"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_OFFDTL"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

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
<body onLoad="doInit();">
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
							align="absmiddle" class="popR05 PL03" /> <span id="title1"
							class="PL03">OFFER SHEET </span></td>
						<td>
						<table border="0" align="right" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="/<%=dir%>/imgs/btn/search.gif" width="50"
									height="22" onClick="btn_Search();" /></td>
								<td><img src="/<%=dir%>/imgs/btn/confirm.gif" width="50"
									height="22" onClick="btn_Conf();" /></td>
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
								<th width="70">점</th>
								<td width="110"><comment id="_NSID_"> <object id=LC_STR_CD
									classid=<%=Util.CLSID_LUXECOMBO%> height=20 width=110></object>
								    </comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="70" class="point" >OFFER 기간</th>
								<td><comment id="_NSID_"> <object id=EM_OFFER_FROM_DT
									classid=<%=Util.CLSID_EMEDIT%> height=20 width=70 align="absmiddle" ></object>
									</comment><script>_ws_(_NSID_);</script>
									<img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"  class="PR03" onclick="javascript:openCal('G',EM_OFFER_FROM_DT)" />
									~
								    <comment id="_NSID_"> <object id=EM_OFFER_TO_DT
									classid=<%=Util.CLSID_EMEDIT%> height=20 width=70 align="absmiddle" > </object> 
                                    </comment><script>_ws_(_NSID_);</script>
                                    <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"  class="PR03" onclick="javascript:openCal('G',EM_OFFER_TO_DT)" />                                    
								</td>
							</tr>
                            <tr>
                                <th >OFFER NO</th>
                                <td colspan="3"><comment id="_NSID_"> <object id=EM_OFFER_NO
                                    classid=<%=Util.CLSID_EMEDIT%> height=20 width=360 align="absmiddle" ></object>
                                    </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <tr>
                                <th width="70">브랜드</th>
                                <td width="110"><comment id="_NSID_"> <object id=EM_PUMBUN_CD
                                    classid=<%=Util.CLSID_EMEDIT%> height=20 width=110 align="absmiddle" ></object>
                                    </comment><script>  _ws_(_NSID_);</script>
                                </td>
                                <th width="70">브랜드명</th>
                                <td><comment id="_NSID_"> <object id=EM_PUMBUN_NAME
                                    classid=<%=Util.CLSID_EMEDIT%> height=20 width=200 align="absmiddle" ></object>
                                    </comment><script>  _ws_(_NSID_);</script>                                    
                                </td>
                            </tr>
                            <tr>
                                <th>협력사</th>
                                <td><comment id="_NSID_"> <object id=EM_VEN_CD
                                    classid=<%=Util.CLSID_EMEDIT%> height=20 width=110 align="absmiddle" ></object>
                                    </comment><script>  _ws_(_NSID_);</script>
                                </td>
                                <th>협력사명</th>
                                <td><comment id="_NSID_"> <object id=EM_VEN_NAME
                                    classid=<%=Util.CLSID_EMEDIT%> height=20 width=200 align="absmiddle" ></object>
                                    </comment><script>  _ws_(_NSID_);</script>                                    
                                </td>
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
						<td><!-- 마스터 --> 
						    <comment id="_NSID_"><object
							id=GD_OFFMST height="225px" width="100%"
							classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_O_OFFMST">
						</object></comment><script>  _ws_(_NSID_);</script>
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
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

<comment id="_NSID_">
<object id=BO_SEARCH classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_I_COND>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=STR_CD           ctrl=LC_STR_CD             param=BindColVal </c>
            <c>col=OFFER_FROM_DT    ctrl=EM_OFFER_FROM_DT      param=Text </c>
            <c>col=OFFER_TO_DT      ctrl=EM_OFFER_TO_DT        param=Text </c>
            <c>col=OFFER_SHEET_NO   ctrl=EM_OFFER_NO           param=Text </c>
            <c>Col=PUMBUN_CD        ctrl=EM_PUMBUN_CD          param=Text </c>
            <c>col=PUMBUN_NAME      ctrl=EM_PUMBUN_NAME        param=Text </c>
            <c>Col=VEN_CD           ctrl=EM_VEN_CD             param=Text </c>
            <c>col=VEN_NAME         ctrl=EM_VEN_NAME           param=Text </c>
            <c>Col=MNG_NM3          ctrl=EM_MNG_NM3            param=Text </c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
