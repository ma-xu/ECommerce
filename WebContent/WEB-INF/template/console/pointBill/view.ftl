<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("console.pointBill.view")} - 爱柚米 • 移动营销平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {

	[@flash_message /]
	
});
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
					<h2> ${message("console.pointBill.view")} </h2>
	                <ol class="breadcrumb">
						<li>
						    <!--首页-->
							<a href="${base}/console/common/index.ct">${message("console.path.index")}</a> 
	                    </li>
	                    <li>
	                        <strong>${message("console.pointBill.view")}</strong>
	                    </li>
					</ol>
	            </div>
	            <div class="col-lg-2">
	
	            </div>
	        </div>
	       	<!-- end 头部面包屑区域 -->	
			<!-- start 中间内容部分 -->
			<div class="wrapper wrapper-content animated fadeIn">
				<div class="row">
			        <div class="col-lg-12">
			            <div class="ibox float-e-margins">
			                <div class="ibox-content" style="width:50%;margin:0 auto;">
		                    	<form id="inputForm" action="view.ct" method="get" class="form-horizontal m-t">
			                    	<input type="hidden" name="id" value="${pointBill.id}" />
			                        <div class="form-group">
			                            <label class="col-sm-3 control-label">${message("PointBill.pointSource")}：</label>
			                            <div class="col-sm-8">
			                                <input id="pointSource" name="pointSource" class="form-control" autocomplete="off" value="${message("PointBill.PointSource."+pointBill.pointSource)}" readonly="true">
			                            </div>
			                        </div>
			                        <div class="form-group">
			                            <label class="col-sm-3 control-label">${message("PointBill.point")}：</label>
			                            <div class="col-sm-8">
			                                <input id="point" name="point" class="form-control" autocomplete="off" value="${pointBill.point}" readonly="true">
			                            </div>
			                        </div>
			                        <div class="form-group">
			                            <label class="col-sm-3 control-label">${message("PointBill.member.realName")}：</label>
			                            <div class="col-sm-8">
			                                <input id="realName" name="realName" class="form-control" autocomplete="off" value="${pointBill.member.realName}" readonly="true">
			                            </div>
			                        </div>
			                        <div class="form-group">
			                            <label class="col-sm-3 control-label">${message("PointBill.remark")}：</label>
			                            <div class="col-sm-8">
			                            	<textarea name="remark" class="form-control" style="height: 80px;" readonly="true">${pointBill.remark}</textarea>
			                            </div>
			                        </div>
			                        <div class="form-group">
			                            <div class="col-sm-8 col-sm-offset-3">
										   <input type="button" class="btn btn-white" value="${message("console.common.back")}" onclick="location.href='list.ct'" />
			                            </div>
			                        </div>
		                        </form>
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