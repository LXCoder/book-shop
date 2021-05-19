using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using booksShop.App_Code.cart;
using booksShop.App_Code.book;
using booksShop.App_Code.util;
using booksShop.App_Code;


namespace booksShop
{
    public partial class cart : System.Web.UI.Page
    {
        private CartItemService cartItemService = new CartItemService();
        private BookService bookService = new BookService();
        public List<CartItem_> cartItemList = new List<CartItem_>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["session_user"] == null)
            {
                //Response.Redirect("login.aspx");
            }
            else
            {
                myCart();
            }
            string method = "";
            if (!IsPostBack)
            {
                if (Request.QueryString["method"] != null)
                {
                    method = Request.QueryString["method"];
                    switch (method)
                    {
                        case "add":
                            add(); break;
                        case "batchDelete":
                            batchDelete(); break;
                        case "updateQuantity":
                            updateQuantity(); break;
                        case "loadCartItems":
                            loadCartItems(); break;
                    }
                }
            }
        }

        /// <summary>
        /// 加载订单条目
        /// </summary>
        public void loadCartItems()
        {
            string cartItemIds = Request.QueryString["cartItemIds"];
            double subTotal = double.Parse(Request.QueryString["subtotal"]);
            List<CartItem_> list = cartItemService.loadCartItems(cartItemIds);
            Session["orderItemList"] = list;
            Session["totalPrice"] = subTotal;
            Session["cartItemIds"] = cartItemIds;
            Response.Redirect("checkout.aspx");
        }

        /// <summary>
        /// 修改购物车书本数量
        /// </summary>
        /// <param name="cartItemId">购物车条目ID</param>
        /// <param name="quantity">数量</param>
        public void updateQuantity()
        {
            CommonModel commonModel = new CommonModel();
            string cartItemId = Request.QueryString["cartItemId"];
            int quantity = int.Parse((string)Request.QueryString["quantity"]);
            string bid = Request.QueryString["bid"];
            try
            {
                if (quantity <= bookService.findByBid(bid).stock)
                {
                    List<CartItem_> cartItems = cartItemService.updateQuantity(cartItemId, quantity);
                    //构造返回的json语句
                    StringBuilder sb = new StringBuilder("{");
                    sb.Append("\"quantity\"").Append(":").Append(cartItems[0].quantity_);
                    sb.Append(",");
                    sb.Append("\"subtotal\"").Append(":").Append(cartItems[0].subtotal);
                    sb.Append("}");
                    commonModel.status = true;
                    commonModel.data = sb.ToString();
                }
                else
                {
                    commonModel.status = false;
                    commonModel.msg = "购买数量大于库存数量！！！";
                }
                 
            }
            catch (Exception e)
            {
                commonModel.status = false;
                commonModel.msg = e.Message;
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
        /// 批删除条目
        /// </summary>
        public void batchDelete()
        {
            string cartItemIds = Request.QueryString["cartItemIds"];
            string flag = Request.QueryString["flag"];
            cartItemService.batchDelete(cartItemIds);
            if ("true" == flag)
            {
                Response.Redirect("cart.aspx");
            }
            else if ("false" == flag)
            {
                CommonModel commonModel = new CommonModel();
                commonModel.status = true;
                object JSONObj = JsonConvert.SerializeObject(commonModel);
                Response.Write(JSONObj);
                //一定要加，不然前端接收失败
                Response.End();
            }

        }

        /// <summary>
        /// 添加购物车条目
        /// </summary>
        public void add()
        {
            CommonModel commonModel = new CommonModel();
            try
            {
                if (Session["session_user"] != null)
                {
                    User user = (User)Session["session_user"];
                    CartItem_ cartItem = new CartItem_();
                    cartItem.bid_ = Request.QueryString["bid"];
                    cartItem.quantity_ = int.Parse(Request.QueryString["quantity"]);
                    cartItem.uid_ = user.uid;

                    string id = cartItemService.add(cartItem);

                    Book book = bookService.findByBid(cartItem.bid_);
                    StringBuilder sb = new StringBuilder("{");
                    decimal substal = ((decimal)cartItem.quantity_ * (decimal)book.currPrice);
                    sb.Append("\"id\"").Append(":\"").Append(id.Substring(1));
                    sb.Append("\",");
                    sb.Append("\"quantity\"").Append(":").Append(cartItem.quantity_);
                    sb.Append(",");
                    sb.Append("\"subtotal\"").Append(":").Append(substal);
                    sb.Append(",");
                    if (id.Substring(0, 1) == "Y")
                    {
                        sb.Append("\"exit\"").Append(":").Append(1);
                        sb.Append("}");
                    }
                    else if (id.Substring(0, 1) == "N")
                    {
                        sb.Append("\"exit\"").Append(":").Append(0);
                        sb.Append(",");
                        sb.Append("\"bname\"").Append(":\"").Append(book.bname);
                        sb.Append("\",");
                        sb.Append("\"image_b\"").Append(":\"").Append(book.image_b);
                        sb.Append("\"}");
                    }

                    commonModel.status = true;
                    commonModel.msg = "加入购物车成功！";
                    commonModel.data = sb.ToString();

                }
                else
                {
                    commonModel.status = false;
                    commonModel.msg = "用户未登陆，不能加入购物车！";
                }
            }
            catch (Exception e)
            {
                commonModel.status = false;
                commonModel.msg = e.Message;
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
        /// 我的购物车
        /// </summary>
        public void myCart()
        {
            //从session中获取用户
            User user = (User)Session["session_user"];
            //调用service的方法
            cartItemList = cartItemService.myCart(user.uid);
        }
    }
}