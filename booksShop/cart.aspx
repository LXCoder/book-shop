<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="cart.aspx.cs" Inherits="booksShop.cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<!-- Sweetalert2 CSS -->
	<link href="assets/css/sweetalert2.min.css" rel="stylesheet" />

	<!-- Sweetalert2 JS -->
	<script src="assets/js/sweetalert2.all.min.js"></script>
	<script src="assets/js/sweetalert2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/promise-polyfill"></script>
    <script src="assets/js/cart/cart.js"></script>

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
								<li>购物车</li>
							</ul>
						</nav>
					</div>
					
					<!--=======  End of breadcrumb container  =======-->
				</div>
			</div>
		</div>
	</div>
	
	<!--=====  End of breadcrumb area  ======-->
	
	<!--=============================================
	=            Cart page content         =
	=============================================-->

    
	<div class="page-section mb-50">
		<div class="container">
			<div class="row">
				<div class="col-12">
							
						<%
                            if (cartItemList.Count == 0)
                            {
                        %>
                        <div class="alert alert-light">
                            <p style="text-align:center;font-size:xx-large"> 当前购物车为空!&nbsp;&nbsp;&nbsp;可点击<a href="index.aspx" class="alert-link" style="text-decoration:none">这里</a>去挑选商品！</p>
                        </div>
                        
                        <%
                            }
                            else
                            {
                         %>
                         <!--=======  cart table  =======-->
						
						<div class="cart-table table-responsive mb-40">
							<table class="table">
								<thead>
									<tr>
										<th>
											<input type="checkbox" id="selectAll" checked="checked"/><label for="selectAll">全选</label>
										</th>
										<th class="pro-thumbnail">产品图</th>
										<th class="pro-title">产品名</th>
										<th class="pro-price">价格</th>
										<th class="pro-quantity">数量</th>
										<th class="pro-subtotal">总价</th>
										<th class="pro-remove">移除</th>
									</tr>
								</thead>
								<tbody>
									<%
										for (int i = 0; i < cartItemList.Count; i++)
										{
									%>
									<tr>
										<td>
											<input value="<%=cartItemList[i].cartItemId_ %>" type="checkbox" name="checkboxBtn" checked="checked"/>
										</td>
										<td class="pro-thumbnail"><a href="single-product.aspx?method=findByBid&bid=<%=cartItemList[i].Book.bid %>"><img src="assets/images/<%=cartItemList[i].Book.image_b %>" class="img-fluid" alt="Product"></a></td>
										<td class="pro-title"><a href="single-product.aspx?method=findByBid&bid=<%=cartItemList[i].Book.bid %>"><%=cartItemList[i].Book.bname %></a></td>
										<td class="pro-price"><span>&yen;<%=cartItemList[i].Book.currPrice %></span></td>
										<td class="pro-quantity">
											<div class="pro-qty">
												<input id="<%=cartItemList[i].cartItemId_ %>Qty" type="text" value="<%=cartItemList[i].quantity_ %>" readonly="readonly" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();">
                                                <a id="<%=cartItemList[i].cartItemId_ %>Inc" href="#" class="inc qty-btn">+</a>
												<a id="<%=cartItemList[i].cartItemId_ %>Dec" href="#" class="dec qty-btn">-</a>
                                                <label id="<%=cartItemList[i].cartItemId_ %>Bid" style="display:none"><%=cartItemList[i].Book.bid %></label>
											</div>
										</td> 
										<td class="pro-subtotal"><span>&yen;<span id="<%=cartItemList[i].cartItemId_ %>Subtotal"><%=cartItemList[i].subtotal %></span></span></td>
										<td class="pro-remove"><a id="remove" href="cart.aspx?method=batchDelete&cartItemIds=<%=cartItemList[i].cartItemId_ %>&flag=true"><i class="fa fa-trash-o"></i></a></td>
									</tr>

									<%            
										}    
									%>
									
                                   <tr>
                                        <td colspan="7" style="text-align:right" >
				                            <strong><span>总计：&yen;&nbsp;&nbsp;</span><span id="total" style="font-size:larger"></span></strong>
			                            </td>
                                   </tr>
									
								</tbody>
							</table>

						</div>
						
						<!--=======  End of cart table  =======-->	
				   
					<div class="row">
						<div class="col-lg-10 col-12"> <button id="batchDelete" class="register-button" type="button">批量删除</button></div>
						<div class="col-lg-2 col-12"> <button id="jiesuan" class="register-button" type="button">结算</button></div>
					</div>
                        <%
                            }
                        %>
                    
				</div>
			</div>
		</div>
	</div>

	<!--=====  End of Cart page content  ======-->

    <script type="text/javascript">

        $(function () {
            
            $('.inc').click(function () {           
                var id = $(this).prop('id').substring(0, 32);
                var quantity = $('#' + id + 'Qty').val();
                var bid = $('#' + id + 'Bid').text();
                sendUpdateQuantity(id, quantity,bid);

            });

            $('.dec').click(function () {
                var id = $(this).prop('id').substring(0, 32);
                var quantity = $("#" + id + "Qty").val();
                var bid = $('#' + id + 'Bid').text();
                if (quantity == "0") {
                    isDelete(id);
                } else {
                    sendUpdateQuantity(id, Number(quantity),bid);
                }
            });
        })
    </script>

</asp:Content>
