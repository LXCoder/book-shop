
$(function () {
    
    /*
	 * 1. 让登录按钮在得到和失去焦点时切换图片
	 */
    $("*[id$=submit]").hover(
		function () {
		    $("*[id$=submit]").attr("color", "#000000");
		},
		function () {
		    $("*[id$=submit]").attr("color", "#ffffff");
		}
	);

    //得到所有的错误信息，循环遍历之。调用一个方法来确定是否显示错误信息！
    $(".labelError").each(function () {
        showError($(this));//遍历每个元素，使用每个元素来调用showError方法
    });

    //输入框得到焦点,就隐藏错误信息，反之则否
    $(".mb-0").focus(function () {
        var lableId = $(this).attr("id") + "Error";
        lableId = lableId.substring(20);
        $("#" + lableId).text("");
        showError($("#" + lableId));
    });

    //输入框失去焦点,就检验
    $(".mb-0").blur(function () {
        var id = $(this).attr("id");
        var funName = "validate" + id.substring(20, 21).toUpperCase() + id.substring(21) + "()";
        eval(funName);
    });

    //提交时全部输入框校验
    $("*[id$=submit]").click(function () {
        var flag = true;
        if (!validateLoginname()) {
            flag = false;
        }
        if (!validateLoginpass()) {
            flag = false;
        }
        if (!validateVerifyCode()) {
            flag = false;
        }
        return flag;
    });
});



//用户名校验
function validateLoginname() {
    var id = "loginname";
    var value = $("*[id$=loginname]").val();
    //非空校验
    if (!value) {
        $("#" + id + "Error").text("用户名不能为空！");
        showError($("#" + id + "Error"));
        return false;
    }
    //长度校验
    if (value.length < 3 || value.length > 20) {
        $("#" + id + "Error").text("用户名长度要在3~20之间！");
        showError($("#" + id + "Error"));
        return false;
    }
    return true;
}


//密码校验
function validateLoginpass() {
    var id = "loginpass";
    var value = $("*[id$=loginpass]").val();
    //非空校验
    if (!value) {
        $("#" + id + "Error").text("密码不能为空！");
        showError($("#" + id + "Error"));
        return false;
    }
    //长度校验
    if (value.length < 3 || value.length > 20) {
        $("#" + id + "Error").text("密码长度要在3~20之间！");
        showError($("#" + id + "Error"));
        return false;
    }
    return true;

}

//验证码校验
function validateVerifyCode() {
    var id = "verifyCode";
    var value = $("*[id$=verifyCode]").val();
    //非空校验
    if (!value) {
        $("#" + id + "Error").text("验证码不能为空！");
        showError($("#" + id + "Error"));
        return false;
    }
    //长度校验
    if (value.length != 4) {
        $("#" + id + "Error").text("验证码长度为4位！");
        showError($("#" + id + "Error"));
        return false;
    }

    $.ajax({
        url: "login.aspx/ajaxValidateVerifyCode",
        //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字  
        data: "{'verifyCode':'" + value + "'}",
        type: "Post",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            if (!result.d) {
                $("#" + id + "Error").text("验证码不正确！");
                showError($("#" + id + "Error"));
                return false;
            }
        }

    });
    return true;

}

//判断当前元素是否存在内容，如果存在显示，不页面不显示！
function showError(ele) {

    var text = ele.text();
    if (!text) {
        ele.css("display", "none");
    } else {
        ele.css("display", "");
    }
}


