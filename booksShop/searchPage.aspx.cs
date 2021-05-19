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

namespace booksShop
{
    public partial class searchPage : System.Web.UI.Page
    {
        private BookService bookService = new BookService();
        private CollectionUtil colUtil = new CollectionUtil();
        public PageBean<Book> pageBean;
        public bool isLogin = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["session_user"] != null)
                isLogin = true;

            string method = "";
            if (Request.QueryString["method"] != null)
                method = Request.QueryString["method"];

            switch (method)
            {
                case "findByBname":
                    findByBname();break;
            }
        }

        /// <summary>
        /// 按书名模糊查询
        /// </summary>
        public void findByBname()
        {
            //得到pc：如果页面传递，使用页面的，如果没传，pc=1
            int pc = getPc();
            //得到url
            string url = getUrl();
            //获取查询条件
            string bname = Request["searchKeyWord"];
            if (Request.QueryString["bname"] != null)
                bname = Request.QueryString["bname"];
            else
                url = url + "&bname=" + bname;

            //调用查询方法返回PageBean
            pageBean = bookService.findByBname(bname, pc);
            if(isLogin)
                colUtil.updateStatue(pageBean.beanList, ((User)Session["session_user"]).uid);
            //给PageBean设置url，保存PageBean
            pageBean.url = url;
        }

        /// <summary>
        /// 按作者模糊查询
        /// </summary>
	    public void findByAuthor() 
        {
		    //得到pc：如果页面传递，使用页面的，如果没传，pc=1
		    int pc = getPc();
		    //得到url
		    string url = getUrl();
		    //获取查询条件
            string author = "";
            //调用查询方法返回PageBean
            pageBean = bookService.findByAuthor(author, pc);
            if (isLogin)
                colUtil.updateStatue(pageBean.beanList, ((User)Session["session_user"]).uid);
		    //给PageBean设置url，保存PageBean
            pageBean.url = url;
		    
	    }
	
	    /// <summary>
        /// 按出版社模糊查询
	    /// </summary>
	    public void findByPress() 
        {
		    //得到pc：如果页面传递，使用页面的，如果没传，pc=1
		    int pc = getPc();
		    //得到url
		    string url = getUrl();
		    //获取查询条件
            string press = "";
		    //调用查询方法返回PageBean
            pageBean = bookService.findByPress(press, pc);
            if (isLogin)
                colUtil.updateStatue(pageBean.beanList, ((User)Session["session_user"]).uid);		    //给PageBean设置url，保存PageBean
            pageBean.url = url;
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
                url = url.Substring(0, index-1);
            }
            return url.Substring(1);
        }
    }
}