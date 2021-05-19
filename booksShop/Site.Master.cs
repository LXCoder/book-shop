using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using booksShop.App_Code;
using booksShop.App_Code.category;
using booksShop.App_Code.book;
using booksShop.App_Code.page;
using booksShop.App_Code.cart;

namespace booksShop
{
	public partial class Site : System.Web.UI.MasterPage
	{
		public bool flag;
		public User user;
		private CategoryService categoryService = new CategoryService();
		private CartItemService cartItemService = new CartItemService();
		public List<CartItem_> cartItemList = new List<CartItem_>();
		public List<Category> categories = new List<Category>();

		protected void Page_Load(object sender, EventArgs e)
		{
			flag = Session["session_user"] != null;
			if (flag)
			{
				user = (User)Session["session_user"];
				cartItemList = cartItemService.myCart(user.uid);
			}
			categories = categoryService.finaAll();
		}

		/*protected void exit(object sender, EventArgs e)
		{
			Session.Contents.Remove("session_user");
			Response.Redirect("login.aspx");
		}*/
	}
}