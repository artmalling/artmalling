<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > POS정산 > POS마감현황
 * 작 성 일 : 2010.07.07
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : psal5090.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.07.07 (정진영) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
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
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
//
var colWidth = 95;
var top = 140;		//해당화면의 동적그리드top위치
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');

    
    //그리드 초기화
    //gridCreate1(); //마스터

    // EMedit에 초기화
    initEmEdit(EM_SALE_DT    , "TODAY" , PK);  //기간
    
    initEmEdit(EM_BFCNT    , "NUMBER^13^0" , READ);  //개설전
    initEmEdit(EM_OPEN     , "NUMBER^13^0" , READ);  //영업중
    initEmEdit(EM_MAGAM    , "NUMBER^13^0" , READ);  //마감
    //콤보 초기화 
    initComboStyle(LC_STR_CD      ,DS_STR_CD      , "CODE^0^30,NAME^0^140", 1, PK);      //점(조회)
    initComboStyle(LC_POS_FLAG    ,DS_POS_FLAG    , "CODE^0^30,NAME^0^160", 1, NORMAL);  //POS구분(조회)
    initComboStyle(LC_FLOOR_CD    ,DS_FLOOR_CD    , "CODE^0^30,NAME^0^110", 1, NORMAL);  //층(조회)

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_POS_FLAG", "D", "P082", "Y");
    getEtcCode("DS_FLOOR_CD", "D", "P061", "Y");
    
    // 점코드 조회
    //getStore("DS_STR_CD"  , "Y", "", "N");
    getStore2("DS_STR_CD", "Y",	"1", "Y", "1");													//점
    

    //관
    initComboStyle(EM_HALL,DS_HALL, "CODE^0^30,NAME^0^80", 1, NORMAL);              
    getEtcCode("DS_HALL"      , "D", "P197", "Y");
    EM_HALL.Index = 0;
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    setComboData(LC_FLOOR_CD   , '%');
    setComboData(LC_POS_FLAG   , '%');

    LC_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}       width=30   align=center name="NO"           </FC>'
                     + '<FC>id=POS_NO         width=80   align=center name="매출일자"     </FC>'
                     + '<FC>id=SHOP_NAME      width=80   align=left   name="층 "           </FC>'
                     + '<FC>id=POS_NAME       width=100  align=left   name="층명"         </FC>'
                     + '<FC>id=POS_FLAG       width=200  align=right  name="총매출 "        </FC>'
                     + '<FC>id=FLOR_CD        width=120  align=right  name="구성비 "       </FC>'
                     + '<FC>id=MAGAM_FLAG     width=150  align=right  name="객단가 "       </FC>';

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    if( LC_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
    }

    if( EM_SALE_DT.Text == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "일자");
        EM_SALE_DT.Focus();
        return;
    }
    DS_MASTER.ClearData();

    var strStrCd    = LC_STR_CD.BindColVal;
    var strDt       = EM_SALE_DT.Text;
    var strPosFlag  = LC_POS_FLAG.BindColVal;
    var strFloorCd  = LC_FLOOR_CD.BindColVal;
    var strHallCd   = EM_HALL.BindColVal;
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="  +encodeURIComponent(strStrCd)
                   + "&strDt="	   +encodeURIComponent(strDt)
                   + "&strPosFlag="+encodeURIComponent(strPosFlag)
                   + "&strFloorCd="+encodeURIComponent(strFloorCd)
                   + "&strHallCd=" +encodeURIComponent(strHallCd)
                   ;
    TR_MAIN.Action="/dps/psal509.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();

    //조회후 결과표시
    setPorcCount("SELECT",DS_MASTER.CountRow);
    //
    drawPosInfo();

    posCnt();
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
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
	 
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * setCalData()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  달력 팝업 실행
 * return값 : void
 */
function setCalData( evnFlag, obj){
    if( evnFlag == 'POP'){
        openCal('G',obj);
    }
    if(obj.Text == "")
        return;
    
    if(!checkDateTypeYMD( obj ))
        return;
}
/**
 * drawPosInfo()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  그리드를 표시합니다.
 * return값 : void
 */
function drawPosInfo(){
	var posImg       = '<img width="60px" height="40px" style="filter:alpha(opacity:80)" show=false src="/<%=dir%>/imgs/dps/pos';
    var pdaImg       = '<img width="60px" height="40px" style="filter:alpha(opacity:80)" show=false src="/<%=dir%>/imgs/dps/pad';
	var total        = DS_MASTER.CountRow;
	var posListDiv   = document.getElementById("DIV_POS_LIST");
	var posListWidth = parseInt(posListDiv.offsetWidth+0);
	var rowCount     = parseInt((posListWidth-53)/colWidth);
	if( total < 1){		
		posListDiv.innerHTML = getDummyTable();
		return;
	}
	
	//Master 그리드 세로크기자동조정  2014.07.18
	posListDiv.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
	var posNoTabStr  = '  </tr>';
	posNoTabStr     += '  <tr>';
    var tmpTableStr  = '<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table center">';
    tmpTableStr     += '  <tr>';  
	for(var i=1; i<= total; i++){
		var posNo   = DS_MASTER.NameValue(i,"POS_NO");
        var posName = DS_MASTER.NameValue(i,"POS_NAME");
		var floorCd = DS_MASTER.NameValue(i,"FLOR_CD");
        var posFlag = DS_MASTER.NameValue(i,"POS_FLAG");
        var magamYn = DS_MASTER.NameValue(i,"MAGAM_FLAG");
        var userName = DS_MASTER.NameValue(i,"SALE_USER_ID");
        var userNo = DS_MASTER.NameValue(i,"EMP_NO");
		if( i%rowCount == 1 && i!=1){
			tmpTableStr += posNoTabStr;
            tmpTableStr += '  </tr>';
            tmpTableStr += '  <tr>';
			posNoTabStr  = '  </tr>';
		    posNoTabStr += '  <tr>';
		}
		if( i%rowCount == 0){
            posNoTabStr     += '    <td style=" ';	
            tmpTableStr     += '    <td style=" ';		
		}else{
            posNoTabStr     += '    <td style="width:'+colWidth+'px; ';
            tmpTableStr     += '    <td style="width:'+colWidth+'px; ';
		}
		posNoTabStr     += ' height:35px;border-left:2px solid #b4d0e1; border-right:2px solid #b4d0e1; border-bottom:2px solid #b4d0e1; border-top:0px dashed #b4d0e1;">'+posNo
		                +  '<br><font style="font-size:10px;font-family:"굴림체";">'+posName
		                +  '<br><font style="font-size:10px;font-family:"굴림체";">'+userNo+"/"+userName
		                +  '</font></td>';
		tmpTableStr     += ' height:50px;border-left:2px solid #b4d0e1; border-right:2px solid #b4d0e1; border-bottom:1px dashed #b4d0e1; border-top:2px solid #b4d0e1;">';
        if(magamYn == 'Y'){
            tmpTableStr     += '        '+(posFlag=='05'?pdaImg:posImg)+'_b.jpg" onclick="javascript:strPosAcount('+posNo+');"';     
        }else if(magamYn == 'N'){
            tmpTableStr     += '        '+(posFlag=='05'?pdaImg:posImg)+'_g.jpg" onclick="javascript:strPosAcount('+posNo+');"';
        }else{
            tmpTableStr     += '        '+(posFlag=='05'?pdaImg:posImg)+'.jpg" ';   	
        }
        tmpTableStr     += ' />';
        tmpTableStr     += '    </td>';
        if((i==total&&total%rowCount!=0)){
        	posNoTabStr += '<td colSpan="'+(rowCount-total%rowCount)+'" style="border:0px;">&nbsp;</td>';
            tmpTableStr += '<td colSpan="'+(rowCount-total%rowCount)+'" style="border:0px;">&nbsp;</td>';
        }
	}
    tmpTableStr     += posNoTabStr;
    tmpTableStr     += '  <tr>';  
	tmpTableStr     += '</table>';
	
	posListDiv.innerHTML = tmpTableStr;
}

/**
 * getDummyTable()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 빈 테이블을 입력한다.
 * return값 : void
 */
function getDummyTable(){
    var tmpTableStr = '<table width="100%" border="0" cellpadding="0" cellspacing="0" >';  
    tmpTableStr    += "  <tr>";
    tmpTableStr    += "   <td >&nbsp;</td>";
    tmpTableStr    += "  </tr>";
    tmpTableStr    += "</table>";
    return tmpTableStr
}

/**
 * getDummyTable()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 빈 테이블을 입력한다.
 * return값 : void
 */
function strPosAcount( strPosNo )
{
	var strDt       = EM_SALE_DT.Text;
    var arrArg  = new Array();

    arrArg.push(strDt);
    arrArg.push(strPosNo);

    var returnVal = window.showModalDialog("/dps/psal509.ps?goTo=strPosAcount",
                                           arrArg,
                                           "dialogWidth:385px;dialogHeight:370px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
    if (returnVal){
        return arrArg[0];
    }
    return null;
}


/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function posCnt() {
    var bfOpen   = 0;
    var openCnt  = 0;
    var magamCnt = 0;
    
	 for(i=1; i <= DS_MASTER.CountRow;i++){
		 if(DS_MASTER.NameValue(i, "MAGAM_FLAG") == "Y"){
			 magamCnt++;
		 }
		 else{
			 if(DS_MASTER.NameValue(i, "MAGAM_FLAG") == "N"){
				 openCnt++;
	         }
			 else{
				 bfOpen++;
			 }
		 }
	 }
	 
	 EM_BFCNT.text = bfOpen;
	 EM_OPEN.text  = openCnt;
	 EM_MAGAM.text = magamCnt;
     
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
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );    
</script>


<!-- 기간(조회) -->
<script language=JavaScript for=EM_SALE_DT event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setCalData('NAME', EM_SALE_DT);
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
<comment id="_NSID_"><object id="DS_STR_CD"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_POS_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_FLOOR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_HALL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
 <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="60" class="point">점</th>
            <td width="120">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=120 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60" class="point">일자</th>
            <td width="100">
              <comment id="_NSID_">
                <object id=EM_SALE_DT classid=<%=Util.CLSID_EMEDIT%>  width=75  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:setCalData('POP', EM_SALE_DT);"  align="absmiddle" />
            </td>
            <th width="60" >POS구분</th>
            <td width="140">
               <comment id="_NSID_">
                 <object id=LC_POS_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            
            <th width="90">관구분</th>
					<td><comment id="_NSID_"> <object
                     id=EM_HALL classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>    
            
            <th width="60" >층</th>
            <td >
               <comment id="_NSID_">
                 <object id=LC_FLOOR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=70 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
              
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
<tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="18" style="font-size:20px; color:black">■
            </th>
            <th  width="100" >개설전
            </th>
            <th width="100">
              <comment id="_NSID_">
                <object id=EM_BFCNT classid=<%=Util.CLSID_EMEDIT%>  width=75  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>대
            </th>
            <th width="18" style="font-size:20px; color:limegreen">■
            </th>
            <th  width="100" >영업중
            </th>
            <th width="100">
              <comment id="_NSID_">
                <object id=EM_OPEN classid=<%=Util.CLSID_EMEDIT%>  width=75  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>대
            </th>
            <th width="18" style="font-size:20px; color:blue">■
            </th>
            <th width="100"  >마감
            </th>
            <th>
              <comment id="_NSID_">
                <object id=EM_MAGAM classid=<%=Util.CLSID_EMEDIT%>  width=75  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>대
            </th>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD2A">
          <tr>
            <td><div  style="height:470px;width:100%;overflow:auto;" id="DIV_POS_LIST" onresize="javascript:drawPosInfo();"></div>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

