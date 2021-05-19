using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using booksShop.App_Code.util;
using booksShop.App_Code.user;
using booksShop.App_Code;

namespace booksShop
{
	public partial class login : System.Web.UI.Page
	{
		private static UserService userService = new UserService();
		private static string vCode = "";
		public Dictionary<string, string> errors = new Dictionary<string, string>();

		protected void Page_Load(object sender, EventArgs e)
		{
			string method = "";
			if (Request.QueryString["method"] != null)
			{
				method = Request.QueryString["method"];

				switch (method)
				{
					case "exit":
						exit();break;
				}
			}
			errors.Add("loginname", "");
			errors.Add("loginpass", "");
			errors.Add("verifyCode", "");
            if (!IsPostBack)
            {
                creatVerifyCode();
            }
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
		/// 登录功能
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void loginFunction(object sender, EventArgs e)
		{
			User formUser = new User();
			formUser.loginname = loginname.Text;
			formUser.loginpass = loginpass.Text;
			formUser.verifyCode = verifyCode.Text;
			// 校验, 如果校验失败，保存错误信息，返回到login.aspx显示
			bool flag = validateLogin(formUser);
			if (flag) 
			{
				loginname.Text = formUser.loginname;
                creatVerifyCode();
				return;
			}
			//登陆流程
			List< User > list = userService.login(formUser);

			if (list.Count<User>() == 0)
			{
				Session["loginname"] = formUser.loginname;
				Session["msg"] = "用户名或密码错误!";
                creatVerifyCode();
				return;
			}else {
				//判断用户是否激活
				User user = list[0];
				if(user.status == 0)
				{
					Session["msg"] = "用户未激活!";
					Session["loginname"] = formUser.loginname;
                    creatVerifyCode();
					return;
				}else {
					//登陆成功
					Session["session_user"] = user;
					//url编码
					string _loginname = user.loginname;
					_loginname = HttpUtility.UrlEncode(_loginname, Encoding.UTF8); 
					//创建cookie
					HttpCookie cookie = new HttpCookie("loginname", _loginname);
					cookie.Expires = DateTime.Now.AddDays(1);
					Response.AppendCookie(cookie);
					Response.Redirect("index.aspx");
				}
			}
		}

		/// <summary>
		/// 登陆表单验证
		/// </summary>
		/// <param name="user"></param>
		/// <returns></returns>
		private bool validateLogin(User user)
		{
			bool flag = false;
			//校验用户名
			string loginname = user.loginname;
			if (string.IsNullOrEmpty(loginname.Trim()))
			{
				errors["loginname"] = "用户名不能为空！";
				flag = true;
			}
			else if (loginname.Length < 3 || loginname.Length > 20)
			{
				errors["loginname"] = "用户名长度要在3~20之间！";
				flag = true;
			}

			//校验密码
			string loginpass = user.loginpass;
			if (string.IsNullOrEmpty(loginpass.Trim()))
			{
				errors["loginpass"] = "密码不能为空！";
				flag = true;
			}
			else if (loginpass.Length < 3 || loginpass.Length > 20)
			{
				errors["loginpass"] = "密码长度要在3~20之间！";
				flag = true;
			}

			//校验验证码
			string code = user.verifyCode;

			if (string.IsNullOrEmpty(code.Trim()))
			{
				errors["verifyCode"] = "验证码不能为空！";
				flag = true;
			}
			else if (code.Length != 4)
			{
				errors["verifyCode"] = "验证码长度为4位！";
				flag = true;
			}
			else if (!code.Equals(vCode, StringComparison.OrdinalIgnoreCase))
			{
				errors["verifyCode"] = "验证码不正确！";
				flag = true;
			}
			return flag;
		}

        /// <summary>
        /// 退出时销毁Session
        /// </summary>
		private void exit()
		{
			Session.Contents.Remove("session_user");
            Response.Redirect("login.aspx");
		}
	}
}