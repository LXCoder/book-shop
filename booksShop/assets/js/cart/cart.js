

$(function () {


    $('#jiesuan').on("click", function (e) {
        jiesuan();
    });

    $('#batchDelete').on("click", function (e) {
        getCartItemIds();
    });

    //删除
    $('.delete').click(function () {
        var id = $(this).prop('id').substring(0, 32);
        var price = $('#' + id + 'Price').text();
        var subtotal = $('#indexSutotal').text();
        subtotal = subtotal - price;
        
        $.ajax({
            url: "cart.aspx?method=batchDelete",
            data: { "cartItemIds": id, "flag": "false" },
            type: "GET",
            dataType: "json",
            success: function (result) {
                if (result.status) {
                    $('#indexSutotal').text(subtotal.toFixed(2));
                    $('#indexSutotal2').text(subtotal.toFixed(2));
                    $('#indexCount').text(Number($('#indexCount').text()) - 1);
                    $('#' + id + 'View').remove();
                } 
            }
        });
    })

    showTotal();

    //给全选框添加事件
    $('#selectAll').click(function () {
        //获取该复选框的状态
        var bool = $(this).prop('checked')
        //同步所有条目的复选框与全选的状态
        setItemCheckBox(bool);
        //同步结算按钮与全选
        setJieSuan(bool);
        //计算总计
        showTotal();
    });

    //统一设置全选/全不选
    function setItemCheckBox(bool) {
        $(":checkbox[name=checkboxBtn]").prop("checked", bool);
    }

    //给所有条目的复选框添加事件
    $(":checkbox[name=checkboxBtn]").click(function () {
        var allCount = $(":checkbox[name=checkboxBtn]").length;
        var selectCount = $(":checkbox[name=checkboxBtn]:checked").length;
        if (allCount == selectCount) {
            $("#selectAll").prop("checked", true);
            setJieSuan(true);//同步结算按钮与全选
        } else if (selectCount == 0) {
            $("#selectAll").prop("checked", false);
            setJieSuan(false);
        } else {
            $("#selectAll").prop("checked", false);
            setJieSuan(true);
        }
        //计算总计
        showTotal();
    });
})

//加入购物车
function buy(bid, flag) {
    var num = 1;
    if (flag)
        num = $('#bookQuantity').val();
    $.ajax({
        url: "cart.aspx?method=add",
        data: { "bid": bid, "quantity": num },
        type: "GET",
        dataType: "json",
        success: function (result) {
            if (result.status) {
                
                toastr.success(result.msg);
                
                var jsonData = JSON.parse(result.data);
                
                if (jsonData.exit == 1) {
                    var sub = Number($("#" + jsonData.id + "Price").text()) + Number(jsonData.subtotal);
                    var qty = Number($("#" + jsonData.id + "IndexQuantity").text()) + Number(jsonData.quantity);
                    $('#' + jsonData.id + 'Price').text(sub);
                    $('#' + jsonData.id + 'IndexQuantity').text(qty);
                } else if (jsonData.exit == 0) {
                    var divView = "<div id='" + jsonData.id + "View' class='cart-float-single-item d-flex'><span class='remove-item' ><a id='" + jsonData.id + "Close' class='delete'><i class='icon ion-md-close'></i></a></span><div class='cart-float-single-item-image'><a href='single-product.aspx?method=findByBid&bid=" + bid + "'><img src='assets/images/" + jsonData.image_b + "' class='img-fluid' alt=''></a></div><div class='cart-float-single-item-desc'><p class='product-title'><a href='single-product.aspx?method=findByBid&bid=" + bid + "'>" + jsonData.bname + "</a></p><p class='quantity'>数量: <span id='" + jsonData.id + "IndexQuantity'>" + jsonData.quantity + "</span></p><p class='price'>&yen;<span id='" + jsonData.id + "Price'>" + jsonData.subtotal + " </span></p></div></div>"
                    $('#indexCart').after(divView);
                    $('#indexCount').text(Number($('#indexCount').text()) + 1);
                }

                var subtotal = $('#indexSutotal').text() + jsonData.subtotal;
                $('#indexSutotal').text(subtotal.toFixed(2));
                $('#indexSutotal2').text(subtotal.toFixed(2));
                

            } else {
                toastr.warning(result.msg);
            }
        },
        error: function (xhr, state, errorThrown) {
            var status = xhr.status;
            if (status) {
                showNotify("error", "网络错误", "发生网络错误，错误码为：" + xhr.status);
            } else {
                showNotify("error", "网络错误", "未知网络错误, 请确保设备处在联网状态");
            }
        }

    });
}

//请求服务器，修改数量。
function sendUpdateQuantity(id, quantity,bid) {
    $.ajax({
        url: "cart.aspx?method=updateQuantity",
        data: { "cartItemId": id, "quantity": quantity,"bid":bid },
        type: "GET",
        dataType: "json",
        success: function (result) {
            if (result.status) {
                var jsondata = JSON.parse(result.data);
                $("#" + id + "Subtotal").text(jsondata.subtotal);
                $("#" + id + "indexSutotal2").text(jsondata.subtotal);
                $("#" + id + "indexSutotal").text(jsondata.subtotal);
                $("#" + id + "View").remove();
                //3. 重新计算总计
                showTotal();
            } else {
                //toastr.warning(result.msg);
                //toastr.warning(result.msg);
                //toastr.warning(result.msg);
                $("#" + id + "Qty").val(quantity-1);
                
                Swal.fire({
                    type: 'error',
                    title: result.msg,
                    text: '',
                })
            }
        }
    });
}

//设置结算状态
function setJieSuan(bool) {
    var jiesuanBtn = $("#jiesuan");
    if (bool) {
        jiesuanBtn.removeAttr('disabled');
        //给该对象绑定点击事件
        jiesuanBtn.on("click", function () {
            jiesuan();
        });

    } else {
        jiesuanBtn.prop('disabled', 'disabled');
        //删除该对象绑定的点击事件
        jiesuanBtn.off("click");
    }
}

//结算
function jiesuan() {
    // 1. 获取所有被选择的条目的id，放到数组中
    var cartItemIdArray = new Array();
    $(":checkbox[name=checkboxBtn]:checked").each(function () {
        cartItemIdArray.push($(this).val());//把复选框的值添加到数组中
    });
    var address = "http://localhost:22256/cart.aspx?method=loadCartItems&cartItemIds=" + cartItemIdArray.toString() + "&subtotal=" + $("#total").text();
    $(window).attr('location', address);
}

//计算购物车的总价格
function showTotal() {
    var total = 0;
    //获得所有勾选的复选框
    $(":checkbox[name=checkboxBtn]:checked").each(function () {
        //获取复选框的id
        var id = $(this).val();
        //获得每个条目的的总价格
        var text = $("#" + id + "Subtotal").text();
        //价格累加
        total += Number(text);
    });
    //显示在总价格上
    $("#total").text(total.toFixed(2));
}

//获选选中条目的cartItemId
function getCartItemIds() {
    var cartItemArr = new Array();
    $(":checkbox[name=checkboxBtn]:checked").each(function () {
        //获取复选框的id
        var id = $(this).val();
        cartItemArr.push(id);
    });

    var address = "http://localhost:22256/cart.aspx?method=batchDelete&cartItemIds=" + cartItemArr + "&flag=true";
    $(window).attr('location', address);
}

function isDelete(id) {
    Swal({
        title: '您确定要删除该商品吗?',
        text: "",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: '确定删除',
        cancelButtonText: "取消",
    }).then(function (result) {
        if (result.value) {
            Swal(
              '删除成功',
              '商品已删除',
              'success'
            ).then(function (result) {
                var address = "http://localhost:22256/cart.aspx?method=batchDelete&cartItemIds=" + id +"&flag=true";
                $(window).attr('location', address);
            })
        } else {
            $("#" + id + "Qty").val(1);
        }
    })
}