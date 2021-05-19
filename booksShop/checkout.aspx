<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="checkout.aspx.cs" Inherits="booksShop.checkout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<script src="assets/js/vendor/jquery.min.js"></script>
	<script src="assets/js/dist/distpicker.min.js"></script>
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
								<li>结算</li>
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
					<form action="#">
						<!--=======  cart table  =======-->
						<div class="cart-table table-responsive mb-40">
							<table class="table">
								<thead>
									<tr>
										<th class="pro-thumbnail">产品图</th>
										<th class="pro-title">产品</th>
										<th class="pro-price">价格</th>
										<th class="pro-quantity">数量</th>
										<th class="pro-subtotal">总价</th>
									</tr>
								</thead>
								<tbody>
									<%
										for (int i = 0; i < orderItemList.Count; i++)
										{
									%>
										<tr>
										<td class="pro-thumbnail"><a href="single-product.aspx?method=findByBid&bid=<%=orderItemList[i].Book.bid %>"><img src="assets/images/<%=orderItemList[i].Book.image_b %>" class="img-fluid" alt="Product"></a></td>
										<td class="pro-title"><a href="single-product.aspx?method=findByBid&bid=<%=orderItemList[i].Book.bid %>"><%=orderItemList[i].Book.bname %></a></td>
										<td class="pro-price"><span>&yen;<%=orderItemList[i].Book.currPrice %></span></td>
										<td class="pro-quantity"><span><%=orderItemList[i].quantity_ %></span></td> 
										<td class="pro-subtotal"><span>&yen;<%=orderItemList[i].subtotal %></span></td>
									</tr>
									<% 
										}
									%>
									
								</tbody>
							</table>
						</div>
						
						<!--=======  End of cart table  =======-->
					</form>	
						
					<div class="row">

						<div class="col-lg-6 col-12">
							<!--=======  Calculate Shipping  =======-->

							<div class="calculate-shipping">
								<h4>收货地址</h4>
								<form class="form-inline mt-2 mb-4">
									<div data-toggle="distpicker" data-autoselect="3" data-province="广东省">
									  <select  id="provinceName" name="provinceName" class="form-control" ></select>
									  <select  id="cityName" name="cityName" class="form-control" ></select>
									  <select  id="districtName" name="districtName" class="form-control" ></select>
									</div>
								</form>		
								
							</div>
							
							<!--=======  End of Calculate Shipping  =======-->
							
							<!--=======  Discount Coupon  =======-->
							
							<div class="discount-coupon">
								
								<form>
									<div class="row">
										<div class="col-md-9 col-12 mb-25">
											<input id="detailAddress" type="text"  placeholder="详细地址">
										</div>
									</div>
								</form>
							</div>
							
							<!--=======  End of Discount Coupon  =======-->
							
						</div>

						<div class="col-lg-6 col-12 d-flex">
							<!--=======  Cart summery  =======-->
						
							<div class="cart-summary">
								<div class="cart-summary-wrap">
									<h4>结算</h4>
									<h2>总价 <span>&yen;<%=subTotal %></span></h2>
								</div>
								<div class="cart-summary-button">
									<button class="checkout-btn" type="button" onclick="placeOrder()">提交订单</button>
									
								</div>
							</div>
						
							<!--=======  End of Cart summery  =======-->
							
						</div>

					</div>
					
				</div>
			</div>
		</div>
	</div>

	<!--=====  End of Cart page content  ======-->

	<script type="text/javascript">
		function placeOrder()
		{
		    var provinceName = $('#provinceName option:selected').text();
		    var cityName = $('#cityName option:selected').text();
		    var districtName = $('#districtName option:selected').text();
		    var detailAddress = $('#detailAddress').val();
		    var address = provinceName + cityName + districtName + detailAddress;

			var address = "http://localhost:22256/checkout.aspx?method=creatOrder&address=" + address;
			$(window).attr('location', address);
		}
	</script>

	
</asp:Content>
