<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="booksShop.register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<style>
	    .leibie input[type="radio"] {
	        width:20px;
            
        }
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

	<div class="breadcrumb-area pt-15 pb-15">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<!--=======  breadcrumb container  =======-->

					<div class="breadcrumb-container">
						<nav>
							<ul>
								<li class="parent-page"><a href="index.aspx">首页</a></li>
								<li>注册</li>
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

						<h4 class="login-title">注册</h4>

						<div class="row">
							<div class="col-md-12 mb-20">
								<label>用户名*</label>
								<!--<input class="mb-0" type="text" placeholder="First Name">-->
								<asp:TextBox ID="loginname" runat="server" CssClass="mb-0"></asp:TextBox>
								<label id="loginnameError" class="labelError"><%=errors["loginname"].ToString() %></label>
							</div>
							<div class="col-md-6 mb-20">
								<label>密码*</label>
								<!--<input class="mb-0" type="password" placeholder="Password">-->
								<asp:TextBox ID="loginpass" runat="server" CssClass="mb-0" TextMode="Password"></asp:TextBox>
								<label id="loginpassError" class="labelError"><%=errors["loginpass"].ToString() %></label>
							</div>
							<div class="col-md-6 mb-20">
								<label>确认密码*</label>
								<!--<input class="mb-0" type="password" placeholder="Confirm Password">-->
								<asp:TextBox ID="reloginpass" runat="server" CssClass="mb-0" TextMode="Password"></asp:TextBox>
								<label id="reloginpassError" class="labelError"><%=errors["reloginpass"].ToString() %></label>
							</div>
                            <!--<div class="col-md-6 mb-20">
								<label>专业类别</label>

								<div class="row" >
                                    
                                    <div class="col-6" >
                                        
                                        <label class="leibie"><input type="radio" name="students" value="1" >文科生</label>
								    </div>
                                    <div class="col-6" >
                                       
		                                <label class="leibie"><input type="radio" name="students" value="2">理科生</label>
                                
								    </div>
								</div>
 								<label id="Label1" class="labelError"><%=errors["reloginpass"].ToString() %></label>
							</div>
                                -->
							<div class="col-md-12 mb-20">
								<label>Email*</label>
								<!--<input class="mb-0" type="email" placeholder="Email Address">-->
								<asp:TextBox ID="email" runat="server" CssClass="mb-0" TextMode="Email"></asp:TextBox>
								<label id="emailError" class="labelError"><%=errors["email"].ToString() %></label>
							</div>
							<div class="col-md-6 mb-20">
								<label>验证码*</label>
								<!--<input class="mb-0" type="password" placeholder="Password">-->
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
							<div class="col-12">
								<button class="register-button mt-0" runat="server" onserverclick="registerFunction">注册</button>
							</div>
						</div>

					</div>


				</div>
			</div>
		</div>
	</div>

	<!--=====  End of Login Register page content  ======-->
	
	<script src="assets/js/user/regist.js"></script>

</asp:Content>
