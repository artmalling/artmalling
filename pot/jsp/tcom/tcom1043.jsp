<!-- 
/*******************************************************************************
 * 시스템명 : 시스템메뉴 > 관리자메뉴> 권한관리
 * 작 성 일 : 2010.06.08
 * 작 성 자 : 정지인
 * 수 정 자 : 
 * 파 일 명 : tcom1043.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 조직권한(TAB)
 * 이    력 :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %>  

<script language = javascript> 
var bfTab3Row = 0;
/**
 * initJojik()
 * 작 성 자 : ckj
 * 작 성 일 : 2010-06-01
 * 개    요 : TAB 조직권한 초기화
 * return값 : void
*/
function initJojik() {   
    //사용자별 프로그램권한 헤더 초기화 
    DS_O_USRMST_J.setDataHeader ('<gauce:dataset name="H_USRMST_J"/>'); 
    DS_IO_JJAUTH.setDataHeader ('<gauce:dataset name="H_JJAUTH"/>'); 
    
    intiGridJ();
    initSearchBarJ()
    
}   
function intiGridJ()
{
    // Grid초기화
    var hdrProperies1 = '<FC>id=USER_ID     width=70     align=left      name="사용자ID"  edit=none</FC>'
                      + '<FC>id=USER_NAME   width=85     align=left      name="성명"      edit=none</FC>'
                      + '<FC>id=ORG_NAME    width=99     align=left      name="조직구분"  edit=none</FC>' 
                      + '<FC>id=STR_NAME    width=100    align=left      name="점"        edit=none</FC>' 
                      + '<FC>id=DEPT_NAME   width=110    align=left      name="팀"      edit=none</FC>' 
                      + '<FC>id=TEAM_NAME   width=110    align=left      name="파트"        edit=none</FC>' 
                      + '<FC>id=PC_NAME     width=120    align=left      name="PC"        edit=none</FC>' ;   
                      
    initGridStyle(GD_USRMST_J, "common", hdrProperies1, true);  
    
    // Grid초기화
    var hdrProperies2 = '<FC>id={currow}    width=30     align=center    name="NO"       </FC>'
                      + '<FC>id=AUTH_LEVEL  width=55     align=center    name="등급"      EditStyle=Lookup   Data="DS_OG_AUTH_LEVEL:CODE:NAME"</FC>'
                      + '<FC>id=ORG_FLAG    width=99     align=left      name="조직구분"  EditStyle=Lookup   Data="DS_OG_ORG_FLAG:CODE:NAME"</FC>'
                      + '<FC>id=STR_NAME    width=100    align=left      name="점"        </FC>' 
                      + '<FC>id=DEPT_NAME   width=110    align=left      name="팀"      </FC>' 
                      + '<FC>id=TEAM_NAME   width=110    align=left      name="파트"        </FC>' 
                      + '<FC>id=PC_NAME     width=120    align=left      name="PC"        </FC>'  
                      + '<FC>id=PUMBUN_NAME width=120    align=left      name="품번"      </FC>' ;   
                      
    initGridStyle(GD_JJAUTH_J, "common", hdrProperies2, false);  
    GD_JJAUTH_J.MultiRowSelect  = "true";
	
}
/**
 * initSearchBar()
 * 작 성 자 : 
 * 작 성 일 : 2010-06-01
 * 개    요 : 공통조회조건 초기화
 * return값 : void
 */
function initSearchBarJ()
{
    //콤보 초기화
    initComboStyle(LC_O_STR_CD_J,     DS_O_STR_CD_J,    "CODE^0^30,NAME^0^80",  1, NORMAL);     //점(조회)
    initComboStyle(LC_O_ORG_FLAG_J,   DS_O_ORG_FLAG_J,  "CODE^0^30,NAME^0^110", 1, PK);         //조직구분(조회) 
    initComboStyle(LC_O_DEPT_CD_J,    DS_O_DEPT_CD_J,   "CODE^0^30,NAME^0^110", 1, NORMAL);     //팀    
    initComboStyle(LC_O_TEAM_CD_J,    DS_O_TEAM_CD_J,   "CODE^0^30,NAME^0^110", 1, NORMAL);     //파트
    initComboStyle(LC_O_PC_CD_J,      DS_O_PC_CD_J,     "CODE^0^30,NAME^0^110", 1, NORMAL);     //PC   
     
    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_DEPT_CD_J.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_TEAM_CD_J.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_PC_CD_J.setDataHeader('CODE:STRING(2),NAME:STRING(40)');   

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_ORG_FLAG_J", "D", "P047", "N"); 
    
    //점콤보 가져오기 ( gauce.js )
    getStore("DS_O_STR_CD_J", "N", "", "Y");  
    
    //콤보데이터 기본값 설정( gauce.js ) 
    setComboData(LC_O_ORG_FLAG_J, glbOrgFlag);
    setComboData(LC_O_STR_CD_J,"%");  
     
    // EMedit에 초기화 
    initEmEdit(EM_USER_NAME_J, "GEN^20", NORMAL);    //사원번호/명
    
    //등급
    getEtcCode("DS_OG_AUTH_LEVEL", "D", "TC02", "N"); 
    DS_OG_AUTH_LEVEL.insertRow(1);
    DS_OG_AUTH_LEVEL.NameValue(1,"CODE") = "";
    DS_OG_AUTH_LEVEL.NameValue(1,"NAME") = ""; 
    
    LC_O_STR_CD_J.Index = 0;

    //조직구분  
    getEtcCode("DS_OG_ORG_FLAG", "D", "P047", "N"); 
    
    EM_USER_NAME_J.Focus();
    
    
}
/**
 * selectUsrmstJojik()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-08-12
 * 개    요  : 조건을 이용하여 사용자 조직 정보 가져오기 
 * return값 : void
 */
function selectUsrmstJojik() { 
	 
	var strBindStrCd    = LC_O_STR_CD_J.BindColVal;      // 점
	var strBindOrgFlag  = LC_O_ORG_FLAG_J.BindColVal;    // 조직 
	var strBindDeptCd   = LC_O_DEPT_CD_J.BindColVal;     // 팀
	var strBindTeamCd   = LC_O_TEAM_CD_J.BindColVal;     // 파트
	var strBindPcCd     = LC_O_PC_CD_J.BindColVal;       // PC 
	var strBindGroupCd  = LC_PGROUP_U.BindColVal;      // 그룹

	var strBindUserCd   = EM_USER_NAME_J.text; 
	if(arguments[0]!="" &&	arguments[0]!=undefined) strBindUserCd = arguments[0];

    DS_IO_JJAUTH.ClearData();
    var goTo       = "selUsrmstCond" ;    
    var action     = "O";     
    var parameters = "&strStrCd="  +encodeURIComponent(strBindStrCd)
                   + "&strOrgFlag="+encodeURIComponent(strBindOrgFlag)
                   + "&strDeptCd=" +encodeURIComponent(strBindDeptCd)
                   + "&strTeamCd=" +encodeURIComponent(strBindTeamCd)
                   + "&strPcCd="   +encodeURIComponent(strBindPcCd)
                   + "&strUserCd=" +encodeURIComponent(strBindUserCd)   
                   + "&strGbn="    +"J";
	     
    TR_TAB3_1.Action="/pot/tcom104.tc?goTo="+goTo+parameters;  
    TR_TAB3_1.KeyValue="SERVLET("+action+":DS_O_USRMST_J=DS_O_USRMST_J)"; //조회는 O
    TR_TAB3_1.Post();

    setPorcCount("SELECT", DS_O_USRMST_J.CountRow);  
}
 
/**
 * showJjauth()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-08-12
 * 개    요  : 사용자별 조직권한 정보를 보여주기 
 * return값 : void
 */
function showJjauth(userCd) 
{
    var goTo       = "selJjauth" ;    
	var action     = "O";     
	var parameters ="&strUserCd=" +encodeURIComponent(userCd) ;
	         
	TR_TAB3_2.Action="/pot/tcom104.tc?goTo="+goTo+parameters;  
	TR_TAB3_2.KeyValue="SERVLET("+action+":DS_IO_JJAUTH=DS_IO_JJAUTH)"; //조회는 O
	TR_TAB3_2.Post();
}
 
 
/**
 * grantAuthor()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-08-12
 * 개    요  : 조직 권한 선택할 팝업을 띄우기(권한 부여 버튼 )
 * return값 : void
 */
function grantAuthor() {

    if(DS_O_USRMST_J.NameValue(DS_O_USRMST_J.RowPosition, "USER_ID") == "" || DS_O_USRMST_J.CountRow < 1)
    {
        showMessage(EXCLAMATION, OK, "USER-1000", "사용자를 먼저 선택하세요.");
        return;
    }
    
    var arrArg = new Array();
    arrArg.push(DS_O_USRMST_J.NameValue(DS_O_USRMST_J.RowPosition, "USER_ID"));
    arrArg.push(window.self); 
    
    var returnVal =  window.showModalDialog("/pot/tcom104.tc?goTo=jojikAuthPop"
	                , arrArg
	                , "dialogWidth:1000px;dialogHeight:520px;scroll:no;" +
	                  "resizable:no;help:no;unadorned:yes;center:yes;status:no");  
}

 /**
  * copyAuthor()
  * 작 성 자 : 
  * 작 성 일 : 
  * 개    요  : 사용자권한복사
  * return값 : void
  */
  function copyAuthor_3()
  {
 	if (DS_O_USRMST_J.CountRow == 0  || DS_O_USRMST_J.NameValue(DS_O_USRMST_J.RowPosition, "USER_ID") == "") 
     {
         showMessage(STOPSIGN, OK, "USER-1000", "선택된 사용자가 없습니다.");
         GD_USRMST_J.focus();
         return;
     }
 
     
     var arrArg  = new Array(); 
     arrArg.push(DS_O_USRMST_J.NameValue(DS_O_USRMST_J.RowPosition, "USER_ID"));
     arrArg.push(DS_O_USRMST_J.NameValue(DS_O_USRMST_J.RowPosition, "USER_NAME")); 
     arrArg.push(window.self);  
     arrArg.push('Jojik');  
     
     window.showModalDialog("/pot/tcom104.tc?goTo=copyAuthorPop"
 		      			, arrArg
 	          			, "dialogWidth:400px;dialogHeight:120px;scroll:no;" +
 	            		  "resizable:no;help:no;unadorned:yes;center:yes;status:no"); 
 	
 }
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_TAB3_1 event=onSuccess>
    for(i=0;i<TR_TAB3_1.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_TAB3_1.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_TAB3_2 event=onSuccess>
    for(i=0;i<TR_TAB3_2.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_TAB3_2.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_TAB3_1 event=onFail>
    trFailed(TR_TAB3_1.ErrorMsg);
</script>
<script language=JavaScript for=TR_TAB3_2 event=onFail>
    trFailed(TR_TAB3_2.ErrorMsg);
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- TAB3(조직 권한) : 헤더클릭시 정렬  -->
<script language=JavaScript for=GD_USRMST_J event=OnClick(row,colid)>
	if( row < 1)
	    sortColId( eval(this.DataID), row , colid );
</script> 
<script language=JavaScript for=GD_JJAUTH_J event=OnClick(row,colid)>
    if( row < 1)
        sortColId( eval(this.DataID), row , colid );
</script> 
<!-- TAB3(조직 권한) : 사용자 선택 시 조직조회  --> 
<script language=JavaScript for=DS_O_USRMST_J event=OnRowPosChanged(row)> 
    if(row < 1) return; 
    
    if( bfTab3Row == row && DS_IO_JJAUTH.CountRow >0) return;            
    if( DS_IO_JJAUTH.IsUpdated ) {
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
        	DS_O_USRMST_J.RowPosition = bfTab3Row;
            return;
        }
    }
    bfTab3Row = row;        

    showJjauth( DS_O_USRMST_J.NameValue(row, "USER_ID") );
    setLastUserSelected( DS_O_USRMST_J.NameValue(row, "USER_ID") );
</script>

<script language=JavaScript for=LC_O_ORG_FLAG_J event=OnSelChange>
    DS_O_DEPT_CD_J.ClearData();
    DS_O_TEAM_CD_J.ClearData();
    DS_O_PC_CD_J.ClearData();
    if (LC_O_STR_CD_J.BindColVal == '%'){
        insComboData(LC_O_DEPT_CD_J, "%", "전체", 1);
        setComboData(LC_O_DEPT_CD_J, "%") 
        return;     
    }
    
    getDept("DS_O_DEPT_CD_J", "N", LC_O_STR_CD_J.BindColVal, "Y", "",
            LC_O_ORG_FLAG_J.BindColVal);
    if(DS_O_DEPT_CD_J.CountRow < 1){
        insComboData(LC_O_DEPT_CD_J, "%", "전체", 1);       
    }
    LC_O_DEPT_CD_J.Index = 0;
</script>

<script language=JavaScript for=LC_O_STR_CD_J event=OnSelChange>
    DS_O_DEPT_CD_J.ClearData();
    DS_O_TEAM_CD_J.ClearData();
    DS_O_PC_CD_J.ClearData();
    if (this.BindColVal == '%'){
        insComboData(LC_O_DEPT_CD_J, "%", "전체", 1);
        setComboData(LC_O_DEPT_CD_J, "%");
        return;     
    }
    
    getDept("DS_O_DEPT_CD_J", "N", LC_O_STR_CD_J.BindColVal, "Y", "",
            LC_O_ORG_FLAG_J.BindColVal);
    if(DS_O_DEPT_CD_J.CountRow < 1){
        insComboData(LC_O_DEPT_CD_J, "%", "전체", 1);       
    }
    LC_O_DEPT_CD_J.Index = 0;
</script>

<script language=JavaScript for=LC_O_DEPT_CD_J event=OnSelChange>
    DS_O_TEAM_CD_J.ClearData();
    DS_O_PC_CD_J.ClearData();
    if (this.BindColVal == '%'){
        insComboData(LC_O_TEAM_CD_J, "%", "전체", 1);
        setComboData(LC_O_TEAM_CD_J, "%");
        return;     
    }
    
    getTeam("DS_O_TEAM_CD_J", "N", LC_O_STR_CD_J.BindColVal,
                LC_O_DEPT_CD_J.BindColVal, "Y", "", LC_O_ORG_FLAG_J.BindColVal);

    if(DS_O_TEAM_CD_J.CountRow < 1){
        insComboData(LC_O_TEAM_CD_J, "%", "전체", 1);       
    }
    LC_O_TEAM_CD_J.Index = 0;
</script>

<script language=JavaScript for=LC_O_TEAM_CD_J event=OnSelChange>
    DS_O_PC_CD_J.ClearData();
    if (this.BindColVal == '%'){
        insComboData(LC_O_PC_CD_J, "%", "전체", 1);
        setComboData(LC_O_PC_CD_J, "%");
        return;     
    }
    getPc("DS_O_PC_CD_J", "N", LC_O_STR_CD_J.BindColVal,
                LC_O_DEPT_CD_J.BindColVal, LC_O_TEAM_CD_J.BindColVal, "Y", "",
                LC_O_ORG_FLAG_J.BindColVal);

    if(DS_O_PC_CD_J.CountRow < 1){
        insComboData(LC_O_PC_CD_J, "%", "전체", 1);       
    }
    LC_O_PC_CD_J.Index = 0;
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
<!-- 콤보 시스템구분 -->
<comment id="_NSID_"><object id="DS_OG_AUTH_LEVEL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_OG_ORG_FLAG"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_IO_JJAUTH"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_USRMST_J"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> <!-- 그룹  담고 있는 데이타셋 -->
<!-- --------------------- 조회조건(searchBar) --------------------------------- -->
<comment id="_NSID_"><object id="DS_O_STR_CD_J"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ORG_FLAG_J"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DEPT_CD_J"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TEAM_CD_J"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PC_CD_J"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_"><object id="TR_TAB3_1"   classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="TR_TAB3_2" classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->



<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%"> 
    <tr><td class="PT03 PB03" > 
	   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
	   <tr><td>
	        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
	            <tr>
	                <th width="60" class="point">조직</th> 
	                <td>
	                    <comment id="_NSID_">
	                    <object id=LC_O_ORG_FLAG_J classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=110 align="absmiddle"> </object> 
	                    </comment><script>_ws_(_NSID_);</script> 
	                </td> 
	                <th width="60">점</th>  
	                <td>
	                    <comment id="_NSID_">
	                    <object id=LC_O_STR_CD_J classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=110 align="absmiddle"> </object> 
	                    </comment><script>_ws_(_NSID_);</script> 
	                </td>
	                
	                <th width="60">팀</th>
	                <td>
	                    <comment id="_NSID_">
	                    <object id=LC_O_DEPT_CD_J classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=110 align="absmiddle"> </object> 
	                    </comment><script>_ws_(_NSID_);</script> 
	                </td>
	                <th width="60">파트</th>
	                <td>
	                    <comment id="_NSID_">
	                    <object id=LC_O_TEAM_CD_J classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=110 align="absmiddle"> </object> 
	                    </comment><script>_ws_(_NSID_);</script> 
	                </td>
	                <th width="60">PC</th>
	                <td>
	                    <comment id="_NSID_">
	                    <object id=LC_O_PC_CD_J classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=110 align="absmiddle"> </object> 
	                    </comment><script>_ws_(_NSID_);</script> 
	                </td>
	            </tr>
	        </table> 
        </td></tr>
       <tr><td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table ">
            <TR>
               <th width="70">성명/사용자ID</th>
               <TD width="120">
                   <comment id="_NSID_">
                     <object id=EM_USER_NAME_J classid=<%=Util.CLSID_EMEDIT%>   width=120 >
                       </object>
                    </comment>
                   <script> _ws_(_NSID_);</script>
               </TD>
               <td>
                    <img src="./imgs/btn/btn_auth.gif"  style="cursor:hand" align=center onclick="grantAuthor()" > 
               </td>   
               <td width ="40">
              		<input type="button" value="권한복사" onclick="copyAuthor_3()" >  
               </td>  
            </TR>
            </TABLE>
        </td></tr>
        </table>
    </td></tr>
	<tr><td class="dot" ></td><tr>
    <tr><td width="100%" >
        <table width="100%" border="0" cellpadding="0" cellspacing="0" height="100%">
        <tr> 
        <!-- 사용자리스트 start -->
        <td valign="top" width="270">
            <table width="100%" cellpadding=0 cellspacing=0>
            <tr><td> 
	            <table  width="270" border="0" cellpadding="0" cellspacing="0" class="BD4A">
	            <tr><td> 
	                <comment id="_NSID_">
	                    <object id=GD_USRMST_J classid=<%=Util.CLSID_GRID%> height=447 width=100% >
	                        <param name=DataID      value="DS_O_USRMST_J">
	                    </object>
	                </comment><script>_ws_(_NSID_);</script>
	            </td></tr>
	            </table> 
            </td></tr>
            </table>      
        </td>
        <!-- 사용자리스트 end --> 
        <td>&nbsp;</td>  
        
        <!-- 조직권한리스트 start -->
        <td  valign="top" width="100%" style="padding-right:5px;">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="BD4A">
            <tr><td valign="top"> 
                 <comment id="_NSID_"><OBJECT id=GD_JJAUTH_J width="100%" height="447" classid=<%=Util.CLSID_GRID%>>
                     <param name="DataID" value="DS_IO_JJAUTH">
                 </OBJECT></comment><script>_ws_(_NSID_);</script> 
            </td></tr>
            </table>
        </td>
        <!-- 조직권한리스트 end -->
        </tr>
        </table>
 
    </td></tr>
    </table>
