using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using booksShop.App_Code.order;
using booksShop.App_Code.util;
using booksShop.App_Code;
using Newtonsoft.Json;
using System.Text;

namespace booksShop.admin
{
    public partial class index : System.Web.UI.Page
    {
        private OrderService orderService = new OrderService();
        public List<Order> orderList = new List<Order>();
        public decimal dayIncome;
        public decimal yearIncome;
        public int dayOrderCount;

        protected void Page_Load(object sender, EventArgs e)
        {
            dayIncome = orderService.dayIncome();
            yearIncome = orderService.yearIncome();
            dayOrderCount = orderService.dayOrderCount();
            if (orderList != null && orderList.Count != 0)
            {
                orderList = orderService.topTen();
            }
            else
            {
                orderList = new List<Order>();
                orderList = orderService.topTen();
            }


            if (!IsPostBack)
            {
                string method = "";
                if (Request.QueryString["method"] != null)
                {
                    method = Request.QueryString["method"];
                    switch (method)
                    {
                        case "updateMonthIncome":
                            updateMonthIncome(); break;
                        case "updateWeekOrderCount":
                            updateWeekOrderCount();break;
                    }
                }
                
            }
        }


        public void updateWeekOrderCount()
        {
            CommonModel commonModel = new CommonModel();
            try
            {
                DateTime dateTime = new DateTime(2014,1,1);
                //DateTime dateTime = DateTime.Now;
                string[] week = new string[7];
                int[] count = new int[7];
                StringBuilder sb = new StringBuilder("{");
                sb.Append("\"date\"").Append(":[");
                for (int i = 7; i > 0; i--)
                {
                    week[7-i] = dateTime.AddDays(-i).ToString("yyyy-MM-dd");
                    sb.Append("\"").Append(week[7-i]).Append("\"");
                    if(i > 1)
                        sb.Append(",");
                }
                sb.Append("],");
                string[] name = { "\"one\"", "\"two\"", "\"three\"", "\"four\"" };
                for (int j = 0; j < 4; j++)
                {
                    count = orderService.weekOrderCount(week, j+1);
                    sb.Append(name[j]).Append(":[");
                    for (int i = 0; i < count.Length; i++)
                    {
                        sb.Append(count[i].ToString());
                        if (i < count.Length - 1)
                            sb.Append(",");
                    }
                    sb.Append("]");
                    if (j < 3)
                        sb.Append(",");
                }

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
        /// 更新月收入
        /// </summary>
        public void updateMonthIncome()
        {
            CommonModel commonModel = new CommonModel();
            try
            {
                int[] income = orderService.monthIncome();
                StringBuilder sb = new StringBuilder("{");
                sb.Append("\"income\"").Append(":[");
                for (int i = 0; i < income.Length; i++)
                {
                    sb.Append(income[i].ToString());
                    if(i < income.Length-1)
                        sb.Append(",");
                }
                sb.Append("]}");
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