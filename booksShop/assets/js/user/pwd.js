$(function () {

    //得到所有的错误信息，循环遍历之。调用一个方法来确定是否显示错误信息！
    $(".labelError").each(function () {
        showError($(this));//遍历每个元素，使用每个元素来调用showError方法
    });

    //输入框得到焦点,就隐藏错误信息，反之则否
    $(".mb-0").focus(function () {
        var lableId = $(this).attr("id") + "Error";
        
        $("#" + lableId).text("");
        showError($("#" + lableId));
    });

    //输入框失去焦点,就检验
    $(".mb-0").blur(function () {
        var id = $(this).attr("id");
        var funName = "validate" + id.substring(0, 1).toUpperCase() + id.substring(1) + "()";
        eval(funName);
    });

    toastr.options.positionClass = 'toast-top-right';

    //提交时全部输入框校验
    $("#submit").click(function () {
        var flag = true;
        if (!validateLoginpass()) {
            flag = false;
        }
        if (!validateNewpass()) {
            flag = false;
        }
        if (!validateReloginpass()) {
            flag = false;
        }
        if (flag)
        {
            var loginpass = $('#loginpass').val();
            var newpass = $('#newpass').val();
            var reloginpass = $('#reloginpass').val();
            $.ajax({
                url: "myAccount.aspx?method=updatePassword",
                data: { "loginpass": loginpass, "newpass": newpass, "reloginpass": reloginpass },
                type: "GET",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    if (result.status) {
                        toastr.success(result.msg);            
                    } else {
                        toastr.error(result.msg);
                    }
                    $('#loginpass').val("");
                    $('#newpass').val("");
                    $('#reloginpass').val("");
                },
                error: function (xhr, state, errorThrown) {
                    alert("errorThrown");
                    var status = xhr.status;
                    if (status) {
                        showNotify("error", "网络错误", "发生网络错误，错误码为：" + xhr.status);
                    } else {
                        showNotify("error", "网络错误", "未知网络错误, 请确保设备处在联网状态");
                    }
                }

            });
        }
    });
});

/*
 * 输入input名称，调用对应的validate方法。
 * 例如input名称为：loginname，那么调用validateLoginname()方法。
 */
function invokeValidateFunction(inputName) {
    inputName = inputName.substring(0, 1).toUpperCase() + inputName.substring(1);
    var functionName = "validate" + inputName;
    return eval(functionName + "()");
}



//密码校验
function validateLoginpass() {
    var id = "loginpass";
    var value = $("#" + id).val();
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

//新密码校验
function validateNewpass() {
    var id = "newpass";
    var value = $("#" + id).val();
    //非空校验
    if (!value) {
        $("#" + id + "Error").text("新密码不能为空！");
        showError($("#" + id + "Error"));
        return false;
    }
    //长度校验
    if (value.length < 3 || value.length > 20) {
        $("#" + id + "Error").text("新密码长度要在3~20之间！");
        showError($("#" + id + "Error"));
        return false;
    }
    return true;

}


//校验确认密码
function validateReloginpass() {
    var id = "reloginpass";
    var value = $("#" + id).val();
    //非空校验
    if (!value) {
        $("#" + id + "Error").text("新密码不能为空！");
        showError($("#" + id + "Error"));
        return false;
    }
    //长度校验
    if (value != $("#newpass").val()) {
        $("#" + id + "Error").text("两次密码输入不一致！");
        showError($("#" + id + "Error"));
        return false;
    }
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