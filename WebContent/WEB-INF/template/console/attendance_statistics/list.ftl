<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("console.attendanceFigures.list")} - 爱柚米 • 移动营销平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/enumAndDateHelper.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/attendance.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/list.js"></script>
<script type="text/javascript" src="${base}/resources/console/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${base}/resources/console/datePicker/lang/zh_CN.js"></script>
<link href="${base}/resources/console/css/attendance.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">

    Date.prototype.Format = function(fmt)   
	{ //author: meizz   
	  var o = {   
	    "M+" : this.getMonth()+1,                 //月份   
	    "d+" : this.getDate(),                    //日   
	    "h+" : this.getHours(),                   //小时   
	    "m+" : this.getMinutes(),                 //分   
	    "s+" : this.getSeconds(),                 //秒   
	    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
	    "S"  : this.getMilliseconds()             //毫秒   
	  };   
	  if(/(y+)/.test(fmt))   
	    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
	  for(var k in o)   
	    if(new RegExp("("+ k +")").test(fmt))   
	  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
	  return fmt;   
   };
	
function showDetail(memberId,date,type){
    if(type == 5){
     $("#showAskLeaveDetail").fadeIn();
    } 
    else{
    	$("#showDetail").fadeIn();
    }
	
	$.ajax({
		type: "GET",
		url: "showDetail.ct",
		data: {
		    memberId:memberId,
		    date:date,
		    type:type
		},
		dataType: "json",
		success:function(data){
			if(type == 5){
				var askLeaveType = {
			        sick:"病假",
			        compassionate:"事假",
			        annual:"年假",
			        off:"调休",
			        marriage:"婚假",
			        maternity:"产假",
			        accompany:"陪产",
			        way:"路途假",
			        funeral:"丧假",
			        other:"其他"
			    }
			    if(data==null){
					$("#askLeaveDetailBody").html("");
					$("# askLeaveDetailBody").append("<tr><td colspan='3'>无数据</td></tr>");
					return;
				}
				else{
					$("#askLeaveDetailBody").html("");
					  $.each(data,function(key,values){     
				      var recode = "<tr>";
					  recode += "<td>"+key+ "</td>";
					  if(values == null || values.length==0){
					    recode += "<td>无</td>";
					  }
				      $(values).each(function(){     
						if(this.askLeaveType != null){
						  recode += "<td>"+askLeaveType[this.askLeaveType] + "</td>";
						} 
						else {
						  recode += "<td>无</td>";
						}
				      });
				      recode +='</tr>';
						$("#askLeaveDetailBody").append(recode);     
				 });   
					return;
				}
				
			} 
			else{
				 var status = {
			        normal:"正常",
			        late:"迟到",
			        early:"早退",
			        leave:"请假",
			        absenteeism:"旷工"
			    }
				if(data==null){
					$("#detailBody").html("");
					$("#detailBody").append("<tr><td colspan='3'>无数据</td></tr>");
					return;
				}
				else{
					  $("#detailBody").html("");
					  $.each(data,function(key,values){     
				      var recode = "<tr>";
					  recode += "<td>"+key+ "</td>";
					  if(values == null || values.length==0){
					    recode += "<td>未打卡</td><td>无</td><td>未打卡</td><td>无</td>";
					  }
				      $(values).each(function(){     
						if(this.workSwipeTime != null){
						  var workSwipeTime = new Date(this.workSwipeTime);
						  recode += "<td>"+workSwipeTime.Format('hh:mm:ss') + "</td>";
						} 
						else {
						  recode += "<td>未打卡</td>";
						}
						if(this.workStatus != null){
						  recode += "<td>"+status[this.workStatus] + "</td>";
						} 
						else {
						  recode += "<td>无</td>";
						}
						if(this.closingSwipeTime != null){
						 
						  var closingSwipeTime = new Date(this.closingSwipeTime);
						  recode += "<td>"+closingSwipeTime.Format('hh:mm:ss') + "</td>";
						}
						else {
						  recode += "<td>未打卡</td>";
						}
						if(this.closingStatus != null){
						  recode += "<td>"+status[this.closingStatus] + "</td>";
						} 
						else {
						  recode += "<td>无</td>";
						}
						
				      });
				      recode +='</tr>';
						$("#detailBody").append(recode);     
				 });   
					return;
			    }
			}
		 }
	});
}
function closeDiv(){
	$("#showDetail").fadeOut();
}
function closeAskLeaveDetail(){
	$("#showAskLeaveDetail").fadeOut();
}
</script>
</head>
<body>
        <div id="wrapper">
            <!-- start 导航 -->
            [#include "/console/include/nav.ftl" /]
            <!-- end 导航 -->
            <div id="page-wrapper" class="gray-bg dashbard-1">
                <!-- start 头部 -->
                [#include "/console/include/header.ftl" /]
                <!-- end 头部-->
                <!-- start 头部面包屑区域 -->
                <div class="row wrapper border-bottom white-bg page-heading">
                    <div class="col-lg-10">
                        <h2>${message("console.attendance.statistics")}</h2>
                        <ol class="breadcrumb">
                            <li>
                                <a href="${base}/console/common/index.ct"> ${message("console.path.index")}</a>
                            </li>
                            <li>
                                <strong>
                                    ${message("console.attendance.statistics")}
                                    <span>(${message("console.page.total", page.total)})</span>
                                </strong>
                            </li>
                        </ol>
                    </div>
                    <div class="col-lg-2">
                    </div>
                </div>
                <!-- end 头部面包屑区域 -->
                
              <!-- start 考勤详情展示区 -->
                <div id="showDetail" class="modal in" style="overflow: auto; display: none;"
                tabindex="-1" aria-hidden="false">
                    <div class="modal-backdrop  in">
                    </div>
                    <div class="modal-dialog">
                        <div class="modal-content marginTop">
                            <div class="modal-header">
                                <a onclick="closeDetail()" type="button" class="close" data-dismiss="modal"  aria-hidden="true">
                                    ×
                                </a>
                                <h4 class="modal-title">
                                    ${message("考勤详情")}
                                </h4>
                            </div>
                            <div class="modal-body ui-front">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>${message("日期")}</th>
                                            <th>${message("上班时间")}</th>
                                            <th>${message("上班状态")}</th>
                                            <th>${message("下班时间")}</th>
                                            <th>${message("下班状态")}</th>
                                        </tr>
                                    </thead>
                                    <tbody id="detailBody">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end 考勤详情展示区 -->
                 <!-- start 请假详情展示区 -->
                <div id="showAskLeaveDetail" class="modal in" style="overflow: auto; display: none;"
                tabindex="-1" aria-hidden="false">
                    <div class="modal-backdrop  in">
                    </div>
                    <div class="modal-dialog">
                        <div class="modal-content marginTop">
                            <div class="modal-header">
                                <a onclick="closeAskLeaveDetail()" type="button" class="close" data-dismiss="modal"  aria-hidden="true">
                                    ×
                                </a>
                                <h4 class="modal-title">
                                    ${message("请假详情")}
                                </h4>
                            </div>
                            <div class="modal-body ui-front">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>${message("日期")}</th>
                                            <th>${message("请假类型")}</th>
                                        </tr>
                                    </thead>
                                    <tbody id="askLeaveDetailBody">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end 请假详情展示区 -->
                <!-- start 中间内容部分 -->
                <div class="wrapper wrapper-content animated fadeIn">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="ibox float-e-margins">
                                <div class="ibox-content">
                                    <!-- start 列表管理 -->
                                    <form id="listForm" action="list.ct" method="get">
                                        <!-- start 查询条件区 -->
                                        <div class="padding">
                                            <div class="row">
                                                ${message("console.attendance.attendanceTime")}
                                                <input type="text" id="date" name="date" class="text Wdate" value="${date}" onfocus="WdatePicker({dateFmt:  'yyyy-MM',maxDate:'%y-%M'});" style="height:29px;width: 155px;"/>
                                                <input type="text" name="searchName" value="${searchName}" class="input-sm form-control" style="width:120px;margin:-29px 217px;position:absolute;height:29px;text-align:center;" placeholder="搜索老师姓名">
                                                <input type="button" id="submitButton" onclick="checkSearchForm()" value="${message("console.attendance.status.search")}" class="btn btn-primary" style="position:absolute;margin:-2px 129px;"/>
                                            </div>
                                        </div>
                                        <!-- end 查询条件区 -->
                                        <!-- start table展示区 -->
                                        <div class="table-responsive">
                                            <table id="attendance_table" class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th><a href="javascript:;" class="sort" name="member">${message("console.teacher.realname")}</a></th>
                                                        <th><a href="javascript:;" class="sort" name="workSettingName">${message("console.attendance.days")}</a></th>
                                                        <th><a href="javascript:;" class="sort" name="workSwipeTime">${message("console.attendance.lateCount")}</a></th>
                                                        <th><a href="javascript:;" class="sort" name="workStatus">${message("console.attendance.earlyCount")}</a></th>
                                                        <th><a href="javascript:;" class="sort" name="workStatus">${message("console.attendance.absenteeismCount")}</a></th>
                                                        <th><a href="javascript:;" class="sort" name="workStatus">${message("console.attendance.Leave")}</a></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    [#list teacherList as teacher]
                                                    <tr>
                                                    	<td>${teacher.realName}</td>
                                                    	<td><a href="#" onclick="showDetail('${teacher.id}','${date}','1')">${teacher.ATTENDANCE_DAYS}</a></td>
                                            			<!--<td>${teacher.ATTENDANCE_DAYS}</td> 
                                            			<td>${teacher.LATE_COUNT}</td>-->
                                            			<td><a href="#" onclick="showDetail('${teacher.id}','${date}','2')">${teacher.LATE_COUNT}</a></td>
                                            			<!--<td>${teacher.EARLY_COUNT}</td> -->
                                            			<td><a href="#" onclick="showDetail('${teacher.id}','${date}','3')">${teacher.EARLY_COUNT}</a></td>
                                            			<!--<td>${teacher.ABSENTEEISM_COUNT}</td> --> 
                                            			<td><a href="#" onclick="showDetail('${teacher.id}','${date}','4')">${teacher.ABSENTEEISM_COUNT}</a></td>
                                            			<!--<td>${teacher.LEAVE_COUNT}</td> -->
                                            			<td><a href="#" onclick="showDetail('${teacher.id}','${date}','5')">${teacher.LEAVE_COUNT}</a></td> 
                                                    </tr>
                                                    [/#list]
                                                </tbody>
                                            </table>
                                        </div>
                                        [@pagination pageNumber = page.pageNumber totalPages = page.totalPages]
                                        	[#include "/console/include/pagination.ftl"] 
                                        [/@pagination]
                                        <!-- end table展示区 -->
                                    </form>
                                    <!-- end 列表管理 -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end 中间内容部分 -->
                [#include "/console/include/footer.ftl" /]
            </div>
        </div>
    </body>
</html>