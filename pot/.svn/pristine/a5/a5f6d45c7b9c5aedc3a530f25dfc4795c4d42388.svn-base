<!-- 
/*******************************************************************************
 * 시스템명 : 시스템관리 > 게시물관리 > 공지사항관리> 공지사항관리
 * 작 성 일 : 2010.06.13
 * 작 성 자 : HSEON
 * 수 정 자 : 
 * 파 일 명 : tcom2012.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 팀공지 : 조직을 추가한다.
 * 이    력 : 
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8");  %>
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
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script> 

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">  
var bfRowPosition = 1; 
var opener = window.dialogArguments; 

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
  
    // Output Data Set Header 초기화
    DS_O_STR_CD.setDataHeader('<gauce:dataset name="H_STR_CD"/>');
    DS_O_DEPT_CD.setDataHeader('<gauce:dataset name="H_DEPT_CD"/>'); 
	    
    //그리드 초기화
    gridCreate();
    
    //조직구분(조회)
    initComboStyle(LC_O_ORG_FLAG,   DS_O_ORG_FLAG,  "CODE^0^20,NAME^0^90", 1, NORMAL); 
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_ORG_FLAG", "D", "P047", "N");
    //콤보데이터 기본값 설정( gauce.js ) 
    LC_O_ORG_FLAG.index = 0;
    
    // 조직
    selectStrCd();
}

function gridCreate(){ 
    var hdrProperies1 = '<FC>id=STR_CD       show=false   name="점코드"    </FC>' 
                      + '<FC>id=STR_CHK      width=40     name="선택"      editstyle=checkbox    </FC>'
				      + '<FC>id=STR_NAME     width=170    name="점"        edit=none            </FC>' ;
				
	initGridStyle(GD_STORE, "common", hdrProperies1, true );   
	
	var hdrProperies2 = '<FC>id=STR_CD        show=false   name="점코드"      </FC>'
		              + '<FC>id=DEPT_CD       show=false   name="팀코드"    </FC>'
				      + '<FC>id=DEPT_CHK      width=40     name="선택"        editstyle=checkbox  </FC>'
				      + '<FC>id=DEPT_NAME     width=200    name="팀"        edit=none           </FC>' ;
				        
    initGridStyle(GD_DEPT, "common", hdrProperies2, true );  
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-02-24
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {  
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
  
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
 
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-02-24
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() { 
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

function btn_Close(){
	this.close();
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/  
 /**
   * btn_InsertRow()
   * 작 성 자 : 
   * 작 성 일 : 2010-09-08
   * 개    요 : opener dataset에 추가
   * return값 : void
 */
 function btn_InsertRow(){ 

    var objDs = window.dialogArguments.DS_IO_DEPT_CD; 
    var row   = 0; 
    var cntDept = 0;
    var addCnt = 0;

    for(var i=1; i<=DS_O_DEPT_CD.CountRow; i++)
    { 
        if(DS_O_DEPT_CD.NameValue(i,"DEPT_CHK") == "T") cntDept +=1; 
    }
    // 
    
    if (cntDept == 0)
    {
    	// 점만까지 addrow
        for(var i=1; i<=DS_O_STR_CD.CountRow; i++)
        {
            if(DS_O_STR_CD.NameValue(i,"STR_CHK") == "T")
            {
               // 점코드는 존재하고 팀코드가 없는 값끼리 비교  
                if( objDs.NameValueRow("GBN" , DS_O_STR_CD.NameValue(i,"STR_CD") ) == 0  )   
               {
                    objDs.AddRow();
                    objDs.NameValue(objDs.CountRow, "CHK")          = "T";
                    objDs.NameValue(objDs.CountRow, "STR_CD")       = DS_O_STR_CD.NameValue(i,"STR_CD");
                    objDs.NameValue(objDs.CountRow, "STR_NAME")     = DS_O_STR_CD.NameValue(i,"STR_NAME");
                    objDs.NameValue(objDs.CountRow, "DEPT_CD")      = "";
                    objDs.NameValue(objDs.CountRow, "DEPT_NAME")    = ""; 
                    objDs.NameValue(objDs.CountRow, "GBN")    		= DS_O_STR_CD.NameValue(i,"STR_CD") ; 
                    addCnt++;
                } 
            } 
            
        } 
    	
    }
    else
    {
    	// 팀까지 addrow
        for(var i=1; i<=DS_O_DEPT_CD.CountRow; i++)
        {
            if(DS_O_DEPT_CD.NameValue(i,"DEPT_CHK") == "T")
            {

                if( objDs.NameValueRow("GBN"
                        , DS_O_DEPT_CD.NameValue(i,"STR_CD") + DS_O_DEPT_CD.NameValue(i,"DEPT_CD") ) == 0  )    
               {
                    objDs.AddRow();
                    objDs.NameValue(objDs.CountRow, "CHK")          = "T";
                    objDs.NameValue(objDs.CountRow, "STR_CD")       = DS_O_DEPT_CD.NameValue(i,"STR_CD");
                    objDs.NameValue(objDs.CountRow, "STR_NAME")     = DS_O_DEPT_CD.NameValue(i,"STR_NAME");
                    objDs.NameValue(objDs.CountRow, "DEPT_CD")      = DS_O_DEPT_CD.NameValue(i,"DEPT_CD");
                    objDs.NameValue(objDs.CountRow, "DEPT_NAME")    = DS_O_DEPT_CD.NameValue(i,"DEPT_NAME"); 
                    objDs.NameValue(objDs.CountRow, "GBN")    		= DS_O_DEPT_CD.NameValue(i,"STR_CD") + DS_O_DEPT_CD.NameValue(i,"DEPT_CD") ;

                    addCnt++;
                }
                
            } 
        } 
    } 

    if (addCnt >0) 
    {
    	showMessage(EXCLAMATION, OK, "USER-1000", "추가하였습니다."); 
    	this.close();
    }
    else showMessage(EXCLAMATION, OK, "USER-1000", "이미 추가하였습니다."); 

}
   
 /**
  * selectStrCd()
  * 작 성 자 : FKL
  * 작 성 일 : 2010-05-30
  * 개    요 : 팀공지 -> 점리스트 셋팅
  * return값 : void
  */
 function selectStrCd()
 {
	 var action = "O"; 
     var goTo   = "selectStrCd";    
        
     TR_MAIN.Action="/pot/tcom201.tc?goTo="+goTo;   
     TR_MAIN.KeyValue="SERVLET("+action+":DS_O_STR_CD=DS_O_STR_CD)"; //조회는 O 
     TR_MAIN.Post();    
 }
 
 /**
  * selectDeptCd()
  * 작 성 자 : FKL
  * 작 성 일 : 2010-05-30
  * 개    요 : 팀공지 -> 팀리스트 셋팅
  * return값 : void
  */
 function selectDeptCd(strCd) {
	 // 조직
     var strBindOrgFlag  = LC_O_ORG_FLAG.BindColVal;                        
	    
     var goTo       = "selectDeptCd" ;    
     var action     = "O";       
     var parameters = "&strStrCd="+encodeURIComponent(strCd)
                    + "&strOrgFlag="+encodeURIComponent(strBindOrgFlag) ;
     
     TR_MAIN1.Action="/pot/tcom201.tc?goTo="+goTo+parameters;  
     TR_MAIN1.KeyValue="SERVLET("+action+":DS_O_DEPT_CD=DS_O_DEPT_CD)"; //조회는 O
     TR_MAIN1.Post();
     
 } 


/**
  * btn_Del1()
  * 작 성 자 : 엄준석
  * 작 성 일 : 2010-09-08
  * 개    요 : 광역 그리드 Row 삭제 
  * return값 : void
*/
function btn_Del(){
}

/**
 * valueCheck()
 * 작 성 자 : 엄준석
 * 작 성 일 : 2010-09-08
 * 개    요 : 데이터 적합성 체크
 * return값 : void
*/
function valueCheck() {
 
}


/**
 * chkStrCnt()
 * 작 성 자 : 
 * 작 성 일 : 2010-09-08
 * 개    요 : 하나 이상 점 선택시 팀 체크박스 READONLY
 * return값 : void
*/ 
function chkStrCnt()
{
    var cntStr = 0;
    for(var i=1; i<=DS_O_STR_CD.CountRow; i++)
    {
        if(DS_O_STR_CD.NameValue(i,"STR_CHK") == "T")
            cntStr += 1;
    }  
    if (cntStr > 1 )
        DS_O_DEPT_CD.ReadOnly = true; 
    else 
        DS_O_DEPT_CD.ReadOnly = false; 
}
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                        *-->
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
        showMessage(EXCLAMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_MAIN1 event=onSuccess>
    for(i=0;i<TR_MAIN1.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_MAIN1.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_MAIN1 event=onFail>
    trFailed(TR_MAIN1.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  -------------------------------> 
<script language=JavaScript for=DS_IO_GROUP event=OnLoadCompleted(rowcnt)>
    if(rowcnt > 0) {
        DS_IO_GROUP.RowPosition = bfGroupRowPosition;
    }
</script>
<script language=JavaScript for=LC_O_ORG_FLAG event=OnSelChange>
    DS_O_DEPT_CD.ClearData();
    
    var strStrRowPosition = DS_O_STR_CD.Rowposition;
    selectStrCd();
    DS_O_STR_CD.Rowposition = strStrRowPosition;
</script>

<script language=JavaScript for=DS_O_STR_CD event=OnLoadCompleted(rowcnt)>
    if(rowcnt > 0) {
    	DS_O_STR_CD.RowPosition = bfRowPosition;
    }
</script>

<!-- 점선택시 팀조회-->
<script language=JavaScript for=DS_O_STR_CD event=OnRowPosChanged(row)>  
//     if(row < 1) return; 

// alert("row = " + row);
    
    if(bfRowPosition == row) return;            
    if( DS_O_DEPT_CD.IsUpdated ) {
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
            DS_O_STR_CD.RowPosition = bfRowPosition;
            return;
        }
        DS_O_STR_CD.UndoAll();
    }
    
    bfRowPosition = row;  
    selectDeptCd(DS_O_STR_CD.NameValue(row,"STR_CD"));
    chkStrCnt();
    
</script> 

<script language=JavaScript for=DS_O_STR_CD event=OnColumnChanged(row,colid)>
    chkStrCnt();
</script>

<script language=JavaScript for=GD_DEPT event=OnClick(row,colid)> 
	if(DS_O_STR_CD.NameValue(DS_O_STR_CD.RowPosition,"STR_CHK") == "F")
	{
	    DS_O_STR_CD.NameValue(DS_O_STR_CD.RowPosition,"STR_CHK") = "T";
	    
	    var cntStr = 0;
	    for(var i=1; i<=DS_O_STR_CD.CountRow; i++)
	    {
	        if(DS_O_STR_CD.NameValue(i,"STR_CHK") == "T")
	            cntStr += 1;
	    } 
	    
	    if (cntStr > 1) 
	    {
	    	DS_O_DEPT_CD.UndoAll(); 
            DS_O_DEPT_CD.ReadOnly = true; 
	    }
	    else 
	        DS_O_DEPT_CD.ReadOnly = false; 
	    
	}  
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------> 
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_USER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_MAIN event=OnClick(row,colid)> 
    if( row < 1)
        sortColId( eval(this.DataID), row , colid );
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
<comment id="_NSID_"><object id="DS_O_ORG_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR_CD"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DEPT_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 본문 -->
<comment id="_NSID_"><object id="DS_IO_ORG_CD" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_NOTICE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

 
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_"><object id="TR_MAIN"  classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="TR_MAIN1" classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>

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
    <td class="pop02" ></td>
    <td class="pop03" ></td>
  </tr>
  <tr>
    <td class="pop04" ></td>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan=3><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="" class="title">
              <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
              <span id="title1" class="PL03">조직POPUP</span>
            </td>
            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/<%=dir%>/imgs/btn/add.gif"   width="50" height="22"   onClick="btn_InsertRow()"/></td>
                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
                
                </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="PT01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr><td class="PB03">
		            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
		            <tr>
		            <td>
		                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table"> 
		                <tr>
		                 <th width="60" >조직구분</th>
		                 <td width="130">
		                    <comment id="_NSID_"> 
		                        <object id=LC_O_ORG_FLAG classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=130 align="absmiddle"  tabindex=2 > </object> 
		                    </comment><script>_ws_(_NSID_);</script></td>
		                </tr>  
		                </table>
		            </td></tr>
		            </table> 
		    </td></tr>
		    <tr><td class="dot"></td></tr>
			<tr><td class="PB03"> 
	             <table width="100%" border="0" cellpadding="0" cellspacing="0" class="BD4A"> 
	             <tr><td>
		              <!-- 점 -->
		              <comment id="_NSID_">
		              <OBJECT id=GD_STORE width="250" height="400" classid=<%=Util.CLSID_GRID%>>
		                  <param name="DataID" value="DS_O_STR_CD">
		              </OBJECT></comment><script>_ws_(_NSID_);</script>
	           </td></tr>
	           </table>
             </td></tr>
             </table>
          </td>  
          <td width="2"></td> 
          <td valign="top">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="BD4A"> 
                <tr><td>
	                <!-- 팀 -->
	                <comment id="_NSID_">
	                <OBJECT id=GD_DEPT width="280" height="444" classid=<%=Util.CLSID_GRID%>>
	                    <param name="DataID" value="DS_O_DEPT_CD">
	                </OBJECT></comment><script>_ws_(_NSID_);</script>
                </td></tr>   
                </table>
            </td></tr>
        </table></td> 
     <td class="pop06" ></td>
  </tr>
  <tr>
     <td class="pop07" ></td>
     <td class="pop08" ></td>
     <td class="pop09" ></td>
  </tr>
</table> 


</body>
</html>

