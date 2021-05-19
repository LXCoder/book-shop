using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using booksShop.App_Code.util;

namespace booksShop.admin
{
    /// <summary>
    /// Handler 的摘要说明
    /// </summary>
    public class Handler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            HttpPostedFile _upfile = context.Request.Files["image_w"];
            if (_upfile == null)
            {
                ResponseWriteEnd(context, "4");//请选择要上传的文件
            }
            else
            {
                string fileName = _upfile.FileName;/*获取文件名： C:\Documents and Settings\Administrator\桌面\123.jpg*/
                string suffix = fileName.Substring(fileName.LastIndexOf(".") + 1).ToLower();/*获取后缀名并转为小写： jpg*/
                int bytes = _upfile.ContentLength;//获取文件的字节大小

                if (suffix != "jpg")
                    ResponseWriteEnd(context, "2"); //只能上传JPG格式图片
                if (bytes > 1024 * 1024)
                    ResponseWriteEnd(context, "3"); //图片不能大于80KB
                string _fileName = System.DateTime.Now.ToString("yyyyMMddhhmmss");
                string _filePath = HttpContext.Current.Server.MapPath("~" + ConstanctString.REALATIVE_BOOK_IMG_PATH + _fileName + ConstanctString.BIG_IMG);
                _upfile.SaveAs(_filePath);//保存图片

                Bitmap img = new Bitmap(_upfile.InputStream);
                if (img.Height > 350 || img.Width > 350)
                {
                    //删除上传的图片
                    string deletName = HttpContext.Current.Server.MapPath(_filePath);
                    File.Delete(deletName);
                    ResponseWriteEnd(context, "1");
                }
                string _newFilePath = HttpContext.Current.Server.MapPath("~" + ConstanctString.REALATIVE_BOOK_IMG_PATH + _fileName + ConstanctString.SMALL_IMG);
                SendSmallImage(_filePath,_newFilePath,200,200,75,"CUT");

                ResponseWriteEnd(context, _fileName); //上传成功
            }


        }

        /// <summary>
        /// 得到缩略图，指定像素
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="newFile"></param>
        /// <param name="maxHeight"></param>
        /// <param name="maxWidth"></param>
        /// <param name="qualityNum">图片质量1-100</param>
        /// <param name="mode">缩放模式，CUT裁剪不失真，HW定宽高有可能变形，W定宽，H定高</param>
        public static void SendSmallImage(string fileName, string newFile, int maxHeight, int maxWidth, long qualityNum, string mode)
        {
            Image img = Image.FromFile(fileName);
            System.Drawing.Imaging.ImageFormat thisFormat = img.RawFormat;
            int towidth = maxWidth;
            int toheight = maxHeight;
            int x = 0;
            int y = 0;
            int ow = img.Width;
            int oh = img.Height;
            switch (mode)
            {
                case "HW"://指定高宽缩放（可能变形）                
                    break;
                case "W"://指定宽，高按比例                    
                    toheight = img.Height * maxWidth / img.Width;
                    break;
                case "H"://指定高，宽按比例
                    towidth = img.Width * maxHeight / img.Height;
                    break;
                case "CUT"://指定高宽裁减（不变形）                
                    if ((double)img.Width / (double)img.Height > (double)towidth / (double)toheight)
                    {
                        oh = img.Height;
                        ow = img.Height * towidth / toheight;
                        y = 0;
                        x = (img.Width - ow) / 2;
                    }
                    else
                    {
                        ow = img.Width;
                        oh = img.Width * maxHeight / towidth;
                        x = 0;
                        y = (img.Height - oh) / 2;
                    }
                    break;
                default:
                    break;
            }
            Bitmap outBmp = new Bitmap(towidth, toheight);
            Graphics g = Graphics.FromImage(outBmp);
            // 设置画布的描绘质量
            g.CompositingQuality = CompositingQuality.HighQuality;
            g.SmoothingMode = SmoothingMode.HighQuality;
            g.InterpolationMode = InterpolationMode.HighQualityBicubic;
            g.DrawImage(img, new Rectangle(0, 0, towidth, toheight), x, y, ow, oh, GraphicsUnit.Pixel);
            g.Dispose();
            // 以下代码为保存图片时,设置压缩质量
            EncoderParameters encoderParams = new EncoderParameters();
            long[] quality = new long[1];
            quality[0] = qualityNum;//图片质量1-100
            EncoderParameter encoderParam = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, quality);
            encoderParams.Param[0] = encoderParam;
            //获得包含有关内置图像编码解码器的信息的ImageCodecInfo 对象.
            ImageCodecInfo[] arrayICI = ImageCodecInfo.GetImageEncoders();
            ImageCodecInfo jpegICI = null;
            for (int index = 0; index < arrayICI.Length; index++)
            {
                if (arrayICI[index].FormatDescription.Equals("JPEG"))
                {
                    jpegICI = arrayICI[index];
                    //设置JPEG编码
                    break;
                }
            }
            if (jpegICI != null)
            {
                outBmp.Save(newFile, jpegICI, encoderParams);
            }
            else
            {
                outBmp.Save(newFile, thisFormat);
            }
            img.Dispose();
            outBmp.Dispose();
        }
    

        private void ResponseWriteEnd(HttpContext context, string msg)
        {
            context.Response.Write(msg);
            context.Response.End();
        }




        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}