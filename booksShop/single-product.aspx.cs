using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using booksShop.App_Code;
using booksShop.App_Code.book;
using booksShop.App_Code.page;
using booksShop.App_Code.util;
using booksShop.App_Code.user;

namespace booksShop
{
    public partial class single_product : System.Web.UI.Page
    {
        public Book book;
        private BookService bookService = new BookService();
        private CollectionUtil colUtil = new CollectionUtil();
        public List<Book> bookList = new List<Book>();
        public List<int> indexList = new List<int>();
        public bool isLogin = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            
            string method = "";
            if (Session["session_user"] != null )
                isLogin = true;
            
            if (Request.QueryString["method"] != null)
            {
                method = Request.QueryString["method"];
                switch (method)
                {
                    case "findByBid":
                        findByBid();break;
                }
                
            }
            bookList = bookService.findAllBookList();
            if (isLogin)
                colUtil.updateStatue(bookList, ((User)Session["session_user"]).uid);
            for (int i = 0; i < bookList.Count; i++)
            {
                indexList.Add(i);
            }

            
        }

        /// <summary>
        /// 按bid查询
        /// </summary>
        /// <returns></returns>
        public void findByBid()
        {
            //获取查询条件
            string bid = Request.QueryString["bid"];
            book = bookService.findByBid(bid);
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
                catch (Exception e) {
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
                url = url.Substring(0, index);
            }
            return url.Substring(1);
        }
    }
}