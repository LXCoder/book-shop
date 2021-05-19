using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using booksShop.App_Code;

namespace booksShop
{
    public partial class ordersuccess : System.Web.UI.Page
    {
        public Order order;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["order"] == null)
            {
                //Response.Redirect("checkout.aspx");
            }
            else
            {
                order = (Order)Session["order"];
            }
        }
    }
}