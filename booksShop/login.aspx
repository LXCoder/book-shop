<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="booksShop.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	
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
								<li>登陆</li>
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
	=            Login Register page content         =
	=============================================-->

	<div class="page-section mb-50">
		<div class="container">
			<div class="row">
				<div class="col-sm-12 col-md-12 col-xs-12 col-lg-6 mb-30">
					<!-- Login Form s-->

					<div class="login-form">
						<h4 class="login-title">登陆</h4>
						<%
							string errorMsg = "";
							if (Session["msg"] != null)
							{
								errorMsg = Session["msg"].ToString();
								Session.Contents.Remove("msg");
							}

							string username = "";
							if (Request.Cookies["loginname"] != null)
							{
								username = Request.Cookies["loginname"].Value;
							}

							if (Session["loginname"] != null)
							{
								username = Session["loginname"].ToString();
								Session.Contents.Remove("loginname");
							}
							loginname.Text = username;
						%>
						<div class="row">
							<div class="col-md-12 col-12 mb-20">
								<!--<asp:Label ID="msg" runat="server" Text="" ForeColor="Red"></asp:Label>-->
								<label id="msg" class="labelError"><%=errorMsg %></label>
							</div>
							<div class="col-md-12 col-12 mb-20">
								<label>用户名</label>
								<asp:TextBox ID="loginname" runat="server" CssClass="mb-0"></asp:TextBox>
								<label id="loginnameError" class="labelError"><%=errors["loginname"].ToString() %></label>
							</div>
							<div class="col-12 mb-20">
								<label>密码</label>
								<asp:TextBox ID="loginpass" runat="server" CssClass="mb-0" TextMode="Password"></asp:TextBox>
								<label id="loginpassError" class="labelError"><%=errors["loginpass"].ToString() %></label>
							</div>

							<div class="col-md-6 mb-20">
								<label>验证码</label>

								<asp:TextBox ID="verifyCode" runat="server" CssClass="mb-0"></asp:TextBox>
								<label id="verifyCodeError" class="labelError"><%=errors["verifyCode"].ToString() %></label>
							</div>
							<div class="col-md-6 mb-20">
								<label></label>
								<asp:UpdatePanel ID="UpdatePanel1" runat="server">
									<ContentTemplate>
										<asp:ImageButton ID="verifyCodeImg" runat="server" OnClick="changeVerifyCode"></asp:ImageButton>
									</ContentTemplate>

								</asp:UpdatePanel>

							</div>

							<div class="col-md-4 mt-10 mb-20 text-left text-md-right" style="left: 350px">
								<a href="register.aspx">没有账号?</a>
							</div>

							<div class="col-md-12">
								<button class="register-button mt-0" runat="server" onserverclick="loginFunction">登陆</button>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script src="assets/js/user/login.js"></script>
	<!--=====  End of Login Register page content  ======-->
</asp:Content>
