<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="myAccount.aspx.cs" Inherits="booksShop.myAcount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="assets/css/order/orderList.css" rel="stylesheet" />
    <link href="assets/css/toastr.min.css" rel="stylesheet" />
    <script src="assets/js/toastr.min.js"></script>
    <script src="assets/js/user/pwd.js"></script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--=============================================
	=            breadcrumb area         =
	=============================================-->

    <div class="breadcrumb-area pt-15 pb-15">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <!--=======  breadcrumb container  =======-->

                    <div class="breadcrumb-container">
                        <nav>
                            <ul>
                                <li class="parent-page"><a href="index.aspx">首页</a></li>
                                <li>用户中心</li>
                            </ul>
                        </nav>
                    </div>

                    <!--=======  End of breadcrumb container  =======-->
                </div>
            </div>
        </div>
    </div>

    <!--=====  End of breadcrumb area  ======-->

    <!--===========================
	=            主体内容         =
	==============================-->

    <div class="page-section mb-60">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="row">
                        <!-- 用户中心菜单 -->
                        <div class="col-lg-2 col-12">
                            <div class="myaccount-tab-menu nav" role="tablist">
                                <a id="dashboadBtn" href="#dashboad" data-toggle="tab"><i class="fa fa-dashboard"></i>用户面板</a>

                                <a id="ordersBtn" href="#orders" data-toggle="tab"><i class="fa fa-cart-arrow-down"></i>订单</a>

                                <!-- <a href="#address-edit" data-toggle="tab"><i class="fa fa-map-marker"></i>地址</a> -->

                                <a href="#collections" data-toggle="tab"><i class="fa fa-star"></i>收藏</a>

                                <a href="#account-info" data-toggle="tab"><i class="fa fa-user"></i>修改密码</a>

                                <a href="login.aspx?method=exit"><i class="fa fa-sign-out"></i>退出</a>
                            </div>
                        </div>
                        <!-- 用户中心菜单 End -->

                        <!-- My Account Tab Content Start -->
                        <div class="col-lg-10 col-12">
                            <div class="tab-content" id="myaccountContent">
                                <!-- 用户面板 Start -->
                                <div class="tab-pane fade show" id="dashboad" role="tabpanel">
                                    <div class="myaccount-content">
                                        <h3>用户面板</h3>

                                        <div class="welcome mb-20">
                                            <p>你好, <strong><%=user.loginname %></strong></p>
                                        </div>

                                        <p class="mb-1">从您的用户面板。您可以轻松地检查和查看您最近的订单，管理您的运输和帐单地址，编辑您的密码和帐户详细信息。</p>
                                    </div>
                                </div>
                                <!-- 用户面板 End -->

                                <!-- 订单 Start -->
                                <div class="tab-pane fade" id="orders" role="tabpanel">
                                    <div class="myaccount-content">
                                        <h3>订单</h3>
                                        <div class="myaccount-table table-responsive text-center">
                                            <table class="table">
                                                <thead class="thead-light">
                                                    <tr>
                                                        <th colspan="2">商品信息</th>

                                                        <th>金额</th>
                                                        <th>订单状态</th>
                                                        <th>操作</th>

                                                    </tr>
                                                </thead>

                                                <tbody>
                                                    <%
                                                        for (int i = 0; i < pb.beanList.Count; i++)
                                                        {
                                                    %>
                                                    <tr class="tt">
                                                        <td>订单号：<a data-toggle="modal" data-target="#<%=pb.beanList[i].oid %>detailView"><%=pb.beanList[i].oid %></a></td>
                                                        <td>下单时间：<%=pb.beanList[i].ordertime %></td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                    </tr>
                                                    <tr style="padding-top: 10px; padding-bottom: 10px;">
                                                        <td colspan="2" style="text-align: left">
                                                            <%
                                                            for (int j = 0; j < pb.beanList[i].Orderitem.Count; j++)
                                                            {
                                                            %>
                                                            <a class="link2" href="single-product.aspx?method=findByBid&bid=<%=pb.beanList[i].Orderitem[j].bid %>">
                                                                <img border="0" width="70" src="assets/images/<%=pb.beanList[i].Orderitem[j].image_b %>" />
                                                            </a>
                                                            <% 
                                                            }
                                                            %>
																	
                                                        </td>
                                                        <td style="width: 115px">
                                                            <span class="price_t">&yen;<%=pb.beanList[i].total %></span>
                                                        </td>
                                                        <td style="width: 142px">
                                                            <%
                                                            string status = "";
                                                            if (pb.beanList[i].status == 1)
                                                                status = "(等待付款)";
                                                            else if (pb.beanList[i].status == 2)
                                                                status = "(准备发货)";
                                                            else if (pb.beanList[i].status == 3)
                                                                status = "(等待确认)";
                                                            else if (pb.beanList[i].status == 4)
                                                                status = "(交易成功)";
                                                            else if (pb.beanList[i].status == 5)
                                                                status = "(已取消)";
                                                            %>
                                                            <span id="<%=pb.beanList[i].oid %>Status"><%=status %></span>
                                                        </td>
                                                        <td>
                                                            <a class="action" data-toggle="modal" data-target="#<%=pb.beanList[i].oid %>detailView" data-tooltip="查看"><i class="fa fa-search"></i>&nbsp;查看</a><br />
                                                            <%
                                                            if (pb.beanList[i].status == 1)
                                                            {
                                                            %>
                                                            <a class="btn" id="<%=pb.beanList[i].oid %>pay" title="支付"><i class="fa fa-money"></i>&nbsp;支付</a><br />
                                                            <a class="action" id="<%=pb.beanList[i].oid %>cancel" title="取消"><i class="fa fa-close"></i>&nbsp;取消</a><br />
                                                            <%
                                                            }
                                                            else if (pb.beanList[i].status == 3)
                                                            {
                                                            %>
                                                            <a class="action" id="<%=pb.beanList[i].oid %>comfirm" title="确认收货"><i class="fa fa-check"></i>&nbsp;确认收货</a><br />
                                                            <%    
                                                            }
                                                            %>
																	
                                                        </td>
                                                    </tr>
                                                    <% 
                                                        }
                                                    %>
                                                </tbody>
                                            </table>

                                            <%
                                                int begin, end;
                                                if (pb.tp() <= 6)
                                                {
                                                    begin = 1;
                                                    end = pb.tp();
                                                }
                                                else
                                                {
                                                    begin = pb.pc - 2;
                                                    end = pb.pc + 3;
                                                    if (begin < 1)
                                                    {
                                                        begin = 1;
                                                        end = 6;
                                                    }
                                                    if (end > pb.tp())
                                                    {
                                                        begin = pb.tp() - 5;
                                                        end = pb.tp();
                                                    }
                                                }
                                            %>
                                            <div class="pagination-area mb-md-50 mb-sm-50">
                                                <ul>


                                                    <%
                                                        if (pb.pc != 1)
                                                        {
                                                    %>
                                                    <li><a class="page" href="<%=pb.url %>&pc=<%=pb.pc-1 %>" title="上一页"><i class="fa fa-angle-double-left disabled"></i></a></li>
                                                    <%         
                                                        }
                                                    %>


                                                    <%
                                                        for (int i = begin; i <= end; i++)
                                                        {
                                                            if (i == pb.pc)
                                                            {
                                                    %>
                                                    <li><a class="page active" href="<%=pb.url %>&pc=<%=i %>"><%=i %></a></li>
                                                    <%
                                                            }
                                                            else
                                                            {
                                                    %>
                                                    <li><a class="page" href="<%=pb.url %>&pc=<%=i %>"><%=i %></a></li>
                                                    <%             
                                                            }
                                                        }
                                                    %>
                                                    <%
                                                        if (end < pb.tp())
                                                        {
                                                    %>
                                                    <li>...</li>
                                                    <%         
                                                        }
                                                    %>

                                                    <%
                                                        if (pb.pc != pb.tp())
                                                        {
                                                    %>
                                                    <li><a class="page" href="<%=pb.url %>&pc=<%=pb.pc+1 %>" title="下一页"><i class="fa fa-angle-double-right"></i></a></li>
                                                    <%         
                                                        }
                                                    %>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Single Tab Content End -->

                                <!-- 地址管理 Start -->
                                <!--<div class="tab-pane fade" id="address-edit" role="tabpanel">
                                    <div class="myaccount-content">
                                        <h3>Billing Address</h3>

                                        <address>
                                            <p><strong>Alex Tuntuni</strong></p>
                                            <p>
                                                1355 Market St, Suite 900
												<br>
                                                San Francisco, CA 94103
                                            </p>
                                            <p>Mobile: (123) 456-7890</p>
                                        </address>

                                        <a href="#" class="btn d-inline-block edit-address-btn"><i class="fa fa-edit"></i>Edit Address</a>
                                    </div>
                                </div>-->
                                <!-- 地址管理 End -->

                                <!-- 收藏 Start -->
                                <div class="tab-pane fade" id="collections" role="tabpanel">
                                    <div class="myaccount-content">
                                        <h3>收藏</h3>
                                        <div class="shop-product-wrap grid row mb-30 no-gutters">
                                            <!--=======  收藏主体展区  =======-->
                                            <%
                                                for (int i = 0; i < collectionList.Count; i++)
                                                {
                                            %>
                                            <!--=======  单品  =======-->
                                            <div id="CView<%=collectionList[i].sid %>" class="col-lg-3 col-md-6 col-sm-6 col-12">
                                                
                                                <div class="fl-product shop-grid-view-product">
                                                    <div class="image">
                                                        <a href="single-product.aspx?method=findByBid&bid=<%=collectionList[i].Book.bid %>">
                                                            <img src="assets/images/<%=collectionList[i].Book.image_b %>" class="img-fluid" alt="">
                                                            <img src="assets/images/<%=collectionList[i].Book.image_b %>" class="img-fluid" alt="">
                                                        </a>

                                                    </div>
                                                    <div class="content">
                                                        <h2 class="product-title"><a href="single-product.aspx?method=findByBid&bid=<%=collectionList[i].Book.bid %>" title="<%=collectionList[i].Book.bname %>"><%=collectionList[i].Book.bname %></a></h2>
                                                        <div class="rating">
                                                            <%
                                        int count = collectionList[i].Book.xingji / 20 > 5 ? 5 : collectionList[i].Book.xingji / 20;
                                        for (int k = 0; k < count; k++)
                                        {
                                                            %>
                                                            <i class="fa fa-star active"></i>
                                                            <%
                                        }
                                                            %>
                                                        </div>
                                                        <p class="product-price">
                                                            <span class="main-price discounted">¥<%=collectionList[i].Book.price %></span>
                                                            <span class="discounted-price">¥<%=collectionList[i].Book.currPrice %></span>
                                                        </p>
                                                        <div class="hover-icons">
										                    <ul>
											                    <li><a data-tooltip="删除" onclick="delCollection('<%=collectionList[i].sid %>')"><i class="icon ion-md-trash"></i></a></li>
										                    </ul>
									                    </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--=======  单品   End=======-->
                                            <%      
                                                }    
                                            %>
                                            <!--=======  收藏主体展区   End=======-->
                                        </div>
                                    </div>
                                </div>
                                <!-- 收藏 End -->

                                <!-- 修改密码 Start -->
                                <div class="tab-pane fade" id="account-info" role="tabpanel">
                                    <div class="myaccount-content">
                                        <h3>修改密码</h3>

                                        <div class="account-details-form">
                                            <form action="#">
                                                <div class="row">
                                                    <div class="col-12 mb-30">
                                                        <input id="loginpass" class="mb-0" placeholder="原密码" type="password">
                                                        <label id="loginpassError" class="labelError"><%=errors["loginpass"].ToString() %></label>
                                                    </div>

                                                    <div class="col-lg-6 col-12 mb-30">
                                                        <input id="newpass" class="mb-0" placeholder="新密码" type="password">
                                                        <label id="newpassError" class="labelError"><%=errors["newpass"].ToString() %></label>
                                                    </div>

                                                    <div class="col-lg-6 col-12 mb-30">
                                                        <input id="reloginpass" class="mb-0" placeholder="确认密码" type="password">
                                                        <label id="reloginpassError" class="labelError"><%=errors["reloginpass"].ToString() %></label>
                                                    </div>

                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                        <ContentTemplate>
                                                            <div class="col-12">
                                                                <button id="submit" class="save-change-btn" onclick="passwordChange()">确定</button>
                                                            </div>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>


                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <!-- 修改密码 End -->
                            </div>
                        </div>
                        <!-- My Account Tab Content End -->
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!--=====  End of 主体内容  ======-->

    <!--=============================================
	=            订单详情模态框         =
	=============================================-->
    <%
        for (int p = 0; p < pb.beanList.Count; p++)
        {
    %>
    <div class="modal fade quick-view-modal-container" id="<%=pb.beanList[p].oid %>detailView" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <%
            string status = "";
            if (pb.beanList[p].status == 1)
                status = "(等待付款)";
            else if (pb.beanList[p].status == 2)
                status = "(准备发货)";
            else if (pb.beanList[p].status == 3)
                status = "(等待确认)";
            else if (pb.beanList[p].status == 4)
                status = "(交易成功)";
            else if (pb.beanList[p].status == 5)
                status = "(已取消)";
                        %>
                        <div class="row" style="font-size: medium">
                            <div class="col-8">订单号：<%=pb.beanList[p].oid %> <%=status %></div>
                            <div class="col-4">下单时间：<%=pb.beanList[p].ordertime %></div>
                        </div>
                        <div class="row" style="font-size: medium">
                            <div class="col-12">收货人信息：<%=pb.beanList[p].address %></div>
                        </div>
                        <hr />
                        <div class="row">
                            <div class="col-12" style="font-size: large"><strong>商品清单</strong></div>
                        </div>
                        <div class="cart-table table-responsive mb-40">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th colspan="2">商品信息</th>
                                        <th>单价</th>
                                        <th colspan="2">数量</th>
                                        <th>小计</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
            for (int q = 0; q < pb.beanList[p].Orderitem.Count; q++)
            {
                                    %>
                                    <tr>
                                        <td>
                                            <img width="100" src="assets/images/<%=pb.beanList[p].Orderitem[q].image_b %>" /></td>
                                        <td><%=pb.beanList[p].Orderitem[q].bname %></td>
                                        <td>&yen;<%=pb.beanList[p].Orderitem[q].currPrice %></td>
                                        <td colspan="2"><%=pb.beanList[p].Orderitem[q].quantity %></td>

                                        <td>&yen;<%=pb.beanList[p].Orderitem[q].subtotal %></td>
                                    </tr>
                                    <%           
            }
                                    %>
                                </tbody>
                            </table>

                        </div>
                        <div class="row">
                            <div class="col-9"></div>
                            <div class="col-3" style="font-size: large">合计金额：<span class="price">&yen;<%=pb.beanList[p].total %></span></div>
                        </div>
                        <div class="row">
                            <div class="col-9"></div>
                            <div class="col-3" style="font-size: large"><a>立即支付</a></div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <!--=====  End of 订单详情模态框  ======-->
    <%
        }
    %>






    <script>
        $(function () {
            var flag = window.location.search;
            if (flag.indexOf("?method=myOrder&pc=") == 0) {
                $('#ordersBtn').addClass("active");
                $('#orders').addClass("active");
            } else {
                $('#dashboadBtn').addClass("active");
                $('#dashboad').addClass("active");
            }

            $('.action').click(function () {
                var id = $(this).prop('id').substring(0, 32);
                var method = $(this).prop('id').substring(32);

                $.ajax({
                    url: "myAccount.aspx?method=" + method,
                    data: { "oid": id },
                    type: "GET",
                    dataType: "json",
                    success: function (result) {
                        if (result.status) {
                            var jsonData = JSON.parse(result.data);
                            if (jsonData.code == "success") {
                                $('#' + id + 'Status').text(jsonData.status);
                                $('#' + id + 'comfirm').remove();
                                $('#' + id + 'cancel').remove();
                                $('#' + id + 'pay').remove();
                                Swal(
								  '操作成功',
								  jsonData.msg,
								  'success'
								)
                            } else if (jsonData.code == "error") {
                                Swal(
								  '操作失败',
								  jsonData.msg,
								  'error'
								)
                            }
                        } else {
                            toastr.error(result.msg);
                            toastr.error(result.msg);
                            toastr.error(result.msg);
                        }
                    }
                });
            })

        })

        function delCollection(sid) {

            Swal.fire({
                title: '确定删除该收藏？',
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '删除',
                cancelButtonText:'取消'
            }).then((result) => {
                if (result.value) {
                        deleteC(sid);
        }
        })
        }

        function deleteC(sid){
            $.ajax({
                url: "myAccount.aspx?method=delCollection",
                data: { "sid": sid },
                type: "GET",
                dataType: "json",
                success: function (result) {
                    if (result.status) {
                        Swal(
								  '操作成功',
								  ' ',
								  'success'
								)
                        $('#CView'+ sid).remove();
                    } else {
                        //失败请求操作
                        Swal(
								  '操作失败',
								  result.msg,
								  'error'
								)
                        
                    }
                }
            });
        }
    </script>

</asp:Content>
