

function cancel(oid)
{
    $.ajax({
        url: "orderAdmin.aspx?method=cancel",
        data: { "oid": oid},
        type: "GET",
        dataType: "json",
        success: function (result) {
            if (result.status) {
                $('#' + oid + "cancel").remove();
                messageSuccess(result.msg);
            } else {
                //失败请求操作
                messageWarming(result.msg, "");
            }
        }
    });
}

function deliver(oid)
{
    $.ajax({
        url: "orderAdmin.aspx?method=deliver",
        data: { "oid": oid },
        type: "GET",
        dataType: "json",
        success: function (result) {
            if (result.status) {
                $('#' + oid + "deliver").remove();
                messageSuccess(result.msg);
            } else {
                //失败请求操作
                messageWarming(result.msg, "");
            }
        }
    });
}

function messageWarming(tle, message) {
    Swal.fire({
        type: 'error',
        title: tle,
        text: message,
    })
}

function messageSuccess(tle) {
    Swal.fire({
        position: 'top-end',
        type: 'success',
        title: tle,
        showConfirmButton: false,
        timer: 1500
    })
}