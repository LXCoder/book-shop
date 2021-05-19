using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Text.RegularExpressions;
using booksShop.App_Code.util;
using booksShop.App_Code.user;
using booksShop.App_Code;

namespace booksShop
{
	public partial class register : System.Web.UI.Page
	{
		private static UserService userService = new UserService();
		private static string vCode = "";
		public Dictionary<string, string> errors = new Dictionary<string, string>();
		

		protected void Page_Load(object sender, EventArgs e)
		{

            if (Request["activation"] == "true")
            {
                activation();
            }

			if (!IsPostBack)
			{
				
				creatVerifyCode();
			}
            
			errors.Add("loginname", "");
			errors.Add("loginpass", "");
			errors.Add("verifyCode", "");
			errors.Add("reloginpass", "");
			errors.Add("email", "");
			
		}

        /// <summary>
        /// 更换验证码
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
		protected void changeVerifyCode(object sender, ImageClickEventArgs e)
		{
			creatVerifyCode();
		}

        /// <summary>
        /// 创建验证码
        /// </summary>
		protected void creatVerifyCode()
		{
			VerifyCodeUtil verifyCode = new VerifyCodeUtil();
			vCode = verifyCode.CreateRandomCode(4);
			verifyCodeImg.ImageUrl = verifyCode.CreateValidateGraphic(vCode);
		}

        /// <summary>
        /// 注册功能
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
		protected void registerFunction(object sender, EventArgs e)
		{
			App_Code.User user = new User();
			user.loginname = loginname.Text;
			user.loginpass = loginpass.Text;
			user.email = email.Text;
			user.reloginpass = reloginpass.Text;
			user.verifyCode = verifyCode.Text;
			// 校验, 如果校验失败，保存错误信息，返回到regist.aspx显示
			Dictionary<string, string> errors = validateRegist(user);
			if (errors.Count() > 0)
			{
				loginname.Text = user.loginname;
				email.Text = user.email;
			}
			//成注册业务
			userService.regist(user);
            //保存成功信息，转发到msg.aspx显示！
			Session["code"] = "success";
			Session["msg"] = "注册成功，请马上到邮箱激活！";
			Response.Redirect("msg.aspx");
		}

        /// <summary>
        /// 激活功能
        /// </summary>
        /// <returns></returns>
	    public void activation() 
        {
            string activationCode = Request.QueryString["activationCode"];
		    try {
			    userService.activation(activationCode);
			    Session["msg"] = "激活成功！";
			    Session["code"] = "success";
		    } catch (Exception e) {
                Session["msg"] = e.Message;
                Session["code"] = "error";
		    }
            Response.Redirect("msg.aspx");
	    }

		/// <summary>
		/// 注册表单验证
		/// </summary>
		/// <param name="user"></param>
		/// <param name="session"></param>
		/// <returns></returns>
		private Dictionary<string, string> validateRegist(User user)
		{
			errors.Clear();
			//校验用户名
			string loginname = user.loginname;
			if (string.IsNullOrEmpty(loginname.Trim()))
			{
				errors["loginname"] = "用户名不能为空！";
			}
			else if (loginname.Length < 3 || loginname.Length > 20)
			{
				errors["loginname"] = "用户名长度要在3~20之间！";
			}else if (!userService.ajaxValidateLoginname(loginname)) {
				errors["loginname"] = "用户名已被注册！";
			}
		
			//校验密码
			string loginpass = user.loginpass;
			if (string.IsNullOrEmpty(loginpass.Trim()))
			{
				errors["loginpass"] = "密码不能为空！";
			}else if (loginpass.Length<3||loginpass.Length>20) {
				errors["loginpass"] = "密码长度要在3~20之间！";
			}
		
			//校验重复密码
			string reloginpass = user.reloginpass;
			if (string.IsNullOrEmpty(reloginpass.Trim()))
			{
				errors["reloginpass"] = "密码不能为空！";
			}else if (!reloginpass.Equals(loginpass)) {
				errors["reloginpass"] = "两次密码不一致！";
			}
		
			//校验Email
			string email = user.email;
			if (string.IsNullOrEmpty(email.Trim()))
			{
				errors["email"] = "Email不能为空！";

			}
			else if (!Regex.IsMatch(email, "^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\\.[a-zA-Z0-9_-]{2,3}){1,2})$"))
			{
				errors["email"] = "错误的Email格式！";
			}else if (!userService.ajaxValidateEmail(email)) {
				errors["email"] = "Email已被注册！";
			}
		
			//校验验证码
			string code = user.verifyCode;

			if (string.IsNullOrEmpty(code.Trim()))
			{
				errors["verifyCode"] = "验证码不能为空！";
			}
			else if (code.Length != 4)
			{
				errors["verifyCode"] = "验证码长度为4位！";
			}
			else if (!code.Equals(vCode, StringComparison.OrdinalIgnoreCase))
			{
				errors["verifyCode"] = "验证码不正确！";
			}
		
			return errors;
		
		}
		
		/// <summary>
		/// ajax用户名是否注册校验
		/// </summary>
		/// <param name="loginname">用户名</param>
		/// <returns></returns>
		[WebMethod]
		public static bool ajaxValidateLoginname(string loginname) 
		{
			bool flag = userService.ajaxValidateLoginname(loginname);
			return flag;
		}
	
		/// <summary>
		/// ajax邮箱是否注册校验
		/// </summary>
		/// <param name="email">邮箱</param>
		/// <returns></returns>
		[WebMethod]
		public static bool ajaxValidateEmail(string email) 
		{
			
			bool flag = userService.ajaxValidateEmail(email);
			return flag;
		}
	
		/// <summary>
		/// ajax验证码正确校验
		/// </summary>
		/// <param name="verifyCode">验证码</param>
		/// <returns></returns>
		[WebMethod]
		public static bool ajaxValidateVerifyCode(string verifyCode) 
		{
			bool flag = verifyCode.Equals(vCode, StringComparison.OrdinalIgnoreCase);
			return flag;
		}
	}
}