using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using booksShop.App_Code.util;


namespace booksShop.App_Code.user
{
	public class UserService
	{
		private UserDao userDao = new UserDao();

        
        /// <summary>
		/// 修改密码
		/// </summary>
		/// <param name="uid">用户uid</param>
		/// <param name="newpass">新密码</param>
		/// <param name="oldpass">旧密码</param>
		public void updatePassword(string uid, string newpass, string oldpass) 
		{
			try {
				bool flag = userDao.findByUidAndPawd(uid, oldpass);
				if(!flag)
				{
					throw new Exception("原密码错误！");
				}
				userDao.updatePassword(uid, newpass);
			} catch (Exception e) {
                throw new Exception(e.Message,e);
			}
		}

		/// <summary>
		/// 登录功能
		/// </summary>
		/// <param name="user">User实例</param>
		/// <returns></returns>
		public List<User> login(User user)
		{
			try
			{
				return userDao.findByNameAndPawd(user.loginname, user.loginpass);
			}
			catch (Exception e)
			{
				throw new Exception(e.Message,e);
			}
		}


		/// <summary>
		/// 注册功能
		/// </summary>
		/// <param name="user">User实例</param>
		public void regist(User user)
		{
			//补全信息
			user.uid = Guid.NewGuid().ToString("N").ToUpper();
			user.status = 0;
			user.activationCode = Guid.NewGuid().ToString("N").ToUpper() + Guid.NewGuid().ToString("N").ToUpper();
			//调用注册功能
			try
			{
				userDao.regist(user);
			}
			catch (Exception e)
			{
				throw new Exception(e.Message,e);
			}
			//发邮件

			string toEmail = user.email;
			string subject = "来自书城的激活邮件";
			string messege = "恭喜，您已注册成功，请点击<a href='http://localhost:22256/register.aspx/activation?activationCode=" + user.activationCode + "'>这里</a>完成激活。";

			try
			{
				P2BEmail email = new P2BEmail(toEmail, subject, messege);
				email.SendEmail(); 
			}
			catch (Exception e)
			{
				throw new Exception(e.Message,e);
			}    
		}

		/// <summary>
		/// ajax用户名是否注册校验
		/// </summary>
		/// <param name="loginname">用户名</param>
		/// <returns></returns>
		public bool ajaxValidateLoginname(string loginname)
		{
			try {
				return userDao.ajaxValidateLoginname(loginname);
			} catch (Exception e) {
				throw new Exception(e.Message,e);
			}
		}
	
		/// <summary>
		/// ajax邮箱是否注册校验
		/// </summary>
		/// <param name="email">邮箱</param>
		/// <returns></returns>
		public bool ajaxValidateEmail(string email)
		{
			try {
				return userDao.ajaxValidateEmail(email);
			} catch (Exception e) {
				throw new Exception(e.Message,e);
			}
		}
	
		/// <summary>
		/// 激活功能
		/// </summary>
		/// <param name="activationCode"></param>
		public void activation(String activationCode) 
		{
			try {
				//通过激活码查询用户
                List<User> list = userDao.findByCode(activationCode);
				//如果User为null，说明是无效激活码，抛出异常，给出异常信息（无效激活码）
				if(list.Count<User>() == 0)
				{
					throw new Exception("无效的激活码!");
				}
				//查看用户状态是否为true，如果为true，抛出异常，给出异常信息（请不要二次激活）
                if (list[0].status == 1)
                {
					throw new Exception("您已经激活过了，不要二次激活！");
				}
				//修改用户状态为true
                userDao.updateStatus(list[0].uid, true);
			}
			catch (Exception e)
			{
                throw new Exception(e.Message,e);
			}
		
			
		
		}

	}
}