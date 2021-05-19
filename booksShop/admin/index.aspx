<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="booksShop.admin.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<style>
		.bg-purple {
			background-color: #926dde !important;
			color: #fff!important;
		}
	</style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<!--页面主要内容-->
	<div class="container-fluid">
		
		<div class="row">
		  <div class="col-sm-6 col-lg-3">
			<div class="card bg-primary">
			  <div class="card-body clearfix">
				<div class="pull-right">
				  <p class="h4 text-white m-t-0">今日收入</p>
				  <p class="h3 text-white m-b-0">&yen;<%=dayIncome.ToString() %></p>
				</div>
				<div class="pull-left"> <span class="img-avatar img-avatar-48 bg-translucent"><i class="mdi mdi-currency-cny fa-1-5x"></i></span> </div>
			  </div>
			</div>
		  </div>
		  
		  <div class="col-sm-6 col-lg-3">
			<div class="card bg-danger">
			  <div class="card-body clearfix">
				<div class="pull-right">
				  <p class="h4 text-white m-t-0">本年收入</p>
				  <p class="h3 text-white m-b-0">&yen;<%=yearIncome.ToString() %></p>
				</div>
				<div class="pull-left"> <span class="img-avatar img-avatar-48 bg-translucent"><i class="mdi mdi-account fa-1-5x"></i></span> </div>
			  </div>
			</div>
		  </div>
		  
		  <div class="col-sm-6 col-lg-3">
			<div class="card bg-success">
			  <div class="card-body clearfix">
				<div class="pull-right">
				  <p class="h4 text-white m-t-0">订单总量</p>
				  <p class="h3 text-white m-b-0">34,005,000</p>
				</div>
				<div class="pull-left"> <span class="img-avatar img-avatar-48 bg-translucent"><i class="mdi mdi-arrow-down-bold fa-1-5x"></i></span> </div>
			  </div>
			</div>
		  </div>
		  
		  <div class="col-sm-6 col-lg-3">
			<div class="card bg-purple">
			  <div class="card-body clearfix">
				<div class="pull-right">
				  <p class="h4 text-white m-t-0">新增订单</p>
				  <p class="h3 text-white m-b-0"><%=dayOrderCount %> </p>
				</div>
				<div class="pull-left"> <span class="img-avatar img-avatar-48 bg-translucent"><i class="mdi mdi-comment-outline fa-1-5x"></i></span> </div>
			  </div>
			</div>
		  </div>
		</div>
		
		<div class="row">
		  
		  <div class="col-lg-6"> 
			<div class="card">
			  <div class="card-header">
				<h4>最近七日订单销量</h4>
			  </div>
			  <div class="card-body">
				<canvas class="js-chartjs-bars"></canvas>
			  </div>
			</div>
		  </div>
		  
		  <div class="col-lg-6"> 
			<div class="card">
			  <div class="card-header">
				<h4>月收入记录</h4>
			  </div>
			  <div class="card-body">
				<canvas class="js-chartjs-lines"></canvas>
			  </div>
			</div>
		  </div>
		   
			<!--<div class="col-lg-6"> 
			<div class="card">
			  <div class="card-header">
				<h4>最近七日订单记录</h4>
			  </div>
			  <div class="card-body">
				<canvas class="js-chartjs-bars"></canvas>
			  </div>
			</div>
		  </div>
		  
		  <div class="col-lg-6"> 
			<div class="card">
			  <div class="card-header">
				<h4>月收入记录</h4>
			  </div>
			  <div class="card-body">
				<canvas class="js-chartjs-lines"></canvas>
			  </div>
			</div>
		  </div>-->
		</div>
		
		<div class="row">
		  <!--- 订单信息 ----->
		  <div class="col-lg-12">
			<div class="card">
			  <div class="card-header">
				<h4>最近订单信息</h4>
			  </div>
			  <div class="card-body">
				<div class="table-responsive">
				  <table class="table table-hover">
					<thead>
					  <tr>
						<th>#</th>
						<th>订单号</th>
						<th>下单时间</th>
						<th>总额</th>
						<th>状态</th>
						
					  </tr>
					</thead>
					<tbody>
						<%
							for (int i = 0; i < orderList.Count; i++)
							{
						%>
								 <tr>
									<td><%=i+1 %></td>
									<td><%=orderList[i].oid %></td>
									<td><%=orderList[i].ordertime %></td>
									<td>&yen;<%=orderList[i].total %></td>
									 <%
								if (orderList[i].status == 1)
								{
									%>
									 <td><span class="label label-warning">等待付款</span></td>
									 <%
								 }else if (orderList[i].status == 2)
								{
									%>
									 <td><span class="label label-info">准备发货</span></td>
									 <%
								 }else if (orderList[i].status == 3)
								{
									%>
									 <td><span class="label label-primary">等待确认</span></td>
									 <%
								 }else if (orderList[i].status == 4)
									{
									%>
									 <td><span class="label label-success">交易成功</span></td>
									 <%
								 }else if (orderList[i].status == 5)
								 {
									%>
									 <td><span class="label label-danger">已取消</span></td>
									 <%
								 }
									
									 %>
									
								   
								</tr>
								
						<%
							}
						%>

					 
					</tbody>
				  </table>
				</div>
			  </div>
			</div>
		  </div>
		  <!---End 订单信息 ----->
		</div>
		
	  </div>
	  

	<!--End 页面主要内容-->
</asp:Content>



<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
	<script src="../assets/js/admin/Chart.js"></script>
	<script src="../assets/js/admin/index.js"></script>
</asp:Content>
