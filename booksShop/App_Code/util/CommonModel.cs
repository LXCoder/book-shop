using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace booksShop.App_Code.util
{
    public class CommonModel
    {
        //状态
        private bool _statues;

        public bool status
        {
            get { return _statues; }
            set { _statues = value; }
        }
        //消息
        private string _msg;

        public string msg
        {
            get { return _msg; }
            set { _msg = value; }
        }
        //数据
        private object _data;

        public object data
        {
            get { return _data; }
            set { _data = value; }
        }
    }
}