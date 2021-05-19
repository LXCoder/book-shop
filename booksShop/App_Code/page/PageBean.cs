using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace booksShop.App_Code.page
{
    public class PageBean<T>
    {
        private int _pc;//pageCode	当前页码
        private int _tr;//totalRecord, 总记录数
        private int _ps;//pagesize, 每页记录数
        //private int tp;//totalPage, 总页数
        private List<T> _beanList;//存放需要分页的实体
        private string _url;//用来保存路径！

        public int pc
        {
            get { return _pc; }
            set { this._pc = value; }
        }

        public int tr
        {
            get { return _tr; }
            set { this._tr = value; }
        }

        public int ps
        {
            get { return _ps; }
            set { this._ps = value; }
        }

        public List<T> beanList
        {
            get { return _beanList; }
            set { this._beanList = value; }
        }

        public string url
        {
            get { return _url; }
            set { this._url = value; }
        }

        //返回总页数
        public int tp()
        {
            int _tp = _tr / _ps;
            return _tr % _ps == 0 ? _tp : _tp + 1;
        }

    }
}