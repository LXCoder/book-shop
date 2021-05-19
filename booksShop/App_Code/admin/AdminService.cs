using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using booksShop.App_Code.user;
using booksShop.App_Code.order;
using booksShop.App_Code.book;

namespace booksShop.App_Code.admin
{
    public class AdminService
    {
        private AdminDao adminDao = new AdminDao();
        private UserDao userDao = new UserDao();
        private OrderDao orderDao = new OrderDao();
        private BookDao bookDao = new BookDao();


        public int curStock(string bid)
        {
            return bookDao.getStock(bid);
        }
        
        /// <summary>
        /// 用户数
        /// </summary>
        /// <returns></returns>
        public int userNumber()
        {
            return userDao.users();
        }

        

        
        public List<Admin> login(Admin admin)
        {
            try
            {
                return adminDao.find(admin.adminname, admin.adminpwd);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }
    }
}