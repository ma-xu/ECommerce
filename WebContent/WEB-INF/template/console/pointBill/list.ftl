<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("console.pointBill.list")}</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/list.js"></script>
<style type="text/css">
</style>
<script type="text/javascript">
$().ready(function() {

	[@flash_message /]
	
});
	//提交表单
	function submitForm(){
		$("#listForm").submit();
	}

</script>
</head>
<body>
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
                    <h2>${message("console.pointBill.list")} </h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="${base}/console/common/index.ct">${message("console.path.index")}</a>
                        </li>
                        <li>
                            <strong>${message("console.pointBill.list")}  <span>(${message("console.page.total", page.total)})</span></strong>
                        </li>
                    </ol>
                </div>
                <div class="col-lg-2">

                </div>
            </div>
	       	<!-- end 头部面包屑区域 -->
	       
	        <!-- start 中间内容部分 -->
	        <div class="wrapper wrapper-content animated fadeIn">
				<!-- start  积分来源账单列表管理 -->
				<form id="listForm" action="list.ct" method="get">
					<div class="row">
						<div class="col-lg-12">
	                        <div class="ibox float-e-margins">
	                            <div class="ibox-content">
	                                <div class="row">
	                                    <div class="col-sm-12 m-b-xs">
											<div class="btn-group">
												<a href="javascript:;" id="refreshButton"  class="btn btn-primary">
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
											<select name="pointSource" class="btn-white dropdown-toggle" style="  height: 30px;width: 120px;" onchange="submitForm();">
		                                        <option value="">${message("积分来源")}</option>
		                                        <option value="CONSUMPTION" [#if pointSource=="CONSUMPTION"] selected="selected"[/#if]>${message("PointBill.PointSource.CONSUMPTION")}</option>
		                                        <option value="LOGIN" [#if pointSource=="LOGIN"] selected="selected" [/#if]>${message("PointBill.PointSource.LOGIN")}</option>
		                                        <option value="GD" [#if pointSource=="GD"] selected="selected"[/#if]>${message("PointBill.PointSource.GD")}</option>
		                                        <option value="ATTENDANCEIC" [#if pointSource=="ATTENDANCEIC"] selected="selected" [/#if]>${message("PointBill.PointSource.ATTENDANCEIC")}</option>
		                                        <option value="ATTENDANCEQR" [#if pointSource=="ATTENDANCEQR"] selected="selected"[/#if]>${message("PointBill.PointSource.ATTENDANCEQR")}</option>
		                                        <option value="ATTENDANCEBAR" [#if pointSource=="ATTENDANCEBAR"] selected="selected" [/#if]>${message("PointBill.PointSource.ATTENDANCEBAR")}</option>
		                                        <option value="APPDOWLOAD" [#if pointSource=="APPDOWLOAD"] selected="selected"[/#if]>${message("PointBill.PointSource.APPDOWLOAD")}</option>
		                                        <option value="NOTICE" [#if pointSource=="NOTICE"] selected="selected" [/#if]>${message("PointBill.PointSource.NOTICE")}</option>
		                                        <option value="ASKLEAVE" [#if pointSource=="ASKLEAVE"] selected="selected"[/#if]>${message("PointBill.PointSource.ASKLEAVE")}</option>
		                                        <option value="CHAT" [#if pointSource=="CHAT"] selected="selected"[/#if]>${message("PointBill.PointSource.CHAT")}</option>
		                                    </select>
		                                    <div class="input-group pull-right">
												<input type="text" name="memberName" id="memberName" value= "${memberName}"  class="laydate-icon form-control layer-date" placeholder="${message("搜索会员名称")}" style="width:160px;display: initial;margin-top:10px;"/>
		                                    	<input id="submitButton" onclick="submitForm()" type="button" value="${message("搜索")}" class="btn btn-primary" />
	                                    	</div>
	                                    </div>
	                                </div>
	                                <div class="table-responsive">
	                                     <table id="listTable" class="table table-striped">
											<tr>
												<th class="check">
													<input type="checkbox" id="selectAll" />
												</th>
												<th>
													<a href="javascript:;" class="sort" name="pointSource">${message("PointBill.pointSource")}</a>
												</th>
												<th>
													<a href="javascript:;" class="sort" name="point">${message("PointBill.point")}</a>
												</th>
												<th>
													<a href="javascript:;" class="sort" name="change">${message("PointBill.change")}</a>
												</th>
												<th>
													<a href="javascript:;" class="sort" name="member">${message("PointBill.member.realName")}</a>
												</th>
												<th>
													<a href="javascript:;" class="sort" name="remark">${message("PointBill.remark")}</a>
												</th>
												<th>
													<span>${message("console.common.handle")}</span>
												</th>
											</tr>
											[#list page.content as pointBill]
												<tr>
													<td>
														<input type="checkbox" name="ids" value="${pointBill.id}" />
													</td>
													<td>
														${message("PointBill.PointSource."+pointBill.pointSource)}
													</td>
													<td>
														${pointBill.point}
													</td>
													<td>
														${pointBill.change}
													</td>
													<td>
														${pointBill.member.realName}
													</td>
													<td>
														<span title="${pointBill.remark}">
															${abbreviate(pointBill.remark, 50, "...")}
														</span>
													</td>
													<td>
														<a href="view.ct?id=${pointBill.id}">[${message("console.common.view")}]</a>
													</td>
												</tr>
											[/#list]
										</table>
										[@pagination pageNumber = page.pageNumber totalPages = page.totalPages]
											[#include "/console/include/pagination.ftl"]
										[/@pagination]
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
                </form>
	             <!-- end 积分来源账单列表-->
	        </div>
	       <!-- end 中间内容部分-->
	       [#include "/console/include/footer.ftl" /]
  </div>
</div>
</body>
</html>