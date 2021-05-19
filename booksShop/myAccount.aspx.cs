using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using booksShop.App_Code;
using booksShop.App_Code.util;
using booksShop.App_Code.user;
using booksShop.App_Code.order;
using booksShop.App_Code.page;
using booksShop.App_Code.collection;
using Newtonsoft.Json;


namespace booksShop
{
	public partial class myAcount : System.Web.UI.Page
	{
		public User user;
		public Dictionary<string, string> errors = new Dictionary<string, string>();
        public PageBean<Order> pb = new PageBean<Order>();
        public List<Collection> collectionList = new List<Collection>();
		private UserService userService = new UserService();
        private OrderService orderService = new OrderService();
        private CollectionService collectionService = new CollectionService();
        
		

		protected void Page_Load(object sender, EventArgs e)
		{
			errors.Add("loginpass", "");
			errors.Add("newpass", "");
			errors.Add("reloginpass", "");
			if (Session["session_user"] == null)
				Response.Redirect("login.aspx");
			else
				user = (User)Session["session_user"];
                
			
            if (!IsPostBack)
            {
                pb = orderService.myOrder(user.uid, 1);
                collectionList = collectionService.findCollectionByUid(user.uid);
                pb.url = getUrl() + "?method=myOrder";
            }
            
			string method = "";
			if (Request.QueryString["method"] != null)
			{
				method = Request.QueryString["method"];
				switch (method)
				{
					case "updatePassword":
                        updatePassword();break;
                    case "myOrder":
                        myOrder();break;
                    case "comfirm":
                        comfirm();break;
                    case "cancel":
                        cancel();break;
                    case "loadOrder":
                        loadOrder();break;
                    case "delCollection":
                        delCollection();break;
				}
			}
		}

        /// <summary>
        /// 移除收藏
        /// </summary>
        public void delCollection()
        {
            CommonModel commonModel = new CommonModel();
            try
            {
                string sid = Request.QueryString["sid"];
                collectionService.deleteCollection(sid);
                commonModel.status = true;
            }
            catch (Exception e)
            {
                commonModel.status = false;
                commonModel.msg = e.ToString();
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
		/// 修改密码表单验证
		/// </summary>
		/// <param name="user"></param>
		/// <returns></returns>
		private bool validateRePassword(User user) 
		{
			bool flag = false;
			//校验密码
			string loginpass = user.loginpass;
			if (string.IsNullOrEmpty(loginpass.Trim()))
			{
				errors["loginpass"] = "原密码不能为空！";
				flag = true;
			}
			else if (loginpass.Length < 3 || loginpass.Length > 20)
			{
				errors["loginpass"] = "密码长度要在3~20之间！";
				flag = true;
			}

			//校验新密码
			string newpass = user.newpass;
			if(string.IsNullOrEmpty(newpass.Trim()))
			{
				errors["newpass"] = "新密码不能为空！";
				flag = true;
			}else if (newpass.Length < 3 || newpass.Length > 20) 
			{
				errors["newpass"] = "密码长度要在3~20之间！";
				flag = true;
			}
		
			//校验重复密码
			string reloginpass = user.reloginpass;
			if(string.IsNullOrEmpty(reloginpass.Trim()))
			{
				errors["reloginpass"] = "确认密码不能为空！";
				flag = true;
			}else if (!reloginpass.Equals(newpass)) 
			{
				errors["reloginpass"] = "两次密码不一致！";
				flag = true;
			}

			
			return flag;
		
		}

		/// <summary>
		/// 修改密码
		/// </summary>
		public void updatePassword() 
		{
			CommonModel commonModel = new CommonModel();
			//封装表单数据到User对象
			User formUser = new User();
			formUser.loginpass = Request.QueryString["loginpass"];
			formUser.newpass = Request.QueryString["newpass"];
			formUser.reloginpass = Request.QueryString["reloginpass"];
			// 校验, 如果校验失败，保存错误信息，返回到login.jsp显示
			bool flag = validateRePassword(formUser);
			if (flag) {
				return;
			}
			
			// 如果用户没有登录，返回到登录页面，显示错误信息
			if(user == null)
			{
				commonModel.status = false;
				commonModel.msg = "你还没有登陆！";
			}
			//使用service完成修改密码工作
			try
			{
				userService.updatePassword(user.uid, formUser.newpass, formUser.loginpass);
				commonModel.status = true;
				commonModel.msg = "修改密码成功！";
			}
			catch (Exception e)
			{
				commonModel.status = false;
				commonModel.msg = e.Message;
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
        /// 我的订单
        /// </summary>
	    public void myOrder() 
        {
		    //得到pc：如果页面传递，使用页面的，如果没传，pc=1
		    int pc = getPc();
		    //得到url
            string url = getUrl();
		    //调用service的查询方法获得PageBean
		    pb = orderService.myOrder(user.uid, pc);
            pb.url = url;  
	    }

        /// <summary>
        /// 加载订单详情页的订单项
        /// </summary>
	    public void loadOrder() 
        {
		    string oid = Request.QueryString["oid"];
		    Order order = orderService.loadOrder(oid);
		    Session["order"] = order;
		    
	    }

        /// <summary>
        /// 取消订单
        /// </summary>
	    public void cancel() 
        {
            CommonModel commonModel = new CommonModel();
		    string oid = Request.QueryString["oid"];
            StringBuilder sb = new StringBuilder("{");
		    try{
                if(orderService.findStatus(oid) != 1)
		        {
                    sb.Append("\"code\"").Append(":\"").Append("error");
				    sb.Append("\",");
				    sb.Append("\"msg\"").Append(":\"").Append("你当前的状态不可以取消订单！");
				    sb.Append("\"}");
		        }
		        orderService.changeStatus(oid, 5);
                sb.Append("\"code\"").Append(":\"").Append("success");
			    sb.Append("\",");
			    sb.Append("\"msg\"").Append(":\"").Append("取消订单成功！");
                sb.Append("\",");
                sb.Append("\"status\"").Append(":\"").Append("(已取消)");
			    sb.Append("\"}");
                commonModel.status = true;
                commonModel.data = sb.ToString();
            }catch(Exception e)
            {
                commonModel.status = false;
                commonModel.msg = e.Message;
            }finally{
                object JSONObj = JsonConvert.SerializeObject(commonModel);
				Response.Write(JSONObj);
				//一定要加，不然前端接收失败
				Response.End();
            }
		
	    }

        /// <summary>
        /// 确认收货
        /// </summary>
	    public void comfirm() 
        {
            CommonModel commonModel = new CommonModel();
		    string oid = Request.QueryString["oid"];
            StringBuilder sb = new StringBuilder("{");
		    try{
                if(orderService.findStatus(oid) != 3)
		        {
                    sb.Append("\"code\"").Append(":\"").Append("error");
                    sb.Append("\",");
				    sb.Append("\"msg\"").Append(":\"").Append("你当前的状态不可以确认收货！");
				    sb.Append("\"}");
		        }
		        orderService.changeStatus(oid, 4);
                sb.Append("\"code\"").Append(":\"").Append("success");
                sb.Append("\",");
			    sb.Append("\"msg\"").Append(":\"").Append("交易成功！");
                sb.Append("\",");
                sb.Append("\"status\"").Append(":\"").Append("(交易成功)");
			    sb.Append("\"}");
                commonModel.status = true;
                commonModel.data = sb.ToString();
            }catch(Exception e)
            {
                commonModel.status = false;
                commonModel.msg = e.Message;
            }finally{
                object JSONObj = JsonConvert.SerializeObject(commonModel);
				Response.Write(JSONObj);
				//一定要加，不然前端接收失败
				Response.End();
            }
	    }

        /// <summary>
        /// 转到支付页面
        /// </summary>
	    public void pay() 
        {
            string oid = Request.QueryString["oid"];
            Order order = orderService.loadOrder(oid);
            Session["order"] = order;
            Response.Redirect("pay.aspx");
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
        private string getUrl()
        {
            string url = Request.Url.PathAndQuery;
            int index = url.LastIndexOf("pc=");
            if (index != -1)
            {
                url = url.Substring(0, index - 1);
            }
            return url.Substring(1);
        }

	}
}