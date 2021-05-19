<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="booksShop.admin.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>后台登陆</title>
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" media="all" />
    <!-- Custom Theme files -->
    <link href="../assets/css/style.css" rel="stylesheet" type="text/css" media="all" />
    <!--js-->
    <script src="../assets/js/vendor/jquery.min.js"></script>
    <!--icons-css-->
    <link href="../assets/css/font-awesome.css" rel="stylesheet" />
    <!--Google Fonts-->
    <link href='https://fonts.googleapis.com/css?family=Carrois+Gothic' rel='stylesheet' type='text/css' />
    <link href='https://fonts.googleapis.com/css?family=Work+Sans:400,500,600' rel='stylesheet' type='text/css' />
    <!--static chart-->
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-page">
            <div class="login-main">
                <div class="login-head">
                    <h1>Admin Login</h1>
                </div>
                <div class="login-block">
                    <%
                        string errorMsg = "";
                        if (Session["admin_msg"] != null )
                        {
                            errorMsg =  Session["admin_msg"].ToString();
                            Session.Contents.Remove("admin_msg");
                        }
                    %>
                    <label style="color:red"><%=errorMsg %></label>
                    <input id="admin_username" type="text" name="username" placeholder="管理员账户" required="" runat="server"/>
                    <input id="admin_password" type="password" name="password" class="lock" placeholder="密码" runat="server"/>
                    
                    <input id="Button1" type="button" name="Sign In" value="登陆" runat="server" onserverclick="adminLogin" />	
                    
                </div>
            </div>
        </div>
        <!--inner block end here-->
        <!--copy rights start here-->
        <div class="copyrights">
            <p>Copyright &copy; 2020 End, All Rights Reserved.</p>
        </div>
        <!--COPY rights end here-->

        <!--scrolling js-->
        <script src="js/jquery.nicescroll.js"></script>
        <script src="js/scripts.js"></script>
        <!--//scrolling js-->
        <script src="js/bootstrap.js"> </script>
        <!-- mother grid end here-->
    </form>
</body>
</html>
