<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("console.askLeave.list")} - 爱柚米 • 移动营销平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/list.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/plugins/chosen/chosen.jquery.js"></script>
<link href="${base}/resources/console/css/plugins/chosen/chosen.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$().ready(function() {

	[@flash_message /]
});
function description(msg){
	layer.open({
	    type: 1,
	    skin: 'layui-layer-demo', //样式类名
	    closeBtn: false, //不显示关闭按钮
	    shift: 2,
	    shadeClose: true, //开启遮罩关闭
	    area: ['400px', '200px'],
	    content: msg
	});
}
</script>
</head>
<body>
<body class="fixed-navigation">
	<div id="wrapper">
	  <!-- start  导航 -->
       [#include "/console/include/nav.ftl" /]
       <!-- end 导航-->
	
	   <div id="page-wrapper" class="gray-bg dashbard-1">
		   <!-- start 头部 -->
	       [#include "/console/include/header.ftl" /]
	       <!-- end 头部-->
	       
	       <!-- start 头部面包屑区域 -->
	       <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-lg-10">
                    <h2>${message("console.askLeave.list")}</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="${base}/console/common/index.ct">${message("console.path.index")}</a>
                        </li>
                        <li>
                           <strong>${message("console.askLeave.list")} <span>(${message("console.page.total", page.total)})</span></strong>
                        </li>
                    </ol>
                </div>
                <div class="col-lg-2">
                
                </div>
            </div>
	       <!-- end 头部面包屑区域 -->
	       
	        <!-- start 中间内容部分 -->
	        <div class="wrapper wrapper-content animated fadeIn">
	             <!-- start  学校管理 -->
	             <form id="listForm" action="list.ct" method="get">
	             <div class="row">
                    <div class="col-lg-12">
                        <div class="ibox float-e-margins">
                            <div class="ibox-content">
                                <div class="row">
                                    <div class="col-sm-4 m-b-xs">
                                    	<div class="btn-group">
	                                       	<!--[@shiro.hasPermission name = "console:addAskLeave"]
	                                        <a href="add.ct" class="btn btn-primary">
												<span class="addIcon">&nbsp;</span>${message("console.common.add")}
											</a>
										   	[/@shiro.hasPermission]
									   	
		                                    [@shiro.hasPermission name = "console:deleteAskLeave"]
												<a href="javascript:;" id="deleteButton" class="btn btn-primary disabled">
													<span class="deleteIcon">&nbsp;</span>${message("console.common.delete")}
												</a>
											[/@shiro.hasPermission]-->
											<a href="javascript:;" id="refreshButton" class="btn btn-primary">
												<span class="refreshIcon">&nbsp;</span>${message("console.common.refresh")}
											</a>
											<div class="btn-group">
		                                        <button data-toggle="dropdown" class="btn btn-primary dropdown-toggle" aria-expanded="false">${message("console.page.pageSize")} <span class="caret"></span>
		                                        </button>
		                                        <ul class="dropdown-menu" id="pageSizeOption">
													<li>
														<a href="javascript:;"[#if page.pageSize == 10] class="current"[/#if] val="10">10</a>
													</li>
													<li>
														<a href="javascript:;"[#if page.pageSize == 20] class="current"[/#if] val="20">20</a>
													</li>
													<li>
														<a href="javascript:;"[#if page.pageSize == 50] class="current"[/#if] val="50">50</a>
													</li>
													<li>
														<a href="javascript:;"[#if page.pageSize == 100] class="current"[/#if] val="100">100</a>
													</li>
												</ul>
		                            		</div>
										</div>
									</div>
										<div class="input-group pull-right">
											<form action="list.ct" method="get">
												<input type="text" name="searchName" value="${searchName}" class="input-sm form-control" style="width:100px;margin-top: 12px;" placeholder="搜索姓名">
												<select data-placeholder="请假类型" name="askLeaveType" class="chosen-select" style="width:100px;margin-top:5px;"  tabindex="4">
		                                            <option value="" hassubinfo="true" ></option>
		                                            <option value="sick" [#if askLeaveType == "sick"]selected="true"[/#if] hassubinfo="true" >病假</option>
		                                            <option value="compassionate" [#if askLeaveType == "compassionate"]selected="true"[/#if] hassubinfo="true" >事假</option>
		                                        </select>
		                                        <input type="text" value="${startDate}" name="startDate" id="startDate" 
                                                	class="laydate-icon form-control layer-date" style="width:120px;margin-top:12px;height:30px;"
                                                	placeholder="开始时间" />
                                                <input type="text" value="${endDate}" name="endDate" id="endDate" 
                                                	class="laydate-icon form-control layer-date" style="width:120px;margin-top:12px;height:30px;"
                                                	placeholder="结束时间"/>
												<input type="submit" class="btn btn-primary" value="搜索"/>
											</form>
										</div>
	                            </div>
	                        </div>
                            <div class="table-responsive">
                                 <div class="table-responsive">
                                     <table id="listTable" class="table table-striped">
										<tr style="white-space: nowrap;">
											<th class="check">
												<input type="checkbox" id="selectAll" />
											</th>
											<th>
												<a href="javascript:;" class="sort" name="stuName">学生名称</a>
											</th>
											<th>
												<a href="javascript:;" class="sort" name="stuNo">学生编号</a>
											</th>
											<th>
												<a href="javascript:;" class="sort" name="askLeaveType">请假类型</a>
											</th>
											<th>
												<a href="javascript:;" class="sort" name="receiverRead">是否已阅</a>
											</th>
											<!--<th>
												<a href="javascript:;" class="sort" name="isAgree">是否同意</a>
											</th>
											<th>
												<a href="javascript:;" class="sort" name="auditingUserName">审批者</a>
											</th>-->
											<th>
												<a href="javascript:;" class="sort" name="leaveStartDate">请假开始时间</a>
											</th>
											<th>
												<a href="javascript:;" class="sort" name="leaveEndDate">请假结束时间</a>
											</th>
											<th>
												<a href="javascript:;" class="sort" name="description">请假说明</a>
											</th>
											<th>
												<span>${message("详情")}</span>
											</th>
										</tr>
										[#list askLeaveList as askLeave]
										<tr>
											<td>
												<input type="checkbox" name="ids" value="${askLeave.ASKLEAVE.id}" />
											</td>
											<td>
												${askLeave.ASKLEAVE.stuName}
											</td>
											<td>
												${askLeave.ASKLEAVE.stuNo}
											</td>
											<td>
												[#if askLeave.ASKLEAVE.askLeaveType=="sick"]
												病假
												[#else]
												事假
												[/#if]
											</td>
											<td>
												${askLeave.READ}
											</td>
											<!--<td>
												[#if askLeave.isAgree="true"]
												是
												[#else]
												否
												[/#if]
											</td>
											<td>
												${askLeave.auditingUserName}
											</td>-->
											<td>
												${askLeave.ASKLEAVE.leaveStartDate}
											</td>
											<td>
												${askLeave.ASKLEAVE.leaveEndDate}
											</td>
											<td>
												[#if askLeave.ASKLEAVE.description?length lt 15]
													${askLeave.ASKLEAVE.description}
												[#else]
													${askLeave.ASKLEAVE.description?substring(0,14)}...
												[/#if]
											</td>
											<td>
											<!--[@shiro.hasPermission name = "console:editAskLeave"]
												<a href="edit.ct?id=${askLeave.id}">[${message("console.common.edit")}]</a>
											[/@shiro.hasPermission]-->
												<a data-toggle="modal" class="btn btn-primary" onclick="getDetail(${askLeave.ASKLEAVE.id})">
                                                	${message("console.attendance.detail")}
                                                </a>
											</td>
										</tr>
										[/#list]
									</table>
									[@pagination pageNumber = page.pageNumber totalPages = page.totalPages]
										[#include "/console/include/pagination.ftl"]
									[/@pagination]
									   <!-- start 详情展示区 -->
                                        <div id="showDetail" class="modal in" style="overflow: auto; display: none;"
                                        tabindex="-1" aria-hidden="false">
                                            <div class="modal-backdrop  in">
                                            </div>
                                            <div class="modal-dialog" style="padding-top: 168px;">
                                                <div class="modal-content marginTop">
                                                    <div class="modal-header">
                                                        <a onclick="closeDetail()" type="button" class="close" data-dismiss="modal"  aria-hidden="true">
                                                            ×
                                                        </a>
                                                        <h4 class="modal-title">
                                                            ${message("console.attendance.detail")}
                                                        </h4>
                                                    </div>
                                                    <div class="modal-body ui-front">
                                                        <table class="table table-striped">
                                                            <thead>
                                                                <tr>
                                                                    <th>${message("console.askLeave.class")}</th>
                                                                    <th>${message("console.askLeave.student")}</th>
                                                                    <th>${message("console.askLeave.type")}</th>
                                                                    <th>${message("console.askLeave.startDate")}</th>
                                                                    <th>${message("console.askLeave.endDate")}</th>
                                                                    <th>${message("console.askLeave.expline")}</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="detailBody">
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- end 详情展示区 -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
           	</form>
         	<!-- end 学校管理 -->
        </div>
       	<!-- end 中间内容部分-->
		[#include "/console/include/footer.ftl" /]
	</div>
	<script>
	    var config = {
	        '.chosen-select': {},
	        '.chosen-select-deselect': {
	            allow_single_deselect: true
	        },
	        '.chosen-select-no-single': {
	            disable_search_threshold: 10
	        },
	        '.chosen-select-no-results': {
	            no_results_text: '无选择项'
	        },
	        '.chosen-select-width': {
	            width: "95%"
	        }
	    }
	    for (var selector in config) {
	        $(selector).chosen(config[selector]);
	    }
	</script>
</div>
<!-- start layerDate plugin javascript -->
<!-- 注意一定要放在结尾，不能放在上面，否则无效，原因加载顺序 -->
<script type="text/javascript" src="${base}/resources/console/js/plugins/layer/laydate/laydate.js"></script>
<script>
	function getDetail(askLeaveId){
	$("#showDetail").fadeIn();
		$.ajax({
			type: "GET",
			url: "showAskLeaveDetail.ct",
			data: {
			    askLeaveId:askLeaveId
			},
			dataType: "json",
			success:function(dataList){
				var data = dataList[0];
				var className = dataList[1].className;
				var content = ""; 
				content+="<tr><td>"+className+"</td>";
				content+="<td>"+data.askLeave.stuName+"</td>";
				if(data.askLeave.askLeaveType=="sick"){
			    	content+="<td>病假</td>";
			    }else{
			    	content+="<td>事假</td>";
			    }
				content+="<td>"+data.leaveStartDate+"</td>";
				content+="<td>"+data.leaveEndDate+"</td>";
				content+="<td>"+data.askLeave.description+"</td>";
				var tbody = $("#detailBody");
				tbody.html(content);
			}
		});
	}
	
	function closeDetail(){
		$("#showDetail").fadeOut();
	}
	
    //日期范围限制
    var start = {
        elem: '#startDate',
        format: 'YYYY-MM-DD',
        min: '1900-01-01', //最小日期
        //设定最小日期为当前日期
        max: '2099-06-16',
        //最大日期
        istime: true,
        istoday: false,
        choose: function(datas) {
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };
    var end = {
        elem: '#endDate',
        format: 'YYYY-MM-DD',
        min: '1900-01-01', //最小日期
        max: '2099-06-16',
        istime: true,
        istoday: false,
        choose: function(datas) {
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    laydate(start);
    laydate(end);
</script>
<!-- end layerDate plugin javascript -->
</body>
</html>