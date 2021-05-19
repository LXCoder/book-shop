using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using booksShop.App_Code;
using booksShop.App_Code.category;
using booksShop.App_Code.book;
using booksShop.App_Code.page;
using booksShop.App_Code.util;

namespace booksShop
{
    public partial class index1 : System.Web.UI.Page
    {
        private BookService bookService = new BookService();
        public CategoryService categoryService = new CategoryService();
        private CollectionUtil colUtil = new CollectionUtil();
        public List<Book> topLike = new List<Book>(); 
        public List<Book> oneList = new List<Book>();
        public List<Book> twoList = new List<Book>();
        public List<Book> threeList = new List<Book>();//书本List
        public List<Category> categoryList = new List<Category>();//分类List
        public Random random = new Random();//因其他分类书籍不足，用随即类随机挑选，待改进
        public Category category = new Category();
        public bool isLogin = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            
                
            
            categoryList = categoryService.findChild("1");
            oneList = bookService._findByCid(categoryList);
            twoList = bookService._findByCid(categoryService.findChild("4"));
            threeList = bookService._findByCid(categoryService.findChild("3"));
            topLike = bookService.topTenLike();
            //更新该用户的收藏状态
            if (Session["session_user"] != null)
            {
                isLogin = true;
                colUtil.updateStatue(topLike, ((User)Session["session_user"]).uid);
                colUtil.updateStatue(oneList, ((User)Session["session_user"]).uid);
                colUtil.updateStatue(twoList, ((User)Session["session_user"]).uid);
                colUtil.updateStatue(threeList, ((User)Session["session_user"]).uid);
            }
        }
    }
}