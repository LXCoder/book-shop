<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="booksShop.contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--=============================================
	=            breadcrumb area         =
	=============================================-->
	
	<div class="breadcrumb-area pt-15 pb-15 mb-0">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<!--=======  breadcrumb container  =======-->
					
					<div class="breadcrumb-container">
						<nav>
							<ul>
								<li class="parent-page"><a href="index.aspx">主页</a></li>
								<li>联系我们</li>
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
	=            Contact page content         =
	=============================================-->
	
	<div class="page-content mb-5">

		<!--=============================================
		=            google map container         =
		=============================================-->
		
		<div class="google-map-container mb-45">
			<div id="google-map"></div>
		</div>
		
		<!--=====  End of google map container  ======-->

		<div class="container">
			<div class="row">
				<div class="col-lg-5 offset-lg-1 col-md-12 mb-sm-45 order-1 order-lg-2 mb-md-45">
					<!--=======  contact page side content  =======-->
					
					<div class="contact-page-side-content">
						<h3 class="contact-page-title">联系我们</h3>
						<p class="contact-page-message mb-30">只要你有梦想，有创意，我们期待你的联系！</p>
						<!--=======  single contact block  =======-->
						
						<div class="single-contact-block">
							<h4><i class="fa fa-fax"></i> 地址</h4>
							<p>广东省江门市蓬江区五邑大学</p>
						</div>
						
						<!--=======  End of single contact block  =======-->

						<!--=======  single contact block  =======-->
						
						<div class="single-contact-block">
							<h4><i class="fa fa-phone"></i> 联系</h4>
							<p>手机: 123456789</p>
						</div>
						
						<!--=======  End of single contact block  =======-->

						<!--=======  single contact block  =======-->
						
						<div class="single-contact-block">
							<h4><i class="fa fa-envelope-o"></i> 邮箱</h4>
							<p>123456@qq.com</p>
						</div>
						
						<!--=======  End of single contact block  =======-->
					</div>
					
					<!--=======  End of contact page side content  =======-->

				</div>
				<div class="col-lg-6 col-md-12 order-2 order-lg-1">
					<!--=======  contact form content  =======-->
					
					<div class="contact-form-content">
						<h3 class="contact-page-title">留言</h3>

						<div class="contact-form">
							
								<div class="form-group">
									<label>姓名 <span class="required">*</span></label>
									<asp:TextBox ID="customername" runat="server" TextMode="SingleLine"></asp:TextBox>
								</div>
								<div class="form-group">
									<label>邮箱 <span class="required">*</span></label>
									<asp:TextBox ID="customerEmail" runat="server" TextMode="Email"></asp:TextBox>
								</div>
								<div class="form-group">
									<label>主题</label>
									
									<asp:TextBox ID="contactSubject" runat="server" TextMode="SingleLine"></asp:TextBox>
								</div>
								<div class="form-group">
									<label>留言</label>
									
									<asp:TextBox ID="contactMessage" runat="server" Height="200" TextMode="MultiLine"></asp:TextBox>
								</div>
								<div class="form-group mb-0">
									<asp:Button ID="submit" runat="server" Text="发送" CssClass="fl-btn" Width="94.11" Height="44" OnClick="sendMessege" />
								</div>
							
						</div>
						<p class="form-messege pt-10 pb-10 mt-10 mb-10"></p>
					</div>
					
					<!--=======  End of contact form content =======-->
				</div>
			</div>
		</div>
	</div>
	
	<!--=====  End of Contact page content  ======-->

	<!-- AJAX mail JS -->
	<script src="assets/js/ajax-mail.js"></script>
	<!-- Google Map -->
	
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=sLCgSI51R5ryIabG9PaED0hcZ4uwSVHb"></script>
	
	<script>
		var map = new BMap.Map("google-map");          // 创建地图实例  
		var point = new BMap.Point(113.091018, 22.603765);  // 创建点坐标  
		map.centerAndZoom(point, 14);  // 初始化地图,设置中心点坐标和地图级别
		//添加地图类型控件
		map.addControl(new BMap.MapTypeControl({
			mapTypes: [
				BMAP_NORMAL_MAP,
				BMAP_HYBRID_MAP
			]
		}));
		map.addControl(new BMap.NavigationControl());//缩放平移控件
		map.addControl(new BMap.ScaleControl());    //比例尺
		map.addControl(new BMap.OverviewMapControl());//缩略图

		map.setCurrentCity("江门");          // 设置地图显示的城市 此项是必须设置的
		map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放

		var myIcon = new BMap.Icon("assets/images/icons/map-marker.png", new BMap.Size(56, 76));
		var marker = new BMap.Marker(point, { icon: myIcon });
		map.addOverlay(marker);
		marker.setAnimation(BMAP_ANIMATION_BOUNCE);//跳动的动画

	</script>

</asp:Content>
