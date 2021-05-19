using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using booksShop.App_Code;
using booksShop.App_Code.page;

namespace booksShop.App_Code.order
{
	public class OrderDao
	{
        private GoodsDataContext db = new GoodsDataContext("Data Source=localhost;Initial Catalog=Goods;Integrated Security=True");

        /// <summary>
        /// 今日总收入
        /// </summary>
        /// <returns></returns>
        public List<Order> income(string date)
        {
            //演示时要把status=4改一下
            var result = from r in db.Order where r.ordertime.Contains(date) && r.status == 4 select r;
            return result.ToList<Order>();
        }

        /// <summary>
        /// 月收入
        /// </summary>
        /// <returns></returns>
        public List<Order> monthIncome(string year)
        {
            //演示时要把status=4改一下
            
            //var result = from r in db.Order where r.ordertime.Contains(date + "-" + month) && r.status == 4 select r;
            var result = from r in db.Order where r.ordertime.Contains(year) && r.status == 4 select r;
            return result.ToList<Order>();
        }

        /// <summary>
        /// 今日订单量
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public int dayOrderCount(string date)
        {
            return (from r in db.Order where r.ordertime.Contains(date) select r).Count();
        }

        /// <summary>
        /// 按日期和状态查询订单量
        /// </summary>
        /// <param name="date"></param>
        /// <param name="status"></param>
        /// <returns></returns>
        public int weekOrderCount(string date,int status)
        {
            return (from r in db.Order where r.ordertime.Contains(date) && r.status == status select r).Count();
        }

        /// <summary>
        /// 选取最新的前10条订单
        /// </summary>
        /// <returns></returns>
        public List<Order> topTen()
        {
            var result =
                (from r in db.Order
                orderby r.ordertime descending
                select r).Take(10);
            List<Order> list = result.ToList<Order>();
            return list;
        }

		/// <summary>
		/// 通过oid查询Order的状态
		/// </summary>
		/// <param name="oid">订单ID</param>
		/// <returns></returns>
		public int findStatus(string oid) 
		{
			var result = 
				from r in db.Order
				where r.oid == oid
				select r;

			List<Order> list = result.ToList<Order>();
			return (int)list[0].status;
		}
	
		/// <summary>
		/// 修改订单状态
		/// </summary>
		/// <param name="oid">订单ID</param>
		/// <param name="status">订单状态</param>
		public void changeStatus(string oid,int status) 
		{
			var result = 
				from r in db.Order
				where r.oid == oid
				select r;

			if(result != null)
			{
				foreach(Order r in result)
				{
					r.status = status;
				}
			}
            db.SubmitChanges();
		}
	
		/// <summary>
		/// 通过oid查询Order
		/// </summary>
		/// <param name="oid">订单ID</param>
		/// <returns></returns>
		public Order findByOid(string oid) 
		{
			var result = 
				from r in db.Order
				where r.oid == oid
				select r;

			List<Order> list = result.ToList<Order>();
			return list[0];
		}
	
	
		/// <summary>
		/// 生成订单
		/// </summary>
		/// <param name="order"></param>
		/// <param name="orderItems"></param>
        public void add(Order order, List<Orderitem> orderItems) 
		{
			//插入订单表
			db.Order.InsertOnSubmit(order);
			//插入订单项表
			db.Orderitem.InsertAllOnSubmit(orderItems);
			db.SubmitChanges();
		}
	
	
		/// <summary>
		/// 按用户查询订单
		/// </summary>
		/// <param name="uid">用户ID</param>
		/// <param name="pc">当前页码</param>
		/// <returns></returns>
		public PageBean<Order> findByUser(string uid,int pc) 
		{
			List<Expression> expressionsList = new List<Expression>();
			expressionsList.Add(new Expression("uid", "=", uid));
			return findByCriteria(expressionsList, pc);
		}
	
		/// <summary>
		/// 查询所有订单
		/// </summary>
		/// <param name="pc">当前页码</param>
		/// <returns></returns>
		public PageBean<Order> findAll(int pc) 
		{
			List<Expression> expressionsList = new List<Expression>();
			return findByCriteria(expressionsList, pc);
		}
	
		/// <summary>
		/// 按订单状态查询
		/// </summary>
		/// <param name="status">订单状态</param>
		/// <param name="pc">当前页码</param>
		/// <returns></returns>
		public PageBean<Order> findByStatus(int status,int pc) 
		{
			List<Expression> expressionsList = new List<Expression>();
			expressionsList.Add(new Expression("status", "=", status+""));
			return findByCriteria(expressionsList, pc);
		}
	
		/// <summary>
		/// 通用的查询方法
		/// </summary>
		/// <param name="expressionsList">查询条件</param>
		/// <param name="pc">当前页码</param>
		/// <returns></returns>
		public PageBean<Order> findByCriteria(List<Expression> expressionsList,int pc) 
		{
			//得到ps每页记录数
			int ps = PageConstants.ORDER_PAGE_SIZE;
			//生成条件值集合
			Object[] conditions = new Object[expressionsList.Count];
			//生成通用where条件句
			StringBuilder whereSql = new StringBuilder("where 1=1");
			int i = 0;
            foreach (Expression expression in expressionsList)
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
			string sql = "select count(*) from [dbo].[Order] " + whereSql;
			var result = db.ExecuteQuery<int>(sql,conditions);
			int tr = result.First<int>();
		
			List<Order> orderList = new List<Order>();
            sql = "select * from [dbo].[Order] " + whereSql + " order by ordertime desc";
			try
			{
				var orderResults = db.ExecuteQuery<Order>(sql,conditions);
				orderList = orderResults.ToList<Order>();
			}
			catch(Exception e)
			{
				throw new Exception(e.Message, e);
			}
			
			int start = (pc - 1) * ps;
			int count = (orderList.Count - start) > ps ? ps : (orderList.Count - start);

			//创建PageBean，返回
			PageBean<Order> pBean = new PageBean<Order>();
			pBean.tr = tr;
			pBean.ps = ps;
			pBean.pc = pc;
			pBean.beanList = orderList.GetRange(start,count);
			return pBean;
		}  
	}
}