
$(document).ready(function () {
    $(".dropdown").mouseover(function () {

        $(this).addClass("open");

    });

    $(".dropdown").mouseleave(function () {

        $(this).removeClass("open");

    })

    $('#keyWordSearch').click(function () {
        var keyWord = $.trim($('#keyWord').val());
        if (keyWord == "") {
            toastr.warning("请输入搜索的关键字");
        } else {
            var address = "http://localhost:22256/admin/bookAdmin.aspx?method=findByBname&searchKeyWord=" + keyWord;
            $(window).attr('location', address);
        }
    })

    $('#search').click(function () {
        var bname = $.trim($('#searchBname').val());
        var author = $.trim($('#searchAuthor').val());
        var press = $.trim($('#searchPress').val());

        var address = "http://localhost:22256/admin/bookAdmin.aspx?method=findByContains&bname=" + bname + "&author=" + author + "&press=" + press;
        $(window).attr('location', address);
        $('#searchBname').val("");
        $('#searchAuthor').val("");
        $('#searchPress').val("");
    })

})

//加载二级分类
function loadChildren(mode,cid) {
    //获取pid
    var cidStr;
    var pidStr;
    if (mode == 1) {
        cidStr = "cid";
        pidStr = "pid";
    } else if (mode == 2) {
        cidStr = "_cid";
        pidStr = "_pid";
    }

    var pid = $('#' + pidStr).val();
    $.ajax({
        url: "bookAdmin.aspx?method=ajaxFindChild",
        data: { "pid": pid },
        type: "GET",
        dataType: "json",
        success: function (result) {
            if (result.status) {

                var jsonData = JSON.parse(result.data);
                $('#' + cidStr).empty();//清空子元素
                $('#' + cidStr).append($("<option>==请选择2级分类==</option>"));
                for (var i = 0; i < jsonData.length; i++) {
                    var option = $("<option>").val(jsonData[i].cid).text(jsonData[i].cname);
                    $('#' + cidStr).append(option);
                }
                if (mode == 2)
                    $('#' + cidStr).val(cid);
                
            } else {
                //失败请求操作
                messageWarming(result.msg, "");
            }
        }
    });
}

function passByValue(bid, bname, price, currPrice, discount, imgSrc, author, press, publictime, pageNum, edtion, printtime, wordNum, size, page, pid, cid) {
    $("#_name").val(bname);
    $("#_price").val(price);
    $("#_discount").val(discount);
    $("#_author").val(author);
    $("#_press").val(press);
    $("#_pageNum").val(pageNum);
    $("#_edtion").val(edtion);
    
    var arr = $.trim(publictime).split('-');
    if (arr[1] >= 1 && arr[1] <= 9)
        arr[1] = "0" + arr[1];
    if (arr[2] >= 1 && arr[2] <= 9)
        arr[2] = "0" + arr[2];
    var date = arr[0] + "-" + arr[1] + "-" + arr[2];
    $("#_publicTime").val(date);
    arr = $.trim(printtime).split('-');
    if (arr[1] >= 1 && arr[1] <= 9)
        arr[1] = "0" + arr[1];
    if (arr[2] >= 1 && arr[2] <= 9)
        arr[2] = "0" + arr[2];
    date = arr[0] + "-" + arr[1] + "-" + arr[2];
    $("#_printTime").val(date);
    $("#_wordNum").val(wordNum);
    $("#_paperSize").val(size);
    $("#_paper").val(page);
    $("#_pid").val(pid)
    loadChildren(2,cid);
    $("#renew").click(function () {
        editBook(bid, $('#_name').val(), $.trim($('#_price').val()), $.trim($('#_discount').val()), $('#_author').val(), $('#_press').val(), $('#_publicTime').val(), $.trim($('#_pageNum').val()), $.trim($('#_edtion').val()), $('#_printTime').val(), $.trim($('#_wordNum').val()), $.trim($('#_paperSize').val()), $('#_paper').val(), $('#_cid').val());

    })
}

function editBook(bid, bname, price, discount,author, press, publictime, pageNum, edtion, printtime, wordNum, size, page,cid) {
    $.ajax({
        url: "bookAdmin.aspx?method=edit",
        data: { "bid": bid, "bname": bname, "price": price, "discount": discount, "author": author, "press": press, "publictime": publictime, "pageNum": pageNum, "edtion": edtion, "printtime": printtime, "wordNum": wordNum, "size": size, "page": page, "cid": cid },
        type: "GET",
        dataType: "json",
        success: function (result) {
            if (result.status) {

                messageSuccess("修改成功！", "");
                $('#Name'+bid).text(bname);
                $('#OldPrice'+bid).text(price);
                $('#NewPrice'+bid).text(price*discount/10);
                
                $('#myModal').modal('hide');
            } else {
                //失败请求操作
                messageWarming(result.msg, "");
            }
        }
    });
}



//添加前检测是否有未输入
function addBookPre()
{
    var bname = $('#bname').val();
    var price = $.trim($('#price').val());
    var discount = $.trim($('#discount').val());
    var author = $('#author').val();
    var press = $('#press').val();
    var pid = $("#pid").val();
    var cid = $("#cid").val();
    var publicTime = $("#publicTime").val();
    var printTime = $("#printTime").val();
    var pageNum = $.trim($('#pageNum').val());
    var edtion = $("#edtion").val();
    var wordNum = $.trim($('#wordNum').val())
    var paperSize = $.trim($('#booksize').val());
    var paper = $("#paper").val();
    var file = $('#image_w').get(0).files[0];

    if (!bname || !price || !discount || !author || !press || !pid || !cid || !file || !publicTime || !printTime || !pageNum || !edtion || !wordNum || !paperSize || !paper) {
        messageWarming("警告", "所有信息必须填写完整");
        return false;
    }

    upload(bname, price, discount, author, press, publicTime, pageNum, edtion, printTime, wordNum, paperSize,paper, cid);
    
}

function addBook(bname, price, discount, author, press, publictime, pageNum, edtion, printtime, wordNum, size, page, cid, imgName) {
    $.ajax({
        url: "bookAdmin.aspx?method=addBook",
        data: { "bname": bname, "price": price, "discount": discount, "author": author, "press": press, "publictime": publictime, "pageNum": pageNum, "edtion": edtion, "printtime": printtime, "wordNum": wordNum, "size": size, "page": page, "cid": cid, "imgName": imgName },
        type: "GET",
        dataType: "json",
        success: function (result) {
            if (result.status) {
                $('#addModal').modal('hide');
                clearVal();
                messageSuccess("添加成功！", "");
            } else {
                //失败请求操作
                messageWarming(result.msg, "");
            }
        }
    });
}

//添加成功后清空信息
function clearVal() {
    $('#bname').val("");
    $('#price').val("");
    $('#discount').val("");
    $('#author').val("");
    $('#press').val("");
    $("#pid").val("");
    $("#cid").val("");
    $("#publicTime").val("");
    $("#printTime").val("");
    $('#pageNum').val("");
    $("#edtion").val("");
    $('#wordNum').val("")
    $('#booksize').val("");
    $("#paper").val("");
    $('#imgName').val("");
    $('#imgName').val("");
    $('#image_w').val("");
}

function showImg(){
    
    var file = $('#image_w').get(0).files[0];
    //创建用来读取此文件的对象
    var reader = new FileReader();
    //使用该对象读取file文件
    reader.readAsDataURL(file);
    //读取文件成功后执行的方法函数
    reader.onload=function(e){
        //读取成功后返回的一个参数e，整个的一个进度事件
        console.log(e);
        //选择所要显示图片的img，要赋值给img的src就是e中target下result里面
        //的base64编码格式的地址
        $('#img1').get(0).src = e.target.result;
    }
}

//图片上传请求
function upload(bname, price, discount, author, press, publicTime, pageNum, edtion, printTime, wordNum, paperSize,paper, cid) {
    var path = document.getElementById("image_w").value;
    var img = document.getElementById("img1");
    
    $("#form1").ajaxSubmit({
        success: function (str) {
            if (str != null && str != "undefined") {
                if(str == "1"){
                    messageWarming("警告", "图片分辨率不能超过350*350");
                }
                else if (str == "2") {
                    messageWarming("警告", "只能上传jpg格式的图片");
                }
                else if (str == "3") {
                    alert("图片不能大于1M");
                    messageWarming("警告", "图片不能大于1M");
                }
                else if (str == "4") {
                    messageWarming("警告", "请选择要上传的文件");
                }
                else {
                    //document.getElementById("img1").src = "../assets/images/book_img/" + str + "_b.jpg";
                    $('#imgName').val(str);
                    addBook(bname, price, discount, author, press, publicTime, pageNum, edtion, printTime, wordNum, paperSize,paper, cid, str);
                }
            }
            else
                messageWarming("警告", "操作失败");
        },
        url: 'Handler.ashx', /*设置post提交到的页面*/
        type: 'POST', /*设置表单以post方法提交*/
        dataType: 'text'/*设置返回值类型为文本*/
    });
}

function delBook(bid) {

    Swal.fire({
        title: '确定删除图书？',
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: '删除',
        cancelButtonText:'取消'
    }).then((result) => {
        if (result.value) {
                deleteB(bid);
        }
    })
}

function deleteB(bid){
    $.ajax({
        url: "bookAdmin.aspx?method=delete",
        data: { "bid": bid },
        type: "GET",
        dataType: "json",
        success: function (result) {
            if (result.status) {
                messageSuccess("删除图书成功！", "");
                $('#View'+bid).remove();
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