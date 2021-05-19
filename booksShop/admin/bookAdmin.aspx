<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="bookAdmin.aspx.cs" Inherits="booksShop.admin.bookAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<link href="../assets/css/admin/book.css" rel="stylesheet" />
	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


	<!--=============================================
	=           书籍展区         =
	=============================================-->

	<div class="shop-page-content mb-50">
		<div class="container">
			<div class="row">

				<div class="col-sm-12" id="easy_search" style="padding-bottom: 15px; padding-top: 15px;">
					<div class="input-group">
						<input id="keyWord" type="text" class="form-control" onkeydown="onKeyDown(event)" />
						<span class="input-group-addon"><a id="keyWordSearch"><i class="glyphicon glyphicon-search"><span>搜索</span></i></a></span>
					</div>
				</div>

				<div class="myMenu">
					<ul class="nav navbar-nav" >
						<%
							for (int i = 0; i < categoryList.Count; i++)
							{  
						%>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color:#333;list-style-type:none;"><%=categoryList[i].cname %></a>
							<ul class="dropdown-menu">
						<%
								for (int j = 0; j < categoryList[i].childrens.Count; j++)
								{
						%>
								<li><a href="bookAdmin.aspx?method=findByCid&cid=<%=categoryList[i].childrens[j].cid %>"><%=categoryList[i].childrens[j].cname %></a></li>
						<%
								} 
								%>
								</ul>
							</li>
						<%
							}
						
						%>
					</ul>
				</div>
				<div class="col-lg-12">

					<!--=======  Shop header  =======-->



					

					<!--=======  End of Shop header  =======-->

					<!--=======  商品展示  =======-->
					<div class="shop-product-wrap grid row mb-30 no-gutters">

						<%
								for (int i = 0; i < pageBean.beanList.Count; i++)
								{
						%>

						<div id="View<%=pageBean.beanList[i].bid%>" class="col-lg-3 col-md-6 col-sm-6 col-12">
							<!--=======  grid view product  =======-->

							<!--=======  single product  =======-->

							<div class="fl-product shop-grid-view-product">
								<div class="image">
									<a>
										<img src="../assets/images/<%=pageBean.beanList[i].image_b%>" class="img-fluid" alt="" />
										<img src="../assets/images/<%=pageBean.beanList[i].image_b%>" class="img-fluid" alt="" />
									</a>
								</div>
								<div class="content">
									<h2 id="Name<%=pageBean.beanList[i].bid%>" class="product-title"><%=pageBean.beanList[i].bname%></h2>
									<div class="rating">
										<%
                                        int count = pageBean.beanList[i].xingji / 20 > 5 ? 5 : pageBean.beanList[i].xingji / 20;
                                        for (int k = 0; k < count; k++)
                                        {
                                                %>
                                                <i class="fa fa-star active"></i>
                                                <%
                                        }
                                                %>
									</div>
									<p class="product-price">
										<span id="OldPrice<%=pageBean.beanList[i].bid%>" class="main-price discounted">¥<%=pageBean.beanList[i].price%></span>
										<span id="NewPrice<%=pageBean.beanList[i].bid%>" class="discounted-price">¥<%=pageBean.beanList[i].currPrice%></span>
									</p>
                                    <p>
										库存：<span id="stockNumber<%=pageBean.beanList[i].bid%>" ><%=pageBean.beanList[i].stock%></span>
									</p>

									<div class="hover-icons">
										<ul>

											<li>
												<a data-toggle="modal" data-target="#myModal" data-tooltip="编辑" id="editPage" onclick="passByValue('<%=pageBean.beanList[i].bid%>','<%=pageBean.beanList[i].bname%>','<%=pageBean.beanList[i].price%>','<%=pageBean.beanList[i].currPrice%>','<%=pageBean.beanList[i].discount%>','<%=pageBean.beanList[i].image_b%>','<%=pageBean.beanList[i].author%>','<%=pageBean.beanList[i].press%>','<%=pageBean.beanList[i].publishtime%>','<%=pageBean.beanList[i].pageNum%>','<%=pageBean.beanList[i].edition%>','<%=pageBean.beanList[i].printtime%>','<%=pageBean.beanList[i].wordNum%>','<%=pageBean.beanList[i].booksize%>','<%=pageBean.beanList[i].paper%>','<%=pageBean.beanList[i].Category.pid %>','<%=pageBean.beanList[i].Category.cid %>')">
													<i class="icon ion-md-create"></i>
												</a>
											</li>
                                            <li>
                                                <a data-toggle="modal" data-target="#stockModal" data-tooltip="库存" id="editStock" onclick="editStockValue('<%=pageBean.beanList[i].bid%>','<%=pageBean.beanList[i].stock%>')">
													<i class="icon ion-md-add"></i>
												</a>
                                            </li>
											<li><a data-tooltip="删除" onclick="delBook('<%=pageBean.beanList[i].bid %>')"><i class="icon ion-md-trash"></i></a></li>
										</ul>
									</div>
								</div>
							</div>

							<!--=======  End of single product  =======-->

							<!--=======  End of grid view product  =======-->


						</div>

						<%      
								}    
						%>
					</div>

					<!--=======  End of 商品展示  =======-->


					<!--========= 右下角功能区  =============-->

					<div class="hover-icons">
						<ul>
							<li><a data-toggle="modal" data-target="#searchModal" title="搜索 " class="functionicon icon-position-search"><i class="icon ion-md-search" style="font-size: xx-large"></i></a></li>
							<li><a data-toggle="modal" data-target="#addModal" title="添加 " class="functionicon icon-add icon-position-add"></a></li>
						</ul>
					</div>

					<!--========= End of 右下角功能区  =============-->

					<!--=======  分页  =======-->
					<!-- 计算begin和end 
								如果总页数<=6，那么显示所有页码，即begin=1 end=${pb.tp} 
								设置begin=当前页码-2，end=当前页码+3 
								如果begin<1，那么让begin=1 end=6 
								如果end>最大页，那么begin=最大页-5 end=最大页 -->
					<%
						int begin, end;
						if (pageBean.tp() <= 6)
						{
							begin = 1;
							end = pageBean.tp();
						}
						else
						{
							begin = pageBean.pc - 2;
							end = pageBean.pc + 3;
							if (begin < 1)
							{
								begin = 1;
								end = 6;
							}
							if (end > pageBean.tp())
							{
								begin = pageBean.tp() - 5;
								end = pageBean.tp();
							}
						}
					%>


					<div class="pagination-area mb-md-50 mb-sm-50">
						<ul>


							<%
								if (pageBean.pc != 1)
								{
							%>
							<li><a href="<%=pageBean.url %>&pc=<%=pageBean.pc-1 %>" title="上一页"><i class="fa fa-angle-double-left disabled"></i></a></li>
							<%         
								}
							%>


							<%
								for (int i = begin; i <= end; i++)
								{
									if (i == pageBean.pc)
									{
							%>
							<li><a class="active" href="<%=pageBean.url %>&pc=<%=i %>"><%=i %></a></li>
							<%
									}
									else
									{
							%>
							<li><a href="<%=pageBean.url %>&pc=<%=i %>"><%=i %></a></li>
							<%             
									}
								}
							%>
							<%
								if (end < pageBean.tp())
								{
							%>
							<li>...</li>
							<%         
								}
							%>

							<%
								if (pageBean.pc != pageBean.tp())
								{
							%>
							<li><a href="<%=pageBean.url %>&pc=<%=pageBean.pc+1 %>" title="下一页"><i class="fa fa-angle-double-right"></i></a></li>
							<%         
								}
							%>
						</ul>
					</div>

					<!--=======  End of 分页  =======-->

				</div>
			</div>
		</div>
	</div>

	<!--=====  End of 书籍展区  ======-->


    <!--=============================================
	=            库存模态框         =
	=============================================-->

    <div class="modal fade" id="stockModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" >
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" >库存量</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>

				</div>
				<div class="modal-body">
					
					<div class="form-group">
						
						<label for="stock" class="col-sm-2 control-label">库存量</label>
						<div class="col-sm-4">
                            <input type="number" class="form-control" id="stock" oninput="if(value<0)value=0;if(value>9999)value=9999"/>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" id="stockBtn" class="btn btn-primary">提交更改</button>
				</div>
			</div>
		</div>
	</div>

	<!--=============================================
	=            修改模态框         =
	=============================================-->


	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" >
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">修改书籍信息</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>

				</div>
				<div class="modal-body">
					
					<div class="form-group">
						
						<label for="_name" class="col-sm-2 control-label">书籍名称</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="_name" placeholder="书籍名称" />
						</div>
						
						<label for="_author" class="col-sm-2 control-label">作者</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="_author" placeholder="作者" />
						</div>
					</div>

					<div class="form-group">
						<label for="_press" class="col-sm-2 control-label">出版社</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="_press" placeholder="出版社" />
						</div>

						<label for="_edtion" class="col-sm-2 control-label">版本</label>
						<div class="col-sm-4">
							<input type="number" class="form-control" id="_edtion" oninput="if(value<0)value=0;if(value>10)value=10"/>
						</div>
					</div>

					<div class="form-group">
						<label for="_price" class="col-sm-2 control-label">单价</label>
						<div class="col-sm-4">
							<input type="number" class="form-control" id="_price" oninput="if(value<0)value=0;if(value.length>6)value=value.slice(0,6);" />
						</div>

						<label for="_discount" class="col-sm-2 control-label">折扣</label>
						<div class="col-sm-4">
							<input type="number" class="form-control" id="_discount" oninput="if(value<0)value=0;if(value>10)value=9.99;if(value.length>4)value=value.slice(0,4);" />
						</div>


						<label for="_pageNum" class="col-sm-2 control-label">页数</label>
						<div class="col-sm-4">
							<input type="number" class="form-control" id="_pageNum" oninput="if(value<0)value=0;if(value.length>4)value=value.slice(0,4);" />
						</div>
						<label for="_wordNum" class="col-sm-2 control-label">字数</label>
						<div class="col-sm-4">
							<input type="number" class="form-control" id="_wordNum" oninput="if(value<0)value=0;if(value.length>10)value=value.slice(0,10);" />
						</div>



						<label for="_paperSize" class="col-sm-2 control-label">开本</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="_paperSize" placeholder="开本" />
						</div>
						<label for="_paper" class="col-sm-2 control-label">纸张</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="_paper" placeholder="纸张" />
						</div>
					</div>

					<div class="form-group">
						<label for="_pid" class="col-sm-2 control-label">一级分类</label>
						<div class="col-sm-4">
							<select id="_pid" name="_pid" class="form-control" onchange="loadChildren(2,0)">
								<option value="">=====请选择1级分类=====</option>
								<%
									for (int i = 0; i < categoryList.Count; i++)
									{
								%>
								<option value="<%=categoryList[i].cid %>"><%=categoryList[i].cname %></option>
								<% 
									}
								%>
							</select>

						</div>
						<label for="_cid" class="col-sm-2 control-label">二级分类</label>
						<div class="col-sm-4">
							<select id="_cid" name="_cid" class="form-control">
								<option value="">=====请选择2级分类=====</option>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="_publicTime" class="col-sm-2 control-label">出版时间</label>
						<div class="col-sm-4">
							<input type="date" class="form-control" id="_publicTime" value="" />
						</div>

						<label for="_printTime" class="col-sm-2 control-label">印刷时间</label>
						<div class="col-sm-4">
							<input type="date" class="form-control" id="_printTime" value="" />
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" id="renew" class="btn btn-primary">提交更改</button>
				</div>
			</div>
		</div>
	</div>


	<!--=====  End of 修改模态框  ======-->

	<!--=============================================
	=            新书上架模态框         =
	=============================================-->

	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="addBook">添加书籍</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>

				</div>

				<div class="modal-body">
					<div class="form-group">
						<label for="image_w" class="col-sm-2 control-label">封面</label>
						<div class="col-sm-4">
							<input type="file" id="image_w" name="image_w" accept=".jpg,image/jpeg" onchange="showImg()" />
                            <input type="hidden" id="imgName" value="" />
                            <img id="img1" alt="网站Logo" src="../assets/images/book_img/book1.jpg" style="height:200px;width:200px" />
						</div>
					</div>

					<div class="form-group">
						<label for="bname" class="col-sm-2 control-label">书籍名称</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="bname" placeholder="书籍名称" />
						</div>

						<label for="author" class="col-sm-2 control-label">作者</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="author" placeholder="作者" />
						</div>
					</div>
					<div class="form-group">
						<label for="press" class="col-sm-2 control-label">出版社</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="press" placeholder="出版社" />
						</div>

						<label for="edtion" class="col-sm-2 control-label">版本</label>
						<div class="col-sm-4">
							<input type="number" class="form-control" id="edtion" oninput="if(value<0)value=0;if(value>10)value=10" />
						</div>
					</div>
					<div class="form-group">

						<label for="price" class="col-sm-2 control-label">定价</label>
						<div class="col-sm-4">
							<input type="number" class="form-control" id="price" oninput="if(value<0)value=0;if(value.length>6)value=value.slice(0,6);" />
						</div>

						<label for="discount" class="col-sm-2 control-label">折扣</label>
						<div class="col-sm-4">
							<input type="number" class="form-control" id="discount" oninput="if(value<0)value=0;if(value>10)value=9.99;if(value.length>4)value=value.slice(0,4);" />
						</div>


						<label for="pageNum" class="col-sm-2 control-label">页数</label>
						<div class="col-sm-4">
							<input type="number" class="form-control" id="pageNum" oninput="if(value<0)value=0;if(value.length>4)value=value.slice(0,4);" />
						</div>
						<label for="wordNum" class="col-sm-2 control-label">字数</label>
						<div class="col-sm-4">
							<input type="number" class="form-control" id="wordNum" oninput="if(value<0)value=0;if(value.length>10)value=value.slice(0,10);" />
						</div>



						<label for="booksize" class="col-sm-2 control-label">开本</label>
						<div class="col-sm-4">
							<input type="number" class="form-control" id="booksize"  oninput="if(value.length>2)value=value.slice(0,2);"/>
						</div>
						<label for="paper" class="col-sm-2 control-label">纸张</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="paper" placeholder="纸张" />
						</div>
					</div>

					<div class="form-group">
						<label for="pid" class="col-sm-2 control-label">一级分类</label>
						<div class="col-sm-4">
							<select id="pid" name="pid" class="form-control" onchange="loadChildren(1,0)">
								<option value="">=====请选择1级分类=====</option>
								<%
									for (int i = 0; i < categoryList.Count; i++)
									{
								%>
								<option value="<%=categoryList[i].cid %>"><%=categoryList[i].cname %></option>
								<% 
									}
								%>
							</select>

						</div>
						<label for="cid" class="col-sm-2 control-label">二级分类</label>
						<div class="col-sm-4">
							<select id="cid" name="cid" class="form-control">
								<option value="0">=====请选择2级分类=====</option>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="publicTime" class="col-sm-2 control-label">出版时间</label>
						<div class="col-sm-4">
							<input type="date" class="form-control" id="publicTime" value="" />
						</div>

						<label for="printTime" class="col-sm-2 control-label">印刷时间</label>
						<div class="col-sm-4">
							<input type="date" class="form-control" id="printTime" value="" />
						</div>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" id="addBtn" class="btn btn-primary" onclick="addBookPre()">新书上架</button>
				</div>
			</div>
		</div>
	</div>

	<!--=====  End of 新书上架模态框  ======-->

	<!--=============================================
	=            高级搜索模态框         =
	=============================================-->

	<div class="modal fade" id="searchModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="H1">高级搜索</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>

				</div>
				<form>
					<div class="modal-body">
						<div class="form-group">
							<label for="searchBname">书名</label>
							<input type="text" class="form-control" id="searchBname" placeholder="请输入书名" />
						</div>
						<div class="form-group">
							<label for="searchAuthor">作者</label>
							<input type="text" class="form-control" id="searchAuthor" placeholder="请输入作者" />
						</div>
						<div class="form-group">
							<label for="searchPress">出版社</label>
							<input type="text" class="form-control" id="searchPress" placeholder="请输入出版社" />
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<input type="reset" class="btn btn-default" value="重新填写" />
						<button type="button" id="search" class="btn btn-primary">搜索</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!--=====  End of 高级搜索模态框  ======-->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
	<script src="../assets/js/admin/category.js"></script>
	<script src="../assets/js/admin/book.js"></script>
    <script src="../assets/js/admin/index.js"></script>
    <script src="../assets/js/vendor/jquery.form.js"></script>
</asp:Content>