using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace booksShop.App_Code.admin
{
    public class AdminDao
    {
        private GoodsDataContext db = new GoodsDataContext("Data Source=localhost;Initial Catalog=Goods;Integrated Security=True");

        public List<Admin> find(string username, string password)
        {
            var result =
                from r in db.Admin
                where r.adminname == username && r.adminpwd == password
                select r;
            List<Admin> list = result.ToList<Admin>();
            return list;
        }
    }
}