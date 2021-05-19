<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="shop.aspx.cs" Inherits="booksShop.index" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="assets/css/toastr.min.css" rel="stylesheet" />
    <script src="assets/js/toastr.min.js"></script>
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
                                <li>商店</li>
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
    =            shop page content         =
    =============================================-->

    <div class="shop-page-content mb-50">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 order-2 order-lg-1">
                    <!--=======  page sidebar   =======-->

                    <div class="page-sidebar">
                        <!--=======  single sidebar block  =======-->

                        <div class="single-sidebar">
                            <h3 class="sidebar-title">分类</h3>

                            <div class="category">

                                <ul>

                                    <%
                                        for (int i = 0; i < categories.Count; i++)
                                        {
                                    %>
                                    <li>
                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#"><%=categories[i].cname %>
                                            <span class="caret"></span>
                                        </a>
                                        <ul class="dropdown-menu">


                                            <%    for (int j = 0; j < categories[i].childrens.Count; j++)
                                                  {
                                            %>
                                            <li style="text-align: center">
                                                <a href="shop.aspx?method=findByCid&cid=<%=categories[i].childrens[j].cid %>"><%=categories[i].childrens[j].cname %></a>

                                            </li>
                                            <%  }  %>
                                        </ul>
                                    </li>
                                    <%  }  %>
                                </ul>

                            </div>


                        </div>

                        <!--=======  End of single sidebar block  =======-->


                        <!--=======  single sidebar block  =======-->

                        <div class="single-sidebar">
                            <h3 class="sidebar-title">热门标签</h3>

                            <!--=======  tag container  =======-->

                            <ul class="tag-container">
                                <li><a href="searchPage.aspx?method=findByBname&searchKeyWord=Java">Java</a> </li>
                                <li><a href="searchPage.aspx?method=findByBname&searchKeyWord=ASP.NET">ASP.NET</a> </li>
                                <li><a href="searchPage.aspx?method=findByBname&searchKeyWord=实战">实战</a> </li>
                                <li><a href="searchPage.aspx?method=findByBname&searchKeyWord=Web">Web</a> </li>
                                <li><a href="searchPage.aspx?method=findByBname&searchKeyWord=PS">PS</a> </li>
                                <li><a href="searchPage.aspx?method=findByBname&searchKeyWord=图像">图像</a> </li>
                            </ul>

                            <!--=======  End of tag container  =======-->
                        </div>

                        <!--=======  End of single sidebar block  =======-->
                    </div>

                    <!--=======  End of page sidebar   =======-->
                </div>

                <div class="col-lg-9 order-1 order-lg-2">


                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>

                            <!--=======  Shop header  =======-->

                            <div class="shop-header mb-30">
                                <div class="row">
                                    <div class="col-lg-4 col-md-4 col-sm-12 d-flex align-items-center">
                                        <!--=======  view mode  =======-->

                                        <div class="view-mode-icons mb-xs-10">
                                            <a class="active" href="#" data-target="grid"><i class="icon ion-md-apps"></i></a>
                                            <a href="#" data-target="list"><i class="icon ion-ios-list"></i></a>
                                        </div>

                                        <!--=======  End of view mode  =======-->

                                    </div>

                                </div>
                            </div>

                            <!--=======  End of Shop header  =======-->

                            <!--=======  shop product display area  =======-->
                            <div class="shop-product-wrap grid row mb-30 no-gutters">

                                <%
                                    for (int i = 0; i < pageBean.beanList.Count; i++)
                                    {
                                %>

                                <div class="col-lg-3 col-md-6 col-sm-6 col-12">
                                    <!--=======  grid view product  =======-->

                                    <!--=======  single product  =======-->

                                    <div class="fl-product shop-grid-view-product">
                                        <div class="image">
                                            <a href="single-product.aspx?method=findByBid&bid=<%=pageBean.beanList[i].bid %>">
                                                <img src="assets/images/<%=pageBean.beanList[i].image_b %>" class="img-fluid" alt="">
                                                <img src="assets/images/<%=pageBean.beanList[i].image_b %>" class="img-fluid" alt="">
                                            </a>
                                            <%
                                        if (isLogin)
                                        {
                                            %>
                                            <!-- 收藏按钮 -->
											<span class="wishlist-icon">
													<a class="xingji" >
                                                        <input type="hidden" value="<%=pageBean.beanList[i].bid%>" />
                                                <%
                                            if (pageBean.beanList[i].statue == 0)
                                            {
                                                %>
                                                        <i class="icon ion-md-heart-empty"></i>
                                                <%
                                            }else if (pageBean.beanList[i].statue == 1)
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
                                            <h2 class="product-title"><a href="single-product.aspx?method=findByBid&bid=<%=pageBean.beanList[i].bid %>" title="<%=pageBean.beanList[i].bname %>"><%=pageBean.beanList[i].bname %></a></h2>
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
                                                <span class="main-price discounted">¥<%=pageBean.beanList[i].price %></span>
                                                <span class="discounted-price">¥<%=pageBean.beanList[i].currPrice %></span>
                                            </p>
                                            <p>
										        库存：<span ><%=pageBean.beanList[i].stock%></span>
									        </p>
                                            <div class="hover-icons">
                                                <ul>
                                                    <li><a data-tooltip="加入购物车" onclick="buy('<%=pageBean.beanList[i].bid %>','false')"><i class="icon ion-md-cart"></i></a></li>
                                                    <li>
                                                        <a data-toggle="modal" data-target="#quick-view-modal-container" data-tooltip="详情" id="detailPage" onclick="passByValue('<%=pageBean.beanList[i].bid %>','<%=pageBean.beanList[i].bname %>','<%=pageBean.beanList[i].price %>','<%=pageBean.beanList[i].currPrice %>','<%=pageBean.beanList[i].discount %>','<%=pageBean.beanList[i].image_b %>','<%=pageBean.beanList[i].author %>','<%=pageBean.beanList[i].press %>','<%=pageBean.beanList[i].publishtime %>','<%=pageBean.beanList[i].pageNum %>','<%=pageBean.beanList[i].edition %>','<%=pageBean.beanList[i].printtime %>','<%=pageBean.beanList[i].wordNum %>','<%=pageBean.beanList[i].booksize %>','<%=pageBean.beanList[i].paper %>',)">
                                                            <i class="icon ion-md-open"></i>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                                    <!--=======  End of single product  =======-->

                                    <!--=======  End of grid view product  =======-->

                                    <!--=======  list view product  =======-->

                                    <div class="fl-product shop-list-view-product">
                                        <div class="image">
                                            <a href="single-product.aspx?method=findByBid&bid=<%=pageBean.beanList[i].bid %>">
                                                <img src="assets/images/<%=pageBean.beanList[i].image_b %>" class="img-fluid" alt="">
                                                <img src="assets/images/<%=pageBean.beanList[i].image_b %>" class="img-fluid" alt="">
                                            </a>
                                            <!-- wishlist icon -->
											<span class="wishlist-icon">
													<a class="xingji" ><input type="hidden" value="<%=pageBean.beanList[i].bid%>" /><i class="icon ion-md-heart-empty"></i></a>
											</span>
                                        </div>
                                        <div class="content">
                                            <h2 class="product-title"><a href="single-product.aspx?method=findByBid&bid=<%=pageBean.beanList[i].bid %>"><%=pageBean.beanList[i].bname %></a></h2>
                                            <div class="rating">
                                                <%
                                        count = pageBean.beanList[i].xingji / 20 > 5 ? 5 : pageBean.beanList[i].xingji / 20;
                                        for (int k = 0; k < count; k++)
                                        {
                                                %>
                                                <i class="fa fa-star active"></i>
                                                <%
                                        }
                                                %>
                                            </div>
                                            <p class="product-price">
                                                <span class="main-price discounted">¥<%=pageBean.beanList[i].price %></span>
                                                <span class="discounted-price">¥<%=pageBean.beanList[i].currPrice %></span>
                                            </p>
                                            <p>
										        库存：<span ><%=pageBean.beanList[i].stock%></span>
									        </p>

                                            <div>
                                                <div class="">作者：<%=pageBean.beanList[i].author %> 著</div>
                                                <div class="">出版社：<%=pageBean.beanList[i].press %></div>
                                                <div class="">出版时间：<%=pageBean.beanList[i].publishtime %></div>
                                                <div class="">页数：<%=pageBean.beanList[i].pageNum %></div>
                                                <div class="">版次：<%=pageBean.beanList[i].edition %></div>
                                                <div class="">印刷时间：<%=pageBean.beanList[i].printtime %></div>
                                                <div class="">字数：<%=pageBean.beanList[i].wordNum %></div>
                                                <div class="">开本：<%=pageBean.beanList[i].booksize %></div>
                                                <div class="">纸张：<%=pageBean.beanList[i].paper %></div>
                                            </div>


                                            <div class="hover-icons">
                                                <ul>
                                                    <li><a data-tooltip="加入购物车" onclick="buy('<%=pageBean.beanList[i].bid %>','false')">加入购物车</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                                    <!--=======  End of list view product  =======-->
                                </div>

                                <%      
                                    }    
                                %>
                            </div>

                            <!--=======  End of shop product display area  =======-->

                            <!--=======  pagination area  =======-->


                            <!-- 计算begin和end 
                                如果总页数<=6，那么显示所有页码，即begin=1 end=总页数 
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
                                    <span>...</span>
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

                            <!--=======  End of pagination area  =======-->

                        </ContentTemplate>

                    </asp:UpdatePanel>

                </div>
            </div>
        </div>
    </div>

    <!--=====  End of shop page content  ======-->

    <!--=============================================
    =            Quick view modal         =
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
                                <!-- 商品描述 -->
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
                                        <input id="bookQuantity" type="text" value="1" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();">
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
    <!--=====  End of Quick view modal  ======-->

</asp:Content>
