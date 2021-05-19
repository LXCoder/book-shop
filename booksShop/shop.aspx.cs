using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using booksShop.App_Code;
using booksShop.App_Code.category;
using booksShop.App_Code.collection;
using booksShop.App_Code.book;
using booksShop.App_Code.page;
using booksShop.App_Code.util;
using Newtonsoft.Json;

namespace booksShop
{
	public partial class index : System.Web.UI.Page
	{
		private CategoryService categoryService = new CategoryService();
		private BookService bookService = new BookService();
        //private CollectionService collectionService = new CollectionService();
        private CollectionUtil colUtil = new CollectionUtil();
		public List<Category> categories;
		public PageBean<Book> pageBean;
        private User user = null;
        public bool isLogin = false;


		protected void Page_Load(object sender, EventArgs e)
		{
			string method = "";
			if (!IsPostBack)
			{
				categories = categoryService.finaAll();
                if (Session["session_user"] != null && user == null)
                {
                    user = (User)Session["session_user"];
                    isLogin = true;
                }
                
				if (Request.QueryString["method"] != null)
				{
					method = Request.QueryString["method"];
				}else
				{
					pageBean = bookService.findAllBook(1);

                    if (isLogin)//判断是否登陆，是的话更新书籍状态
                        colUtil.updateStatue(pageBean.beanList, user.uid);
                        
					pageBean.url = getUrl() + "?method=findAllBook";
				}
			}
			
			
			switch(method)
			{
				case "findByCid":
					findByCid();break;
				case "findAllBook":
					findAllBook();break;
                case "collected":
                    collected();break;
			}
		}

        /// <summary>
        /// 收藏功能
        /// </summary>
        public void collected()
        {
            CommonModel commonModel = new CommonModel();
            string bid = Request.QueryString["bid"];
            
            try
            {
                bookService.like(bid);

                if (isLogin)
                {
                    //Collection col = new Collection();
                    //col.bid = bid;
                    //col.uid = user.uid;
                    //collectionService.addCollection(col);
                    colUtil.add(bid, user.uid);
                }

                commonModel.status = true;
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

		public void findAllBook()
		{
			//得到pc：如果页面传递，使用页面的，如果没传，pc=1
			int pc = getPc();
			//得到url
			String url = getUrl();
			//调用service的查询方法PageBean
			pageBean = bookService.findAllBook(pc);
            if (isLogin)
                colUtil.updateStatue(pageBean.beanList, user.uid);
			
			pageBean.url = url;
		}

		/// <summary>
		/// 通过分类ID查找
		/// </summary>
		public void findByCid() 
		{
			//获取查询条件
			string cid = Request.QueryString["cid"];
			//调用service的查询方法获得PageBean
			pageBean = bookService.findByCid(cid, getPc());
            if (isLogin)
                colUtil.updateStatue(pageBean.beanList, user.uid);
			pageBean.url = getUrl();
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
			{
				url = url.Substring(0, index-1);
			}
			return url.Substring(1);
		}
	}
}