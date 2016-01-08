<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${message("优惠券码列表")} - 爱柚米 • 移动营销平台</title>
<meta name="author" content="福州盛云软件技术有限公司 Team" />
<meta name="copyright" content="福州盛云软件技术有限公司" />
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/console/js/list.js"></script>
<script type="text/javascript">
$().ready(function() {
	[@flash_message /]
	
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
                    <h2>${message("优惠券码列表")}</h2>
                    <ol class="breadcrumb">
                        <li>
                            <a href="${base}/console/common/index.ct">${message("console.path.index")}</a>
                        </li>
                        <li>
                           <strong>${message("优惠券码列表")} <span>(${message("console.page.total", page.total)})</span></strong>
                        </li>
                    </ol>
                </div>
                <div class="col-lg-2">
                
                </div>
            </div>
	        <!-- end 头部面包屑区域 -->
	       
	        <!-- start 中间内容部分 -->
	        <div class="wrapper wrapper-content animated fadeIn">
	             <!-- start  地区管理 -->
	             <form id="listForm" action="list.ct" method="get">
                	<div class="row">
	           	 		<div class="col-lg-12">
	                    	<div class="ibox float-e-margins">
	                            <div class="ibox-content">
	                                <div class="row">
	                                    <div class="col-sm-14 m-b-xs">
		                                    <div class="btn-group">
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
											<div class="input-group pull-right">
												<input type="text" name="codeNum" value="${codeNum}" class="input-sm form-control" style="width:100px;margin-top: 12px;" placeholder="优惠券码">
												<input type="text" name="couponName" value="${couponName}" class="input-sm form-control" style="width:150px;margin-top: 12px;" placeholder="优惠券名称">
												<input type="text" name="memberName" value="${memberName}" class="input-sm form-control" style="width:150px;margin-top: 12px;" placeholder="使用者姓名">
												<input type="submit" class="btn btn-primary" value="搜索"/>
											</div>
	                                    </div>
	                                </div>
	                                <div class="table-responsive">
	                                     <div class="table-responsive">
		                                     <table id="listTable" class="table table-striped">
												<tr>
													<th>
														<a href="javascript:;" class="sort" name="code">${message("优惠券码")}</a>
													</th>
													<th>
														<a href="javascript:;" class="sort" name="isUsed">${message("是否使用")}</a>
													</th>
													<th>
														<a href="javascript:;" class="sort" name="usedDate">${message("使用日期")}</a>
													</th>
													<th>
														<a href="javascript:;" class="sort" name="coupon">${message("优惠券名称")}</a>
													</th>
													<th>
														<a href="javascript:;" class="sort" name="member">${message("使用者姓名")}</a>
													</th>
												</tr>
												[#list page.content as couponCode]
													<tr>
														<td>
															${couponCode.code}
														</td>
														<td>
															[#if couponCode.isUsed]是
															[#else]否
															[/#if]
														</td>
														<td>
															[#if couponCode.usedDate??]
															<span title="${couponCode.usedDate?string("yyyy-MM-dd HH:mm:ss")}">${couponCode.usedDate}</span>
															[/#if]
														</td>
														<td>
															${couponCode.coupon.name}
														</td>
														<td>
															${couponCode.member.realName}
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
                </form>
             	<!-- end 地区管理 -->
	        </div>
	       <!-- end 中间内容部分-->
	       [#include "/console/include/footer.ftl" /]
  </div>
</div>
</body>
</html>