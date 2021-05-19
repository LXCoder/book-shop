using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using booksShop.App_Code.page;

namespace booksShop.App_Code.book
{
	public class BookDao
	{

        private GoodsDataContext db = new GoodsDataContext("Data Source=localhost;Initial Catalog=Goods;Integrated Security=True");

        /// <summary>
        /// 查询库存
        /// </summary>
        /// <param name="bid"></param>
        /// <returns></returns>
        public int getStock(string bid)
        {
            var result =
                from r in db.Book
                where r.bid == bid
                select r;

            return (int)result.ToList<Book>()[0].stock;
        }

        /// <summary>
        /// 更新库存
        /// </summary>
        /// <param name="book"></param>
        public void editStock(Book book)
        {
            var result =
                from r in db.Book
                where r.bid == book.bid
                select r;

            if (result != null)
            {
                foreach (Book r in result)
                {
                    r.stock = book.stock;
                }
                db.SubmitChanges();
            }
        }

        /// <summary>
        /// 查询交易量
        /// </summary>
        /// <param name="bid"></param>
        /// <returns></returns>
        public int getDeal(string bid)
        {
            var result =
                from r in db.Book
                where r.bid == bid
                select r;

            return (int)result.ToList<Book>()[0].deal;
        }

        /// <summary>
        /// 根据销售量排序
        /// </summary>
        /// <returns></returns>
        public List<Book> findBookOrderByDeal()
        {
            var result = (from r in db.Book orderby r.deal descending select r).Take(10);
            return result.ToList<Book>();
        }

        /// <summary>
        /// 根据库存排序
        /// </summary>
        /// <returns></returns>
        public List<Book> findBookOrderBystock()
        {
            var result = (from r in db.Book orderby r.stock ascending select r).Take(10);
            return result.ToList<Book>();
        }

		/// <summary>
		/// 查询所有书籍
		/// </summary>
		public List<Book> findAllBookList()
		{
			var result = db.Book;
			return result.ToList<Book>();
		}

        

		/// <summary>
		/// 查询所有书籍
		/// </summary>
		/// <param name="pc">当前页码</param>
		/// <returns></returns>
		public PageBean<Book> findAllBook(int pc)
		{
			List<Expression> expressionsList = new List<Expression>();
			return findByCriteria(expressionsList, pc);
		}


		/// <summary>
		/// 按分类查找书本数
		/// </summary>
		/// <param name="cid">分类ID</param>
		/// <returns></returns>
		public int findBookCountByCategory(string cid) 
		{
			int count = 
				(from r in db.Book
				where r.cid == cid
				select r).Count<Book>();
			
			return count;
		}

		/// <summary>
		/// 添加图书
		/// </summary>
		/// <param name="book">Book实体</param>
		public void add(Book book) 
		{
			db.Book.InsertOnSubmit(book);
			db.SubmitChanges();
		}

        /// <summary>
        /// 点赞功能
        /// </summary>
        /// <param name="bid"></param>
        public void like(string bid)
        {
            var book = db.Book.SingleOrDefault<Book>(s=>s.bid == bid);

            if (book != null)
                book.xingji += 5;

            db.SubmitChanges();
        }

        
        public List<Book> topTenLike()
        {
            var result =
                (from r in db.Book
                 orderby r.xingji descending
                 select r).Take(10);
            return result.ToList<Book>();  
        }

		/// <summary>
		/// 编辑图书
		/// </summary>
		/// <param name="book">Book实体</param>
		public void edit(Book book) 
		{    
			var result = 
				from r in db.Book
				where r.bid == book.bid
				select r;

			if(result != null)
			{
				foreach(Book r in result)
				{
					r.bname = book.bname;
					r.author = book.author;
					r.price = book.price;
					r.currPrice = book.currPrice;
					r.discount = book.discount;
					r.press = book.press;
					r.publishtime = book.publishtime;
					r.edition = book.edition;
					r.pageNum = book.pageNum;
					r.wordNum = book.wordNum;
					r.printtime = book.printtime;
					r.booksize = book.booksize;
					r.paper = book.paper;
					r.cid = book.cid;
					//r.image_w = book.image_w;
					//r.image_b = book.image_b;
				}
				db.SubmitChanges();
			}
		}

		/// <summary>
		/// 删除图书
		/// </summary>
		/// <param name="bid">书籍ID</param>
		public void delete(string bid) 
		{
			var result =
				from r in db.Book
				where r.bid == bid
				select r;
			db.Book.DeleteAllOnSubmit(result);
			db.SubmitChanges();
		}

		/// <summary>
        /// 按分类查询,返回PageBean类型
		/// </summary>
		/// <param name="cid">分类ID</param>
		/// <param name="pc">当前页码</param>
		/// <returns></returns>
		public PageBean<Book> findByCid(String cid,int pc) 
		{
			List<Expression> expressionsList = new List<Expression>();
			expressionsList.Add(new Expression("cid", "=", cid));
			return findByCriteria(expressionsList, pc);
		}

        /// <summary>
        /// 按分类查询,返回List类型
        /// </summary>
        /// <param name="cid"></param>
        /// <returns></returns>
        public List<Book> _findByCid(List<Category> categoryList)
        {
            Object[] conditions = new Object[categoryList.Count];
            string sql = "select top 6 * from dbo.Book where ";
            for (int i = 0; i < categoryList.Count; i++)
            {
                sql += "cid={" + i.ToString() + "}";
                conditions[i] = categoryList[i].cid;
                if (i < categoryList.Count - 1)
                    sql += " or ";
            }

            var result = db.ExecuteQuery<Book>(sql,conditions);
            return result.ToList<Book>();
        }

		/// <summary>
		/// 按bid查询
		/// </summary>
		/// <param name="bid">书籍ID</param>
		/// <returns></returns>
		public List<Book> findByBid(string bid) 
		{
			var result =
				from r in db.Book
				where r.bid == bid
				select r;
			return result.ToList<Book>();
		}

		/// <summary>
		/// 按书名模糊查询
		/// </summary>
		/// <param name="bname">书名</param>
		/// <param name="pc">当前页码</param>
		/// <returns></returns>
		public PageBean<Book> findByBname(String bname,int pc)  
		{
			List<Expression> expressionsList = new List<Expression>();
			expressionsList.Add(new Expression("bname", "like", "%"+bname+"%"));
			return findByCriteria(expressionsList, pc);
		}

		/// <summary>
		/// 按作者模糊查询
		/// </summary>
		/// <param name="author">作者</param>
		/// <param name="pc">当前页码</param>
		/// <returns></returns>
		public PageBean<Book> findByAuthor(String author,int pc) 
		{
			List<Expression> expressionsList = new List<Expression>();
			expressionsList.Add(new Expression("author", "like", "%" + author + "%"));
			return findByCriteria(expressionsList, pc);
		}

		/// <summary>
		/// 按出版社模糊查询
		/// </summary>
		/// <param name="press">出版社</param>
		/// <param name="pc">当前页码</param>
		/// <returns></returns>
		public PageBean<Book> findByPress(String press,int pc) 
		{
			List<Expression> expressionsList = new List<Expression>();
			expressionsList.Add(new Expression("press", "like", "%" + press + "%"));
			return findByCriteria(expressionsList, pc);
		}

		/// <summary>
		/// 多条件组合查询
		/// </summary>
		/// <param name="criteria">Book实体</param>
		/// <param name="pc">当前页码</param>
		/// <returns></returns>
		public PageBean<Book> findByContains(Book criteria,int pc) 
		{
			List<Expression> expressionsList = new List<Expression>();
			expressionsList.Add(new Expression("bname", "like", "%" + criteria.bname + "%"));
			expressionsList.Add(new Expression("author", "like", "%" + criteria.author + "%"));
			expressionsList.Add(new Expression("press", "like", "%" + criteria.press + "%"));
			return findByCriteria(expressionsList, pc);
		}

		/// <summary>
		/// 通用的查询方法
		/// </summary>
		/// <param name="expressionsList">条件子句</param>
		/// <param name="pc">当前页码</param>
		/// <returns></returns>
		public PageBean<Book> findByCriteria(List<Expression> expressionsList,int pc)  
		{
			//得到ps每页记录数
			int ps = PageConstants.BOOK_PAGE_SIZE;
			//生成条件值集合
			Object[] conditions = new Object[expressionsList.Count];
			//生成通用where条件句
			StringBuilder whereSql = new StringBuilder("where 1=1");
			int i = 0;
			foreach(Expression expression in expressionsList)
			{
				whereSql.Append(" and ").Append(expression.name).Append(" ").Append(expression.op).Append(" {");
				if(!expression.op.Equals("is null"))
				{
					whereSql.Append(i.ToString());
					whereSql.Append("}");
					conditions[i] = expression.value;
					i++;
				}
			}
			//得到tr总记录数
			string sql="select count(*) from dbo.Book " + whereSql;
			var result = db.ExecuteQuery<int>(sql,conditions);
			int tr = result.First<int>();

			//得到bookList
			List<Book> bookList = new List<Book>();
			sql = "select * from dbo.Book " + whereSql + " order by orderBy";
			try
			{
				var bookResults = db.ExecuteQuery<Book>(sql,conditions);
				bookList = bookResults.ToList<Book>();
			}
			catch(Exception e)
			{
				throw new Exception(e.Message, e);
			}

			int start = (pc - 1) * ps;//开始记录的下标
			int count = (bookList.Count - start) > ps ? ps : (bookList.Count - start);//结束记录的下标
			PageBean<Book> pBean = new PageBean<Book>();
			pBean.tr = tr;//总记录数
			pBean.ps = ps;//每页记录数
			pBean.pc = pc;//当前页码
			pBean.beanList = bookList.GetRange(start,count);//获取这个范围的数据
			return pBean;
		}

	}
}