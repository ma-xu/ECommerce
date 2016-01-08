<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("console.appPushMsg.list")} - 爱柚米 • 移动营销平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/list.js"></script>
<link rel="stylesheet" href="${base}/resources/console/css/animate.css" >
<script type="text/javascript" src="${base}/resources/console/js/plugins/chosen/chosen.jquery.js"></script>
<link href="${base}/resources/console/css/plugins/chosen/chosen.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$().ready(function() {

	[@flash_message /]

});

function showDeatil(id){
	$.ajax({
        url: "showDetail.ct",
        type: "POST",
        data: {
            id: id
        },
        dataType: "json",
        cache: false,
        async: false,
        success: function(message) {
        	var content= '<div>'+message+'</div>';
        	layer.open({
				type: 1,
			    title: false,
			    area: '300px',
			    shift:1,
			    skin: 'layui-layer-demo', //样式类名
			    closeBtn: true, //不显示关闭按钮
			    shift: 2,
			    shadeClose: true, //开启遮罩关闭
			    content: content
			});
        }
    });
}

</script>
<style type="text/css">
.datagrid-cell,
.datagrid-cell-rownumber {
  margin: 0;
  padding: 0 4px;
  white-space: nowrap;
  word-wrap: normal;
  overflow: hidden;
  height: 18px;
  line-height: 18px;
  font-size: 12px;
}
.datagrid-cell-c1-item {
  width: 772px;
}
.imgBox {
  float: left;
  width: 85px;
  height: 85px;
  margin-left: 10px;
}
.imgBox img {
  width: 85px;
  height: 85px;
}
.contBox {
  margin-left: 20px;
  width: 440px;
  float: left;
}
.contBox .cont-tit {
  font-weight: bold;
  color: #4E4E4E;
}
.contBox p {
  display: block;
  width: 500px;
  word-break: break-all;
  word-wrap: break-word;
}
.contBox .cont-detail {
  color: #909090;
}
.mt10 {
  margin-top: 10px;
}
</style>
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
                    <h2>${message("console.appPushMsg.list")}</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="${base}/console/common/index.ct">${message("console.path.index")}</a>
                        </li>
                        <li>
                           <strong>${message("console.appPushMsg.list")} <span>(${message("console.page.total", page.total)})</span></strong>
                        </li>
                    </ol>
                </div>
                <div class="col-lg-2">
                
                </div>
            </div>
	       <!-- end 头部面包屑区域 -->
	       
	        <!-- start 中间内容部分 -->
	        <div class="wrapper wrapper-content animated fadeIn">
        		<form id="listForm" action="list.ct" method="get">
             	<!-- start  地区管理 -->
             	<div class="row">
           	 		<div class="col-lg-12">
                    	<div class="ibox float-e-margins">
                            <div class="ibox-content">
                                <div class="row">
                                    <div class="col-sm-6 m-b-xs">
                                    	<div class="btn-group">
	                                       	[@shiro.hasPermission name = "console:addAppPushMsg"]
	                                        <a href="add.ct" class="btn btn-primary">
												<span class="addIcon">&nbsp;</span>${message("console.appPushMsg.send")}
											</a>
										   	[/@shiro.hasPermission]
	                                        [@shiro.hasPermission name = "console:deleteAppPushMsg"]
											<a href="javascript:;" id="deleteButton" class="btn btn-primary disabled">
												<span class="deleteIcon">&nbsp;</span>${message("console.common.delete")}
											</a>
											[/@shiro.hasPermission]
											<a href="javascript:;" id="refreshButton" class="btn btn-primary">
												<span class="refreshIcon">&nbsp;</span>${message("console.common.refresh")}
											</a>
											<div class="btn-group">
		                                        <button data-toggle="dropdown" class="btn btn-primary dropdown-toggle" aria-expanded="false">${message("console.page.pageSize")} <span class="caret"></span>
		                                        </button>
		                                        <ul class="dropdown-menu" id="pageSizeOption">
													<li>
														<a href="javascript:;"[#if page.pageSize == 5] class="current"[/#if] val="5">5</a>
													</li>
													<li>
														<a href="javascript:;"[#if page.pageSize == 10] class="current"[/#if] val="10">10</a>
													</li>
													<li>
														<a href="javascript:;"[#if page.pageSize == 15] class="current"[/#if] val="15">15</a>
													</li>
													<li>
														<a href="javascript:;"[#if page.pageSize == 20] class="current"[/#if] val="20">20</a>
													</li>
												</ul>
	                                       	</div>
	                                       	                                       	
										</div>
                                    </div>
                                    <form action="list.ct" method="get">
	                                    <div class="col-sm-4 m-b-xs">
	                                    	<!--班级选择-->
		                                    <div class="btn-group" style="width:80%;float:left;margin-top:11px;">
		                                        <select data-placeholder="请选择关联班级(可搜索名字)" name="searchClassId" class="chosen-select" style="width:100%;float:left;" tabindex="4">
		                                            <option hassubinfo="true"></option>
		                                            [#list dictClasses as dictClass]
		                                            <option value="${dictClass.id}" [#if searchClassId == dictClass.id]selected[/#if] hassubinfo="true" >${dictClass.name}</option>
		                                            [/#list]
		                                        </select>
		                                    </div>  
											<!--班级选择-->	
											<input type="submit" value="搜索" style="float:right" class="btn btn-primary"/>
	                                    </div>
	                                    
                                    </form>
                                </div>
                                <div class="table-responsive">
                                     <div class="table-responsive">
	                                     <table id="listTable" class="table table-striped">
												<tr>
													<th class="check">
														<input type="checkbox" id="selectAll" />
													</th>
													<th>
														<a href="javascript:;" class="sort" name="title">${message("标题")}</a>
													</th>
													<th>
														<a href="javascript:;" class="sort" name="author">${message("作者")}</a>
													</th>
													<th>
														<a href="javascript:;" class="sort" name="coverImage">${message("封面图片")}</a>
													</th>
													<th>
														<a href="javascript:;" class="sort" name="isDraft">${message("是否草稿")}</a>
													</th>
													<th>
														<span>${message("console.common.handle")}</span>
													</th>
												</tr>
												[#list page.content as appPushMsg]
													<tr>
														<td>
															<input type="checkbox" name="ids" value="${appPushMsg.id}" />
														</td>
														<td>
															<a onclick="showDeatil(${appPushMsg.id})">[${appPushMsg.title}]</a>
															
														</td>
														<td>
															${appPushMsg.author}
														</td>
														<td>
															<a href="javscript:;" onclick='showBigImge("${appPushMsg.coverImage}")'>
																<img class="img_plus" src="${appPushMsg.coverImage}" height="50" width="50" />
															</a>
														</td>
														<td>
															[#if appPushMsg.isDraft == true]
																是
															[#else]
																否
															[/#if]
														</td>
														<td>
														[@shiro.hasPermission name = "console:editAppPushMsg"]
															<a href="edit.ct?id=${appPushMsg.id}">[${message("console.common.edit")}]</a>
														[/@shiro.hasPermission]
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
                </div>
             	<!-- end 地区管理 -->
             	</form>
	        </div>
	       <!-- end 中间内容部分-->
	       [#include "/console/include/footer.ftl" /]
  </div>
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
	$(".chosen-select").trigger("chosen:updated");
</script>
</body>
</html>