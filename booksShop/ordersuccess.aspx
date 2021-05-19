<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ordersuccess.aspx.cs" Inherits="booksShop.ordersuccess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<style type="text/css">
		.price_t {
			color: #c30;
			font-weight: bold;
			padding-right: 10px;
			font-family: Arial;
			font-size: 15pt;
		}

		.div1 {
			
			width: 690px;
			height: 35px;
			background-color: #efeae5;
			border-left: 5px solid #efeae5;
			border-right: 5px solid #efeae5;
		}

		.div2 {
			
			width: 690px;
			height: 300px;
			border: 5px solid #efeae5;
		}

		.div3 {
			margin-left: 50px;
			margin-top: 20px;
			margin-right: 20px;
			margin-bottom: 20px;
		}

		.span1 {
			margin-top: 10px;
			margin-left: 10px;
			height: 25px;
			font-weight: 900;
			display: inline-block;
		}

		.img {
			float: left;
			margin: 30px 100px 0px 30px;
			width: 150px;
		}

		dl {
			float: left;
			width: 400px;
			margin-top: 30px;
		}

		dt {
			font-weight: 900;
		}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

	<div class="container">
	   <div class="row">
			<div class="col-3"></div>
			<div class="col-9" style="margin-top:30px">
			   <div class="div1">
				<span class="span1">订单已生成</span>
			</div>
			<div class="div2">
				<img src="assets/images/duihao.jpg" class="img" />
				<dl>
					<dt>订单编号</dt>
					<dd><%=order.oid %></dd>
					<dt>合计金额</dt>
					<dd><span class="price_t">&yen;<%=order.total %></span></dd>
					<dt>收货地址</dt>
					<dd><%=order.address %></dd>
				</dl>
				<div style="text-align:center">
					<span>感谢您的支持，祝您购物愉快！</span>
					<strong style="font-size:xx-large"><a href="#" id="linkPay">支付</a></strong>
				</div>
			</div>
		   </div>
	   </div>
	</div>

</asp:Content>
