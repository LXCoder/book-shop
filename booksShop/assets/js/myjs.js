
$(function () {

    var page = window.location.pathname;

    if (page.indexOf("index.aspx") != -1) {
        $('#homeMenu').addClass("active");

    } else if (page.indexOf("shop.aspx") != -1) {
        $('#shopMenu').addClass("active");
    } else if (page.indexOf("contact.aspx") != -1) {
        $('#contactMenu').addClass("active");
    }

    $('.xingji').each(function (i) {
        $(this).click(function (e) {
            if ($(this).children('i').hasClass("ion-md-heart") == 0)
            {
                collected($(this).children('input').val(),$(this));
            }
        })
    })
})

//收藏
function collected(bid,dom)
{
    $.ajax({
        url: "shop.aspx?method=collected",
        data: { "bid": bid},
        type: "GET",
        dataType: "json",
        success: function (result) {
            if (result.status) {
                dom.children('i').removeClass("ion-md-heart-empty")
                dom.children('i').addClass("ion-md-heart");
                dom.children('i').addClass("activexing");
            } else {
                Swal(
                  '错误',
                  result.msg,
                  'error'
                )
                
            }
        }
    });
}

window.onload = function () {
    //定时器每秒调用一次fnDate()
    setInterval(function () {
        fnDate();
    }, 1000);
}

//js 获取当前时间
function fnDate() {
    var oDiv = document.getElementById("currenTime");
    var date = new Date();
    var year = date.getFullYear();//当前年份
    var month = date.getMonth();//当前月份
    var data = date.getDate();//天
    var hours = date.getHours();//小时
    var minute = date.getMinutes();//分
    var second = date.getSeconds();//秒
    var time = year + "-" + fnW((month + 1)) + "-" + fnW(data) + " " + fnW(hours) + ":" + fnW(minute) + ":" + fnW(second);
    oDiv.innerHTML = time;
}
//补位 当某个字段不是两位数时补0
function fnW(str) {
    var num;
    str > 10 ? num = str : num = "0" + str;
    return num;
}

toastr.options.positionClass = 'toast-center-center';


//添加购物车功能的参数传递
function passByValue(bid, bname, price, currPrice, discount, imgSrc, author, press, publictime, pageNum, edtion, printtime, wordNum, size, page) {
    $("#bookImg").attr("src", "assets/images/" + imgSrc);
    $("#bookName").text(bname);
    $("#bookCurrPrice").text("¥" + currPrice);
    $("#bookPrice").text("¥" + price);
    $("#bookDiscount").text(discount + "折");
    $("#bookAuthor").text("作者：" + author + " 著");
    $("#bookPress").text("出版社：" + press);
    $("#bookPublictime").text("出版时间：" + publictime);
    $("#bookPageNum").text("页数：" + pageNum);
    $("#bookEdtion").text("版次：" + edtion);
    $("#bookPrinttime").text("印刷时间：" + printtime);
    $("#bookWordnum").text("字数：" + wordNum);
    $("#bookSize").text("开本：" + size);
    $("#bookPage").text("纸张：" + page);
    $("#buyBook").click(function () {
        buy(bid, 'true');
    })
}



/*function textUp(e, time, heightUp) {
    
    var $i = $('<span />').text("+1");
    var xx = e.pageX || e.clientX + document.body.scroolLeft;
    var yy = e.pageY || e.clientY + document.body.scrollTop;

    $('body').append($i);
    $i.css({
        top: yy,
        left: xx,
        color: '#9acf6a',
        transform: 'translate(-50%, -50%)',
        display: 'block',
        position: 'absolute',
        zIndex: 999999999999
    })
    $i.animate({
        top: yy - (heightUp ? heightUp : 200),
        opacity: 0
    }, time, function () {
        $i.remove();
    })
}*/