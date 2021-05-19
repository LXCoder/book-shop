using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace booksShop.App_Code.user
{
	public class UserDao
	{
        private GoodsDataContext db = new GoodsDataContext("Data Source=localhost;Initial Catalog=Goods;Integrated Security=True");


        /// <summary>
        /// 用户数
        /// </summary>
        /// <returns></returns>
        public int users()
        {
            return (from r in db.User select r).Count();
        }

		/// <summary>
		/// 修改密码
		/// </summary>
		/// <param name="uid">用户id</param>
		/// <param name="newpass">新密码</param>
		public void updatePassword(string uid,string newpass)
		{
			var results = 
				from r in db.User 
				where r.uid == uid 
				select r;
			if (results != null)
			{

				foreach (User user in results)
				{
					user.loginpass = newpass;
				}
			}

			db.SubmitChanges();
		}

		/// <summary>
		/// 通过uid和密码查询
		/// </summary>
		/// <param name="uid">用户id</param>
		/// <param name="loginpass">密码</param>
		/// <returns></returns>
		public bool findByUidAndPawd(string uid,string loginpass)
		{
			int number =
				(from r in db.User
				where r.uid == uid && r.loginpass == loginpass
				select r).Count();

			return number > 0;
		}

		/// <summary>
		/// 通过用户名和密码查询
		/// </summary>
		/// <param name="loginname">用户名</param>
		/// <param name="loginpass">密码</param>
		/// <returns></returns>
		public List<User> findByNameAndPawd(string loginname, string loginpass)
		{
			var result =
				 from r in db.User
				 where r.loginname == loginname && r.loginpass == loginpass
				 select r;

			List<User> list = result.ToList<User>();

			return list;
		}

		/// <summary>
		/// 修改用户状态
		/// </summary>
		/// <param name="uid">用户id</param>
		/// <param name="status">状态</param>
		public void updateStatus(string uid,bool status) 
		{
			var results =
				from r in db.User
				where r.uid == uid
				select r;
			if (results != null)
			{

				foreach (User user in results)
				{
					if (status)
						user.status = 1;
					else
						user.status = 0;
				}
			}

			db.SubmitChanges();
		}

	   
		/// <summary>
		/// 通过激活码查询
		/// </summary>
		/// <param name="activationCode">激活码</param>
		/// <returns></returns>
		public List<User> findByCode(string activationCode) 
		{
			var result =
					   from r in db.User
					   where r.activationCode == activationCode
					   select r;
			List<User> list = result.ToList<User>();
			return list;
		}

		/// <summary>
		/// 注册功能
		/// </summary>
		/// <param name="user">User实例</param>
		public void regist(User user)  
		{
			db.User.InsertOnSubmit(user);
			db.SubmitChanges();
		}

		/// <summary>
		/// ajax用户名是否注册校验
		/// </summary>
		/// <param name="loginname">用户名</param>
		/// <returns></returns>
		public bool ajaxValidateLoginname(string loginname)  
		{
			int number =
				 (from r in db.User
				  where r.loginname == loginname
				  select r).Count();

			return number == 0;
		}

		/// <summary>
		/// ajax邮箱是否注册校验
		/// </summary>
		/// <param name="email">邮箱</param>
		/// <returns></returns>
		public bool ajaxValidateEmail(string email)
		{
			int number =
				 (from r in db.User
				  where r.email == email
				  select r).Count();

			return number == 0;
		}

	}
}