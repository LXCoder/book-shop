using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using booksShop.App_Code;

namespace booksShop
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        public Admin admin;
        public bool flag = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["session_admin"] != null)
            {
                admin = (Admin)Session["session_admin"];
                flag = true;
            }
            else
            {
                Session["admin_msg"] = "管理员未登录！";
                Response.Redirect("login.aspx");
            }
             
        }
    }
}