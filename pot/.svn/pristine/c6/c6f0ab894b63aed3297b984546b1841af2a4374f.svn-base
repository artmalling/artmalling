<!-- 
/*******************************************************************************
 * 시스템명 : 시스템관리 > 게시물관리 > 공지사항관리> 공지사항관리
 * 작 성 일 : 2010.06.09
 * 작 성 자 : 김호선
 * 수 정 자 : 
 * 파 일 명 : tcom2010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 공지사항을 관리한다.
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
var strGbn         = dialogArguments[0];
var strNotiID      = dialogArguments[1];  
var opener         = dialogArguments[2]; 
var strToday       = "";               
var strNewFlag; 
var g_openPage = true; //파일다운로드에 사용 할 변수
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    // Output Data Set Header 초기화
    DS_IO_NOTICE.setDataHeader('<gauce:dataset name="H_NOTICE"/>');
    DS_IO_DEPT_CD.setDataHeader('<gauce:dataset name="H_NOTICE_DEPT"/>');
    DS_O_NOTI_ID.setDataHeader('<gauce:dataset name="H_NOTI_ID"/>');

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    //registerUsingDataset("tcom201","DS_IO_NOTICE,DS_IO_DEPT_CD" );
    
	// 일자셋팅
	strToday = getTodayDB("DS_O_RESULT");
	    
    //그리드 초기화
    gridCreate();  
    
    // EMedit에 초기화 (조회용)
    initEmEdit(EM_S_DATE    , "SYYYYMMDD"   , PK);          // 조회기간1
    initEmEdit(EM_E_DATE    , "TODAY"       , PK);          // 조회기간2
    initEmEdit(EM_P_TITLE   , "GEN^500"     , PK);      	// 제목
    initEmEdit(EM_P_NAME    , "GEN^100"     , READ);        // 작성자 
    initEmEdit(EM_TEL1      , "CODE^3^0" 	, NORMAL);      // 전화번호 
    initEmEdit(EM_TEL2      , "CODE^4^0" 	, NORMAL);      // 전화번호 
    initEmEdit(EM_TEL3      , "CODE^4^0" 	, NORMAL);      // 전화번호 
	initEmEdit(EM_FILE_NM	, "GEN"			, READ);		// 첨부파일
    initTxtAreaEdit(TEXT_CONTENT, PK);               		// 내용

    initComboStyle(LC_O_NOTI_FLAG, DS_O_NOTI_FLAG,  "CODE^0^30,NAME^0^80",  1, PK);     //게시분류

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_NOTI_FLAG", "D", "TC05", "N");
    
    if(strGbn == "NEW") {	//신규
    	btn_New();	//신규 등록 하기 위해 필요
    } else {
    	btn_Search();
    }
}

function gridCreate(){

    var hdrProperies =  '<FC>id=STR_CD       show=false  name="점코드"      </FC>'
                      + '<FC>id=DEPT_CD      show=false  name="팀코드"    </FC>'
                      + '<FC>id=CHK          width=60    name="선택"        editstyle=checkbox  </FC>'
                      + '<FC>id=STR_NAME     width=150   name="점"          edit=none </FC>' 	
                      + '<FC>id=DEPT_NAME    width=232   name="팀"        edit=none </FC>'   ;
                      
    initGridStyle(GD_DEPT, "common", hdrProperies, true );  
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
	 
     var goTo       = "selectNotice" ;    
     var action     = "O";       
     var parameters = "&strNoti="+encodeURIComponent(strNotiID);
      
     TR_MAIN.Action="/pot/tcom201.tc?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DEPT_CD = DS_IO_DEPT_CD,"
                                +action+":DS_IO_NOTICE  = DS_IO_NOTICE)"; //조회는 O
     TR_MAIN.Post();
     EM_P_TITLE.Focus();
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
	 //기존의 신규로우 존재 시 초기화
    if( DS_IO_NOTICE.IsUpdated || DS_IO_DEPT_CD.IsUpdated ) 
    {
        if( showMessage(QUESTION, YESNO, "USER-1051") != 1 ){ 
            GD_DEPT.Focus();
            return;
        } 
    }
    DS_IO_NOTICE.ClearData();
    DS_IO_DEPT_CD.ClearData();
     
    DS_IO_NOTICE.Addrow();
    DS_IO_NOTICE.NameValue(1, "SEND_TO_ALL") = "Y";
    DS_IO_NOTICE.NameValue(1, "S_DATE")      = strToday; 
    EM_P_NAME.Text = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />'; 

    EM_TEL1.Text = '<%=Util.getTelNo1(request)%>'; 
    EM_TEL2.Text = '<%=Util.getTelNo2(request)%>'; 
    EM_TEL3.Text = '<%=Util.getTelNo3(request)%>';  

    /*
	Wec.TextValue = ""; 
	Wec.HeadValue = ""; 
	Wec.ActiveTab = 0;  
    */
    
    // 공지구분     
    RD_NOTI_GUBUN.CodeValue = "Y";     
    checkDiv("Y"); 
    LC_O_NOTI_FLAG.Focus();
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {

	var strNoti =  DS_IO_NOTICE.NameValue(DS_IO_NOTICE.CountRow, "NOTI_ID");  
	
	// 삭제할 데이터 없는 경우
    if ( strNoti == "" || DS_IO_NOTICE.CountRow < 1){
        //삭제할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1019");
        EM_P_TITLE.Focus();
        return;
    }
    
    // 상세에 변경내역있을  경우 
    if( DS_IO_DEPT_CD.IsUpdated){
        showMessage(INFORMATION , OK, "USER-1091");
        GD_DEPT.Focus();
        return;
    }
    
    //선택한 항목을 삭제하겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
    	EM_P_TITLE.Focus();
        return; 
    } 

    var goTo       = "delNoti";  
    var parameters = "&strNoti ="+encodeURIComponent(strNoti);  
    
    DS_IO_NOTICE.DeleteMarked();
    TR_MAIN.Action="/pot/tcom201.tc?goTo="+goTo+parameters;   
    TR_MAIN.KeyValue="SERVLET(  I:DS_IO_NOTICE   = DS_IO_NOTICE)";   
    TR_MAIN.Post(); 
    
	opener.btn_Search();
    this.close();
    // btn_New();
     
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    // 저장할 데이터 없는 경우  
    //Wec.DefaultCharSet = "utf-8"; 
    
    DS_IO_NOTICE.NameValue(DS_IO_NOTICE.RowPosition, "NOTI_CONTENT") = TEXT_CONTENT.Text;
    
    if (!DS_IO_NOTICE.IsUpdated && !DS_IO_DEPT_CD.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028"); 
        return;
    }
    
    DS_IO_NOTICE.NameValue(DS_IO_NOTICE.RowPosition,"URL")   = "TEXT_CONTENT"; 
    
	if(!valueCheck()) return;   
    var strNoti = DS_IO_NOTICE.NameValue(DS_IO_NOTICE.CountRow, "NOTI_ID");

	// 팀공지를 전체공지로 수정하는 경우 alert
    if (RD_NOTI_GUBUN.CodeValue =="Y" && DS_IO_DEPT_CD.CountRow > 0 && strNoti !="")
    {
	    if( showMessage(QUESTION, YESNO, "USER-1000","팀공지 데이터가 존재합니다. 전체공지로 변경하시겠습니까") != 1 ) 
	        return; 
    }
    else if( showMessage(QUESTION, YESNO, "USER-1010") != 1 )
    {
         EM_S_DATE.Focus();
         return;
    }
  
     // DELETE -> INSERT 
     for(var i=1; i<DS_IO_DEPT_CD.CountRow+1; i++)
     {
    	 DS_IO_DEPT_CD.UserStatus(i) = 1;
     }
     
     // 공지 구분에 따라 체크/언체크드
     if (RD_NOTI_GUBUN.CodeValue =="Y" && DS_IO_DEPT_CD.CountRow > 0)
     { 
         for(var i=1; i<DS_IO_DEPT_CD.CountRow+1; i++)
         {
             DS_IO_DEPT_CD.NameValue(i, "CHK") = "F";
         } 
     }
     
     var strAddFileYn ="N"; 
     if(DS_IO_NOTICE.NameValue(DS_IO_NOTICE.rowposition, "FILE_PATH")  != "") strAddFileYn ="Y";
     
     var goTo       = "saveNoti";            
     var parameters = "&strNoti =" + encodeURIComponent(strNoti)
     				+ "&strAddFileYn="+ encodeURIComponent(strAddFileYn)  ;  
     
     TR_MAIN.Action="/pot/tcom201.tc?goTo="+goTo+parameters;   
     TR_MAIN.KeyValue="SERVLET(  I:DS_IO_NOTICE   = DS_IO_NOTICE"
    		                + " ,I:DS_IO_DEPT_CD  = DS_IO_DEPT_CD"
    		                + " ,O:DS_O_NOTI_ID   = DS_O_NOTI_ID)";   
     TR_MAIN.Post();
     
     // 저장 후 재조회
     if(DS_O_NOTI_ID.CountRow>0)
     { 
    	 showMessage(INFORMATION, OK, "USER-1000", "처리하였습니다.");
    	 opener.btn_Search();
    	 this.close();
    	 // btn_Search(DS_O_NOTI_ID.NameValue(1,"NOTI_ID")); 
     }
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
	if(strGbn!="READ") opener.btn_Search();
	this.close();
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/  
 /**
  * btn_Add()
  * 작 성 자 : 
  * 작 성 일 : 2010-09-08
  * 개    요 : 사용자 그리드 Row추가 
  * return값 : void
*/
function btn_Add(){  
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

    if (LC_O_NOTI_FLAG.Text == "" ) 
    {
        showMessage(STOPSIGN, OK, "USER-1002", "게시분류");
        LC_O_NOTI_FLAG.focus();
        return false;
    }
    
    if (EM_S_DATE.text == "" || EM_S_DATE.text.length < 8) 
    {
        showMessage(STOPSIGN, OK, "USER-1003", "게시시작일");
        EM_S_DATE.focus();
        return false;
    }
    
    if (EM_E_DATE.text == "" || EM_E_DATE.text.length < 8 ) 
    {
        showMessage(STOPSIGN, OK, "USER-1003", "게시종료일");
        EM_E_DATE.focus();
        return false;
    }
    
    if(EM_S_DATE.Text > EM_E_DATE.Text){                              // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_S_DATE.Focus();
        return false;
    }
    
    if ( (EM_P_TITLE.text).trim() == ""  ) {
        showMessage(STOPSIGN, OK, "USER-1003", "제목");
        EM_P_TITLE.focus();
        return false;
    }
    if ( getByteValLength(EM_P_TITLE.Text) > 500) {
        showMessage(STOPSIGN, OK, "USER-1000", "제목은 최대 500byte입니다.");
        EM_P_TITLE.focus();
        return false;
    } 
   
    if ( (TEXT_CONTENT.Text).trim() == ""  ) {
        showMessage(STOPSIGN, OK, "USER-1003", "내용");
        TEXT_CONTENT.focus();
        return false;
    }
    /*
    var cWec = trim(Wec.TextValue.replace("\u000D", "")).length + Wec.GetFileNum(0);
    
    if(cWec == 0 ){
        showMessage(STOPSIGN, OK, "USER-1003",  "내용");
        //TEXT_CONTENT.Focus();
        return;
    }
    TEXT_CONTENT.Text = Wec.MimeValue;
    */
    
    // 팀공지인데 팀이 없을 경우 에러
    if (RD_NOTI_GUBUN.CodeValue =="N")
    { 
    	var intCnt = 0;
    	for(var i=1; i<=DS_IO_DEPT_CD.CountRow; i++)
    	{
    		if(DS_IO_DEPT_CD.NameValue(i,"CHK")=="T") intCnt +=1;
    			
    	}
    	if (intCnt == 0 ) {
            showMessage(STOPSIGN, OK, "USER-1000", "팀공지인 경우 적어도 하나의 팀은 선택하여야 합니다."); 
            return false;
        }
    		
    }
    return true;
}
/**
 * getNotiDept()
 * 작 성 자 : 
 * 작 성 일 : 2010.06.13
 * 개     요 : 조직구분 선택하기(점,팀까지)
 * return값 : void
 */
function getNotiDept() 
{  
    var returnVal =  window.showModalDialog("/pot/tcom201.tc?goTo=orgPop"
               , window.self
               , "dialogWidth:600px;dialogHeight:500px;scroll:no;" +
                 "resizable:no;help:no;unadorned:yes;center:yes;status:no");  
}
/**
 * onCheckLength()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  공지내용 입력 길이 저장
 * return값 : void
 */
function onCheckLength(){  
	 document.all.spanByte.innerHTML ="<br>" +  getByteValLength(TXT_NOTI_CONTENT.Text) + " Byte";
	 
	if (getByteValLength(TXT_NOTI_CONTENT.Text) > 4000 ) 
	{  
	    showMessage(STOPSIGN, OK, "USER-1000", "내용은 최대 4000byte만 가능합니다.");  
	    TXT_NOTI_CONTENT.Text = cutByte(4000); 
		document.all.spanByte.innerHTML ="<br><br>" + getByteValLength(TXT_NOTI_CONTENT.Text) + " Byte";
	}
}

function cutByte(len)
{
	var str = TXT_NOTI_CONTENT.Text;
	var l = 0;
	for (var i =0; i<str.length; i++)
	{
		l += (str.charCodeAt(i)>128)? 2:1;
		if(l>len) return str.substring(0,i);
	}
	return str;
}

/**
 * checkDiv()
 * 작 성 자 : Hseon
 * 작 성 일 : 2011.02.21
 * 개    요 : div활성화/비활성화
 * return값 : void
 */  
function checkDiv(val)
{ 
	if (val == "Y") 
	    document.getElementById("divDept").style.visibility = "hidden";  
	else
	    document.getElementById("divDept").style.visibility = "visible";
}	


/**
 * openFile()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010.02.21
 * 개    요 : 첨부파일선택
 * return값 : void
 */  
function openFile() {
    INF_UPLOAD.Open();
    
    if (INF_UPLOAD.SelectState) 
	{
		var strFileInfo = INF_UPLOAD.Value; //파일이름
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
           if((1024 * 1024 * 20) < INF_UPLOAD.FileInfo("size")){
               showMessage(STOPSIGN, OK, "USER-1000", "업로드파일의 사이즈는 20M 를 넘을 수 없습니다.");

               DS_IO_NOTICE.NameValue(DS_IO_NOTICE.RowPosition, "FILE_NM") 		= ""; // FILE명
               DS_IO_NOTICE.NameValue(DS_IO_NOTICE.RowPosition, "FILE_PATH") 	= ""; // FILE경로
           } else { 
        	   DS_IO_NOTICE.NameValue(DS_IO_NOTICE.RowPosition, "FILE_NM") 		= strFileInfo.substring(strFileInfo.lastIndexOf("\\")+1); // 경로명 표기  
        	   DS_IO_NOTICE.NameValue(DS_IO_NOTICE.RowPosition, "FILE_PATH") 	= strFileInfo; // FILE경로
           }
       }
	}  
}


/**
 * saveAsFiles()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.01
 * 개    요 : 값체크(저장)
 * return값 :
 */
function downFile() {
        
       var strPath   = "notice/";    
       var strFileNm = DS_IO_NOTICE.NameValue(DS_IO_NOTICE.Rowposition, "FILE_NM");       
       if( strPath != null  ) {                          
           iFrame.location.href="/pot/jsp/fileDownload.jsp?strPath="+strPath+"&strFileNm="+strFileNm;
	   }   
 }
 

 /**
  * checkLenByteStr()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.03.05
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
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<script language=JavaScript for=DS_IO_GROUP event=OnLoadCompleted(rowcnt)>
    if(rowcnt > 0) {
        DS_IO_GROUP.RowPosition = bfGroupRowPosition;
    }
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  -------------------------------> 
<script language=JavaScript for=DS_IO_NOTICE event=OnLoadCompleted(rowcnt)>

    checkDiv(this.NameValue(rowcnt,"SEND_TO_ALL"));
    
	var notiContent = DS_IO_NOTICE.NameValue(0, "NOTI_CONTENT");  
	
	//데이터 내용 가져올 방법 연구해야 함
	if(notiContent == "") {
		notiContent = "내용이 존재하지 않습니다.";
	}
	
	TEXT_CONTENT.Text = notiContent;
	
	
 
	/*
	Wec.ActiveTab = 0;
	if(TEXT_CONTENT.Text == "")
	{
	   	// 메뉴단위인 경우 데이터celar
		Wec.TextValue = ""; 
		Wec.HeadValue = ""; 
	}
	else 
	   Wec.Value = TEXT_CONTENT.Text;
	*/
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
 <script language=JavaScript for=TXT_NOTI_CONTENT event=OnChange()>
	document.all.spanByte.innerHTML ="<br><br>" + getByteValLength(TXT_NOTI_CONTENT.Text) + " Byte";
</script>
 
<!-- Grid GROUP 상하키 event 처리 -->
<script language=JavaScript for=GD_MAIN event=onKeyPress(keycode)>  
    if ((keycode == 38) || (keycode == 40) 
        || (keycode == 255 && GD_MAIN.GetColumn() =="GROUP_NAME" && DS_IO_GROUP.NameValue(DS_IO_GROUP.RowPosition, "GROUP_NAME") != "" )		
    )
    { 
        if (DS_IO_GROUP.RowPosition > 0 ){
            bfGroupRowPosition = DS_IO_GROUP.RowPosition;
            showUserList(DS_IO_GROUP.NameValue(DS_IO_GROUP.RowPosition, "GROUP_CD"));
        }
    }
</script>
 
<!-- 공지선택 시 div 처리  -->
<script language=JavaScript for=RD_NOTI_GUBUN event=OnSelChange()>   
    checkDiv(RD_NOTI_GUBUN.CodeValue); 
</script>
  
<script language="JavaScript" FOR="Wec" EVENT="OnInitCompleted()"> 
	// 구분이 수정인 경우 리스트 조회
	if(strGbn=="NEW")  btn_New(); 
	else btn_Search(strNotiID);
	
	/*
	Wec.DefaultCharSet = "utf-8"; 

	Wec.SetDefaultFont("맑은 고딕");
	Wec.SetDefaultFontSize("10");
	*/
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
<comment id="_NSID_"><object id="DS_O_RESULT" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_NOTI_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_O_STR_CD" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DEPT_CD" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 본문 -->
<comment id="_NSID_"><object id="DS_IO_ORG_CD" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_NOTICE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_NOTI_ID" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
 
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_"><object id="TR_MAIN"  classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();">
<iframe id=iFrame  name=iFrame src="about:blank" width=0 height=0 ></iframe>   
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
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="" class="title">
              <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
              <span id="title1" class="PL03">공지사항</span>
            </td>
            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/<%=dir%>/imgs/btn/new.gif"   id=IMG_BTN_NEW width="50" height="22"  onClick="btn_New();"/></td>
                <td><img src="/<%=dir%>/imgs/btn/save.gif"  id=IMG_BTN_SAVE width="50" height="22"  onClick="btn_Save();"/></td>
                <td><img src="/<%=dir%>/imgs/btn/del.gif"   id=IMG_BTN_DEL width="50" height="22"  onClick="btn_Delete()"/></td>
                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"  onClick="btn_Close();"/></td>
                
                </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="PT01 PB03">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
            <tr><td>
	            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table"> 
	            <tr> 
		            <th class="point" width="80">구분</th>
		            <td colspan="3"> 
		              <comment id="_NSID_"> 
		                <object id="RD_NOTI_GUBUN" classid="<%=Util.CLSID_RADIO%>" width=160 height=18 align="absmiddle" tabindex=1>
		                  <param name="Cols" value="2">
		                  <param name="Format" value="Y^전체,N^팀">
		                </object> 
		              </comment><script>_ws_(_NSID_);</script>    
		            </td>
	            </tr> 
	            
	            <tr> 
                    <th>팀</th>
                    <td colspan="3"> 
                        <div id = "divDept"  style="visibility:hidden;display:" >  
		                   <table  border="0" cellspacing="0" cellpadding="0" width="100%" class="o_table"> 
		                   <tr>
		                         <td valign="top"> 
		                          <!-- 팀 -->    
		                          <comment id="_NSID_">
		                          <OBJECT id=GD_DEPT width="480" height="67" classid=<%=Util.CLSID_GRID%>>
		                              <param name="DataID" value="DS_IO_DEPT_CD">
		                          </OBJECT></comment><script>_ws_(_NSID_);</script> 
		                          </td>
		                          <td valign=top>
		                          	<img src="./imgs/btn/btn_rowAdd.gif" id=IMG_BTN_ADD style="cursor:hand" align=center onclick="getNotiDept()" > 
                                 </td>
		                    </tr> 
		                    </table>
		                </div> 
                    </td>
                </tr> 
                <tr>
                 <th width="80" class="point">게시분류</th>
                 <td width=130 > 
                 	<comment id="_NSID_"> 
                 		<object id=LC_O_NOTI_FLAG classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=130 align="absmiddle" tabindex=1> </object> 
                 	</comment><script>_ws_(_NSID_);</script>
                 </td>
                 <th width="80" class="point">게시기간</th>
                 <td>
                   <comment id="_NSID_"> 
                       <object id=EM_S_DATE classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=2 align="absmiddle" tabindex=2> </object> 
                   </comment><script> _ws_(_NSID_);</script>
                   <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_S_START_DT onclick="javascript:openCal('G',EM_S_DATE)" align="absmiddle" />
                   ~ 
                   <comment id="_NSID_"> 
                       <object id=EM_E_DATE classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=3 align="absmiddle" tabindex=3> </object> 
                   </comment><script> _ws_(_NSID_);</script> 
                   <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_S_END_DT onclick="javascript:openCal('G',EM_E_DATE)" align="absmiddle" />
                  </td>
              </tr>  
              <tr>
                <th width="80">작성자</th>
                <td width="130">
                   <comment id="_NSID_">
                       <object id=EM_P_NAME width="130" align="absmiddle"  classid="<%=Util.CLSID_EMEDIT%>"></object>
                   </comment><script> _ws_(_NSID_);</script>
                 </td> 
                 <th width="80">전화번호</th>
                 <td>
                    <comment id="_NSID_"><object id=EM_TEL1 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=4 > </object> </comment> <script> _ws_(_NSID_);</script>
                    -
                    <comment id="_NSID_"><object id=EM_TEL2 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=5 > </object> </comment> <script> _ws_(_NSID_);</script>
                    - 
                    <comment id="_NSID_"><object id=EM_TEL3 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=6 > </object> </comment> <script> _ws_(_NSID_);</script>
                 </td>
               </tr>
               <tr>
                    <th width="80" class="point">제목</th>
                    <td colspan =3> 
                         <comment id="_NSID_">
                             <object id=EM_P_TITLE width="560" align="absmiddle"  classid="<%=Util.CLSID_EMEDIT%>" tabindex=7>
                             </object>
                         </comment><script> _ws_(_NSID_);</script>
                     </td> 
                </tr>  
                <tr>
                   <th width="80" class="point">내용
                      <span id = "spanByte"></span>
                   </th>
					<td colspan="3">
						<!-- table width="100%" height="450" cellpadding=0 cellspacing=0>
							<tr><td>
		     					<script language="javascript" src="/pot/jsp/namo/NamoWec7.js"></script>
		     				</td></tr>
						</table-->
						<comment id="_NSID_"> 
						    <object id=TEXT_CONTENT classid=<%=Util.CLSID_TEXTAREA%> width="100%" height="450" align="absmiddle">
						        <param name=Enable         value="true">
						        <param name=ReadOnly       value="false">
						        <param name="CacheLoad"    value="true">
						        <param name=ApplyRTF       value="true">
						        <param name=ApplyUTF8      value="true">
						    </object>
						</comment>
						<script> _ws_(_NSID_);</script>
            		</td>
                </tr>  
                <tr>
                	<th width="80">첨부파일</th>
                    <td colspan =3> 
                       <comment id="_NSID_">
                         <object id=EM_FILE_NM classid=<%=Util.CLSID_EMEDIT%> height=20 width=430 ></object>
                       </comment><script>_ws_(_NSID_);</script>
                       <img src="/<%=dir%>/imgs/btn/file_search.gif" onclick="openFile();" align="absmiddle"  id="IMG_FILE_OPEN"/>
                       <img src="/<%=dir%>/imgs/btn/file_down.gif"   onclick="downFile();" align="absmiddle"  id="IMG_FILE_DOWN" />
                    </td>
                </tr>
            </table>
          </td></tr>
        </table></td>
      </tr>
    </table></td>
     <td class="pop06" ></td>
  </tr>
  <tr>
     <td class="pop07" ></td>
     <td class="pop08" ></td>
     <td class="pop09" ></td>
  </tr>
</table> 

<div id="divContent" style="width:0px;height:0px;"></div>

<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
    <object id=BD_HEADER classid=<%= Util.CLSID_BIND %>>
        <param name=DataID value=DS_IO_NOTICE>
        <param name="ActiveBind" value=true>
        <param name=BindInfo
            value='            
                <c>col=SEND_TO_ALL  ctrl=RD_NOTI_GUBUN          param=CodeValue </c>
                <c>col=NOTI_FLAG    ctrl=LC_O_NOTI_FLAG         param=BindColVal</c>
                <c>col=NOTI_TITLE   ctrl=EM_P_TITLE             param=Text </c>     
                <c>col=S_DATE       ctrl=EM_S_DATE              param=Text </c>            
                <c>col=E_DATE       ctrl=EM_E_DATE              param=Text </c>        
                <c>col=FILE_NM      ctrl=EM_FILE_NM             param=Text </c>            
                <c>col=USER_NAME    ctrl=EM_P_NAME              param=Text </c> 
                <c>col=TEL1         ctrl=EM_TEL1                param=Text </c>          
                <c>col=TEL2         ctrl=EM_TEL2                param=Text </c>        
                <c>col=TEL3         ctrl=EM_TEL3                param=Text </c> 
        '>
        <!-- <c>col=URL_CONTENT  ctrl=TEXT_CONTENT           Param=Text</c> 제거 sbcho -->
    </object> 
</comment>
<script>_ws_(_NSID_);</script>
 
<comment id="_NSID_">
    <object id="INF_UPLOAD" classid=<%=Util.CLSID_INPUTFILE%> width="0" height="0"> 
	    <param name="Text"     value='FileOpen'>
	    <param name="Enable"   value="true">
    </object> 
</comment><script> _ws_(_NSID_);</script>
</body>
</html>

