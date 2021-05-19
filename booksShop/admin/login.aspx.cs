using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using booksShop.App_Code.admin;
using booksShop.App_Code;

namespace booksShop.admin
{
    public partial class login : System.Web.UI.Page
    {
        private AdminService adminService = new AdminService();

        protected void Page_Load(object sender, EventArgs e)
        {
            string method = "";
            if (Request.QueryString["method"] != null)
                method = Request.QueryString["method"];
            switch (method)
            {

                case "exit":
                    exit();
                    break;
            }
        }




        /// <summary>
        /// 退出
        /// </summary>
        private void exit()
        {
            Session.Contents.Remove("session_admin");
            Response.Redirect("login.aspx");
        }

        protected void adminLogin(object sender, EventArgs e)
        {
            Admin adminForm = new Admin();
            adminForm.adminname = admin_username.Value;
            adminForm.adminpwd = admin_password.Value;
            List<Admin> list = adminService.login(adminForm);
            if (list.Count == 0)
            {
                Session["admin_msg"] = "用户名或密码错误!";
                return;
            }
            else
            {
                Session["session_admin"] = list[0];
                Response.Redirect("/admin/index.aspx");
            }
        }
    }
}