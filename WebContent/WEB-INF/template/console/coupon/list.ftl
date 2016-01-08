<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("console.coupon.list")}</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/list.js"></script>
<link href="${base}/resources/console/css/excelImport.css" rel="stylesheet">
<script type="text/javascript" src="${base}/resources/console/js/excelImport.js"></script>
<link href="${base}/resources/console/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${base}/resources/console/switch/bootstrap-switch.css" >
<script type="text/javascript" src="${base}/resources/console/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript" src="${base}/resources/console/switch/bootstrap-switch.js"></script>
<script type="text/javascript">
	$().ready(function() {
	
		[@flash_message /]
		
	//上移
    $(".upIcon").click(function() {
        var $tr = $(this).parents("tr");
        if ($tr.index() == 1) {
            $.message("warn", "${message("console.appPoster.top")}");
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
            $.message("warn", "${message("console.appPoster.bottom")}");
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
	 
	//图片放大
	function showBigImge(url){
		var content= 
		'<div>'+
		'<img src="'+url+'"  width="300" />'+
		'</div>';
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
	
    //改变状态
	function changeStatus(id,status){
		$.ajax({
			type:"GET",
			url:"changeStatus.ct",
			data:{
				id:id,
				status:status,
			},
			success:function(){
				location.reload();
			}
		})
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
                    <h2>${message("console.coupon.list")} </h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="${base}/console/common/index.ct">${message("console.path.index")}</a>
                        </li>
                        <li>
                            <strong>${message("console.coupon.list")}  <span>(${message("console.page.total", page.total)})</span></strong>
                        </li>
                    </ol>
                </div>
                <div class="col-lg-2">
                </div>
            </div>
	       	<!-- end 头部面包屑区域 -->
	       
	        <!-- start 中间内容部分 -->
	        <div class="wrapper wrapper-content animated fadeIn">
				<!-- start  管理员列表管理 -->
				<form id="listForm" action="list.ct" method="get">
					<div class="row">
						<div class="col-lg-12">
	                        <div class="ibox float-e-margins">
	                            <div class="ibox-content">
	                                <div class="row">
	                                    <div class="col-sm-12 m-b-xs">
											<div class="btn-group">
		                                        [@shiro.hasPermission name = "console:addCoupon"]
													<a href="add.ct" class="btn btn-primary">
														<span class="addIcon">&nbsp;</span>${message("console.common.add")}
													</a>
												[/@shiro.hasPermission]
												[@shiro.hasPermission name = "console:deleteCoupon"]
													<a href="javascript:;" id="deleteButton" class="btn btn-primary disabled">
														<span class="deleteIcon">&nbsp;</span>${message("console.common.delete")}
													</a>
												[/@shiro.hasPermission]
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
											<div class="input-group pull-right">
												<form action="list.ct" method="get">
													<input type="text" name="couponName" value="${couponName}" class="input-sm form-control" style="width:119px;margin-top: 12px;" placeholder="搜索优惠劵名称">
													<input type="submit" class="btn btn-primary" value="搜索"/>
												</form>
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
													<a href="javascript:;" class="sort" name="name">${message("Coupon.name")}</a>
												</th>
												<th>
													<a href="javascript:;" class="sort" name="couponConver">${message("Coupon.couponConver")}</a>
												</th>
												<!--<th>
													<a href="javascript:;" class="sort" name="priceExpression">${message("Coupon.priceExpression")}</a>
												</th>
												<th>
														<a href="javascript:;" class="sort" name="point">${message("Coupon.point")}</a>
												</th>
												<th>
													<a href="javascript:;" class="sort" name="circulation">${message("Coupon.circulation")}</a>
												</th>
												<th>
														<a href="javascript:;" class="sort" name="limited">${message("Coupon.limited")}</a>
												</th>-->
												<th>
													<a href="javascript:;" class="sort" name="beginDate">${message("Coupon.useDate")}</a>
												</th>
												<th>
													<a href="javascript:;" class="sort">${message("Coupon.state")}</a>
												</th>
												<th>
													<a href="javascript:;" class="sort">${message("排序")}</a>
												</th>
												<th>
													<span>${message("console.common.handle")}</span>
												</th>
											</tr>
											[#list page.content as coupon]
												<tr>
													<td>
														<input type="checkbox" name="ids" value="${coupon.id}" />
													</td>
													<td>
														${coupon.name}
													</td>
													<td>
														<a href="javscript:;" onclick='showBigImge("${coupon.couponConver}")'>
													    	<img src="${coupon.couponConver}" style="width: 120px;"/>
														</a>
													</td>
													<!--<td>
														${coupon.couponPrice}
													</td>
													<td>
														${coupon.priceExpression}
													</td>
													<td>
														${coupon.point}
													</td>
													<td>
														${coupon.circulation}
													</td>
													<td>
														${coupon.limited}
													</td>-->
													<td>
														${message("开始时间")}：${coupon.beginDate}<br/>
														${message("结束时间")}：${coupon.endDate}
													</td>
													<td>
														[#if coupon.isEnabled == true]
															<a>${message("启用")}</a><br/>
														[#else]
															<a>${message("禁用")}</a><br/>
														[/#if]
													</td>
													<td>
														<a class="upIcon" posterOrder="${coupon.id}">${message("console.common.shiftUp")}</a><br/>
														<a class="downIcon" posterOrder="${coupon.id}">${message("console.common.shiftDown")}</a><br/>
													</td>
													<td>
														[@shiro.hasPermission name = "console:editCoupon"]
															<a href="edit.ct?id=${coupon.id}">[${message("console.common.edit")}]</a>
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
                </form>
	             <!-- end 管理员列表-->
	        </div>
	       <!-- end 中间内容部分-->
	       [#include "/console/include/footer.ftl" /]
  </div>
</div>
</body>
</html>