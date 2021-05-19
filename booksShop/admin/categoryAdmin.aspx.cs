using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using booksShop.App_Code;
using booksShop.App_Code.category;
using booksShop.App_Code.book;
using booksShop.App_Code.util;
using Newtonsoft.Json;

namespace booksShop.admin
{
    public partial class categoryAdmin : System.Web.UI.Page
    {

        private CategoryService categoryService = new CategoryService();
        private BookService bookService = new BookService();
        public List<Category> categoryList;

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                string method = "";
                if (Request.QueryString["method"] != null)
                {
                    method = Request.QueryString["method"];
                    switch (method)
                    {
                        case "editParent":
                            editParent();break;
                        case "editChild":
                            editChild();break;
                        case "addParent":
                            addParent();break;
                        case "addChild":
                            addChild();break;
                        case "deleteChild":
                            deleteChild();break;
                        case "deleteParent":
                            deleteParent();break;
                    }
                }
                categoryList = categoryService.finaAll();
            }
        }


        

        /// <summary>
        /// 添加父分类
        /// </summary>
        public void addParent()
        {
            CommonModel commonModel = new CommonModel();
            Category category = new Category();
            string cname = Request.QueryString["cname"];
            string desc = Request.QueryString["desc"];
            category.cname = cname;
            category.desc = desc;
            try
            {
                string cid = categoryService.add(category);
                StringBuilder sb = new StringBuilder("{");
                sb.Append("\"cid\"").Append(":").Append(int.Parse(cid));
                sb.Append("}");
                commonModel.status = true;
                commonModel.data = sb.ToString();
            }
            catch (Exception e)
            {
                commonModel.status = false;
                commonModel.msg = "添加二级分类失败：" + e.Message;
                
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
        /// 添加子分类
        /// </summary>
        public void addChild()
        {
            CommonModel commonModel = new CommonModel();
            Category parent = new Category();
            Category child = new Category();
            string cname = Request.QueryString["cname"];
            string desc = Request.QueryString["desc"];
            string pid = Request.QueryString["pid"];
            child.cname = cname;
            child.desc = desc;
            child.pid = pid;
            try
            {
                string cid = categoryService.add(child);
                StringBuilder sb = new StringBuilder("{");
                sb.Append("\"cid\"").Append(":\"").Append(cid);
                sb.Append("\"}");
                commonModel.status = true;
                commonModel.data = sb.ToString();
            }
            catch (Exception e)
            {
                commonModel.status = false;
                commonModel.msg = "添加二级分类失败：" + e.Message;
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
        /// 修改父分类
        /// </summary>
        public void editParent()
        {
            CommonModel commonModel = new CommonModel();
            string cid = Request.QueryString["cid"];
            string cname = Request.QueryString["cname"];
            string desc = Request.QueryString["desc"];
            Category category = new Category();
            category.cid = cid;
            category.cname = cname;
            category.desc = desc;
            try
            {
                categoryService.edit(category);
                commonModel.status = true;
            }
            catch (Exception e)
            {
                commonModel.status = false;
                commonModel.msg = "修改一级分类失败：" + e.Message;
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
        /// 修改子分类
        /// </summary>
        public void editChild()
        {
            CommonModel commonModel = new CommonModel();
            string cid = Request.QueryString["cid"];
            string cname = Request.QueryString["cname"];
            string desc = Request.QueryString["desc"];
            string pid = Request.QueryString["pid"];
            Category category = new Category();
            category.cid = cid;
            category.cname = cname;
            category.desc = desc;
            category.pid = pid;
            try
            {
                categoryService.edit(category);
                commonModel.status = true;
            }
            catch (Exception e)
            {
                commonModel.status = false;
                commonModel.msg = "修改二级分类失败：" + e.Message;
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
        /// 删除父分类
        /// </summary>
        public void deleteParent()
        {
            CommonModel commonModel = new CommonModel();
            string cid = Request.QueryString["cid"];
            try
            {

                int count = categoryService.findCategoryCountByParent(cid);
                string msg = "";
                int flag = 1;
                if (count > 0)
                {
                    msg = "该分类下还有子分类，不能删除！";
                    flag = 0;
                }
                else
                {
                    msg = "删除成功！";
                    categoryService.delete(cid);
                }
                StringBuilder sb = new StringBuilder("{");
                sb.Append("\"msg\"").Append(":\"").Append(msg);
                sb.Append("\",");
                sb.Append("\"flag\"").Append(":").Append(flag);
                sb.Append("}");
                commonModel.status = true;
                commonModel.data = sb.ToString();
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
        /// 删除子分类
        /// </summary>
        public void deleteChild()
        {
            CommonModel commonModel = new CommonModel();
            string cid = Request.QueryString["cid"];
            try
            {
                int count = bookService.findBookCountByParent(cid);
                string msg = "";
                int flag = 1;
                if (count > 0)
                {
                    msg = "该分类下还有图书，不能删除！";
                    flag = 0;
                }
                else
                {
                    msg = "删除成功！";
                    categoryService.delete(cid);
                }
                StringBuilder sb = new StringBuilder("{");
                sb.Append("\"msg\"").Append(":\"").Append(msg);
                sb.Append("\",");
                sb.Append("\"flag\"").Append(":").Append(flag);
                sb.Append("}");
                commonModel.status = true;
                commonModel.data = sb.ToString();
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

        

    }
}