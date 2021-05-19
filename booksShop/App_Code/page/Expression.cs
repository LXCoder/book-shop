using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace booksShop.App_Code.page
{
	public class Expression
	{
		private string _name;//属性名
		private string _op;//操作符
		private string _value;//属性值

		public Expression(string name, string op, string value)
		{
			this._name = name;
			this._op = op;
			this._value = value;
		}

		public string name
		{
			get { return _name; }
			set { this._name = value; }
		}

		public string op
		{
			get { return _op; }
			set { this._op = value; }
		}

		public string value
		{
			get { return _value; }
			set { this._value = value; }
		}
	}
}