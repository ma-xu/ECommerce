<!DOCTYPE html>
<html>
<head>
<title>分享有礼注册</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="福州盛云汇" />
<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no,width=320,target-densitydpi=142" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<meta name="format-detection" content="telephone=no" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
[#include "/console/include/resources.ftl" /]
<script type="text/javascript" src="${base}/resources/console/js/jquery.tools.js"></script>
<link href="${base}/resources/console/css/style_sharepolite.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
function submit()
{
    var telephoneNum = $("#telephoneNum").val();; //获取手机号
	var telReg = !!telephoneNum.match(/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/);
	if(!telephoneNum)
	{
	    alert("手机号码不能为空！");
	    $("#telephoneNum").focus();
	    return false;
	}
	else if(telReg == false)//如果手机号码不能通过验证
	{
        alert("手机号码格式不对！");
        $("#telephoneNum").focus();
        return false;
    }else
    {
        $.ajax({
				url: "getInCouponGift.ct",
				type: "GET",
				data: {
				    telephoneNum:telephoneNum,
				    couponId:'${coupon.id}',
				    dictSchoolId:'${dictSchool.id}',
				    memberId:'${member.id}' 
				},
				dataType: "json",
				cache: false,
				success: function(data) {
					if (data.success == "0") {
					    window.location.href = '${base}/gotoDownLoad.ct?couponId=${coupon.id}'
					}else{
					    alert(data.message);
					}
				}
			});
    }
}
</script>

</head>
<body>
    <!--页眉开始-->
    <div id="header">
    </div>
    <div id="content">
        <div class="main">
            <img src="${base}/resources/console/images/pre_get_bg.png"/>
            <div class="center">
                <div class="number"><input id="telephoneNum" name="telephoneNum" type="number" placeholder="请输入您的手机号"/></div></a>
                <a href="javascripit:;" onclick="submit()"><div class="button"><span>马上领取</span></div></a>
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
    <!--页脚开始-->
	<div id="footer">
	</div>
	<!--页脚结束-->
</body>
</html>