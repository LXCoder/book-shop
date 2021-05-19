using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Text;
using System.IO;
using booksShop.App_Code;


namespace booksShop.App_Code.util
{
    public class P2BEmail
    {

        private string fromEmail = "13138774157@163.com";//邮件发送方

        private string fromPwd = "19951204lucy"; //邮件发送方密码/QQ授权码

        private string emailType = "smtp.163.com";//邮件类型 smtp.163.com.cn; smtp.qq.com.cn; smtp.126.com.cn;  smtp.sina.com.cn

        private string toEmail;
        private string subject;
        private string body;
        private string attFile;
        private SmtpClient smtp;
        private NetworkCredential nc;


        public P2BEmail(string toEmail, string subject, string body, string attFile = "")
        {
            this.toEmail = toEmail;
            this.subject = subject;
            this.body = body;
            this.attFile = attFile;

            nc = new NetworkCredential(fromEmail, fromPwd);
            smtp = new SmtpClient(emailType);
            smtp.EnableSsl = true;　　//启用SSl
            //　　随请求一起发送
            smtp.UseDefaultCredentials = false;
            //　　邮件账户凭证
            smtp.Credentials = nc;
            //　　邮件发送方式-网络发送
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
        }


        /// <summary>
        /// 发送电子邮件
        /// </summary>
        /// <param name="toEmail">接收方邮箱地址</param>
        /// <param name="subject">邮件标题</param>
        /// <param name="body">邮件内容</param>
        public void SendEmail()
        {
        
            MailAddress addrFrom = new MailAddress(fromEmail, fromEmail);
            MailAddress addrTo = new MailAddress(toEmail, toEmail);
            MailMessage mm = new MailMessage(addrFrom, addrTo);
            mm.BodyEncoding = Encoding.UTF8;
            mm.IsBodyHtml = true;
            mm.Subject = subject;
            mm.Body = body;
            mm.IsBodyHtml = true;//设置为HTML格式
            mm.Priority = MailPriority.Low;//优先级

            if (!string.IsNullOrEmpty(attFile))
            {
                Attachment att = new Attachment(attFile, MediaTypeNames.Application.Octet);
                ContentDisposition cd = att.ContentDisposition;
                cd.CreationDate = File.GetCreationTime(attFile);
                cd.ModificationDate = File.GetLastWriteTime(attFile);
                cd.ReadDate = File.GetLastAccessTime(attFile);
                mm.Attachments.Add(att);//添加附件
            }

            try
            {
                smtp.Send(mm);
            }
            catch (SmtpFailedRecipientException)
            {
                smtp.Dispose();
                return;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            smtp.Dispose();

        }
    }
}