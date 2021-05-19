using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace booksShop.App_Code.collection
{
    public class CollectionService
    {
        private CollectionDao collectionDao = new CollectionDao();

        /// <summary>
        /// 判断该藏品是否存在
        /// </summary>
        /// <param name="bid"></param>
        /// <param name="uid"></param>
        /// <returns></returns>
        public bool isExit(string bid,string uid)
        {
           return collectionDao.isExit(bid, uid);
        }

        /// <summary>
        /// 返回该用户的藏品
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public List<Collection> findCollectionByUid(string uid)
        {
            return collectionDao.findCollectionByUid(uid);
        }

        /// <summary>
        /// 加入收藏
        /// </summary>
        /// <param name="col"></param>
        /// <returns></returns>
        public bool addCollection(Collection col)
        {
            bool flag = false;
            try
            {
                col.sid = Guid.NewGuid().ToString("N").ToUpper();
                collectionDao.addCollection(col);
                flag = true;
            }
            catch (Exception e)
            {
                throw new Exception("加入收藏失败："+e.Message,e);
            }
            return flag;
        }


        /// <summary>
        /// 删除收藏
        /// </summary>
        /// <param name="sid"></param>
        /// <returns></returns>
        public bool deleteCollection(string sid)
        {
            bool flag = false;
            try
            {
                collectionDao.deleteCollection(sid);
                flag = true;
            }
            catch (Exception e)
            {
                throw new Exception("删除收藏失败：" + e.Message, e);
            }
            return flag;
        }
    }
}