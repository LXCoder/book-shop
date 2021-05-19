

function load()
{
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler); 
}

//添加、修改分类的操作
function category_passVal(cid, pid, mode) {
    //mode:1表示添加一级分类；2表示编辑一级分类；3表示添加二级分类；4表示编辑二级分类
    cid = $.trim(cid);
    pid = $.trim(pid);
    var cname = $.trim($('#Cname' + cid).text());
    var desc = $.trim($('#Cname' + cid).attr("title"));
    if (mode == 1 || mode == 2) {
        if (mode == 1) {
            $("#model_title1").text("添加一级分类");
            $("#add_category1").removeClass("hidden");
            $("#edit_category1").addClass("hidden");
            $("#category_cname1").val("");
            $("#category_desc1").val("");
            $("#add_category1").click(function () {
                if($.trim($("#category_cname1").val()) != "" && $.trim($("#category_desc1").val()) != "")
                    addCategory1($("#category_cname1").val(), $("#category_desc1").val());
                else
                    messageWarming("信息不能为空","请输入信息！");
            })
        } else if (mode == 2) {
            $("#model_title1").text("修改一级分类");
            $("#edit_category1").removeClass("hidden");
            $("#add_category1").addClass("hidden");
            $("#category_cname1").val(cname);
            $("#category_desc1").val(desc);
            $("#edit_category1").click(function () {
                if($.trim($("#category_cname1").val()) != "" && $.trim($("#category_desc1").val()) != "")
                    editCategory1(cid, $("#category_cname1").val(), $("#category_desc1").val());
                else
                    messageWarming("信息不能为空","请输入信息！");
            })
        }
    } else if (mode == 3 || mode == 4) {
        desc = $.trim($('#Desc' + cid).text());
        if (mode == 3) {
            $("#model_title2").text("添加二级分类");
            $("#add_category2").removeClass("hidden");
            $("#edit_category2").addClass("hidden");
            $("#category_cname2").val("");
            $("#category_desc2").val("");
            $("#pid").val("0");
            $("#add_category2").click(function () {
                if($.trim($("#category_cname2").val()) != "" && $.trim($("#category_desc2").val()) != "" && $("#pid").val() != 0)
                    addCategory2($("#pid").val(), $("#category_cname2").val(), $("#category_desc2").val());
                else
                    messageWarming("信息不能为空","请输入信息！");
            })
        } else if (mode == 4) {
            $("#model_title2").text("修改二级分类");
            $("#edit_category2").removeClass("hidden");
            $("#add_category2").addClass("hidden");
            $("#category_cname2").val(cname);
            $("#category_desc2").val(desc);
            $("#pid").val(pid);
            $("#edit_category2").click(function () {
                if($.trim($("#category_cname2").val()) != "" && $.trim($("#category_desc2").val()) != "" && $("#pid").val() != 0)
                    editCategory2(cid,pid, $("#pid").val(), $("#category_cname2").val(), $("#category_desc2").val());
                else
                    messageWarming("信息不能为空","请输入信息！");
            })
        }
    }
}

function messageWarming(tle,message)
{
    Swal.fire({
        type: 'error',
        title: tle,
        text: message,
    })
}

function messageSuccess(tle)
{
    Swal.fire({
        position: 'top-end',
        type: 'success',
        title: tle,
        showConfirmButton: false,
        timer: 1500
    })
}


//删除分类
function category_delete(cid,mode)
{
    var str = "";
    if (mode == 1)
    {
        str = "您是否真要删除该一级分类？";
    } else if (mode == 2)
    {
        str = "您是否真要删除该二级分类？";
    }

    Swal.fire({
        title: str,
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: '删除',
        cancelButtonText:'取消'
    }).then((result) => {
        if (result.value) {
                deleteC(cid,mode);
        }
    })
}

function deleteC(cid,mode)
{
    var requestUrl;

    if (mode == 1)
    {
        requestUrl = "categoryAdmin.aspx?method=deleteParent";
    } else if (mode == 2)
    {
        requestUrl = "categoryAdmin.aspx?method=deleteChild";
    }

    $.ajax({
        url: requestUrl,
        data: { "cid": cid },
        type: "GET",
        dataType: "json",
        success: function (result) {
            if (result.status) {
                var jsonData = JSON.parse(result.data);
                if(jsonData.flag == 1)
                {
                    messageSuccess(jsonData.msg,"");
                    $('#Unit'+cid).remove();
                    if(mode == 1)
                        $("#pid option[value='"+cid+"']").remove();
                }else
                {
                    messageWarming(jsonData.msg,"");
                }
            } else {
                messageWarming(result.msg,"");
            }
        }
    });
}

//修改一级分类
function editCategory1(cid,cname,desc) {
    $.ajax({
        url: "categoryAdmin.aspx?method=editParent",
        data: { "cid": cid, "cname": cname,"desc":desc },
        type: "GET",
        dataType: "json",
        success: function (result) {
            if (result.status) {
                //成果请求后操作
                $('#Cname' + cid).text(cname);
                $('#Cname' + cid).attr("title",desc);
                messageSuccess("修改成功");
                $('#addModal1').modal('hide');
            } else {
                //失败请求操作
                messageWarming(result.msg,"");
            }
        }
    });
}



function addCategory1(cname,desc) {
    $.ajax({
        url: "categoryAdmin.aspx?method=addParent",
        data: { "cname": cname,"desc":desc },
        type: "GET",
        dataType: "json",
        success: function (result) {
            if (result.status) {
                //成果请求后操作
                var jsonData = JSON.parse(result.data);
                var strHtml="<div class='panel panel-default' id='Unit"+jsonData.cid+"'><div class='panel-heading'><div class='row'><div class='col-8'><h4 class='panel-title'><a  id='Cname"+jsonData.cid+"' data-toggle='collapse' data-parent='#accordion' href='#collapse"+jsonData.cid+"'title='"+desc+"'>"+cname+"</a></h4></div><div class='col-4'><a data-toggle='modal' data-target='#addModal2' onclick='category_passVal(0,0,3)'><i class='fa fa-plus fa-2x' title='添加二级分类'></i></a><a id='edit"+ jsonData.cid +"' data-toggle='modal' data-target='#addModal1'><i class='fa fa-edit fa-2x' title='修改'></i></a><a id='del"+ jsonData.cid +"'><i class='fa fa-trash fa-2x' title='删除'></i></a></div></div></div><div id='collapse"+jsonData.cid+"' class='panel-collapse collapse'><div class='panel-body'><table class='table table-condensed mytable'><tbody></tbody></table></div></div></div>"
                //var strHtml = "<tr id='Unit"+ jsonData.cid +"' class='success oneLevel'><td id='Cname"+ jsonData.cid +"'>"+cname+"</td><td id='Desc"+jsonData.cid+"'>"+desc+"</td><td><a data-toggle='modal' data-target='#addModal2' onclick='category_passVal(0,0,3)'><i class='fa fa-plus fa-2x' title='添加二级分类'></i></a><a id='edit"+ jsonData.cid +"' data-toggle='modal' data-target='#addModal2'><i class='fa fa-edit fa-2x' title='修改'></i></a><a id='del"+ jsonData.cid +"'><i class='fa fa-trash fa-2x' title='删除'></i></a></td></tr>"
                $('#accordion').append(strHtml);
                
                $('#pid').append("<option value='"+jsonData.cid+"'>"+cname+"</option>");
                $('#edit'+jsonData.cid).click(function(){
                    category_passVal(jsonData.cid,0,2);
                })
                $('#del'+jsonData.cid).click(function(){
                    category_delete(jsonData.cid,1);
                })
                messageSuccess("添加成功");
                $('#addModal1').modal('hide');
            } else {
                //失败请求操作
                messageWarming(result.msg,"");
            }
        }
    });
}



function addCategory2(pid,cname,desc) {
    $.ajax({
        url: "categoryAdmin.aspx?method=addChild",
        data: { "cname": cname,"desc":desc ,"pid":pid},
        type: "GET",
        dataType: "json",
        success: function (result) {
            if (result.status) {
                //成果请求后操作
                var jsonData = JSON.parse(result.data);
                var strHtml = "<tr id='Unit"+ jsonData.cid +"' ><td id='Cname"+ jsonData.cid +"'>"+cname+"</td><td id='Desc"+jsonData.cid+"'>"+desc+"</td><td><a id='edit"+ jsonData.cid +"' data-toggle='modal' data-target='#addModal2'><i class='fa fa-edit fa-2x' title='修改'></i></a><a id='del"+ jsonData.cid +"'><i class='fa fa-trash fa-2x' title='删除'></i></a></td></tr>"
                $('#Table'+pid).append(strHtml);
                $('#edit'+jsonData.cid).click(function(){
                    category_passVal(jsonData.cid,pid,4);
                })
                $('#del'+jsonData.cid).click(function(){
                    category_delete(jsonData.cid,2);

                })
                messageSuccess("添加成功");
                $('#addModal2').modal('hide');
            } else {
                //失败请求操作
                messageWarming(result.msg,"");
            }
        }
    });
}

function editCategory2(cid,oldPid,pid,cname,desc)
{
    $.ajax({
        url: "categoryAdmin.aspx?method=editChild",
        data: { "cid": cid ,"cname": cname,"desc":desc ,"pid":pid},
        type: "GET",
        dataType: "json",
        success: function (result) {
            if (result.status) {
                //成果请求后操作
                $('#Cname' + cid).text(cname);
                $('#Desc' + cid).text(desc);
                if(oldPid != pid)
                {
                    var $tr = $('#Unit'+cid);
                    if($tr.index() != 0)
                    {
                        var strHtml = $tr.html();
                        $tr.remove();
                        $('#Table'+pid).append(strHtml);
                    }
                }
                
                var editA = $('#Unit'+cid).children('td').eq(2).children('a').eq(1);
                editA.unbind();
                editA.click(function(){
                    category_passVal(cid,pid,4);
                })
                $('#addModal2').modal('hide');
                messageSuccess("修改成功");
            } else {
                //失败请求操作
                messageWarming(result.msg,"");
            }
        }
    });
}





