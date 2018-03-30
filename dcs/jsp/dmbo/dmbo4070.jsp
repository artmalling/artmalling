<!-- 
/*******************************************************************************
 * 시스템명 : 영업지원 > 고객관리 > 멤버쉽운영 > 기간별가입회원List조회
 * 작 성 일 : 2010.05.03
 * 작 성 자 : 김경은
 * 수 정 자 :  
 * 파 일 명 : dmbo4070.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 : 기간별가입회원List조회
 * 
 ******************************************************************************/
--> 

<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    String dir = BaseProperty.get("context.common.dir");

	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"   src="/<%=dir%>/js/common.js"        type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/gauce.js"         type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/global.js"        type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/message.js"       type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/popup.js"         type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/popup_dcs.js"     type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--

var strToday          = "";                            // 현재날짜
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 80;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID
 function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";


     strToday = getTodayDB("DS_O_RESULT");
     
     // Input Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
   
     //그리드 초기화
     gridCreate1(); //마스터
     
     // EMedit에 초기화
     initEmEdit(EM_FROM_DT, "YYYYMMDD", PK);            // 시작일
     initEmEdit(EM_TO_DT, 	"YYYYMMDD", PK);            // 종료일

     //콤보 초기화
     initComboStyle(LC_STR_CD,	DS_IO_STR_CD,	"CODE^0^30,NAME^0^150", 1, PK);        // 점(조회)
     //initComboStyle(LC_GB_CD,	DS_IO_GB_CD,	"CODE^0^20,NAME^0^40", 1, PK);        // 
     
     DS_IO_GB_CD.setDataHeader('CODE:STRING(10),NAME:STRING(40)');
     
     var row = "";
     DS_IO_GB_CD.AddRow();
     row = DS_IO_GB_CD.CountRow;
	 DS_IO_GB_CD.NameValue(row, "CODE") = "%";
     DS_IO_GB_CD.NameValue(row, "NAME") = "전체";
     DS_IO_GB_CD.AddRow();
     row = DS_IO_GB_CD.CountRow;
	 DS_IO_GB_CD.NameValue(row, "CODE") = "Y";
     DS_IO_GB_CD.NameValue(row, "NAME") = "제휴";
     DS_IO_GB_CD.AddRow();
     row = DS_IO_GB_CD.CountRow;
	 DS_IO_GB_CD.NameValue(row, "CODE") = "N";
     DS_IO_GB_CD.NameValue(row, "NAME") = "일반";
     
     
     getStore("DS_IO_STR_CD",     "Y", "", "N");  
     
     EM_FROM_DT.Text = strToday;
     EM_TO_DT.Text = strToday;
     
     //LC_GB_CD.index   = 0;
     LC_STR_CD.index   = 0;
     LC_STR_CD.Focus(); 
     
     RD_BFGUBUN.CodeValue = "%";
     RD_ENTRGUBUN.CodeValue = "%";
     /*
     document.getElementById("CHK_BRAND").checked 	= true;
     document.getElementById("CHK_INFO").checked	= true;
     document.getElementById("CHK_MOBILE").checked	= true;
     */

 }

 function gridCreate1(){
     var hdrProperies = '<C>id={currow}		name="NO"				width=30    Edit=none  	align=center		</C>'
                      + '<C>id=ENTR_DT      name="가입일자"    		width=80    Edit=none 	mask="XXXX-XX-XX"	align=center</C>'
                      + '<C>id=CUST_ID     	name="회원번호"     	width=80    Edit=none 	sumtext="회원수"	align=center</C>'
                      + '<C>id=CUST_NAME	name="성명"    			width=80	Edit=none  	sumtext=@count 		align=center</C>'
                      + '<C>id=MOBILE_PH    name="휴대폰번호"   	width=120   Edit=none 	align=center		</C>'
                      + '<C>id=SMS_YN       name="문자수신"     	width=70    Edit=none 	align=center		</C>'
                      + '<C>id=EMAIL       	name="이메일"      		width=100   Edit=none 	sumtext="합계" 		align=left	</C>'
                      + '<C>id=EMAIL_YN    	name="이메일수신"   	width=70    Edit=none 	align=center		</C>'
                      + '<C>id=SALE_AMT  	name="기간누계매출(원)"	width=120   Edit=none 	sumtext=@sum 		align=right	</C>'
                      + '<C>id=ENURI_AMT  	name="가입일자매출(원)"	width=120   Edit=none 	sumtext=@sum 		align=right	</C>'
                      + '<C>id=CUST_POINT  	name="포인트"       	width=80    Edit=none  	sumtext=@sum 		align=right	</C>'
                      + '<C>id=DI_BG  		name="혜택구분"     	width=80    Edit=none  	align=center 		color={decode(DI,"0","#FE2E2E","1","#2E64FE","black")}	</C>'
                      + '<C>id=ENTR_GB  	name="가입구분"     	width=80    Edit=none  	align=center 		color={decode(ENTR_GB,"브랜드","#FE2E2E","모바일","#2E64FE","black")}	</C>'
                      + '<C>id=JEHU       	name="회원구분"     	width=65    Edit=none	align=center		</C>'
                      + '<C>id=ZIP_CD     	name="우편번호"     	width=60    Edit=none	align=center		</C>'
                      + '<C>id=HOME_ADDR    name="주소"      		width=400   Edit=none	align=left			</C>'
                      + '<C>id=REG_DATE     name="등록일시"     	width=140   Edit=none	align=center		</C>'
                      + '<C>id=REG_ID     	name="등록자"      		width=100   Edit=none	align=center		</C>'
                      ;
                      
     initGridStyle(GR_MASTER, "common", hdrProperies, false);
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
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	if(!checkValidation("search")) return;
	 
	DS_IO_MASTER.ClearData(); 
    // 조회조건 셋팅
    var strStrCd   		= LC_STR_CD.BindColVal;	// 점
    var strFromDt       = EM_FROM_DT.text;      // 시작일자
    var strToDt         = EM_TO_DT.text;        // 종료일자
    //var strGbFlag       = LC_GB_CD.BindColVal;        // 
    
    var strEntrGubun	= RD_ENTRGUBUN.CodeValue;

    var strBfGubun		= RD_BFGUBUN.CodeValue;
    
	var strChkNoBf		= "";
	
    if (document.getElementById("CHK_NOBF").checked)
    	strChkNoBf = "1";
    else
    	strChkNoBf = "0";
    
    var strOrder = "1";
    
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters =  "&strStrCd="		+encodeURIComponent(strStrCd)
				    + "&strFromDt=" 	+encodeURIComponent(strFromDt)
				    + "&strToDt="   	+encodeURIComponent(strToDt)
				    + "&strGbFlag="		+encodeURIComponent("%")
				    + "&strBfGubun="	+encodeURIComponent(strBfGubun)
				    + "&strEntrGubun="	+encodeURIComponent(strEntrGubun)				    
				    + "&strChkNoBf="	+encodeURIComponent(strChkNoBf)
				    + "&strOrder="		+encodeURIComponent(strOrder)
				    ; 
    
    TR_MAIN.Action  = "/dcs/dmbo407.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; 
    TR_MAIN.Post();
 
    GR_MASTER.focus();
    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);

    //스크롤바 위치 조정
    GR_MASTER.SETVSCROLLING(0);
    GR_MASTER.SETHSCROLLING(0);
    
}

/**
 * btn_New()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-05-03
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
function btn_Save() {
    
}


/**
 * btn_Excel()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	 
	var strStrCd   		= LC_STR_CD.Text;          // 점
    var strFromDt       = EM_FROM_DT.Text;         // 시작일자
    var strToDt         = EM_TO_DT.Text;           // 종료일자
    //var strGbFlag       = LC_GB_CD.Text;        // 구분
    var strNoBf			= "";
    
    if (document.getElementById("CHK_NOBF").checked)
    	strNoBf = " ＊ 혜택없음제외"
    
	var parameters = "";
		parameters  = "점="+strStrCd                    
			    	+ " -조회기간="+ strFromDt
			    	+ "~"+ strToDt
			    	+ " - 가입구분 ="+ RD_ENTRGUBUN.DataValue
					+ " - 혜택구분 ="+ RD_BFGUBUN.DataValue
			    	//+ " -회원구분="+ strGbFlag
			    	+ "   " + strNoBf;
			    	;
	//openExcel2(GR_MASTER, "기간별가입회원list", parameters, true );
	openExcel5(GR_MASTER, "기간별가입회원list", parameters, true , "",g_strPid );
}

/**
 * btn_Print()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * checkValidation()
  * 작 성 자     : 김경은
  * 작 성 일     : 2010-04-13
  * 개    요        : 조회조건 값 체크 
  * return값 : void
  */	 
 function checkValidation(Gubun) {
	 switch (Gubun){
	    case "search" :

	        //점 체크
	        if (isNull(LC_STR_CD.BindColVal)==true ) {
	            showMessage(Information, OK, "USER-1003","점");
	            LC_STR_CD.focus();
	            return false;
	        }
	        
			//매출일자
	        if (isNull(EM_FROM_DT.Text) ==true ) {
	            showMessage(Information, OK, "USER-1003","시작일자"); 
	            EM_FROM_DT.focus();
	            return false;
	        }
	        //년월 자릿수, 공백 체크
	        if (EM_FROM_DT.Text.replace(" ","").length != 8 ) {
	            showMessage(Information, OK, "USER-1027","시작일자","8");
	            EM_FROM_DT.focus();
	            return false;
	        }
	        if(!checkYYYYMMDD(EM_FROM_DT.Text)){
	        	showMessage(Information, OK, "USER-1004","시작일자");
	        	EM_FROM_DT.focus();
	            return false;
	        }
	        	
	        if (isNull(EM_TO_DT.Text) ==true ) {
	            showMessage(Information, OK, "USER-1003","종료일자"); 
	            EM_TO_DT.focus();
	            return false;
	        }
	        //년월 자릿수, 공백 체크
	        if (EM_TO_DT.Text.replace(" ","").length != 8 ) {
	            showMessage(Information, OK, "USER-1027","종료일자","8");
	            EM_TO_DT.focus();
	            return false;
	        }
	        if(!checkYYYYMMDD(EM_TO_DT.Text)){
	            showMessage(Information, OK, "USER-1004","종료일자");
	            EM_TO_DT.focus();
	            return false;
	        }
	        
	        if(!isBetweenFromTo(EM_FROM_DT.Text, EM_TO_DT.Text)){
	            showMessage(INFORMATION, OK, "USER-1015"); 
	            EM_FROM_DT.focus();
	            return false;
	        }
	        
	        if(setDateAdd("M", "3", EM_FROM_DT.Text) < EM_TO_DT.Text) {
	        	showMessage(EXCLAMATION, OK, "USER-1000",  "가입기간은 최대 3개월이내로 조회 할 수 있습니다.");
	            EM_FROM_DT.focus();
	            return false;
	        } 
	         
	        break;
	   
	    }
	    return true;
      
  }

 /**
  * fnChk(obj)
  * 작 성 자     :  
  * 작 성 일     : 2017-11-21
  * 개       요    : 체크박스 옵션 모두 해제 금지
  * return값 : void
  */
function fnChk(obj){
 	
 	 var tfTemp = !obj.checked;
 	 
 	 if (!document.getElementById("CHK_INFO").checked&&!document.getElementById("CHK_MOBILE").checked&&!document.getElementById("CHK_BRAND").checked) {
 		 alert("반드시 한가지 옵션은 선택되어야 합니다.");
 		 obj.checked = tfTemp;
 	 }
}
 

-->
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

<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>
	
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<script	language=JavaScript	for=RD_BFGUBUN event=onSelChange()>
	var strTemp = RD_BFGUBUN.CodeValue;
	
	if (strTemp != "%") { // 단문
		document.getElementById("CHK_NOBF").checked = false;
		document.getElementById("CHK_NOBF").disabled = true;
	} else {
		document.getElementById("CHK_NOBF").disabled = false;
	}
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
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_IO_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_GB_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<table width="100%"  border="0" cellspacing="0" cellpadding="0">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="60" class="point">점</th>
            <td width="100">
                    <comment id="_NSID_">
                        <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=150 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>

            </td>
            <th width="60" class="point">가입기간</th>
            <td width="300">
                  <comment id="_NSID_">
                      <object id=EM_FROM_DT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
                      </object>
                  </comment><script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_FROM_DT" onclick="javascript:openCal('G',EM_FROM_DT)" align="absmiddle" />
                  ~
                  <comment id="_NSID_">
                      <object id=EM_TO_DT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
                      </object>
                  </comment><script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_TO_DT" onclick="javascript:openCal('G',EM_TO_DT)" align="absmiddle" />
            </td>
            <th width="60" class="point">가입구분</th>
            <td width="250" >
				<!-- input type="checkbox" id=CHK_INFO checked onclick="fnChk(this);"> 고객센터
				<input type="checkbox" id=CHK_BRAND checked onclick="fnChk(this);"> 브랜드
				<input type="checkbox" id=CHK_MOBILE checked onclick="fnChk(this);"> 모바일 -->
				<comment id="_NSID_"> 
					<object id="RD_ENTRGUBUN" classid="<%=Util.CLSID_RADIO%>" width=300 height=18 align="absmiddle">
						<param name="Cols"   value="4">
						<param name="Format" value="%^전체,0^고객센터,1^브랜드,2^모바일">
					</object> 
				</comment><script>_ws_(_NSID_);</script>
			</td>
			<th width="60" class="point">혜택구분</th>
            <td width="350" >
            	<comment id="_NSID_"> 
					<object id="RD_BFGUBUN" classid="<%=Util.CLSID_RADIO%>" width=250 height=18 align="absmiddle">
						<param name="Cols"   value="3">
						<param name="Format" value="%^전체,0^적립,1^즉시할인">
					</object> 
				</comment><script>_ws_(_NSID_);</script>
				<input type="checkbox" id=CHK_NOBF> 혜택없음제외
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  
  <tr>
    <td class="dot"></td>
  </tr>

  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
          <tr>
            <td width="100%">
                <comment id="_NSID_">
                    <OBJECT id=GR_MASTER width=100% height=500 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_IO_MASTER">
                        <Param Name="ViewSummary"   value="1" >
                    </OBJECT>
                </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>  
</table>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>

