using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace booksShop.App_Code.category
{
	public class CategoryDao
	{
		private GoodsDataContext db = new GoodsDataContext("Data Source=localhost;Initial Catalog=Goods;Integrated Security=True");

		/// <summary>
		/// 返回所有分类
		/// </summary>
		/// <returns></returns>
		public List<Category> finaAll()
		{
			var result =
				from r in db.Category
				where r.pid == null
				select r;

			List<Category> list = result.ToList<Category>();  

			return list;
			
		}

		/// <summary>
		/// 通过父分类查询子分类
		/// </summary>
		/// <param name="pid">父分类ID</param>
		/// <returns></returns>
		public List<Category> finaByParent(String pid) 
		{
			var result =
				from r in db.Category
				where r.pid == pid
				orderby r.orderBy ascending
				select r;

			List<Category> list = list = result.ToList<Category>();

			return list;
		}

		


		/// <summary>
		/// 添加一级分类
		/// </summary>
		/// <param name="category">分类实例</param>
		public void add(Category category) 
		{
			
			/*string pid = null;
			if(category.pid != null)
			{
				pid = category.pid;
			}
			category.pid = pid;*/

			db.Category.InsertOnSubmit(category);
			db.SubmitChanges();
		}

		/// <summary>
		/// 加载分类
		/// </summary>
		/// <param name="cid">分类ID</param>
		/// <returns></returns>
		public List<Category> load(string cid)  
		{
			var result =
				from r in db.Category
				where r.cid == cid
				select r;
			List<Category> list = result.ToList<Category>();
			return list;
		}

		/// <summary>
		/// 修改分类
		/// </summary>
		/// <param name="category">分类实例</param>
		public void edit(Category category) 
		{
			var result =
				from r in db.Category
				where r.cid == category.cid
				select r;

			string pid = null;
			if (category.pid != null)
				pid = category.pid;

			if(result != null)
			{
				foreach(Category r in result)
				{
					r.cname = category.cname;
					r.pid = pid;
					r.desc = category.desc;
				}
			}
			db.SubmitChanges();
			
		}

		/// <summary>
		/// 查询父分类下子分类的个数
		/// </summary>
		/// <param name="pid">父分类ID</param>
		/// <returns></returns>
		public int findCategoryCountByParent(string pid) 
		{ 
			int count =
				(from r in db.Category
				 where r.pid == pid
				 select r).Count<Category>(); ;

			return count;
		}

		/// <summary>
		/// 查询父分类的个数
		/// </summary>
		/// <param name="pid">父分类ID</param>
		/// <returns></returns>
		public int findParentCategoryCount()
		{
			int count =
				(from r in db.Category
				 where r.pid == null
				 select r).Count<Category>(); ;

			return count;
		}

		/// <summary>
		/// 删除分类
		/// </summary>
		/// <param name="cid"></param>
		public void delete(string cid) 
		{
			var result =
				from r in db.Category
				where r.cid == cid
				select r;
			db.Category.DeleteAllOnSubmit(result);
			db.SubmitChanges();
		}
	}
}