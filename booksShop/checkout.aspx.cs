using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using booksShop.App_Code;
using booksShop.App_Code.cart;
using booksShop.App_Code.order;

namespace booksShop
{
	public partial class checkout : System.Web.UI.Page
	{
		private OrderService orderService = new OrderService();
		private CartItemService cartItemService = new CartItemService();
		public List<CartItem_> orderItemList = new List<CartItem_>();
		public string subTotal;
		public string cartItemIds;
		
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["orderItemList"] == null || Session["session_user"] == null)
			{
				//Response.Redirect("cart.aspx");
			}
			else
			{
				orderItemList = (List<CartItem_>)Session["orderItemList"];
				subTotal = Session["totalPrice"].ToString();
				cartItemIds = Session["cartItemIds"].ToString();
			}
			string method = "";
			if (Request.QueryString["method"] != null)
			{
				method = Request.QueryString["method"];
				switch (method)
				{
					case "creatOrder":
						creatOrder();break;
				}
			}
		}

		/// <summary>
		/// 创建订单
		/// </summary>
		public void creatOrder() 
		{
			//获取参数
			string address = Request.QueryString["address"];
			User user = (User)Session["session_user"];

			//判断购物车是否有商品
			if (orderItemList.Count == 0) {
				Session["code"] = "error";
				Session["msg"] = "你的购物车没有商品，不能下单！";
				Response.Redirect("msg.aspx");
			}
			//实例化一个order
			Order order = new Order();
			order.oid = Guid.NewGuid().ToString("N").ToUpper();
			order.ordertime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
			order.status = 1;
			order.address = address;
			order.uid = user.uid;
			order.total = decimal.Parse(subTotal);
		
			//设置order的orderItemList属性
			List<Orderitem> orderItems = new List<Orderitem>();
			foreach (CartItem_ item in orderItemList)
			{
				Orderitem orderItem = new Orderitem();
				orderItem.orderItemId = Guid.NewGuid().ToString("N").ToUpper();
				orderItem.quantity = item.quantity_;
				orderItem.subtotal = item.subtotal;
				orderItem.bid = item.bid_;
				orderItem.bname = item.Book.bname;
				orderItem.currPrice = item.Book.currPrice;
				orderItem.image_b = item.Book.image_b;
				orderItem.oid = order.oid;
				orderItems.Add(orderItem);
			}
			
			//调用orderService的方法
			orderService.creatOrder(order, orderItems);
			//删除购物车下单的商品
			cartItemService.batchDelete(cartItemIds);
			Session.Contents.Remove("orderItemList");
			Session.Contents.Remove("totalPrice");
			Session.Contents.Remove("cartItemIds");
			//保存到域
			Session["order"] = order;
			Response.Redirect("ordersuccess.aspx");
		}

		
	}
}