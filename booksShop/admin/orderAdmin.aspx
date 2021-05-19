<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="orderAdmin.aspx.cs" Inherits="booksShop.admin.orderAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<link href="../assets/css/admin/order.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


	<div class="shop-page-content mb-50">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<p class="pLink">
						<a href="/admin/orderAdmin.aspx?method=findByStatus&status=1">未付款</a>  | 
						<a href="/admin/orderAdmin.aspx?method=findByStatus&status=2">已付款</a>  | 
						<a href="/admin/orderAdmin.aspx?method=findByStatus&status=3">已发货</a>  | 
						<a href="/admin/orderAdmin.aspx?method=findByStatus&status=4">交易成功</a>  | 
						<a href="/admin/orderAdmin.aspx?method=findByStatus&status=5">已取消</a>
					</p>
					<table class="table table-condensed">
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
								<td>订单号：
                                    <a class="action" data-toggle="modal" data-target="#<%=pb.beanList[i].oid %>detailView">
                                    <%=pb.beanList[i].oid %>
                                    </a>
								</td>
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
									<img border="0" width="70" src="../assets/images/<%=pb.beanList[i].Orderitem[j].image_b %>" />
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
									<a class="action" data-toggle="modal" data-target="#<%=pb.beanList[i].oid %>detailView" data-tooltip="查看" title="查看"><i class="fa fa-search"></i>&nbsp;查看</a><br />
									<%
									if (pb.beanList[i].status == 1)
									{
									%>
									<a class="action" id="<%=pb.beanList[i].oid %>cancel" title="取消" onclick="cancel('<%=pb.beanList[i].oid %>')"><i class="fa fa-close"></i>&nbsp;取消</a><br />
									<%
												}
												else if (pb.beanList[i].status == 2)
												{
									%>
									<a class="action" id="<%=pb.beanList[i].oid %>deliver" title="发货" onclick="deliver('<%=pb.beanList[i].oid %>')"><i class="fa fa-truck"></i>&nbsp;发货</a><br />
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



					<!--==========================
					=            分页         =
					==============================-->

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

					<!--=====  End of 分页  ======-->
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
		<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
			<div class="modal-content" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container" style="width:850px">
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
											<img width="100" src="../assets/images/<%=pb.beanList[p].Orderitem[q].image_b %>" /></td>
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
			<%
			if (pb.beanList[p].status == 2)
			{
			%>
							<div class="col-3" style="font-size: large"><a class="pLink">立即发货</a></div>
			<%
			}
			%>
							
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
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
	<script src="../assets/js/admin/order.js"></script>
	
</asp:Content>
