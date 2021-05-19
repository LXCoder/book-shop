using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;

namespace booksShop.App_Code.cart
{
	public class CartItemDao
	{
        private GoodsDataContext db = new GoodsDataContext("Data Source=localhost;Initial Catalog=Goods;Integrated Security=True");


		/// <summary>
		/// 生成where条件子句
		/// </summary>
		/// <param name="length">条件长度</param>
		/// <returns></returns>
		private String creatWhereSql(int length)
		{
			StringBuilder whereSql = new StringBuilder("cartItemId in(");
			for (int i = 0; i < length; i++)
			{
				whereSql.Append("{");
				whereSql.Append(i.ToString());
				whereSql.Append("}");
				if (i < length - 1)
				{
					whereSql.Append(",");
				}
			}

			whereSql.Append(")");
			return whereSql.ToString();
		}

		/// <summary>
		/// 批删除条目
		/// </summary>
		/// <param name="cartItemIds">购物车条目ID</param>
		public void batchDelete(string cartItemIds) 
		{
			Object[] conditions = cartItemIds.Split(',');
			string whereSql = creatWhereSql(conditions.Length);
			string sql = "delete from dbo.Cartitem where " + whereSql;
			db.ExecuteCommand(sql, conditions);
		}

        /// <summary>
        /// 加载CartItem集合
        /// </summary>
        /// <param name="cartItemIds">购物车条目ID</param>
        /// <returns></returns>
	    public List<CartItem_> loadCartItems(string cartItemIds) 
        {
		    Object[] conditions = cartItemIds.Split(',');
		    string whereSql = creatWhereSql(conditions.Length);
		    string sql = "select * from dbo.Cartitem c,dbo.Book b where c.bid = b.bid and "+ whereSql;
            var result = db.ExecuteQuery<CartItem_>(sql,conditions);
		    List<CartItem_> list = result.ToList<CartItem_>();
		    return list;
	    }
	
	    /// <summary>
	    /// 通过CartItemId查询购物车条目
	    /// </summary>
	    /// <param name="cartItemId">购物车条目ID</param>
	    /// <returns></returns>
	    public List<CartItem_> findByCartItemId(string cartItemId) 
        {
		    //string sql="select * from t_cartitem c,t_book b where c.bid=b.bid and c.cartItemId=?";
            var result = 
                from r in db.CartItem_
                where r.cartItemId_ == cartItemId
                select r;
		    List<CartItem_> list = result.ToList<CartItem_>();
		    return list;
	    }
	
	    /// <summary>
	    /// 通过uid和bid查询购物车条目
	    /// </summary>
	    /// <param name="uid">用户ID</param>
	    /// <param name="bid">图书ID</param>
	    /// <returns></returns>
	    public List<CartItem_> findByUidAndBid(string uid,string bid) 
        {
		    //String sql="select * from t_cartitem where uid=? and bid=?";
		    var result = 
                from r in db.CartItem_
                where r.bid_ == bid && r.uid_ == uid
                select r;
		    List<CartItem_> list = result.ToList<CartItem_>();
		    return list;
	    }
	
	    /// <summary>
	    /// 修改条目数量
	    /// </summary>
	    /// <param name="cartItemId">购物车条目ID</param>
	    /// <param name="quantity">数量</param>
	    public void updateQuantity(string cartItemId,int quantity) 
        {
		    //String sql="UPDATE t_cartitem SET quantity=? WHERE cartItemId=?";
            var result = 
                from r in db.CartItem_
                where r.cartItemId_ == cartItemId
                select r;
		    if(result != null)
            {
                foreach(CartItem_ r in result)
                {
                    r.quantity_ = quantity;
                }
            }
            db.SubmitChanges();
	    }
	
	    /// <summary>
	    /// 添加条目
	    /// </summary>
	    /// <param name="cartItem">CartItem_实例</param>
	    public void addCartItem(CartItem_ cartItem) 
        {
            db.CartItem_.InsertOnSubmit(cartItem);
            db.SubmitChanges();
	    }
	
	
	    /// <summary>
	    /// 通过用户查询购物车条目
	    /// </summary>
	    /// <param name="uid">用户ID</param>
	    /// <returns></returns>
	    public List<CartItem_> findByUser(string uid) 
        {
		    //String sql="select * from t_cartitem c,t_book b where c.bid=b.bid and uid=? order by c.orderBy";
		    var result = 
                from r in db.CartItem_
                where r.uid_ == uid
                select r;
            
		    List<CartItem_> list = result.ToList<CartItem_>();
		    return list;
	    }
	
	}
}