using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace booksShop.App_Code.category
{
    public class CategoryService
    {
        CategoryDao categoryDao = new CategoryDao();

        /// <summary>
        /// 返回所有分类
        /// </summary>
        /// <returns></returns>
        public List<Category> finaAll()
        {
            try
            {
                return categoryDao.finaAll();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message,e);
            }
        }


        

        /// <summary>
        /// 添加一级分类
        /// </summary>
        /// <param name="category">分类实体</param>
        public string add(Category category)
        {
            try
            {
                if (category.pid != null)
                    category.cid = Guid.NewGuid().ToString("N").ToUpper();
                else
                    category.cid = (categoryDao.findParentCategoryCount()+1).ToString();
                categoryDao.add(category);
                return category.cid;
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }

        /// <summary>
        /// 返回所有父分类
        /// </summary>
        /// <returns></returns>
        public List<Category> findParent()
        {
            try
            {
                return categoryDao.finaAll();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }

        /// <summary>
        /// 加载分类
        /// </summary>
        /// <param name="cid">分类ID</param>
        /// <returns></returns>
        public Category load(string cid)
        {
            try
            {
                List<Category> list = categoryDao.load(cid);
                if (list.Count<Category>() > 0)
                    return list[0];
                else
                    return null;
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }

        /// <summary>
        /// 修改分类
        /// </summary>
        /// <param name="category">分类实体</param>
        public void edit(Category category)
        {
            try
            {
                categoryDao.edit(category);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }

        /// <summary>
        /// 删除分类
        /// </summary>
        /// <param name="cid">分类ID</param>
        public void delete(String cid)
        {
            try
            {
                categoryDao.delete(cid);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }

        /// <summary>
        /// 查询父分类下子分类的个数
        /// </summary>
        /// <param name="pid">父分类ID</param>
        /// <returns></returns>
        public int findCategoryCountByParent(string pid)
        {
            try
            {
                return categoryDao.findCategoryCountByParent(pid);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }

        /// <summary>
        /// 查询父分类下子分类
        /// </summary>
        /// <param name="pid"></param>
        /// <returns></returns>
        public List<Category> findChild(String pid)
        {
            try
            {
                return categoryDao.finaByParent(pid);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }

    }
}