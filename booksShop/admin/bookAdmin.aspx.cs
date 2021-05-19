using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Text;
using System.IO;
using System.Web.UI.WebControls;
using booksShop.App_Code.book;
using booksShop.App_Code.category;
using booksShop.App_Code.page;
using booksShop.App_Code.util;
using booksShop.App_Code;
using Newtonsoft.Json;

namespace booksShop.admin
{
	public partial class bookAdmin : System.Web.UI.Page
	{
		private CategoryService categoryService = new CategoryService();
		private BookService bookService = new BookService();
		public PageBean<Book> pageBean;
		public List<Category> categoryList;

		protected void Page_Load(object sender, EventArgs e)
		{
			string method = "";
			if (!IsPostBack)
			{
				if (Request.QueryString["method"] != null)
				{
					method = Request.QueryString["method"];
				}
				else
				{
					pageBean = bookService.findAllBook(1);
					pageBean.url = getUrl() + "?method=findAllBook";
						
				}
			}

			categoryList = categoryService.finaAll();

			switch (method)
			{
                case "edit": 
                    edit();break;
				case "findByCid":
					findByCid(); break;
				case "findAllBook":
					findAllBook(); break;
				case "ajaxFindChild": 
                    ajaxFindChild(); break;
				case "findByBname": 
                    findByBname(); break;
                case "findByContains": 
                    findByContains(); break;
                case "addBook": 
                    addBook(); break;
                case "delete": 
                    delete(); break;
                case "editStock": 
                    editStock(); break;
			}

		}



		public void findAllBook()
		{
			//得到pc：如果页面传递，使用页面的，如果没传，pc=1
			int pc = getPc();
			//得到url
			String url = getUrl();
			//调用查询方法返回PageBean
			pageBean = bookService.findAllBook(pc);
			pageBean.url = url;
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
			//调用查询方法返回PageBean
			pageBean = bookService.findByBname(bname, pc);
			
			pageBean.url = url;
		}

        /// <summary>
        /// 多条件查询
        /// </summary>
        public void findByContains()
        {
            int pc = getPc();
            string url = getUrl();
            Book criteria = new Book();
            criteria.bname = Request.QueryString["bname"];
            criteria.author = Request.QueryString["author"];
            criteria.press = Request.QueryString["press"];
            pageBean = bookService.findByContains(criteria, pc);
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
			pageBean.url = getUrl();
		}

		/// <summary>
		/// ajax响应查询子分类
		/// </summary>
		/// <returns></returns>
		public void ajaxFindChild()
		{
			CommonModel commonModel = new CommonModel();
			string pid = Request.QueryString["pid"];
			try
			{
				List<Category> categories = categoryService.findChild(pid);
				string json = toJson(categories);
				commonModel.status = true;
				commonModel.data = json;
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
		/// 编辑图书
		/// </summary>
		public void edit()
		{
            CommonModel commonModel = new CommonModel();
            Book book = new Book();
            try
            {
                book.bid = Request.QueryString["bid"];
                book.bname = Request.QueryString["bname"];
                book.author = Request.QueryString["author"];
                book.price = Math.Round(decimal.Parse(Request.QueryString["price"]),2);
                book.discount = Math.Round(decimal.Parse(Request.QueryString["discount"]),2);
                decimal currPrice = (decimal)book.price * (decimal)book.discount/10;
                book.currPrice = Math.Round(currPrice, 2);
                book.press = Request.QueryString["press"];
                book.edition = Int32.Parse(Request.QueryString["edtion"]);
                book.pageNum = Int32.Parse(Request.QueryString["pageNum"]);
                book.wordNum = Int32.Parse(Request.QueryString["wordNum"]);
                book.printtime = Request.QueryString["printtime"];
                book.publishtime = Request.QueryString["publictime"];
                book.cid = Request.QueryString["cid"];
                book.booksize = Int32.Parse(Request.QueryString["size"]);
                book.paper = Request.QueryString["page"];
            
                bookService.edit(book);
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
        /// 编辑图书
        /// </summary>
        public void editStock()
        {
            CommonModel commonModel = new CommonModel();
            Book book = new Book();
            try
            {
                book.bid = Request.QueryString["bid"];
                book.stock = Int32.Parse(Request.QueryString["stock"]);
                bookService.editStock(book);
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
        /// 添加图书
        /// </summary>
        public void addBook()
        {

            CommonModel commonModel = new CommonModel();
            Book book = new Book();
            try
            {
                string imgName = Request.QueryString["imgName"];
                book.bname = Request.QueryString["bname"];
                book.author = Request.QueryString["author"];
                book.price = Math.Round(decimal.Parse(Request.QueryString["price"]), 2);
                book.discount = Math.Round(decimal.Parse(Request.QueryString["discount"]), 2);
                decimal currPrice = (decimal)book.price * (decimal)book.discount / 10;
                book.currPrice = Math.Round(currPrice, 2);
                book.press = Request.QueryString["press"];
                book.edition = Int32.Parse(Request.QueryString["edtion"]);
                book.pageNum = Int32.Parse(Request.QueryString["pageNum"]);
                book.wordNum = Int32.Parse(Request.QueryString["wordNum"]);
                book.printtime = Request.QueryString["printtime"];
                book.publishtime = Request.QueryString["publictime"];
                book.cid = Request.QueryString["cid"];
                book.booksize = Int32.Parse(Request.QueryString["size"]);
                book.paper = Request.QueryString["page"];
                book.image_b = "book_img/" + imgName + ConstanctString.SMALL_IMG;
                book.image_w = "book_img/" + imgName + ConstanctString.BIG_IMG;

                bookService.add(book);
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
		/// 删除图书
		/// </summary>
		public void delete()
		{
            CommonModel commonModel = new CommonModel();
            try
            {
                string bid = Request.QueryString["bid"];
                Book book = bookService.findByBid(bid);
                //获取真实路径
                string savepath = HttpContext.Current.Server.MapPath("~/assets/images/" + book.image_w);
                //删除图片
                File.Delete(savepath);
                savepath = HttpContext.Current.Server.MapPath("~/assets/images/" + book.image_b);
                File.Delete(savepath);
                bookService.delete(bid);
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
				url = url.Substring(7, index - 8);
			else
				url = url.Substring(7);
			return url;
		}

		/// <summary>
		/// 把category集合转换成json对象数组
		/// </summary>
		/// <param name="categories"></param>
		/// <returns></returns>
		private string toJson(List<Category> categories)
		{
			StringBuilder sb = new StringBuilder("[");
			for (int i = 0; i < categories.Count; i++)
			{
				sb.Append(toJson(categories[i]));
				if (i < categories.Count - 1)
				{
					sb.Append(",");
				}
			}
			sb.Append("]");
			return sb.ToString();
		}

		/// <summary>
		/// 把category转换成json对象
		/// </summary>
		/// <param name="category"></param>
		/// <returns></returns>
		private string toJson(Category category)
		{
			StringBuilder sb = new StringBuilder("{");
			sb.Append("\"cid\"").Append(":").Append("\"").Append(category.cid).Append("\"");
			sb.Append(",");
			sb.Append("\"cname\"").Append(":").Append("\"").Append(category.cname).Append("\"");
			sb.Append("}");
			return sb.ToString();
		}
	}
}