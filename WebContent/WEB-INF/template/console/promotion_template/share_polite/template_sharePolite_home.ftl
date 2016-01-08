<!DOCTYPE html>
<html>
<head>
<title>分享有礼红包领取</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="福州盛云汇" />
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width,height=device-height" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<meta name="format-detection" content="telephone=no" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/jquery.tools.js"></script>
<link href="${base}/resources/console/css/style_sharepolite.css" rel="stylesheet" type="text/css" />

</head>
<body>
    <!--页眉开始-->
    <div id="header">
    </div>
    <div id="content">
        <div class="main_get">
            <img src="${base}/resources/console/images/share_bg.png"/>
            <div class="red_envelope_amount_bg">
                <img src="${base}/resources/console/images/red_package.png"/>
                [#if isExpired]
                    <div class="money_unit"><span></span></div>
                    <div class="money" style="font-size:50px;margin-top:13%;margin-left:40%"><span>已过期</span></div>
                    <div class="tips"><span></span></div>
                [#else]
                    <div class="money_unit"><span>￥</span></div>
	                <div class="money"><span>${coupon.couponPrice}</span></div>
	                <div class="tips"><span>红包已放入账户，快去使用吧。不要过期哦~</span></div>
                [/#if]
                <div class="center_get">
	                <a href="http://a.app.qq.com/o/simple.jsp?plg_nld=1&plg_auth=1&plg_vkey=1&plg_usr=1&plg_uin=1&pkgname=com.sammyun.xiaoshutong&plg_dev=1&plg_nld=1"><div class="button"><span>下载使用</span></div></a>
	                <div class="rules">
	                <img src="${base}/resources/console/images/rules.png"/>
		            </div>
		            
		            <div class="rules_desc">
		                <p>1.红包新老用户同享</p>
		                <p>2.使用红包时的手机号码必须为抢红包时的手机号码</p>
		                <p>3.本活动的最终解释权归爱柚米所有</p>
		            </div>
	            </div>
            </div>
        </div>
    </div>
    <!--页脚开始-->
	<div id="footer">
	</div>
	<!--页脚结束-->
</body>
</html>