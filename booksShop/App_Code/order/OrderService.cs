using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Transactions;
using booksShop.App_Code.page;

namespace booksShop.App_Code.order
{
    public class OrderService
    {

        private OrderDao orderDao = new OrderDao();

        /// <summary>
        /// 今日订单量
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public int dayOrderCount()
        {
            //string date = DateTime.Now.ToString("yyyy-MM-dd");
            string date = "2014-01-01";
            return orderDao.dayOrderCount(date);
        }

        public int[] weekOrderCount(string[] week,int status)
        {
            int[] count = new int[7];
            for (int i = 0; i < week.Length; i++)
                count[i] = orderDao.weekOrderCount(week[i], status); ;
            return count;
        }

        /// <summary>
        /// 日总收入
        /// </summary>
        /// <returns></returns>
        public decimal dayIncome()
        {
            //string date = DateTime.Now.ToString("yyyy-MM-dd");
            string date = "2014-01-01";
            List<Order> list = orderDao.income(date);
            decimal income = 0;
            for (int i = 0; i < list.Count; i++)
                income += (decimal)list[i].total;

            return income;
        }

        public decimal yearIncome()
        {
            //string year = DateTime.Now.ToString("yyyy");
            string year = "2014";
            decimal income = 0;
            List<Order> list = orderDao.income(year);
            for (int i = 0; i < list.Count; i++)
                income += (decimal)list[i].total;
            return income;
        }

        /// <summary>
        /// 今年各个月份的月收入总额
        /// </summary>
        /// <returns></returns>
        public int[] monthIncome()
        {
            //string year = DateTime.Now.ToString("yyyy");
            string year = "2014";
            int[] arr = new int[12];
            List<Order> list = orderDao.income(year);
            for (int i = 0; i < list.Count; i++)
            {
                if (list[i].ordertime.Contains(year + "-01"))
                    arr[0] += (int)list[i].total;
                else if(list[i].ordertime.Contains(year + "-02"))
                    arr[1] += (int)list[i].total;
                else if (list[i].ordertime.Contains(year + "-03"))
                    arr[2] += (int)list[i].total;
                else if (list[i].ordertime.Contains(year + "-04"))
                    arr[3] += (int)list[i].total;
                else if (list[i].ordertime.Contains(year + "-05"))
                    arr[4] += (int)list[i].total;
                else if (list[i].ordertime.Contains(year + "-06"))
                    arr[5] += (int)list[i].total;
                else if (list[i].ordertime.Contains(year + "-07"))
                    arr[6] += (int)list[i].total;
                else if (list[i].ordertime.Contains(year + "-08"))
                    arr[7] += (int)list[i].total;
                else if (list[i].ordertime.Contains(year + "-09"))
                    arr[8] += (int)list[i].total;
                else if (list[i].ordertime.Contains(year + "-10"))
                    arr[9] += (int)list[i].total;
                else if (list[i].ordertime.Contains(year + "-11"))
                    arr[10] += (int)list[i].total;
                else if (list[i].ordertime.Contains(year + "-12"))
                    arr[11] += (int)list[i].total;
            }
            return arr;
        }

        /// <summary>
        /// 选取前10条最新订单
        /// </summary>
        /// <returns></returns>
        public List<Order> topTen() 
        {
            return orderDao.topTen();
        }

        /// <summary>
        /// 查询订单状态
        /// </summary>
        /// <param name="oid">订单ID</param>
        /// <returns></returns>
        public int findStatus(string oid)
        {
            try
            {
                return orderDao.findStatus(oid);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }

        /// <summary>
        /// 修改订单状态
        /// </summary>
        /// <param name="oid">订单ID</param>
        /// <param name="status">订单状态</param>
        public void changeStatus(string oid, int status)
        {
            try
            {
                orderDao.changeStatus(oid, status);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }


        /// <summary>
        /// 加载订单详情页的订单项
        /// </summary>
        /// <param name="oid">订单ID</param>
        /// <returns></returns>
        public Order loadOrder(string oid)
        {
            Order order = new Order();
            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    order = orderDao.findByOid(oid);
                    scope.Complete();
                }
            }
            catch (TransactionAbortedException e)
            {
                order = null;
                throw new Exception(e.Message, e);
            }

            return order;
        }


       /// <summary>
        /// 我的订单
       /// </summary>
       /// <param name="uid">用户ID</param>
       /// <param name="pc">当前页码</param>
       /// <returns></returns>
        public PageBean<Order> myOrder(string uid, int pc)
        {
            PageBean<Order> pBean = new PageBean<Order>();
            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    pBean = orderDao.findByUser(uid, pc);
                    scope.Complete();
                }
            }
            catch (TransactionAbortedException e)
            {
                throw new Exception(e.Message, e);
            }
            return pBean;
        }

        /// <summary>
        /// 按订单状态查询
        /// </summary>
        /// <param name="status">订单状态</param>
        /// <param name="pc">当前页码</param>
        /// <returns></returns>
        public PageBean<Order> findByStatus(int status, int pc)
        {
            PageBean<Order> pBean = new PageBean<Order>();
            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    pBean = orderDao.findByStatus(status, pc);
                    scope.Complete();
                }
            }
            catch (TransactionAbortedException e)
            {
                throw new Exception(e.Message, e);
            }
            return pBean;
        }


        /// <summary>
        /// 查询所有订单
        /// </summary>
        /// <param name="pc">当前页码</param>
        /// <returns></returns>
        public PageBean<Order> findAll(int pc)
        {
            PageBean<Order> pBean = new PageBean<Order>();
            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    pBean = orderDao.findAll(pc);
                    scope.Complete();
                }
            }
            catch (TransactionAbortedException e)
            {
                throw new Exception(e.Message, e);
            }
            return pBean;
        }

        /// <summary>
        /// 生成订单
        /// </summary>
        /// <param name="order"></param>
        /// <param name="orderItems"></param>
        public void creatOrder(Order order, List<Orderitem> orderItems)
        {
            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    orderDao.add(order,orderItems);
                    scope.Complete();
                }
            }
            catch (TransactionAbortedException e)
            {
                throw new Exception(e.Message, e);
            }
        }
    }
}