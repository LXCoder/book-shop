using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using booksShop.App_Code.collection;

namespace booksShop.App_Code.util
{
    public class CollectionUtil
    {
        private CollectionService collectionService = new CollectionService();

        /// <summary>
        /// 更新书籍状态
        /// </summary>
        /// <param name="list">书籍列表</param>
        /// <param name="uid">用户uid</param>
        public void updateStatue(List<Book> list,string uid)
        {
            bool flag = false;
            for (int i = 0; i < list.Count; i++)
            {
                flag = collectionService.isExit(list[i].bid, uid);
                if (flag)
                    list[i].statue = 1;//表示该用户收藏了该本书
                else
                    list[i].statue = 0;
            }
        }

        /// <summary>
        /// 加入收藏
        /// </summary>
        /// <param name="bid">书籍id</param>
        /// <param name="uid">用户id</param>
        public void add(string bid, string uid)
        {
            Collection col = new Collection();
            col.bid = bid;
            col.uid = uid;
            collectionService.addCollection(col);
        }
    }
}