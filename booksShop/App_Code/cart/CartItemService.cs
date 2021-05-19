using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace booksShop.App_Code.cart
{
    public class CartItemService
    {
        private CartItemDao cartItemDao = new CartItemDao();

        /// <summary>
        /// 加载CartItem集合
        /// </summary>
        /// <param name="cartItemIds">购物车条目ID</param>
        /// <returns></returns>
        public List<CartItem_> loadCartItems(string cartItemIds)
        {
            try
            {
                return cartItemDao.loadCartItems(cartItemIds);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message,e);
            }
        }

        /// <summary>
        /// 修改购物车书本数量
        /// </summary>
        /// <param name="cartItemId">购物车条目ID</param>
        /// <param name="quantity">数量</param>
        /// <returns></returns>
        public List<CartItem_> updateQuantity(string cartItemId, int quantity)
        {
            try
            {
                cartItemDao.updateQuantity(cartItemId, quantity);
                return cartItemDao.findByCartItemId(cartItemId);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }

        /// <summary>
        /// 批删除条目
        /// </summary>
        /// <param name="cartItemIds">购物车条目ID</param>
        public void batchDelete(string cartItemIds)
        {
            try
            {
                cartItemDao.batchDelete(cartItemIds);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }

        /// <summary>
        /// 添加条目
        /// </summary>
        /// <param name="cartItem">CartItem_实例</param>
        public string add(CartItem_ cartItem)
        {
            string cartItemId = "";
            try
            {
                List<CartItem_> items = cartItemDao.findByUidAndBid(cartItem.uid_, cartItem.bid_);
                if (items.Count > 0)
                {
                    //有这个条目就修改数量
                    int quantity = (int)(items[0].quantity_ + cartItem.quantity_);
                    cartItemDao.updateQuantity(items[0].cartItemId_, quantity);
                    cartItemId = "Y" + items[0].cartItemId_;
                }
                else
                {
                    //没有这个条目就添加
                    cartItem.cartItemId_ = Guid.NewGuid().ToString("N").ToUpper();
                    cartItemDao.addCartItem(cartItem);
                    cartItemId = "N" + cartItem.cartItemId_;
                }
                return cartItemId;
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }


        /// <summary>
        /// 我的购物车
        /// </summary>
        /// <param name="uid">用户ID</param>
        /// <returns></returns>
        public List<CartItem_> myCart(string uid)
        {
            try
            {
                return cartItemDao.findByUser(uid);
            }
            catch (Exception e)
            {
                throw new Exception(e.Message, e);
            }
        }
    }
}