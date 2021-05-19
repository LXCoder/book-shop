using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using booksShop.App_Code;
using booksShop.App_Code.util;
using booksShop.App_Code.user;
using booksShop.App_Code.order;
using booksShop.App_Code.book;
using booksShop.App_Code.page;
using Newtonsoft.Json;

namespace booksShop.admin
{
	public partial class orderAdmin : System.Web.UI.Page
	{
		public PageBean<Order> pb = new PageBean<Order>();

		private OrderService orderService = new OrderService();
        private BookService bookService = new BookService();

		protected void Page_Load(object sender, EventArgs e)
		{
			string method = "";
			if (!IsPostBack)
			{
				if (Request.QueryString["method"] != null)
				{
					method = Request.QueryString["method"];
				}
				else
				{
					pb = orderService.findAll(1);
					pb.url = getUrl() + "?method=findAll";
				}
			}

			switch (method)
			{
				case "findAll":
					findAll(); break;
				case "findByStatus":
					findByStatus(); break;
				case "cancel":
					cancel(); break;
				case "deliver":
					deliver(); break;
			}
		}

		/// <summary>
		/// 查找全部订单
		/// </summary>
		public void findAll()
		{
			//得到pc：如果页面传递，使用页面的，如果没传，pc=1
			int pc = getPc();
			//得到url
			String url = getUrl();
			//调用service的查询方法获得PageBean
			pb = orderService.findAll(pc);
			//给PageBean设置url，保存PageBean
			pb.url = url;
		}


		/// <summary>
		/// 按订单状态查询
		/// </summary>
		/// <returns></returns>
		public void findByStatus()
		{
			//得到pc：如果页面传递，使用页面的，如果没传，pc=1
			int pc = getPc();
			//得到url
			string url = getUrl();
			//获取查询条件
			string status = "1";
			if (Request.QueryString["status"] != null)
				status = Request.QueryString["status"];
			//调用查询方法返回PageBean
			pb = orderService.findByStatus(int.Parse(status), pc);
			//给PageBean设置url，保存PageBean
			pb.url = url;
		}


		/// <summary>
		/// 取消订单
		/// </summary>
		public void cancel()
		{
			CommonModel commonModel = new CommonModel();
			string oid = Request.QueryString["oid"];
			try
			{
				if (orderService.findStatus(oid) != 1)
				{
					commonModel.status = false;
					commonModel.msg = "你当前的状态不可以取消订单！";
				}
				orderService.changeStatus(oid, 5);
				commonModel.status = true;
				commonModel.msg = "取消订单成功！";

			}
			catch (Exception e)
			{
                commonModel.msg = "取消订单失败：" + e.Message;
			}
			finally
			{
				object JSONObj = JsonConvert.SerializeObject(commonModel);
				Response.Write(JSONObj);
				//一定要加，不然前端接收失败
				Response.End();
			}
		}

		/// <summary>
		/// 发货
		/// </summary>
		public void deliver()
		{
			CommonModel commonModel = new CommonModel();
			string oid = Request.QueryString["oid"];
			try
			{
				if (orderService.findStatus(oid) != 2)
				{
					commonModel.status = false;
					commonModel.msg = "你当前的状态不可以发货！";
				}
				orderService.changeStatus(oid, 3);
                Book book = new Book();
                foreach (Orderitem item in orderService.loadOrder(oid).Orderitem)
                {
                    book = bookService.findByBid(item.bid);
                    book.stock = book.stock - (int)item.quantity;
                    bookService.editStock(book);
                }
				commonModel.status = true;
				commonModel.msg = "发货成功，请查看物流！";
			}
			catch (Exception e)
			{
                commonModel.msg = "发货失败：" + e.Message;
			}
			finally
			{
				object JSONObj = JsonConvert.SerializeObject(commonModel);
				Response.Write(JSONObj);
				//一定要加，不然前端接收失败
				Response.End();
			}
		}

		/// <summary>
		/// 获取当前页码
		/// </summary>
		/// <returns></returns>
		private int getPc()
		{
			int pc = 1;
			string param = Request.QueryString["pc"];
			if (param != null && !String.IsNullOrEmpty(param.Trim()))
			{
				try
				{
					pc = int.Parse(param);
				}
				catch (Exception e)
				{
					throw new Exception(e.Message, e);
				}
			}
			return pc;
		}

		/// <summary>
		/// 获取请求路径
		/// </summary>
		/// <param name="request"></param>
		/// <returns></returns>
		private String getUrl()
		{
			string url = Request.Url.PathAndQuery;
			int index = url.LastIndexOf("pc=");
			if (index != -1)
				url = url.Substring(7, index - 8);
			else
				url = url.Substring(7);
			return url;
		}
	}



}