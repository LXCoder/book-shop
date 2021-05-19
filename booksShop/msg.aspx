<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="msg.aspx.cs" Inherits="booksShop.msg" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">

        .divBody {
            margin-left:20%;
        }

        .divTitle {
            text-align: left;
            width: 900px;
            height: 25px;
            line-height: 25px;
            background-color: #C0C0C0;
            border: 5px solid #C0C0C0;
            margin-top: 30px;
        }

        .divContent {
            width: 900px;
            height: 230px;
            border: 5px solid #C0C0C0;
            margin-right: 20px;
            margin-bottom: 20px;
        }

        .spanTitle {
            margin-top: 10px;
            margin-left: 10px;
            height: 25px;
            font-weight: 900;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <% 
        string title = "";
        string img = "";
        string msg = "";
        if (Session["code"] != null || Session["msg"] != null)
        {
            if (Session["code"].ToString() == "success")
            {
                title = "成功";
                img = "assets/images/duihao.jpg";
            }
            else if (Session["code"].ToString() == "error")
            {
                title = "失败";
                img = "assets/images/cuohao.png";
            }
            msg = Session["msg"].ToString();
            Session.Contents.Remove("code");
            Session.Contents.Remove("msg");
        }
        
            
    %>
    <div class="divBody">
        <div class="divTitle">
            <span class="spanTitle"><%=title %></span>
        </div>
        <div class="divContent">
            <div style="margin: 20px;">
                <img style="float: left; margin-right: 30px;" src="<%=img %>" width="150" />
                <span style="font-size: 30px; color: #c30; font-weight: 900;"><%=msg %></span>
                <br />
                <br />
                <br />
                <br />
                <span style="margin-left: 50px;"><a target="_top" href="login.aspx">登录</a></span>
                <span style="margin-left: 50px;"><a target="_top" href="~/index.html">主页</a></span>
            </div>
        </div>
    </div>
</asp:Content>
