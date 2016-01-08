<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("育儿类别列表")} - 爱柚米 • 移动营销平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/list.js"></script>
<script type="text/javascript">
$().ready(function() {

	[@flash_message /]
	 //上移
    $(".upIcon").click(function() {
        var $tr = $(this).parents("tr");
        if ($tr.index() == 1) {
            $.message("warn", "${message("该类别已置于顶部")}");
            return false;
        } else {
            var $currentId = this.attributes.posterOrder.nodeValue;
            var $changeId = $tr.prev().find("td:eq(5)").find("a:eq(0)")[0].attributes.posterOrder.nodeValue;
            $.ajax({
                url: "changeOrders.ct",
                type: "POST",
                data: {
                    currentId: $currentId,
                    changeId: $changeId,
                    btnType: "up"
                },
                dataType: "json",
                cache: false,
                async: false,
                success: function(message) {
                    if (message.type == "success") {
                        $tr.prev().before($tr);
                    }
                }
            });
        }
    });

    //下移
    var $downbtns = $(".downIcon");
    $downbtns.click(function() {
        var $tr = $(this).parents("tr");
        
        var len =  $(this).parents("table").find("tr").length-1;
        if ($tr.index() == len) {
            $.message("warn", "${message("该类别已置于底部")}");
            return false;
        } else {
            var $currentId = this.attributes.posterOrder.nodeValue;
            var $changeId = $tr.next().find("td:eq(5)").find("a:eq(0)")[0].attributes.posterOrder.nodeValue;
            $.ajax({
                url: "changeOrders.ct",
                type: "POST",
                data: {
                    currentId: $currentId,
                    changeId: $changeId,
                    btnType: "down",
                },
                dataType: "json",
                cache: false,
                async: false,
                success: function(message) {
                    if (message.type == "success") {
                        $tr.next().after($tr);
                    }
                }
            });
        }
    });

});
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
                    <h2>${message("育儿类别列表")}</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="${base}/console/common/index.ct">${message("console.path.index")}</a>
                        </li>
                        <li>
                           <strong>${message("育儿类别列表")} <span>(${message("console.page.total", page.total)})</span></strong>
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
	                                       	[@shiro.hasPermission name = "console:addParentingCategory"]
	                                        	<a href="add.ct" class="btn btn-primary">
													<span class="addIcon">&nbsp;</span>${message("console.common.add")}
												</a>
										   	[/@shiro.hasPermission]
                                        	[@shiro.hasPermission name = "console:deleteParentingCategory"]
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
	                                       <a href="${base}/console/parenting/list.ct" class="btn btn-primary">
										      <span class="addIcon">&nbsp;</span>${message("返回育儿列表")}
										   </a>
										</div>
                                    </div>
                                </div>
                                <div class="table-responsive">
                                     <div class="table-responsive">
	                                     <table id="listTable" class="table table-striped">
												<tr>
													<th class="check">
														<input type="checkbox" id="selectAll" />
													</th>
													<th>
														<a href="javascript:;" class="sort" name="categoryName">${message("NewsCategory.categoryName")}</a>
													</th>
													<th>
														<a href="javascript:;" class="sort" name="status">${message("NewsCategory.status")}</a>
													</th>
													<th>
														<a href="javascript:;" class="sort" name="createDate">${message("console.common.createDate")}</a>
													</th>
													<th>
														<span>${message("console.common.handle")}</span>
													</th>
													<th>
														<span>${message("console.common.order")}</span>
													</th>
												</tr>
												[#list page.content as parentingCategory]
													<tr>
														<td>
															<input type="checkbox" name="ids" value="${parentingCategory.id}" />
														</td>
														<td>
															${parentingCategory.categoryName}
														</td>
														<td>
															${message("NewsCategory.status.${parentingCategory.status}")}
														</td>
														<td>
															<span title="${parentingCategory.createDate?string("yyyy-MM-dd HH:mm:ss")}">${parentingCategory.createDate}</span>
														</td>
														<td>
														[@shiro.hasPermission name = "console:editParentingCategory"]
															<a href="edit.ct?id=${parentingCategory.id}">[${message("console.common.edit")}]</a>
														[/@shiro.hasPermission]
														</td>
														<td>
															<a class="upIcon" posterOrder="${parentingCategory.id}">${message("console.common.shiftUp")}</a><br/>
															<a class="downIcon" posterOrder="${parentingCategory.id}">${message("console.common.shiftDown")}</a><br/>
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
</body>
</html>