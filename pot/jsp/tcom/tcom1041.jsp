<!-- 
/*******************************************************************************
 * 시스템명 : 시스템메뉴 > 관리자메뉴> 권한관리
 * 작 성 일 : 2010.12.12
 * 작 성 자 : 정지인
 * 수 정 자 : 
 * 파 일 명 : tcom1041.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 사용자별 프로그램 사용권한(TAB)
 * 이    력 :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %> 

<script language = javascript> 
var bfTab1Row = 0;
/**
 * initByUser()
 * 작 성 자 : ckj
 * 작 성 일 : 2010-06-01
 * 개    요 : TAB 그룹별 프로그램 권한 초기화
 * return값 : void
*/
function initByUser() {  
     
    //트리 헤더 초기화 
    DS_O_TREE_MAIN.setDataHeader ('<gauce:dataset name="H_TREE_MAIN"/>');     
    //사용자별 프로그램권한 헤더 초기화 
    DS_IO_USRPGM.setDataHeader ('<gauce:dataset name="H_USRPGM"/>'); 
    DS_O_USRMST.setDataHeader ('<gauce:dataset name="H_USRMST"/>'); 
    
    initSearchBar();
    intiGrid();

}   

function intiGrid()
{
	// 사용자리스트 그리드 셋팅
	var hdrProperies1 = '<FC>id=USER_ID     width=70    align=left      name="사용자ID"  </FC>'
	                  + '<FC>id=USER_NAME   width=80    align=left      name="성명"      </FC>'
	                  + '<FC>id=ORG_NAME    width=80    align=left      name="조직구분"  </FC>' 
	                  + '<FC>id=STR_NAME    width=80    align=left      name="점"        </FC>' 
	                  + '<FC>id=DEPT_NAME   width=80    align=left      name="팀"      </FC>' 
	                  + '<FC>id=TEAM_NAME   width=80    align=left      name="파트"        </FC>' 
	                  + '<FC>id=PC_NAME     width=80    align=left      name="PC"        </FC>' ;   
	 initGridStyle(GD_USRMST_U, "common", hdrProperies1, true);
	 GD_USRMST_U.Editable = "false";
	
	 // 프로그램리스트 그리드 셋팅
	 var hdrProperies2 = '<FC>ID=SUB_SYSTEM     width=70     align=Center              name="시스템구분"      edit=None </FC>'
                       + '<FC>ID=PID            width=70     align=Center              name="프로그램ID"     edit=None </FC>'
	                   + '<FC>ID=NAME           width=150                              name="프로그램명"     edit=None </FC>'  
	                   + '<FC>ID=IS_RET         width=30     EditStyle=CheckBox        name="조회"           edit={IF(IS_RET_GB       ="Y","true","false")}</FC>'
	                   + '<FC>ID=IS_NEW         width=30     EditStyle=CheckBox        name="신규"           edit={IF(IS_NEW_GB       ="Y","true","false")}</FC>'
	                   + '<FC>ID=IS_DEL         width=30     EditStyle=CheckBox        name="삭제"           edit={IF(IS_DEL_GB       ="Y","true","false")}</FC>'
	                   + '<FC>ID=IS_SAVE        width=30     EditStyle=CheckBox        name="저장"           edit={IF(IS_SAVE_GB      ="Y","true","false")}</FC>'
	                   + '<FC>ID=IS_EXCEL       width=30     EditStyle=CheckBox        name="엑셀"           edit={IF(IS_EXCEL_GB     ="Y","true","false")}</FC>'
	                   + '<FC>ID=IS_PRINT       width=30     EditStyle=CheckBox        name="출력"           edit={IF(IS_PRINT_GB     ="Y","true","false")}</FC>'
	                   + '<FC>ID=IS_CONFIRM     width=30     EditStyle=CheckBox        name="확정"           edit={IF(IS_CONFIRM_GB   ="Y","true","false")}</FC>'
	                   //// MARIO OUTLET
	                   + '<FC>ID=LNAME          width=70     align=left                name="대분류"         edit=None </FC>'
	                   + '<FC>ID=MNAME          width=70     align=left                name="중분류"         edit=None </FC>'
	                   //+ '<FC>ID=SNAME          width=100    align=left                name="소분류"         edit=None </FC>'
	                   //// MARIO OUTLET
	                   ;  
	   initGridStyle(GD_USRPGM_U, "common", hdrProperies2, true);
	   GD_USRPGM_U.MultiRowSelect  = "true";
}

/**
 * initSearchBar()
 * 작 성 자 : 
 * 작 성 일 : 2010-06-01
 * 개    요 : 공통조회조건 초기화
 * return값 : void
 */
function initSearchBar()
{
    //콤보 초기화
    initComboStyle(LC_O_STR_CD,     DS_O_STR_CD,    "CODE^0^30,NAME^0^80",  1, NORMAL);     //점(조회)
    initComboStyle(LC_O_ORG_FLAG,   DS_O_ORG_FLAG,  "CODE^0^30,NAME^0^110", 1, PK);         //조직구분(조회) 
    initComboStyle(LC_O_DEPT_CD,    DS_O_DEPT_CD,   "CODE^0^30,NAME^0^110", 1, NORMAL);     //팀    
    initComboStyle(LC_O_TEAM_CD,    DS_O_TEAM_CD,   "CODE^0^30,NAME^0^110", 1, NORMAL);     //파트
    initComboStyle(LC_O_PC_CD,      DS_O_PC_CD,     "CODE^0^30,NAME^0^110", 1, NORMAL);     //PC   
     
    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_DEPT_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_TEAM_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_PC_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');   

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_ORG_FLAG", "D", "P047", "N"); 
    
    //점콤보 가져오기 ( gauce.js )
    getStore("DS_O_STR_CD", "N", "", "Y");  
    
    //콤보데이터 기본값 설정( gauce.js ) 
    setComboData(LC_O_ORG_FLAG, glbOrgFlag);
    setComboData(LC_O_STR_CD,"%");  
    
    // EMedit에 초기화 
    initEmEdit(EM_USER_NAME_U, "GEN^20", NORMAL);    //사원번호/명
    
    //럭스콤보 초기화    
    initComboStyle(LC_PGROUP_U,DS_O_PGROUP,"GROUP_CD^0^30,GROUP_NAME^0^84",1 ,NORMAL); // 그룹 콤보 
    selectPgroup("DS_O_PGROUP"); 
    
    
    LC_O_STR_CD.Index = 0;
    LC_O_ORG_FLAG.Index = 0;
    
    DS_O_PGROUP.insertRow(1);
    DS_O_PGROUP.NameValue(1,"GROUP_CD")     = "";
    DS_O_PGROUP.NameValue(1,"GROUP_NAME")   = ""; 
    
    
    
    //콤보 초기화 : 시스템구분
    initComboStyle(LC_SUB_SYSTEM_U, DS_O_SUBSYSTEM, "CODE^0^30,NAME^0^80", 1, PK);
    //서브시스템 공통 코드 에서 가져 오기
    getEtcCode("DS_O_SUBSYSTEM",   "D", "TC01", "N"); 
    //콤보 기본값셋팅 = 백화점
    setComboData(LC_SUB_SYSTEM_U, "P");   
    
    LC_O_STR_CD.Index = 0;
    
       
    // 조회조건
    EM_USER_NAME_U.Focus();
}
/**
 * selectUsrmstUser()
 * 작 성 자 : ckj
 * 작 성 일 : 
 * 개    요  : 조건을 이용하여 사용자 조직 정보 가져오기 
 * return값 : void
 */
function selectUsrmstUser() 
{   
    var strBindStrCd    = LC_O_STR_CD.BindColVal;      // 점
    var strBindOrgFlag  = LC_O_ORG_FLAG.BindColVal;    // 조직 
    var strBindDeptCd   = LC_O_DEPT_CD.BindColVal;     // 팀
    var strBindTeamCd   = LC_O_TEAM_CD.BindColVal;     // 파트
    var strBindPcCd     = LC_O_PC_CD.BindColVal;       // PC 
    var strBindGroupCd  = LC_PGROUP_U.BindColVal;       // 그룹
    var strBindUserCd   = EM_USER_NAME_U.text;
    
    var goTo       = "selUsrmstCond" ;    
    var action     = "O";     
    var parameters = "&strStrCd="  +encodeURIComponent(strBindStrCd)
                   + "&strOrgFlag="+encodeURIComponent(strBindOrgFlag)
                   + "&strDeptCd=" +encodeURIComponent(strBindDeptCd)
                   + "&strTeamCd=" +encodeURIComponent(strBindTeamCd)
                   + "&strPcCd="   +encodeURIComponent(strBindPcCd)
                   + "&strGroupCd="+encodeURIComponent(strBindGroupCd)
                   + "&strUserCd=" +encodeURIComponent(strBindUserCd)
                   + "&strGbn="    +"U";
    
    TR_MAIN.Action="/pot/tcom104.tc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_USRMST=DS_O_USRMST)"; //조회는 O
    TR_MAIN.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", DS_O_USRMST.CountRow); 
     
}

/**
 * copyAuthor()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개    요  : 사용자권한복사
 * return값 : void
 */
function copyAuthor_1()
{
	if (DS_O_USRMST.CountRow == 0  || DS_O_USRMST.NameValue(DS_O_USRMST.RowPosition, "USER_ID") == "") 
    {
        showMessage(STOPSIGN, OK, "USER-1000", "선택된 사용자가 없습니다.");
        GD_USRMST_U.focus();
        return;
    }

	/*
	if (DS_IO_USRPGM.CountRow == 0 ) 
    {
        showMessage(STOPSIGN, OK, "USER-1000", "해당 사용자는 복사할 권한이 없습니다.");
        GD_USRMST_U.focus();
        return;
    }
	*/
    
    var arrArg  = new Array(); 
    arrArg.push(DS_O_USRMST.NameValue(DS_O_USRMST.RowPosition, "USER_ID"));
    arrArg.push(DS_O_USRMST.NameValue(DS_O_USRMST.RowPosition, "USER_NAME")); 
    arrArg.push(window.self);  
    arrArg.push('User');  
    
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

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- TAB1(사용자별 프로그램 권한) :  메뉴 TREE 클릭시  -->
<script language=JavaScript for=TV_MAIN_U event=OnClick(row,colid)>
    setLastProgramSelected( "U", DS_O_TREE_MAIN.NameValue(DS_O_TREE_MAIN.RowPosition, "CODE") );
</script>

<!-- TAB1(사용자별 프로그램 권한) : 서브시스템 LUXCOMBO 상태 변경시   -->
<script language=JavaScript for=LC_SUB_SYSTEM_U event=onSelChange()> 
    showTreeView('U',"DS_O_TREE_MAIN");
//  syncLCIndex('U');
</script>

<!-- TAB1(사용자별 프로그램 권한) :  사용자 리스트 클릭시   -->
<script language=JavaScript for=DS_O_USRMST event=OnRowPosChanged(row)>  
    if(row < 1) return;	
   	if(bfTab1Row == row && DS_IO_USRPGM.CountRow >0) return;
   	 
   	if( DS_IO_USRPGM.IsUpdated ) 
   	{
   	    if( showMessage(QUESTION, YESNO, "USER-1049") != 1 )
        {
        	 DS_O_USRMST.RowPosition = bfTab1Row;
             return;
         }
   	 }
   	 DS_O_USRMST.UndoAll();
     bfTab1Row = row;
        
     showUsrpgm( 'U', DS_O_USRMST.NameValue(row, "USER_ID"), DS_IO_USRPGM);
     setLastUserSelected( DS_O_USRMST.NameValue(row, "USER_ID") );  
</script>
<!-- TAB1  : 헤더클릭시 정렬  -->
<script language=JavaScript for=GD_USRMST_U event=OnClick(row,colid)>
    if( row < 1)
        sortColId( eval(this.DataID), row , colid );
</script> 
<script language=JavaScript for=GD_USRPGM_U event=OnClick(row,colid)>
    if( row < 1)
        sortColId( eval(this.DataID), row , colid );
</script> 

<script language=JavaScript for=LC_O_ORG_FLAG event=OnSelChange>
    DS_O_DEPT_CD.ClearData();
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    if (LC_O_STR_CD.BindColVal == '%'){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);
        setComboData(LC_O_DEPT_CD, "%") 
        return;     
    }
    
    getDept("DS_O_DEPT_CD", "N", LC_O_STR_CD.BindColVal, "Y", "",
            LC_O_ORG_FLAG.BindColVal);
    if(DS_O_DEPT_CD.CountRow < 1){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);       
    }
    LC_O_DEPT_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_STR_CD event=OnSelChange>
    DS_O_DEPT_CD.ClearData();
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    if (this.BindColVal == '%'){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);
        setComboData(LC_O_DEPT_CD, "%");
        return;     
    }
    
    getDept("DS_O_DEPT_CD", "N", LC_O_STR_CD.BindColVal, "Y", "",
            LC_O_ORG_FLAG.BindColVal);
    if(DS_O_DEPT_CD.CountRow < 1){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);       
    }
    LC_O_DEPT_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_DEPT_CD event=OnSelChange>
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    if (this.BindColVal == '%'){
        insComboData(LC_O_TEAM_CD, "%", "전체", 1);
        setComboData(LC_O_TEAM_CD, "%");
        return;     
    }
    
    getTeam("DS_O_TEAM_CD", "N", LC_O_STR_CD.BindColVal,
                LC_O_DEPT_CD.BindColVal, "Y", "", LC_O_ORG_FLAG.BindColVal);

    if(DS_O_TEAM_CD.CountRow < 1){
        insComboData(LC_O_TEAM_CD, "%", "전체", 1);       
    }
    LC_O_TEAM_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_TEAM_CD event=OnSelChange>
    DS_O_PC_CD.ClearData();
    if (this.BindColVal == '%'){
        insComboData(LC_O_PC_CD, "%", "전체", 1);
        setComboData(LC_O_PC_CD, "%");
        return;     
    }
    getPc("DS_O_PC_CD", "N", LC_O_STR_CD.BindColVal,
                LC_O_DEPT_CD.BindColVal, LC_O_TEAM_CD.BindColVal, "Y", "",
                LC_O_ORG_FLAG.BindColVal);

    if(DS_O_PC_CD.CountRow < 1){
        insComboData(LC_O_PC_CD, "%", "전체", 1);       
    }
    LC_O_PC_CD.Index = 0;
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
<comment id="_NSID_"><object id="DS_O_SUBSYSTEM"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- 콤보 그룹 -->
<comment id="_NSID_"><object id="DS_O_PGROUP"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> <!-- 그룹  담고 있는 데이타셋 -->
<!-- 사용자 조회 -->
<comment id="_NSID_"><object id="DS_O_USRMST"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> 
<!-- 트리 -->
<comment id="_NSID_"><object id="DS_O_TREE_MAIN"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> <!-- TREE 표현할 데이타셋 -->
<!-- 프로그램 권한 리스트 -->
<comment id="_NSID_"><object id="DS_IO_USRPGM"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> 

<!-- --------------------- 조회조건(searchBar) --------------------------------- -->
<comment id="_NSID_"><object id="DS_O_STR_CD"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ORG_FLAG"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DEPT_CD"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TEAM_CD"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PC_CD"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->

<body >
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
    <tr><td class="PT03 PB03" > 
	   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
	   <tr><td>
	        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
	            <tr>
	                <th width="60" class="point">조직</th> 
	                <td>
	                    <comment id="_NSID_">
	                    <object id=LC_O_ORG_FLAG classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=110 align="absmiddle"> </object> 
	                    </comment><script>_ws_(_NSID_);</script> 
	                </td> 
	                <th width="60">점</th>  
	                <td>
	                    <comment id="_NSID_">
	                    <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=110 align="absmiddle"> </object> 
	                    </comment><script>_ws_(_NSID_);</script> 
	                </td>
	                
	                <th width="60">팀</th>
	                <td>
	                    <comment id="_NSID_">
	                    <object id=LC_O_DEPT_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=110 align="absmiddle"> </object> 
	                    </comment><script>_ws_(_NSID_);</script> 
	                </td>
	                <th width="60">파트</th>
	                <td>
	                    <comment id="_NSID_">
	                    <object id=LC_O_TEAM_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=110 align="absmiddle"> </object> 
	                    </comment><script>_ws_(_NSID_);</script> 
	                </td>
	                <th width="60">PC</th>
	                <td>
	                    <comment id="_NSID_">
	                    <object id=LC_O_PC_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=110 align="absmiddle"> </object> 
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
                     <object id=EM_USER_NAME_U classid=<%=Util.CLSID_EMEDIT%>   width=120 >
                       </object>
                    </comment>
                   <script> _ws_(_NSID_);</script>
               </TD>
	           <th width="80">그룹</th> 
               <td width="165">
                    <comment id="_NSID_"> <object id=LC_PGROUP_U classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165 align="absmiddle"> 
                    <param name=DataID value=DS_O_PGROUP> 
                    </object> </comment><script>_ws_(_NSID_);</script>
               </td>
               <td></td>  
               <td width ="40">
              		<input type="button" value="권한복사" onclick="copyAuthor_1()" > 
              		<!-- img src="./imgs/btn/btn_auth.gif"  style="cursor:hand" align=center onclick="copyAuthor()" --> 
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
        <td valign="top" width="250">
            <table  width="170" border="0" cellpadding="0" cellspacing="0" class="BD4A">
            <tr><td> 
	            <comment id="_NSID_"><OBJECT id=GD_USRMST_U width="100%" height="446" classid=<%=Util.CLSID_GRID%>>
	                <param name="DataID" value="DS_O_USRMST">
	            </OBJECT></comment><script>_ws_(_NSID_);</script> 
            </td></tr>
            </table>       
        </td>
        <!-- 사용자리스트 end --> 
        <td>&nbsp;</td>
        
        <!-- tree start -->
        <td valign="top" width="180" >  
        <Table width="100" border="0" cellpadding="0" cellspacing="0" align="center">
            <tr>
	            <Td>
	                <comment id="_NSID_">
	                <object id=LC_SUB_SYSTEM_U classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=120 align="absmiddle"></object>
	                </comment><script>_ws_(_NSID_);</script> 
	            </td>
	            <td valign ="left">
                    <img src="./imgs/btn/btn_addprogram.gif"  style="cursor:hand" align=center onclick="addProgram('U')" > </td> 
            </tr> 
            
            <tr><td colspan=2></td></tr>
            <Tr>
	            <TD colspan=2 width="180" align=center valign="top" class="BD2A" >
	                <comment id="_NSID_">
	                  <object id=TV_MAIN_U classid=<%=Util.CLSID_TREEVIEW%>  width=180  height=427>
	                    <param name=DataID          value="DS_O_TREE_MAIN">
	                    <param name=TextColumn      value="TXT">
	                    <param name=LevelColumn     value="LVL">
	                    <param name=UseImage        value="false">
	                    <param name=ExpandOneClick  value="true">
	                    <param name=BorderStyle     value="0">
	                  </object>
	                  </comment><script>_ws_(_NSID_);</script>
	            </TD>
	        </Tr>
        </table>        
        </td>
        <!-- tree end --> 
        <td>&nbsp;</td>
        
        <!-- 프로그램리스트 start -->
        <td  valign="top" width="100%" style="padding-right:5px;">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="BD4A">
            <tr><td >
                <comment id="_NSID_">
                    <object id=GD_USRPGM_U classid=<%=Util.CLSID_GRID%> height=447 width=100% >
                        <param name=DataID      value="DS_IO_USRPGM">
                    </object>
                </comment><script>_ws_(_NSID_);</script>
            </td></tr>
            </table>
        </td>
        <!-- 프로그램리스트 end -->
        </tr>
        </table>
 
    </td></tr>
    </table>
</body>
 
