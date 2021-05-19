<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="single-product.aspx.cs" Inherits="booksShop.single_product" %>

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
                                <li class="parent-page"><a href="index.aspx">主页</a></li>
                                <li>详情页</li>
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
	=            书籍单品         =
	=============================================-->

    <div class="single-product-content-area mb-50">
        <div class="container">
            <div class="row">
                <div class="col-lg-5 col-md-6 col-xs-12 mb-xxs-25 mb-xs-25 mb-sm-25">
                    <!-- single product tabstyle one image gallery -->
                    <div class="product-image-slider fl-product-image-slider fl3-product-image-slider">
                        <!--product large image start -->
                        <div class="tab-content product-large-image-list fl-product-large-image-list fl3-product-large-image-list" id="myTabContent">
                            <div class="tab-pane fade show active" id="single-slide-1" role="tabpanel" aria-labelledby="single-slide-tab-1">
                                <!--Single Product Image Start-->
                                <div class="single-product-img img-full">
                                    <img src="assets/images/<%=book.image_w %>" class="img-fluid" alt="">
                                    <a href="assets/images/<%=book.image_w %>" class="big-image-popup"><i class="fa fa-search-plus"></i></a>
                                </div>
                                <!--Single Product Image End-->
                            </div>

                        </div>
                        <!--product large image End-->

                        <!--product small image slider Start-->

                    </div>
                    <!-- end of single product tabstyle one image gallery -->
                </div>
                <div class="col-lg-7 col-md-6 col-xs-12">
                    <!-- product view description -->
                    <div class="product-feature-details">
                        <h2 class="product-title mb-15"><%=book.bname %></h2>

                        <div class="rating d-inline-block mb-15">
                            <%
                                int count = book.xingji / 20 > 5 ? 5 : book.xingji / 20;
                                for (int k = 0; k < count; k++)
                                {
                            %>
                            <i class="fa fa-star active"></i>
                            <%
                                }
                            %>
                        </div>

                        <h2 class="product-price mb-0">
                            <span class="main-price discounted">￥<%=book.price %></span>
                            <span class="discounted-price">￥<%=book.currPrice %></span>
                        </h2>

                        <!--<p class="product-description mb-20">商品描述</p>-->
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-sm-4 col-md-4 col-lg-4 col-xl-4">作者：<%=book.author %> 著</div>
                                <div class="col-sm-4 col-md-4 col-lg-4 col-xl-4">出版社：<%=book.press %></div>
                                <div class="col-sm-4 col-md-4 col-lg-4 col-xl-4">出版时间：<%=book.publishtime %></div>
                            </div>
                            <div class="row">
                                <div class="col-sm-4 col-md-4 col-lg-4 col-xl-4">页数：<%=book.pageNum %></div>
                                <div class="col-sm-4 col-md-4 col-lg-4 col-xl-4">版次：<%=book.edition %></div>
                                <div class="col-sm-4 col-md-4 col-lg-4 col-xl-4">印刷时间：<%=book.printtime %></div>
                            </div>
                            <div class="row">
                                <div class="col-sm-4 col-md-4 col-lg-4 col-xl-4">字数：<%=book.wordNum %></div>
                                <div class="col-sm-4 col-md-4 col-lg-4 col-xl-4">开本：<%=book.booksize %></div>
                                <div class="col-sm-4 col-md-4 col-lg-4 col-xl-4">纸张：<%=book.paper %></div>
                            </div>
                        </div>

                        <div class="cart-buttons mb-20">
                            <span class="quantity-title mr-10">数量: </span>
                            <div class="pro-qty mb-20">
                                <input id="bookQuantity" type="text" value="1">
                                <a href="#" class="inc qty-btn">+</a>
                                <a href="#" class="dec qty-btn">-</a>
                            </div>
                            <div class="add-to-cart-btn d-block">
                                <a href="#" class="fl-btn" onclick="buy('<%=book.bid %>','true')"><i class="fa fa-shopping-cart"></i>加入购物车</a>
                            </div>
                        </div>
                    </div>
                    <!-- end of product quick view description -->
                </div>
            </div>
        </div>
    </div>

    <!--=====  End of 书籍单品  ======-->


    <!--=============================================
	=            推荐书籍         =
	=============================================-->

    <div class="related-product-slider-area mb-50">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <!--=======  section title  =======-->

                    <div class="section-title">
                        <h2>推荐书籍</h2>
                    </div>

                    <!--=======  End of section title  =======-->
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <!--=======  tab product slider  =======-->

                    <div class="fl-slider tab-product-slider">
                        <!--=======  single product  =======-->
                        <%
                            Random random = new Random();
                            for (int i = 0; i < 6; i++)
                            {
                                int index = indexList[random.Next(0, bookList.Count)];
                                indexList.Remove(index);
                        %>
                        <div class="fl-product">
                            <div class="image sale-product">
                                <a href="single-product.aspx?method=findByBid&bid=<%=bookList[index].bid %>">
                                    <img src="assets/images/<%=bookList[index].image_b %>" class="img-fluid" alt="">
                                    <img src="assets/images/<%=bookList[index].image_b %>" class="img-fluid" alt="">
                                </a>
                               

                                <%
                                        if (isLogin)
                                        {
                                            %>
                                            <!-- 收藏按钮 -->
											<span class="wishlist-icon">
													<a class="xingji" >
                                                        <input type="hidden" value="<%=bookList[index].bid%>" />
                                                <%
                                            if (bookList[index].statue == 0)
                                            {
                                                %>
                                                        <i class="icon ion-md-heart-empty"></i>
                                                <%
                                            }else if (bookList[index].statue == 1)
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
                                <h2 class="product-title"><%=bookList[index].bname %></h2>
                                <div class="rating">
                                    <%
                                count = bookList[index].xingji / 20 > 5 ? 5 : bookList[index].xingji / 20;
                                for (int k = 0; k < count; k++)
                                {
                                    %>
                                    <i class="fa fa-star active"></i>
                                    <%
                                }
                                    %>
                                </div>
                                <p class="product-price">
                                    <span class="main-price discounted">&yen;<%=bookList[index].price %></span>
                                    <span class="discounted-price">&yen;<%=bookList[index].currPrice %></span>
                                </p>

                                <div class="hover-icons">
                                    <ul>
                                        <li><a data-tooltip="加入购物车" onclick="buy('<%=bookList[index].bid %>','false')"><i class="icon ion-md-cart"></i></a></li>
                                        <li><a data-toggle="modal" data-target="#quick-view-modal-container" data-tooltip="详情" id="detailPage" onclick="passByValue('<%=bookList[index].bid %>','<%=bookList[index].bname %>','<%=bookList[index].price %>','<%=bookList[index].currPrice %>','<%=bookList[index].discount %>','<%=bookList[index].image_b %>','<%=bookList[index].author %>','<%=bookList[index].press %>','<%=bookList[index].publishtime %>','<%=bookList[index].pageNum %>','<%=bookList[index].edition %>','<%=bookList[index].printtime %>','<%=bookList[index].wordNum %>','<%=bookList[index].booksize %>','<%=bookList[index].paper %>',)"><i class="icon ion-md-open"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <%
								 
                            }
                        %>


                        <!--=======  End of single product  =======-->


                        <!--=======  End of tab product slider  =======-->
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!--=====  End of 推荐书籍  ======-->

    <!--=============================================
	=            详情模态框         =
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
                                        <input id="Text1" type="text" value="1">
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
    <!--=====  End of 详情模态框  ======-->

</asp:Content>
