<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="booksShop.index1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<!-- Toastr CSS -->
	<link href="assets/css/toastr.min.css" rel="stylesheet"/>
	<!-- Toastr JS -->
	<script src="assets/js/toastr.min.js"></script>
	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<!--=============================================
	=            轮播图         =
	=============================================-->
	
	<div class="hero-area mb-30">
		<!--=======  slider container  =======-->
			
		<div class="slider-container">
			<!--=======  hero slider one  =======-->
				
			<div class="hero-slider">
				<!--=======  slider item  =======-->
					
				<div class="hero-slider-item " style="background-image:url('assets/images/sliders/14.jpg')">
					<!--=======  slider content  =======-->
						
					<div class="d-flex flex-column justify-content-center ">
						<div class="container">
							<div class="row">
								<div class="col-lg-12">
									<div class="slider-content">
										<p class="slider-price" style="color:white;font-size:x-large">惊爆价 <span>&yen;33.80</span></p>
										<a href="single-product.aspx?method=findByBid&bid=00799E567204496388902AFE09268BC8" class="slider-btn">购买</a>
									</div>
								</div>
							</div>
						</div>
					</div>
						
					<!--=======  End of slider content  =======-->
				</div>
					
				<!--=======  End of slider item  =======-->

				<!--=======  slider item  =======-->
				
				<div class="hero-slider-item" style="background-image:url('assets/images/sliders/15.jpg')">
					<!--=======  slider content  =======-->
					
					<div class="d-flex flex-column justify-content-center align-items-start h-100">
						<div class="container">
							<div class="row">
								<div class="col-lg-12">
									<div class="slider-content">
										<p class="slider-price" style="color:white;font-size:x-large">惊爆价 <span>&yen;$46.92</span></p>
										<a href="single-product.aspx?method=findByBid&bid=F075E14F42C6425AAC7717EF371EB9BC" class="slider-btn">购买</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<!--=======  End of slider content  =======-->
				</div>
				
				<!--=======  End of slider item  =======-->

				<!--=======  slider item  =======-->
				
				<div class="hero-slider-item" style="background-image:url('assets/images/sliders/16.jpg')">
					<!--=======  slider content  =======-->
					
					<div class="d-flex flex-column justify-content-center align-items-start h-100">
						<div class="container">
							<div class="row">
								<div class="col-lg-12">
									<div class="slider-content">
										<p class="slider-price" style="color:white;font-size:x-large">惊爆价 <span>&yen;$35.80</span></p>
										<a href="single-product.aspx?method=findByBid&bid=A1BE0D1A19054D24A21446E04F60C614" class="slider-btn">购买</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<!--=======  End of slider content  =======-->
				</div>
				
				<!--=======  End of slider item  =======-->

			</div>
			
			<!--=======  End of hero slider one  =======-->
		</div>
		
		<!--=======  End of slider container  =======-->
	</div>
	
	<!--=====  End of 轮播图  ======-->

	

	<!--=============================================
	=            热门书籍         =
	=============================================-->
	
	<div class="tab-product-slider-container mb-50">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<!--=======  tab slider wraspper  =======-->
					
					<div class="tab-slider-wrapper">
						<nav>
							<div class="nav nav-tabs" id="nav-tab" role="tablist">
								<a class="nav-item nav-link active" id="featured-tab" data-toggle="tab" href="#featured" role="tab"
									aria-selected="true">热门书籍</a>
								
							</div>
						</nav>
						<div class="tab-content" id="nav-tabContent">
							<div class="tab-pane fade show active" id="featured" role="tabpanel" aria-labelledby="featured-tab">
								<!--=======  tab product slider  =======-->
								
								<div class="fl-slider tab-product-slider">
									<!--=======  single product  =======-->
									
									<%
										for (int i = 0; i < topLike.Count; i++)
										{
											//int index = indexList[random.Next(0, indexList.Count)];
											//indexList.Remove(index);
									%>
									<div class="fl-product">
										<div class="image sale-product">
											<a href="single-product.aspx?method=findByBid&bid=<%=topLike[i].bid %>">
												<img src="assets/images/<%=topLike[i].image_b %>" class="img-fluid" alt="">
												<img src="assets/images/<%=topLike[i].image_b %>" class="img-fluid" alt="">
											</a>
											

                                            <%
                                        if (isLogin)
                                        {
                                            %>
                                            <!-- 收藏按钮 -->
											<span class="wishlist-icon">
													<a class="xingji" >
                                                        <input type="hidden" value="<%=topLike[i].bid%>" />
                                                <%
                                            if (topLike[i].statue == 0)
                                            {
                                                %>
                                                        <i class="icon ion-md-heart-empty"></i>
                                                <%
                                            }else if (topLike[i].statue == 1)
                                            {
                                                %>
                                                        <i class="icon ion-md-heart activexing"></i>
                                                <% 
                                            }
                                                %>
                                                        

													</a>
											</span>

                                            <% 
                                        }
                                            %>

										</div>
										<div class="content">
											<h2 class="product-title"> <a href="single-product.aspx?method=findByBid&bid=<%=topLike[i].bid %>" title="<%=topLike[i].bname %>"><%=topLike[i].bname %></a></h2>
											<div class="rating">
												<%
                                            int count = topLike[i].xingji / 20 > 5 ? 5 : topLike[i].xingji / 20;
									for (int k = 0; k < count; k++)
									{
										 %>
										<i class="fa fa-star active"></i>
										 <%
									}
										%>
											</div>
											<p class="product-price">
												<span class="main-price discounted">&yen;<%=topLike[i].price %></span>
												<span class="discounted-price">&yen;<%=topLike[i].currPrice %></span>
											</p>
                                            <p>
										        库存：<span ><%=topLike[i].stock%></span>
									        </p>

											<div class="hover-icons">
												<ul>
													<li><a  data-tooltip="加入购物车" onclick="buy('<%=topLike[i].bid %>','false')"><i class="icon ion-md-cart"></i></a></li>
													<li><a  data-toggle = "modal" data-target="#quick-view-modal-container" data-tooltip="详情" id="detailPage" onclick="passByValue('<%=topLike[i].bid %>','<%=topLike[i].bname %>','<%=topLike[i].price %>','<%=topLike[i].currPrice %>','<%=topLike[i].discount %>','<%=topLike[i].image_b %>','<%=topLike[i].author %>','<%=topLike[i].press %>','<%=topLike[i].publishtime %>','<%=topLike[i].pageNum %>','<%=topLike[i].edition %>','<%=topLike[i].printtime %>','<%=topLike[i].wordNum %>','<%=topLike[i].booksize %>','<%=topLike[i].paper %>',)"><i class="icon ion-md-open"></i></a></li>
												</ul>
											</div>
										</div>
									</div>
									<% 
										}
									%>
									
									<!--=======  End of single product  =======-->
								</div>
							
							
					</div>
					
					<!--=======  End of tab slider wraspper  =======-->
				</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!--=====  End of 热门书籍  ======-->


	<!--=============================================
	=            程序设计         =
	=============================================-->
	
	<div class="slider-banner-sidebar-area mb-50">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<!--=======  slider with banner and sidebar container  =======-->
					
					<div class="slider-banner-sidebar-container">
						<div class="row no-gutters">
							<div class="col-lg-3 col-xl-2 col-md-4">
								<!--=======  程序设计  =======-->
								
								<div class="slider-sidebar">
									<h3 class="slider-sidebar-title">程序设计</h3>
									<div class="sidebar-list">
										<ul>
											<%
												for(int i = 0;i < categoryList.Count;i++)
												{
											%>
											<li><a href="shop.aspx?method=findByCid&cid=<%=categoryList[i].cid %>"><%=categoryList[i].cname %></a></li>
											<%
												}
												
											%>
											
										</ul>
									</div>
								</div>
								
								<!--=======  End of 程序设计  =======-->
							</div>
							<div class="col-lg-9 col-xl-10 col-md-8">
								<!--=======  banner slider  =======-->
								
								<div class="fl-slider banner-slider">
									<%
										for (int i = 0; i < 6; i++)
										{
											//int index = indexList[random.Next(0, indexList.Count)];
											//indexList.Remove(index);
									%>
									<!--=======  商品  =======-->
									
									<div class="fl-product">
										<div class="image sale-product">
											<a href="single-product.aspx?method=findByBid&bid=<%=oneList[i].bid %>">
												<img src="assets/images/<%=oneList[i].image_b %>" class="img-fluid" alt="">
												<img src="assets/images/<%=oneList[i].image_b %>" class="img-fluid" alt="">
											</a>
											

                                            <%
                                        if (isLogin)
                                        {
                                            %>
                                            <!-- 收藏按钮 -->
											<span class="wishlist-icon">
													<a class="xingji" >
                                                        <input type="hidden" value="<%=oneList[i].bid%>" />
                                                <%
                                            if (oneList[i].statue == 0)
                                            {
                                                %>
                                                        <i class="icon ion-md-heart-empty"></i>
                                                <%
                                            }
                                            else if (oneList[i].statue == 1)
                                            {
                                                %>
                                                        <i class="icon ion-md-heart activexing"></i>
                                                <% 
                                            }
                                                %>
                                                        

													</a>
											</span>

                                            <% 
                                        }
                                            %>

										</div>
										<div class="content">
											<h2 class="product-title"> <a href="single-product.aspx?method=findByBid&bid=<%=oneList[i].bid %>" title="<%=oneList[i].bname %>"><%=oneList[i].bname %></a></h2>
											<div class="rating">
												<%
                                            int count = oneList[i].xingji / 20 > 5 ? 5 : oneList[i].xingji / 20;
									for (int k = 0; k < count; k++)
									{
										 %>
										<i class="fa fa-star active"></i>
										 <%
									}
										%>
											</div>
											<p class="product-price">
												<span class="main-price discounted">&yen;<%=oneList[i].price %></span>
												<span class="discounted-price">&yen;<%=oneList[i].currPrice %></span>
											</p>
                                            <p>
										        库存：<span><%=oneList[i].stock%></span>
									        </p>

											<div class="hover-icons">
												<ul>
													<li><a  data-tooltip="加入购物车" onclick="buy('<%=oneList[i].bid %>','false')"><i class="icon ion-md-cart"></i></a></li>
													<li><a  data-toggle = "modal" data-target="#quick-view-modal-container" data-tooltip="详情" id="A1" onclick="passByValue('<%=oneList[i].bid %>','<%=oneList[i].bname %>','<%=oneList[i].price %>','<%=oneList[i].currPrice %>','<%=oneList[i].discount %>','<%=oneList[i].image_b %>','<%=oneList[i].author %>','<%=oneList[i].press %>','<%=oneList[i].publishtime %>','<%=oneList[i].pageNum %>','<%=oneList[i].edition %>','<%=oneList[i].printtime %>','<%=oneList[i].wordNum %>','<%=oneList[i].booksize %>','<%=oneList[i].paper %>',)"><i class="icon ion-md-open"></i></a></li>
												</ul>
											</div>
										</div>
									</div>
									
									<!--=======  End of 商品  =======-->
									<%    
										}
									%>
									
								</div>
								
								<!--=======  End of banner slider  =======-->

								
							</div>
						</div>
					</div>
					
					<!--=======  End of slider with banner and sidebar container  =======-->
				</div>
			</div>
		</div>
	</div>
	
	<!--=====  End of 程序设计  ======-->

	<!--=============================================
	=            小说         =
	=============================================-->
	
	<div class="slider-banner-sidebar-area mb-50">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<!--=======  slider with banner and sidebar container  =======-->
					
					<div class="slider-banner-sidebar-container">
						<div class="row no-gutters">
							<div class="col-lg-3 col-xl-2 col-md-4">
								<!--=======  小说  =======-->
								<%
									categoryList = categoryService.findChild("4");
								%>
								<div class="slider-sidebar">
									<h3 class="slider-sidebar-title">小说</h3>
									<div class="sidebar-list">
										<ul>
											<%
												for(int i = 0;i < categoryList.Count;i++)
												{
											%>
											<li><a href="shop.aspx?method=findByCid&cid=<%=categoryList[i].cid %>"><%=categoryList[i].cname %></a></li>
											<%
												}
												
											%>
											
										</ul>
									</div>
								</div>
								
								<!--=======  End of sidebar  =======-->
							</div>
							<div class="col-lg-9 col-xl-10 col-md-8">
								<!--=======  banner slider  =======-->
								
								<div class="fl-slider banner-slider">
									<%
										for (int i = 0; i < 6; i++)
										{
											//int index = indexList[random.Next(0, indexList.Count)];
											//indexList.Remove(index);
									%>
									<!--=======  single product  =======-->
									
									<div class="fl-product">
										<div class="image sale-product">
											<a href="single-product.aspx?method=findByBid&bid=<%=twoList[i].bid %>">
												<img src="assets/images/<%=twoList[i].image_b %>" class="img-fluid" alt="">
												<img src="assets/images/<%=twoList[i].image_b %>" class="img-fluid" alt="">
											</a>

											<%
                                        if (isLogin)
                                        {
                                            %>
                                            <!-- 收藏按钮 -->
											<span class="wishlist-icon">
													<a class="xingji" >
                                                        <input type="hidden" value="<%=twoList[i].bid%>" />
                                                <%
                                            if (twoList[i].statue == 0)
                                            {
                                                %>
                                                        <i class="icon ion-md-heart-empty"></i>
                                                <%
                                            }else if (twoList[i].statue == 1)
                                            {
                                                %>
                                                        <i class="icon ion-md-heart activexing"></i>
                                                <% 
                                            }
                                                %>
                                                        

													</a>
											</span>

                                            <% 
                                        }
                                            %>
										</div>
										<div class="content">
											<h2 class="product-title"> <a href="single-product.aspx?method=findByBid&bid=<%=twoList[i].bid %>" title="<%=twoList[i].bname %>"><%=twoList[i].bname %></a></h2>
											<div class="rating">
												<%
                                            int count = twoList[i].xingji / 20 > 5 ? 5 : twoList[i].xingji / 20;
									for (int k = 0; k < count; k++)
									{
										 %>
										<i class="fa fa-star active"></i>
										 <%
									}
										%>
											</div>
											<p class="product-price">
												<span class="main-price discounted">&yen;<%=twoList[i].price %></span>
												<span class="discounted-price">&yen;<%=twoList[i].currPrice %></span>
											</p>
                                            <p>
										        库存：<span ><%=twoList[i].stock%></span>
									        </p>

											<div class="hover-icons">
												<ul>
													<li><a  data-tooltip="加入购物车" onclick="buy('<%=twoList[i].bid %>','false')"><i class="icon ion-md-cart"></i></a></li>
													<li><a  data-toggle = "modal" data-target="#quick-view-modal-container" data-tooltip="详情" id="A2" onclick="passByValue('<%=twoList[i].bid %>','<%=twoList[i].bname %>','<%=twoList[i].price %>','<%=twoList[i].currPrice %>','<%=twoList[i].discount %>','<%=twoList[i].image_b %>','<%=twoList[i].author %>','<%=twoList[i].press %>','<%=twoList[i].publishtime %>','<%=twoList[i].pageNum %>','<%=twoList[i].edition %>','<%=twoList[i].printtime %>','<%=twoList[i].wordNum %>','<%=twoList[i].booksize %>','<%=twoList[i].paper %>',)"><i class="icon ion-md-open"></i></a></li>
												</ul>
											</div>
										</div>
									</div>
									
									<!--=======  End of single product  =======-->
									<%    
										}
									%>
									
								</div>
								
								<!--=======  End of banner slider  =======-->

								
							</div>
						</div>
					</div>
					
					<!--=======  End of slider with banner and sidebar container  =======-->
				</div>
			</div>
		</div>
	</div>
	
	<!--=====  End of 小说  ======-->

	<!--=============================================
	=            图形 图像 多媒体         =
	=============================================-->
	
	<div class="slider-banner-sidebar-area mb-50">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<!--=======  slider with banner and sidebar container  =======-->
					
					<div class="slider-banner-sidebar-container">
						<div class="row no-gutters">
							<div class="col-lg-3 col-xl-2 col-md-4">
								<!--=======  sidebar  =======-->
								<%
									categoryList = categoryService.findChild("3");
								%>
								<div class="slider-sidebar">
									<h3 class="slider-sidebar-title">图形 图像 多媒体</h3>
									<div class="sidebar-list">
										<ul>
											<%
												for(int i = 0;i < categoryList.Count;i++)
												{
											%>
											<li><a href="shop.aspx?method=findByCid&cid=<%=categoryList[i].cid %>"><%=categoryList[i].cname %></a></li>
											<%
												}
												
											%>
											
										</ul>
									</div>
								</div>
								
								<!--=======  End of sidebar  =======-->
							</div>
							<div class="col-lg-9 col-xl-10 col-md-8">
								<!--=======  banner slider  =======-->
								
								<div class="fl-slider banner-slider">
									<%
										for (int i = 0; i < 6; i++)
										{
											//int index = indexList[random.Next(0, indexList.Count)];
											//indexList.Remove(index);
									%>
									<!--=======  single product  =======-->
									
									<div class="fl-product">
										<div class="image sale-product">
											<a href="single-product.aspx?method=findByBid&bid=<%=threeList[i].bid %>">
												<img src="assets/images/<%=threeList[i].image_b %>" class="img-fluid" alt="">
												<img src="assets/images/<%=threeList[i].image_b %>" class="img-fluid" alt="">
											</a>
											
                                            <%
                                        if (isLogin)
                                        {
                                            %>
                                            <!-- 收藏按钮 -->
											<span class="wishlist-icon">
													<a class="xingji" >
                                                        <input type="hidden" value="<%=threeList[i].bid%>" />
                                                <%
                                            if (threeList[i].statue == 0)
                                            {
                                                %>
                                                        <i class="icon ion-md-heart-empty"></i>
                                                <%
                                            }
                                            else if (threeList[i].statue == 1)
                                            {
                                                %>
                                                        <i class="icon ion-md-heart activexing"></i>
                                                <% 
                                            }
                                                %>
                                                        

													</a>
											</span>

                                            <% 
                                        }
                                            %>

										</div>
										<div class="content">
											<h2 class="product-title"> <a href="single-product.aspx?method=findByBid&bid=<%=threeList[i].bid %>" title="<%=threeList[i].bname %>"><%=threeList[i].bname %></a></h2>
											<div class="rating">
												<%
                                            int count = threeList[i].xingji / 20 > 5 ? 5 : threeList[i].xingji / 20;
									for (int k = 0; k < count; k++)
									{
										 %>
										<i class="fa fa-star active"></i>
										 <%
									}
										%>
											</div>
											<p class="product-price">
												<span class="main-price discounted">&yen;<%=threeList[i].price %></span>
												<span class="discounted-price">&yen;<%=threeList[i].currPrice %></span>
											</p>
                                            <p>
										        库存：<span ><%=threeList[i].stock%></span>
									        </p>

											<div class="hover-icons">
												<ul>
													<li><a  data-tooltip="加入购物车" onclick="buy('<%=threeList[i].bid %>','false')"><i class="icon ion-md-cart"></i></a></li>
													<li><a  data-toggle = "modal" data-target="#quick-view-modal-container" data-tooltip="详情" id="A3" onclick="passByValue('<%=threeList[i].bid %>','<%=threeList[i].bname %>','<%=threeList[i].price %>','<%=threeList[i].currPrice %>','<%=threeList[i].discount %>','<%=threeList[i].image_b %>','<%=threeList[i].author %>','<%=threeList[i].press %>','<%=threeList[i].publishtime %>','<%=threeList[i].pageNum %>','<%=threeList[i].edition %>','<%=threeList[i].printtime %>','<%=threeList[i].wordNum %>','<%=threeList[i].booksize %>','<%=threeList[i].paper %>',)"><i class="icon ion-md-open"></i></a></li>
												</ul>
											</div>
										</div>
									</div>
									
									<!--=======  End of single product  =======-->
									<%    
										}
									%>
									
								</div>
								
								<!--=======  End of banner slider  =======-->

								
							</div>
						</div>
					</div>
					
					<!--=======  End of slider with banner and sidebar container  =======-->
				</div>
			</div>
		</div>
	</div>
	
	<!--=====  End of 图形 图像 多媒体  ======-->


	<!--=============================================
	=            详细信息模态框         =
	=============================================-->

	<div class="modal fade quick-view-modal-container" id="quick-view-modal-container" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-5 col-md-6 col-xs-12 mb-xxs-25 mb-xs-25 mb-sm-25">
							<!-- single product tabstyle one image gallery -->
							<div class="product-image-slider fl-product-image-slider fl3-product-image-slider quickview-product-image-slider">
								<!--product large image start -->
								<div class="tab-content product-large-image-list fl-product-large-image-list fl3-product-large-image-list quickview-product-large-image-list" id="myTabContent2">
									<div class="tab-pane fade show active" id="single-slide-1-q" role="tabpanel" aria-labelledby="single-slide-tab-1-q">
										<!--Single Product Image Start-->
										<div class="single-product-img img-full">
											<img id="bookImg" src="assets/images/single-product-slider/01.jpg" class="img-fluid" alt="">
										</div>
										<!--Single Product Image End-->
									</div>
								</div>
								<!--product large image End-->
							</div>
							<!-- end of single product tabstyle one image gallery -->
						</div>
						<div class="col-lg-7 col-md-6 col-xs-12">
							<!-- product quick view description -->
							<div class="product-feature-details">
								<h2 id="bookName" class="product-title mb-15">商品名称</h2>

								<h2 class="product-price mb-15">
									<span id="bookPrice" class="main-price discounted">¥原价</span>
									<span id="bookCurrPrice" class="discounted-price">¥现价</span>
									<span id="bookDiscount" class="discount-percentage">Save 8%</span>
								</h2>

								<div class="container-fluid">
									<div class="row">
										<div id="bookAuthor" class="col-sm-12 col-md-12 col-lg-12 col-xl-12">作者： 著</div>
									</div>
									<div class="row">
										<div id="bookPress" class="col-sm-12 col-md-12 col-lg-12 col-xl-12">出版社：</div>
									</div>
									<div class="row">
										<div id="bookPublictime" class="col-sm-12 col-md-12 col-lg-12 col-xl-12">出版时间：</div>
									</div>
									<div class="row">
										<div id="bookPageNum" class="col-sm-4 col-md-4 col-lg-4 col-xl-4">页数：</div>
										<div id="bookEdtion" class="col-sm-4 col-md-4 col-lg-4 col-xl-4">版次：</div>
										<div id="bookPrinttime" class="col-sm-4 col-md-4 col-lg-4 col-xl-4">印刷时间：</div>
									</div>
									<div class="row">
										<div id="bookWordnum" class="col-sm-4 col-md-4 col-lg-4 col-xl-4">字数：</div>
										<div id="bookSize" class="col-sm-4 col-md-4 col-lg-4 col-xl-4">开本：</div>
										<div id="bookPage" class="col-sm-4 col-md-4 col-lg-4 col-xl-4">纸张：</div>
									</div>
								</div>


								<div class="cart-buttons mb-20">
									<div class="pro-qty mr-10">
										<input id="bookQuantity" type="text" value="1">
										<a href="#" class="inc qty-btn">+</a>
										<a href="#" class="dec qty-btn">-</a>
									</div>
									<div class="add-to-cart-btn">
										<a id="buyBook" class="fl-btn"><i class="fa fa-shopping-cart"></i>加入购物车</a>
									</div>
								</div>
							</div>
							<!-- end of product quick view description -->
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
	<!--=====  End of 详细信息模态框  ======-->


</asp:Content>
