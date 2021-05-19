using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using booksShop.App_Code.util;

namespace booksShop
{
    public partial class contact : System.Web.UI.Page
    {
        

        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void sendMessege(object sender, EventArgs e)
        {
                string name = customername.Text;
                string toEmail = customerEmail.Text;
                string subject = contactSubject.Text;
                string messege = "尊敬的" + name + "先生：\r\n\t\t你的留言：" + contactMessage.Text + "\r\n已收到，感谢你的留言，我们会尽快联系你！" + name;

                try
                {
                    P2BEmail email = new P2BEmail(toEmail, subject, messege);
                    email.SendEmail();
                    Response.Write("<script>alert( '发送成功！')</script>");
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('发送失败\r\n" + ex.Message + ex.StackTrace + "')</script>");
                }

        }


    }
}