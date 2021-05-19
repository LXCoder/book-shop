using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace booksShop.App_Code.collection
{
    public class CollectionDao
    {
        private GoodsDataContext db = new GoodsDataContext("Data Source=localhost;Initial Catalog=Goods;Integrated Security=True");

        /// <summary>
        /// 判断该书籍是否在收藏列表
        /// </summary>
        /// <param name="bid"></param>
        /// <param name="uid"></param>
        /// <returns></returns>
        public bool isExit(string bid,string uid)
        {
            int number =
                (from r in db.Collection
                 where r.uid == uid && r.bid == bid
                 select r).Count();
            return number > 0;
        }

        /// <summary>
        /// 返回用户的收藏
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public List<Collection> findCollectionByUid(string uid)
        {
            var result = from r in db.Collection
                         where r.uid == uid
                         select r;

            return result.ToList<Collection>();
        }

        /// <summary>
        /// 添加收藏
        /// </summary>
        /// <param name="col"></param>
        public void addCollection(Collection col)
        {
            db.Collection.InsertOnSubmit(col);
            db.SubmitChanges();
        }

        /// <summary>
        /// 删除收藏
        /// </summary>
        /// <param name="cid"></param>
        public void deleteCollection(string sid)
        {
            var result = from r in db.Collection
                         where r.sid == sid
                         select r;
            db.Collection.DeleteAllOnSubmit(result);
            db.SubmitChanges();
        }
    }
}