<!-- 
/*******************************************************************************
 * 시스템명 : 
 * 작 성 일 : 2010.06.09
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : 
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
var strStrCd       = dialogArguments[0];
var strSlipNo      = dialogArguments[1];  
var opener         = dialogArguments[2]; 
var strSlipProcStat  = dialogArguments[3]; 
var strToday       = "";               
var strNewFlag; 
var g_openPage = true; //파일다운로드에 사용 할 변수
var strSearchFlag = "0";
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
	
	 DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
	 DS_IO_DTL_FILE.setDataHeader('<gauce:dataset name="H_FILE"/>');
	 strSearchFlag = "0";
	 gridCreate1();
	 gridCreate2();
	 
	 if(dialogArguments[3] == "09") {
		 enableControl(IMG_BTN_NEW,false);
		 enableControl(IMG_BTN_SAVE,false);
		 enableControl(IMG_BTN_DEL,false);
	 } else {
		 enableControl(IMG_BTN_NEW,true);
		 enableControl(IMG_BTN_SAVE,true);
		 enableControl(IMG_BTN_DEL,true);
	 }
	 btn_Search();
	 
}

function gridCreate1(){
	
	 var hdrProperies = '<FC>id={currow}          name="NO"           width=30    align=center sumtext=""</FC>'
		 + '<FC>id=STR_CD            name="점"           width=130    align=left edit=none show=false </FC>'
		 + '<FC>id=ORG_SEQ_NO            name="점"           width=130    align=left edit=none show=false </FC>'
		+ '<FC>id=STR_NM            name="점"           width=130    align=left edit=none </FC>'                 
			         + '<FC>id=SLIP_NO            name="전표번호"     width=90    align=center edit=none Mask="XXXX-XXXXXXX" </FC>'
			         + '<FC>id=SKU_CD            name="단품코드"    width=110    align=center edit=none </FC>'                           
			         + '<FC>id=SKU_NM            name="단품명"       width=140    align=left edit=none </FC>'                           
			         + '<FC>id=ORD_UNIT_NM       name="단위"         width=45    align=center edit=none </FC>'                           
			         + '<FC>id=ORD_QTY           name="수량"        width=45    align=center edit=none </FC>'                           
			         + '<FG> name="원가 (부가세 제외)"'                                       
			         + '<FC>id=NEW_COST_PRC      name="단가"        width=70    align=right edit=none </FC>'                        
			         + '<FC>id=NEW_COST_AMT      name="금액"         width=70    align=right edit=none </FC>'                        
			         + '</FG> '
			         + '<FG> name="매가 (부가세 포함)"'                                       
			         + '<FC>id=NEW_SALE_PRC      name="단가"        width=70    align=right edit=none </FC>'                        
			         + '<FC>id=NEW_SALE_AMT      name="금액"         width=70    align=right edit=none </FC>'                        
			         + '</FG> '
			         + '<FC>id=NEW_GAP_RATE      name="차익율"       width=80    align=right  Edit=none  </FC>'
			         ;     
	     initGridStyle(GR_MASTER, "common", hdrProperies, true);
	 
   
} 

function gridCreate2(){
	
	var hdrProperies = '<FC>id={currow}          name="NO"           width=30    align=center edit=none </FC>'
			        + '<FC>id=STR_CD            name="점"           width=70    align=center edit=none show=false </FC>'                 
			        + '<FC>id=SLIP_NO            name="전표번호"     width=70    align=center edit=none show=false </FC>'
			        + '<FC>id=ORD_SEQ_NO       name="순번"         width=70    align=center edit=none show=false </FC>'                           
			        + '<FC>id=FILE_NAME           name="첨부파일명"        width=200    align=left edit=none </FC>'                           
			        + '<FC>id=O_FILE_NAME           name="원본파일명"        width=180    align=left edit=none </FC>'
			        + '<FC>id=FILE_COMMENT           name="파일설명"        width=200    align=left  edit={IF(REG_ID="","true","false")} </FC>'
			        + '<FC>id=FILE_PATH           name="파일경로"        width=200    align=left  show=false</FC>'
			        + '<FC>id=REG_ID           name="등록자"        width=85    align=center edit=none </FC>'
			        + '<FC>id=REG_DATE           name="등록일시"        width=150    align=center edit=none </FC>'
			        ;   
    initGridStyle(GR_FILE, "common", hdrProperies, true);


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
	 
	var strStrCd    = dialogArguments[0]; 
	var strSlipNo   = dialogArguments[1];
	
	
   var goTo       = "searchMaster";    
   var action     = "O";     
   var parameters =  "&strStrCd=" +encodeURIComponent(strStrCd)     
                   + "&strSlipNo="+encodeURIComponent(strSlipNo);
   
   TR_MAIN.Action  = "/dps/pord001.po?goTo="+goTo+parameters;  
   TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; 
   TR_MAIN.Post();
	
   if(DS_O_MASTER.CountRow > 0 ) {
	   fn_FileList();
	   strSearchFlag = "1";
   }
   
   //fn_FileList();
   
}
/**
 * fn_FileList()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-02-24
 * 개    요 : 파일리스트 조회
 * return값 : void
 */
function fn_FileList(){
	
	var row = DS_O_MASTER.RowPosition;
	var strStrCd    = DS_O_MASTER.NameValue(row,"STR_CD");
	var strSlipNo   = DS_O_MASTER.NameValue(row,"SLIP_NO");
	var strOrdSeqNo   = DS_O_MASTER.NameValue(row,"ORD_SEQ_NO");
	
   var goTo       = "searchFile";    
   var action     = "O";     
   var parameters =  "&strStrCd="	+encodeURIComponent(strStrCd)     
                   + "&strSlipNo="	+encodeURIComponent(strSlipNo)
                   + "&strOrdSeqNo="+encodeURIComponent(strOrdSeqNo)
                   ;
   
   TR_MAIN1.Action  = "/dps/pord001.po?goTo="+goTo+parameters;  
   TR_MAIN1.KeyValue= "SERVLET("+action+":DS_IO_DTL_FILE=DS_IO_DTL_FILE)"; 
   TR_MAIN1.Post();
	
   
}
/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
	DS_IO_DTL_FILE.Addrow();
	var rowM = DS_O_MASTER.RowPosition;
	var rowD = DS_IO_DTL_FILE.RowPosition;
	
	var strFileTemp = DS_O_MASTER.NameValue(rowM,"STR_CD")
	                 +DS_O_MASTER.NameValue(rowM,"SLIP_NO")
	                 +numFormat(DS_O_MASTER.NameValue(rowM,"ORD_SEQ_NO"),3);
	
	DS_IO_DTL_FILE.NameValue(rowD, "STR_CD") = DS_O_MASTER.NameValue(rowM,"STR_CD");
	DS_IO_DTL_FILE.NameValue(rowD, "SLIP_NO") = DS_O_MASTER.NameValue(rowM,"SLIP_NO");
	DS_IO_DTL_FILE.NameValue(rowD, "ORD_SEQ_NO") = DS_O_MASTER.NameValue(rowM,"ORD_SEQ_NO");
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
           DS_IO_DTL_FILE.Deleterow(rowD);
           return;
       	} else if (chrByre > 75) {  // 파일명 22Byte이내작성
           showMessage(STOPSIGN, OK, "USER-1000", "파일명은 75Byte이내로 작성해주세요");
           DS_IO_DTL_FILE.Deleterow(rowD);
           return;
       } else {
           if((1024 * 1024 * 20) < INF_UPLOAD.FileInfo("size")){
               showMessage(STOPSIGN, OK, "USER-1000", "업로드파일의 사이즈는 20M 를 넘을 수 없습니다.");

               //DS_IO_DTL_FILE.NameValue(DS_IO_DTL_FILE.RowPosition, "O_FILE_NAME") 		= ""; // FILE명
               DS_IO_DTL_FILE.Deleterow(rowD);
             
           } else {
        	   
        	   var checkFlag = 0;
        	   for(var i=1;i<=DS_IO_DTL_FILE.CountRow;i++)
        	   {
        		   
        		   	if(DS_IO_DTL_FILE.NameValue(i, "O_FILE_NAME") == strFileInfo.substring(strFileInfo.lastIndexOf("\\")+1)){
        		   		showMessage(STOPSIGN, OK, "USER-1000", "중복된 파일이 존재 합니다.");
        				checkFlag += 1;
        		   	}  
        	   }
        	   
        	   if(checkFlag > 0) {
        		   DS_IO_DTL_FILE.Deleterow(rowD); 
        	   } else {
	        	   DS_IO_DTL_FILE.NameValue(DS_IO_DTL_FILE.RowPosition, "O_FILE_NAME") 		= strFileInfo.substring(strFileInfo.lastIndexOf("\\")+1); // 경로명 표기  
	        	   DS_IO_DTL_FILE.NameValue(DS_IO_DTL_FILE.RowPosition, "FILE_NAME") 		= strFileTemp+strFileInfo.substring(strFileInfo.lastIndexOf("\\")+1); // 경로명 표기  
	        	   DS_IO_DTL_FILE.NameValue(DS_IO_DTL_FILE.RowPosition, "FILE_PATH") 		= strFileInfo; // 경로명 표기
        	   }
           }
       }
	} else {
		DS_IO_DTL_FILE.Deleterow(rowD);
	} 
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {

	if(DS_IO_DTL_FILE.CountRow == 0){
		showMessage(EXCLAMATION, OK, "USER-1019");
        return;
	}
    
	var row = DS_IO_DTL_FILE.RowPosition;
	if (DS_IO_DTL_FILE.RowStatus(row) == "1") //신규입력만 삭제 가능 0:조회, 1:신규, 3:수정
	{
		DS_IO_DTL_FILE.DeleteRow(row);
		
	} else {
		
		DS_IO_DTL_FILE.DeleteRow(row);
		
		var strStrCd    = DS_IO_DTL_FILE.NameValue(row,"STR_CD"); 
		var strSlipNo   = DS_IO_DTL_FILE.NameValue(row,"SLIP_NO");
		var strOrdSeqNo   = DS_IO_DTL_FILE.NameValue(row,"ORD_SEQ_NO");
		var strFileName   = DS_IO_DTL_FILE.NameValue(row,"FILE_NAME");
		
		
	   	var goTo       = "deleteFile";    
	   	var action     = "I";     
	   	var parameters =  "&strStrCd="	+encodeURIComponent(strStrCd)     
	                   + "&strSlipNo="	+encodeURIComponent(strSlipNo)
	                   + "&strOrdSeqNo="+encodeURIComponent(strOrdSeqNo)
	                   + "&strFileName="+encodeURIComponent(strFileName)
	                   ;
	   
	   	TR_MAIN1.Action  = "/dps/pord001.po?goTo="+goTo+parameters;  
	   	TR_MAIN1.KeyValue= "SERVLET("+action+":DS_IO_DTL_FILE=DS_IO_DTL_FILE)"; 
	   	TR_MAIN1.Post();
	   	
	}
	
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
    if (!DS_IO_DTL_FILE.IsUpdated){
       //저장할 내용이 없습니다
       showMessage(EXCLAMATION, OK, "USER-1028");
       return;
    }
	
    var goTo       = "saveFile";    
   	var action     = "I";     
   
   	TR_MAIN1.Action  = "/dps/pord001.po?goTo="+goTo;  
   	TR_MAIN1.KeyValue= "SERVLET("+action+":DS_IO_DTL_FILE=DS_IO_DTL_FILE)"; 
   	TR_MAIN1.Post();
   	
   	fn_FileList();
}


function btn_Close(){
	dialogArguments[2].getDetail();
	this.close();

}

/**
 * downFile()
 * 작 성 자 : 엄준석
 * 작 성 일 : 2010-09-08
 * 개    요 : 파일다운
 * return값 : void
*/
function downFile() {
        
       var strPath   = "slipfile/";    
       var strFileNm = DS_IO_DTL_FILE.NameValue(DS_IO_DTL_FILE.Rowposition, "FILE_NAME");       
       if( strPath != null  ) {                          
           iFrame.location.href="/dps/jsp/fileDownload.jsp?strPath="+strPath+"&strFileNm="+strFileNm;
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
<script language=JavaScript for=TR_MAIN1 event=onSuccess>
    for(i=0;i<TR_MAIN1.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN1.SrvErrMsg('UserMsg',i));
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
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>

	if (DS_IO_DTL_FILE.IsUpdated){
		
		if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            return false;
        } else {
        	DS_IO_DTL_FILE.ClearDate;
        	return true;
        }
	} else {
		return true;
	}

</script>

<script language=JavaScript for=DS_O_MASTER event=onRowPosChanged(row)>

	if(strSearchFlag == "1") {
		
		fn_FileList();
	}

</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

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

<comment id="_NSID_"><object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DTL_FILE" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
 
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
	    		<tr height=5>
	    			<td/>
	    		</tr>
	    		<tr>
	      			<td>
	      				<table width="100%" border="0" cellspacing="0" cellpadding="0">
	        				<tr>
	          					<td width="" class="title">
	            					<img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
	       							<span id="title1" class="PL03">직매입 반품 증빙 자료 첨부</span>
	     						</td>
	     						<td>
	     							<table border="0" align="right" cellpadding="0" cellspacing="0">
	       								<tr>
	         								<td><img src="/<%=dir%>/imgs/btn/new.gif"   id=IMG_BTN_NEW width="50" height="22"  onClick="btn_New();"/></td>
	         								<td><img src="/<%=dir%>/imgs/btn/save.gif"  id=IMG_BTN_SAVE width="50" height="22"  onClick="btn_Save();"/></td>
	         								<td><img src="/<%=dir%>/imgs/btn/del.gif"   id=IMG_BTN_DEL width="50" height="22"  onClick="btn_Delete()"/></td>
	         								<td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"  onClick="btn_Close();"/></td>
	              						</tr>
	          						</table>
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
		<td class="pop04" ></td>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="sub_title PB03 PT10">
						<img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
						align="absmiddle" /> 단품내역
					</td>
				</tr>
			</table>
		</td>
		<td class="pop06" ></td>
	</tr>
	<tr>
    	<td class="pop04" ></td>
    	<td>
			<table border="0" cellspacing="0" cellpadding="0" class="BD4A" width="100%">
				<tr>
					<td>
						<comment id="_NSID_">
							<object id=GR_MASTER width="100%" height=235 classid=<%=Util.CLSID_GRID%>>
								<param name="DataID" value="DS_O_MASTER">
							</object>
						</comment>
						<script>_ws_(_NSID_);</script>
					</td>
				</tr>
			</table>
		</td>
		<td class="pop06" ></td>
	</tr>
	<tr>
		<td class="pop04" ></td>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="sub_title PB03 PT10">
						<img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
						align="absmiddle" /> 파일첨부내역
					</td>
					<td>
					<img src="/<%=dir%>/imgs/btn/file_down.gif"   onclick="downFile();" align="right"  id="IMG_FILE_DOWN" />
					</td>
				</tr>
			</table>
		</td>
		<td class="pop06" ></td>
	</tr>
	<tr>
		<td class="pop04" ></td>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
				<tr>
					<td>
						<comment id="_NSID_">
							<object id=GR_FILE width="100%" height=200 classid=<%=Util.CLSID_GRID%>>
								<param name="DataID" value="DS_IO_DTL_FILE">
							</object>
						</comment>
						<script>_ws_(_NSID_);</script>
					</td>
				</tr>
			</table>
		</td>
		<td class="pop06" ></td>
	</tr>
	<tr>
	     <td class="pop07" ></td>
	     <td class="pop08" ></td>
	     <td class="pop09" ></td>
  	</tr>
</table> 
<comment id="_NSID_">
    <object id="INF_UPLOAD" classid=<%=Util.CLSID_INPUTFILE%> width="0" height="0"> 
	    <param name="Text"     value='FileOpen'>
	    <param name="Enable"   value="true">
    </object> 
</comment><script> _ws_(_NSID_);</script>
</body>
</html>

