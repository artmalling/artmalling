<!-- 
/*******************************************************************************
 * 시스템명 : 시스템관리 > 포탈관리> 업무배너관리
 * 작 성 일 : 2010.07.19
 * 작 성 자 : Hseon
 * 수 정 자 : 
 * 파 일 명 : tcom4040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
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
<%@ page import="common.dao.CCom900DAO"%>

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
var strGlbOrgFlag  = ""; // 조직구분                                                                                                                  
var strGlbStrCd    = ""; // 점코드                                                                                                                    
var strGlbDeptCd   = ""; // 팀코드                                                                                                                  
var strGlbTeamCd   = ""; // 파트코드                                                                                                                    
var strGlbPcCd     = "";  // PC코드                                 

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

	// Data Set Header 초기화
	DS_IO_MAIN.setDataHeader('<gauce:dataset name="H_SEL_MAIN"/>');	

	// 이미지 데이터셋 초기화
	initImgDataSet(IDS_IMAGE);

    //그리드 초기화
	gridCreate(); 

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("tcom404","DS_IO_MAIN" );
	
    // 조회
	btn_Search(); 
    
}

function gridCreate(){

    GD_MAIN.ImgDataID = "IDS_IMAGE"; 
    var hdrProperies = '<FC>id=BAN_NO         	width=30   align=center     name="NO"			edit=none			</FC>'
                     + '<FC>id=BAN_NAME			width=125                   name="배너명"        					</FC>'
                     + '<FC>id=BAN_LINK			width=290                   name="LINK 주소"            				</FC>'
                     + '<FC>id=FILE_NM	        width=250  align=left       name="이미지"        edit=none 			</FC>'  
                     + '<FC>id=IMG   			width=65   align=center 						imgcol="true" 		imgfitstyle=2 		</FC>'
                     + '<FC>id=USE_YN           width=40   align=center     name="사용"      	EditStyle=checkbox 	</FC>' 
                     ;
    initGridStyle(GD_MAIN, "common", hdrProperies, true);  
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
     var goTo       = "selectBannerList" ;    
     var action     = "O";     

     TR_MAIN.Action="/pot/tcom404.tc?goTo="+goTo;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MAIN=DS_IO_MAIN)"; //조회는 O
     TR_MAIN.Post();
     
     // 조회결과 Return
     setPorcCount("SELECT", DS_IO_MAIN.CountRow);  
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
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    
    // 저장할 데이터 없는 경우 
    if (!DS_IO_MAIN.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
		GD_MAIN.Focus(); 
        return;
    }
    
    if(!checkValidation()) return;
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
    	GD_MAIN.Focus();
        return; 
    }
     
    TR_MAIN.Action  ="/pot/tcom404.tc?goTo=saveBanner"; 
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MAIN=DS_IO_MAIN)";
    TR_MAIN.Post();
 
    // 저장 후 처리
    if(TR_MAIN.ErrorCode == 0) btn_Search();  
    
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


/*************************************************************************
 * 3. 함수
 *************************************************************************/ 

 /**
  * checkValidation()
  * 작 성 자 : 
  * 작 성 일 : 2010-04-04
  * 개    요 : 입력 값을 검증한다.
  * return값 : void
  */
 function checkValidation(){
  
     for(var i=1; i<=DS_IO_MAIN.CountRow; i++)
     {
    	 var rowStatus = DS_IO_MAIN.RowStatus(i);
         if( !(rowStatus == "1" || rowStatus == "3") ) continue; 
    	   
         if( DS_IO_MAIN.NameValue(i,"BAN_NAME").trim() == ""  )
         {
             showMessage(EXCLAMATION, OK, "USER-1003", "배너명"); 
             setFocusGrid(GD_MAIN, DS_IO_MAIN, i, "BAN_NAME"); 
             return false;
         } 
		 
         if( !checkInputByte( GD_MAIN, DS_IO_MAIN, i, "BAN_NAME", "배너명", null,50)){ 
             return false;
         }

         if( DS_IO_MAIN.NameValue(i,"BAN_LINK").trim() == ""  )
         {
             showMessage(EXCLAMATION, OK, "USER-1003", "LINK 주소"); 
             setFocusGrid(GD_MAIN, DS_IO_MAIN, i, "BAN_LINK"); 
             return false;
         } 
         
         if( !checkInputByte( GD_MAIN, DS_IO_MAIN, i, "BAN_LINK", "LINK 주소", null, 200)){ 
             return false;
         } 
         
         if( DS_IO_MAIN.NameValue(i,"BAN_LINK").trim().substring(0,7).toLowerCase() != "http://" )
         {
             showMessage(EXCLAMATION, OK, "USER-1000", "[LINK 주소]는 http://로 시작해주세요."); 
             setFocusGrid(GD_MAIN, DS_IO_MAIN, i, "BAN_LINK"); 
             return false;
         } 

         if( DS_IO_MAIN.NameValue(i,"FILE_NM").trim() == ""  )
         {
             showMessage(EXCLAMATION, OK, "USER-1002", "이미지"); 
             setFocusGrid(GD_MAIN, DS_IO_MAIN, i, "FILE_NM"); 
             return false;
         } 
     }   
     return true;

 }
 
/**
 * openFile()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.05
 * 개    요 : 파일열기
 * return값 :
 */
function openFile(row) {
	INF_FILEUPLOAD.Open();
	
	if (INF_FILEUPLOAD.SelectState) 
	{
		var strFileInfo = INF_FILEUPLOAD.Value; //파일이름
	    var tmpFileName = strFileInfo.substring(strFileInfo.lastIndexOf("\\")+1);
	    var strFileName = tmpFileName.substring(0, tmpFileName.lastIndexOf("."));
        
	    var chrByre = checkLenByteStr(strFileName);
		var chrLen  = strFileName.length;
       	if (chrByre != chrLen) {    // 파일명 한글
           showMessage(STOPSIGN, OK, "USER-1000", "파일명은 영문,숫자만으로 작성해주세요");
           return;
       	} else if (chrByre > 75) {  // 파일명 22Byte이내작성
           showMessage(STOPSIGN, OK, "USER-1000", "파일명은 75Byte이내로 작성해주세요");
           return;
       } else {
           if((1024 * 1024 * 5) < INF_FILEUPLOAD.FileInfo("size")){
               showMessage(STOPSIGN, OK, "USER-1000", "업로드파일의 사이즈는 5M 를 넘을 수 없습니다.");

               DS_IO_MAIN.NameValue(row, "FILE_NM") 	= ""; // FILE명
               DS_IO_MAIN.NameValue(row, "FILE_PATH") 	= ""; // FILE경로
           } else { 
               DS_IO_MAIN.NameValue(row, "FILE_NM") 	= strFileInfo.substring(strFileInfo.lastIndexOf("\\")+1); // 경로명 표기  
               DS_IO_MAIN.NameValue(row, "FILE_PATH") 	= strFileInfo; // FILE경로
           }
       }
	} 
}

/**
 * checkLenByteStr()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.05
 * 개    요 : 문자열 Byte체크
 * return값 :
 */
function checkLenByteStr(str) {
    //byte체크
    var intByte = 0;
    for (k = 0; k < str.length; k++) {
        var onechar = str.charAt(k);
        if (escape(onechar).length > 4) {
            intByte += 2;
        } else {
            intByte++;
        }
    }
    return intByte;
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
<script language=JavaScript for=DS_IO_USER event=OnLoadCompleted(rowcnt)> 
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->    

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------> 
<script language=JavaScript for=GD_MAIN event=OnClick(row,colid)> 
	if (colid =="IMG") openFile(row);
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
<comment id="_NSID_"><object id="DS_IO_MAIN"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script> 

<comment id="_NSID_"><object id="IDS_IMAGE"     	classid=<%= Util.CLSID_IMGDATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_"><object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 3. Fileupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_FILEUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
    <param name="Text" 				value='FileOpen'>
    <param name="Enable" 			value="true">
    <param name="FileFilterString"  value=256>
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">
<iframe id=iFrame  name=iFrame src="about:blank" width=0 height=0 ></iframe>     
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td height=4></td></tr>
	<tr><td>
		<table cellpadding="0" border="0" cellspacing="0" class="BD4A"  width="100%">
		<tr><td>
         	<!-- 디테일 -->
            <comment id="_NSID_"><OBJECT id=GD_MAIN width=100% height="125" classid=<%=Util.CLSID_GRID%>>
                <param name=DataID   value="DS_IO_MAIN"> 
            </OBJECT></comment><script>_ws_(_NSID_);</script>
         </td></TR>
         </table>
	</td></tr>
	</table>
</DIV>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

