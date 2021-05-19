using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using booksShop.App_Code.page;


namespace booksShop.App_Code.book
{
	public class BookService
	{
		private BookDao bookDao = new BookDao();

        public List<Book> findAllBookList()
        {
            return bookDao.findAllBookList();
        }

		/// <summary>
		/// 查询所有书籍
		/// </summary>
		/// <returns></returns>
        public PageBean<Book> findAllBook(int pc)
		{
            PageBean<Book> pageBean = bookDao.findAllBook(pc);

            return pageBean;
		}
        /// <summary>
        /// 库存
        /// </summary>
        /// <param name="bid"></param>
        /// <returns></returns>
        public int curStock(string bid)
        {
            return bookDao.getStock(bid);
        }


        /// <summary>
        /// 更改库存量
        /// </summary>
        /// <param name="book"></param>
        public void editStock(Book book)
        {
            try
            {
                bookDao.editStock(book);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }

		/// <summary>
		/// 查询子分类下图书的数量
		/// </summary>
		/// <param name="cid">分类ID</param>
		/// <returns></returns>
		public int findBookCountByParent(string cid)
		{
			try
			{
				return bookDao.findBookCountByCategory(cid);
			}
			catch (Exception e)
			{
				throw new Exception(e.Message,e);
			}
		}

		/// <summary>
		/// 删除图书
		/// </summary>
		/// <param name="bid">书籍ID</param>
		public void delete(string bid)
		{
			try
			{
				bookDao.delete(bid);
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		/// <summary>
		/// 编辑图书
		/// </summary>
		/// <param name="book">Book实例</param>
		public void edit(Book book)
		{
			try
			{
				bookDao.edit(book);
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		/// <summary>
		/// 按bid查询
		/// </summary>
		/// <param name="bid">书籍ID</param>
		/// <returns></returns>
		public Book findByBid(string bid)
		{
			try
			{
				return bookDao.findByBid(bid)[0];
			}
			catch (Exception e)
			{
				throw new Exception(e.Message,e);
			}
		}

		/// <summary>
		/// 多条件组合查询
		/// </summary>
		/// <param name="criteria">多条件</param>
		/// <param name="pc">当前页码</param>
		/// <returns></returns>
		public PageBean<Book> findByContains(Book criteria, int pc)
		{
			try
			{
				return bookDao.findByContains(criteria, pc);
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		/// <summary>
		/// 按作者模糊查询
		/// </summary>
		/// <param name="author">作者</param>
		/// <param name="pc">当前页码</param>
		/// <returns></returns>
        public PageBean<Book> findByAuthor(string author, int pc)
		{
			try
			{
				return bookDao.findByAuthor(author, pc);
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		/// <summary>
		/// 按出版社模糊查询
		/// </summary>
		/// <param name="press">出版社</param>
		/// <param name="pc">当前页码</param>
		/// <returns></returns>
		public PageBean<Book> findByPress(string press, int pc)
		{
			try
			{
				return bookDao.findByPress(press, pc);
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		/// <summary>
		/// 按书名模糊查询
		/// </summary>
		/// <param name="bname">书名</param>
		/// <param name="pc">当前页码</param>
		/// <returns></returns>
		public PageBean<Book> findByBname(string bname, int pc)
		{
			try
			{
				return bookDao.findByBname(bname, pc);
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}

		/// <summary>
		/// 按分类查询
		/// </summary>
		/// <param name="cid">分类ID</param>
		/// <param name="pc">当前页码</param>
		/// <returns></returns>
        public PageBean<Book> findByCid(string cid, int pc)
		{
			try
			{
				return bookDao.findByCid(cid, pc);
			}
			catch (Exception e)
			{
				throw new Exception(e.Message,e);
			}
		}

        /// <summary>
        /// 按分类查询,返回List类型
        /// </summary>
        /// <param name="cid">分类ID</param>
        /// <returns></returns>
        public List<Book> _findByCid(List<Category> categoryList)
        {
            try
            {

                return bookDao._findByCid(categoryList);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }


        public List<Book> topTenLike()
        {
            try
            {
                return bookDao.topTenLike();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }

        /// <summary>
        /// 点赞
        /// </summary>
        /// <param name="bid"></param>
        public void like(string bid)
        {
            try
            {
                bookDao.like(bid);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }

		/// <summary>
		/// 添加图书
		/// </summary>
		/// <param name="book">Book实例</param>
		public void add(Book book)
		{
			try
			{
                book.bid = Guid.NewGuid().ToString("N");
                bookDao.add(book);
			}
			catch (Exception e)
			{
				throw new Exception(e.Message, e);
			}
		}
	}
}