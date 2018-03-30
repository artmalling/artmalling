<!-- 
/*******************************************************************************
 * 시스템명 : 점별 브랜드 조회  팝업
 * 작 성 일 : 2016-10-25
 * 작 성 자 : 박래형 
 * 수 정 자 : 
 * 파 일 명 : ccom9992.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 점별 브랜드 조회 팝업
 * 이    력 :
 ******************************************************************************/
--> 
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<title>브랜드 -POPUP</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 // 부모에게 받은 변수 세팅
 var gStrPid    = dialogArguments[0];
 var gStrSqlGb  = dialogArguments[1];
 var gStrMulti  = dialogArguments[2];
 var gArrParams = dialogArguments[3];

/**
 * doInit()
 * 작 성 자 : 박래형 
 * 작 성 일 : 2016-10-25
 * 개    요 : initialize
 * return값 : void
**/
function doInit() 
{     	
    //그리드 초기화
    gridCreate1();
            
    // EMedit 초기화
    initEmEdit(EM_SEARCH_CD, "CODE^40^0", NORMAL);
    initEmEdit(EM_SEARCH_NM, "GEN^20", NORMAL);

    // Input Data Set Header 초기화 
	var strDataHd  = "";
	strDataHd  = "STR_CD:STRING(2),PUMBUN_CD:STRING(40),PUMBUN_NAME:STRING(100),PID:STRING(7),SQL_GB:STRING(100)";
	strDataHd += ",PUMBUN_TYPE:STRING(1),SKU_FLAG:STRING(1),BIZE_TYPE:STRING(100),SKU_TYPE:STRING(1)";
    DS_I_COND.setDataHeader(strDataHd);

    // 공통코드 호출
    getEtcCode("DS_HALL_CD", "D", "P197", "Y");		// 관
    getEtcCode("DS_FLOR_CD", "D", "P061", "Y");		// 층

    EM_SEARCH_CD.Focus();
    // 자동조회
	var strSearchCd = gArrParams.PUMBUN_CD != "undefined" ? gArrParams.PUMBUN_CD : "";
    if(strSearchCd.length > 0){
    	EM_SEARCH_CD.Text = strSearchCd;
    	btn_Search();
    }
} 

function gridCreate1(){
	var strShow = false;
	
    if(gStrMulti == "M") strShow = true;
    
	var hdrProperies = '<FC>id={currow}        name="NO"    width=40    align=center  edit=none </FC>'
	                 + '<FC>ID="CHK"           name="선택"  width=60,   align=center, EditStyle="CheckBox" show=' + strShow + '</FC>'
                     + '<FG>name="브랜드"'                                 
                     + '<FC>ID="PUMBUN_CD"     name="코드"  width=80,   edit=none     align=center  </FC>'
                     + '<FC>ID="PUMBUN_NAME"   name="명"    width=220,  edit=none     align=left    </FC>'
                     + '</FG>'   
                     ;
    
    initGridStyle(GD_SEARCH, "common", hdrProperies, true);
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
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-25
 * 개    요 : 점별 POS 조회
 * return값 : void
 */
function btn_Search(){ 
	DS_I_COND.ClearData();
	DS_I_COND.Addrow();
    	
	var nRow = DS_I_COND.RowPosition;
	DS_I_COND.NameValue(nRow, "PID")         = gStrPid   != "undefined" ? gStrPid   : "";
	DS_I_COND.NameValue(nRow, "SQL_GB")      = gStrSqlGb != "undefined" ? gStrSqlGb : "";
	DS_I_COND.NameValue(nRow, "STR_CD")      = gArrParams.STR_CD != "undefined" ? gArrParams.STR_CD : "";
	DS_I_COND.NameValue(nRow, "PUMBUN_CD")   = EM_SEARCH_CD.Text;
	DS_I_COND.NameValue(nRow, "PUMBUN_NAME") = EM_SEARCH_NM.Text;
	DS_I_COND.NameValue(nRow, "PUMBUN_TYPE") = gArrParams.PUMBUN_TYPE != "undefined" ? gArrParams.PUMBUN_TYPE : "";
	DS_I_COND.NameValue(nRow, "SKU_FLAG")    = gArrParams.SKU_FLAG    != "undefined" ? gArrParams.SKU_FLAG    : "";
	DS_I_COND.NameValue(nRow, "BIZE_TYPE")   = gArrParams.BIZE_TYPE   != "undefined" ? gArrParams.BIZE_TYPE   : "";
	DS_I_COND.NameValue(nRow, "SKU_TYPE")    = gArrParams.SKU_TYPE    != "undefined" ? gArrParams.SKU_TYPE    : "";
	
	var strGoTo      = "searchPumbunCd";
    TR_MAIN.Action   = "/pot/ccom999.cc?goTo=" + strGoTo;
	TR_MAIN.KeyValue = "SERVLET(I:DS_I_COND=DS_I_COND,O:DS_O_RESULT=DS_O_RESULT)";
    TR_MAIN.Post();
}    

/*************************************************************************
 * 3. 함수
*************************************************************************/

/**
 * btn_Close()
 * 작 성 자 : 박래형 
 * 작 성 일 : 2016-10-25
 * 개    요 : Close
 * return값 : void
 */  
function btn_Close(){
    var rtnList = new Array();
    window.returnValue = rtnList;
    window.close();
}

/**
 * btn_Conf()
 * 작 성 자 : 박래형 
 * 작 성 일 : 2016-10-25
 * 개    요 : 확인버튼 클릭 처리
 * return값 : void
 **/  
function btn_Conf(){
    var nRow    = DS_O_RESULT.RowPosition;
    var arrList = new Array();
    var rtnList = new Array();
    var nCnt    = 0;
    
    if(DS_O_RESULT.CountRow < 1){
        window.returnValue = rtnList;
        window.close();
        return;
    }

    if(gStrMulti != "M"){	// 멀티 일 경우
    	arrList["STR_CD"]          = DS_O_RESULT.NameValue(nRow, "STR_CD");
    	arrList["PUMBUN_CD"]       = DS_O_RESULT.NameValue(nRow, "PUMBUN_CD");
    	arrList["PUMBUN_NAME"]     = DS_O_RESULT.NameValue(nRow, "PUMBUN_NAME");
    	arrList["RECP_NAME"]       = DS_O_RESULT.NameValue(nRow, "RECP_NAME");
    	arrList["SKU_FLAG"]        = DS_O_RESULT.NameValue(nRow, "SKU_FLAG");
    	arrList["REP_PUMBUN_CD"]   = DS_O_RESULT.NameValue(nRow, "REP_PUMBUN_CD");
    	arrList["SKU_TYPE"]        = DS_O_RESULT.NameValue(nRow, "SKU_TYPE");
    	arrList["BIZ_TYPE"]        = DS_O_RESULT.NameValue(nRow, "BIZ_TYPE");
    	arrList["TAX_FLAG"]        = DS_O_RESULT.NameValue(nRow, "TAX_FLAG");
    	arrList["CHAR_BUYER_CD"]   = DS_O_RESULT.NameValue(nRow, "CHAR_BUYER_CD");
    	arrList["CHAR_BUYER_NAME"] = DS_O_RESULT.NameValue(nRow, "CHAR_BUYER_NAME");
    	arrList["CHAR_SM_CD"]      = DS_O_RESULT.NameValue(nRow, "CHAR_SM_CD");
    	arrList["CHAR_SM_NAME"]    = DS_O_RESULT.NameValue(nRow, "CHAR_SM_NAME");
    	arrList["VEN_CD"]          = DS_O_RESULT.NameValue(nRow, "VEN_CD");
    	arrList["VEN_NAME"]        = DS_O_RESULT.NameValue(nRow, "VEN_NAME");
    	arrList["STYLE_TYPE"]      = DS_O_RESULT.NameValue(nRow, "STYLE_TYPE");
    	arrList["BUYER_EMP_NAME"]  = DS_O_RESULT.NameValue(nRow, "BUYER_EMP_NAME");
    	arrList["BUY_ORG_CD"]      = DS_O_RESULT.NameValue(nRow, "BUY_ORG_CD");
    	arrList["SALE_ORG_CD"]     = DS_O_RESULT.NameValue(nRow, "SALE_ORG_CD");
    	arrList["BRAND_CD"]        = DS_O_RESULT.NameValue(nRow, "BRAND_CD");
    	arrList["BRAND_NM"]        = DS_O_RESULT.NameValue(nRow, "BRAND_NM");
    	arrList["PUMBUN_TYPE"]     = DS_O_RESULT.NameValue(nRow, "PUMBUN_TYPE");
        rtnList[nCnt] = arrList;

    }else{					// 싱글일  경우
        for(nRow=1; nRow<=DS_O_RESULT.CountRow; nRow++){
            arrList = new Array();
            
            if(DS_O_RESULT.NameValue(nRow, "CHK") == "T"){
            	arrList["STR_CD"]          = DS_O_RESULT.NameValue(nRow, "STR_CD");
            	arrList["PUMBUN_CD"]       = DS_O_RESULT.NameValue(nRow, "PUMBUN_CD");
            	arrList["PUMBUN_NAME"]     = DS_O_RESULT.NameValue(nRow, "PUMBUN_NAME");
            	arrList["RECP_NAME"]       = DS_O_RESULT.NameValue(nRow, "RECP_NAME");
            	arrList["SKU_FLAG"]        = DS_O_RESULT.NameValue(nRow, "SKU_FLAG");
            	arrList["REP_PUMBUN_CD"]   = DS_O_RESULT.NameValue(nRow, "REP_PUMBUN_CD");
            	arrList["SKU_TYPE"]        = DS_O_RESULT.NameValue(nRow, "SKU_TYPE");
            	arrList["BIZ_TYPE"]        = DS_O_RESULT.NameValue(nRow, "BIZ_TYPE");
            	arrList["TAX_FLAG"]        = DS_O_RESULT.NameValue(nRow, "TAX_FLAG");
            	arrList["CHAR_BUYER_CD"]   = DS_O_RESULT.NameValue(nRow, "CHAR_BUYER_CD");
            	arrList["CHAR_BUYER_NAME"] = DS_O_RESULT.NameValue(nRow, "CHAR_BUYER_NAME");
            	arrList["CHAR_SM_CD"]      = DS_O_RESULT.NameValue(nRow, "CHAR_SM_CD");
            	arrList["CHAR_SM_NAME"]    = DS_O_RESULT.NameValue(nRow, "CHAR_SM_NAME");
            	arrList["VEN_CD"]          = DS_O_RESULT.NameValue(nRow, "VEN_CD");
            	arrList["VEN_NAME"]        = DS_O_RESULT.NameValue(nRow, "VEN_NAME");
            	arrList["STYLE_TYPE"]      = DS_O_RESULT.NameValue(nRow, "STYLE_TYPE");
            	arrList["BUYER_EMP_NAME"]  = DS_O_RESULT.NameValue(nRow, "BUYER_EMP_NAME");
            	arrList["BUY_ORG_CD"]      = DS_O_RESULT.NameValue(nRow, "BUY_ORG_CD");
            	arrList["SALE_ORG_CD"]     = DS_O_RESULT.NameValue(nRow, "SALE_ORG_CD");
            	arrList["BRAND_CD"]        = DS_O_RESULT.NameValue(nRow, "BRAND_CD");
            	arrList["BRAND_NM"]        = DS_O_RESULT.NameValue(nRow, "BRAND_NM");
            	arrList["PUMBUN_TYPE"]     = DS_O_RESULT.NameValue(nRow, "PUMBUN_TYPE");
            	
                rtnList[nCnt++] = arrList;
            }
        }
    
        // 멀티일 때 선택없이 그리드 더블클릭 시 해당Row 리턴
        if(nCnt == 0){
        	nRow = DS_O_RESULT.Rowposition;
        	arrList["STR_CD"]          = DS_O_RESULT.NameValue(nRow, "STR_CD");
        	arrList["PUMBUN_CD"]       = DS_O_RESULT.NameValue(nRow, "PUMBUN_CD");
        	arrList["PUMBUN_NAME"]     = DS_O_RESULT.NameValue(nRow, "PUMBUN_NAME");
        	arrList["RECP_NAME"]       = DS_O_RESULT.NameValue(nRow, "RECP_NAME");
        	arrList["SKU_FLAG"]        = DS_O_RESULT.NameValue(nRow, "SKU_FLAG");
        	arrList["REP_PUMBUN_CD"]   = DS_O_RESULT.NameValue(nRow, "REP_PUMBUN_CD");
        	arrList["SKU_TYPE"]        = DS_O_RESULT.NameValue(nRow, "SKU_TYPE");
        	arrList["BIZ_TYPE"]        = DS_O_RESULT.NameValue(nRow, "BIZ_TYPE");
        	arrList["TAX_FLAG"]        = DS_O_RESULT.NameValue(nRow, "TAX_FLAG");
        	arrList["CHAR_BUYER_CD"]   = DS_O_RESULT.NameValue(nRow, "CHAR_BUYER_CD");
        	arrList["CHAR_BUYER_NAME"] = DS_O_RESULT.NameValue(nRow, "CHAR_BUYER_NAME");
        	arrList["CHAR_SM_CD"]      = DS_O_RESULT.NameValue(nRow, "CHAR_SM_CD");
        	arrList["CHAR_SM_NAME"]    = DS_O_RESULT.NameValue(nRow, "CHAR_SM_NAME");
        	arrList["VEN_CD"]          = DS_O_RESULT.NameValue(nRow, "VEN_CD");
        	arrList["VEN_NAME"]        = DS_O_RESULT.NameValue(nRow, "VEN_NAME");
        	arrList["STYLE_TYPE"]      = DS_O_RESULT.NameValue(nRow, "STYLE_TYPE");
        	arrList["BUYER_EMP_NAME"]  = DS_O_RESULT.NameValue(nRow, "BUYER_EMP_NAME");
        	arrList["BUY_ORG_CD"]      = DS_O_RESULT.NameValue(nRow, "BUY_ORG_CD");
        	arrList["SALE_ORG_CD"]     = DS_O_RESULT.NameValue(nRow, "SALE_ORG_CD");
        	arrList["BRAND_CD"]        = DS_O_RESULT.NameValue(nRow, "BRAND_CD");
        	arrList["BRAND_NM"]        = DS_O_RESULT.NameValue(nRow, "BRAND_NM");
        	arrList["PUMBUN_TYPE"]     = DS_O_RESULT.NameValue(nRow, "PUMBUN_TYPE");
            rtnList[nCnt] = arrList;
        }
    }
    window.returnValue = rtnList;
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
 <script language=JavaScript for=GD_SEARCH event=OnDblClick(row,colid)>
	btn_Conf();
</script> 
<script language=JavaScript for=GD_SEARCH event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
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
<comment id="_NSID_"><object id=DS_I_COND   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_I_COMMON classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== Output용 -->
<comment id="_NSID_"><object id=DS_O_RESULT classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_HALL_CD  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_FLOR_CD  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

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
		<td class="pop04" ></td>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="" class="title">
									<img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
									<span id="title1" class="PL03">점별 브랜드 </span>
								</td>
								<td>
									<table border="0" align="right" cellpadding="0" cellspacing="0">
										<tr>
											<td><img src="/<%=dir%>/imgs/btn/search.gif" width="50" height="22"  onClick="btn_Search();"/></td>
											<td><img src="/<%=dir%>/imgs/btn/confirm.gif" width="50" height="22" onClick="btn_Conf()"/></td>
											<td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="popT01 PB03">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
										<tr>
											<th width="60">브랜드코드</th>
											<td width="66">
												<comment id="_NSID_">
													<object id=EM_SEARCH_CD classid=<%=Util.CLSID_EMEDIT%> height=20 width=65 onKeyDown="if(event.keyCode == 13) btn_Search();" >
													</object>
												</comment><script>_ws_(_NSID_);</script>
											</td>
										</tr>
										<tr>
										<th width="50">브랜드명</th>
											<td>
												<comment id="_NSID_">
													<object id=EM_SEARCH_NM classid=<%=Util.CLSID_EMEDIT%> height=20 width=245 onKeyDown="if(event.keyCode == 13) btn_Search();" >
													</object>
												</comment><script>_ws_(_NSID_);</script>
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
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="g_table">      
							<tr>
								<td>
									<!-- 마스터 -->
									<comment id="_NSID_">
										<object id=GD_SEARCH height="375px" width="100%" classid=<%=Util.CLSID_GRID%>>
											<param name="DataID" value="DS_O_RESULT">
										</object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
		<td class="pop06" ></td>
	</tr>
	<tr>
		<td class="pop07"></td>
		<td class="pop08"></td>
		<td class="pop09"></td>
	</tr>
</table>
</body>
</html>
