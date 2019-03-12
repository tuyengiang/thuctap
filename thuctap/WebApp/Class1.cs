using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;
using System.Collections.Generic;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Net.Mail;

namespace MyNews
{
    public  class Class1
    {
        public static string conn = WebConfigurationManager.ConnectionStrings["ConnectionToMyNews"].ConnectionString;
        public SqlConnection con;
        public SqlCommand cmd;
        public SqlDataAdapter adapter;
        public SqlDataReader reader;
        public DataTable dt;
        public SqlDataReader sdr;
        public void ConnectionString()
        {
            con = new SqlConnection(conn);
            con.Open();
        }
        public void close()
        {
            con.Close();
            con.Dispose();
        }
       
        public int ExecuteQuery(string sql)
        {
            ConnectionString();
            SqlCommand cmd = new SqlCommand(sql, con);
            int i = cmd.ExecuteNonQuery();
            close();
            return i;
        }
        public DataTable bindDataTable(string sql)
        {
            ConnectionString();
            SqlDataAdapter da = new SqlDataAdapter(sql, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            close();
            return dt;
        }

        //MD5
        public string MD5Hash(string text)
        {
            MD5 md5 = new MD5CryptoServiceProvider();

            //compute hash from the bytes of text
            md5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(text));

            //get hash result after compute it
            byte[] result = md5.Hash;

            StringBuilder strBuilder = new StringBuilder();
            for (int i = 0; i < result.Length; i++)
            {
                //change it into 2 hexadecimal digits
                //for each byte
                strBuilder.Append(result[i].ToString("x2"));
            }

            return strBuilder.ToString();
        }
        // resize image
        public static System.Drawing.Image ScaleImage(System.Drawing.Image image, int maxHeight)
        {
            var ratio = (double)maxHeight / image.Height;

            var newWidth = (int)(image.Width * ratio);
            var newHeight = (int)(image.Height * ratio);

            var newImage = new Bitmap(newWidth, newHeight);
            newImage.SetResolution(72, 72);
            using (var g = Graphics.FromImage(newImage))
            {
                g.DrawImage(image, 0, 0, newWidth, newHeight);
            }
            return newImage;
        }
        // resize image
        public static System.Drawing.Image ScaleImageW(System.Drawing.Image image, int maxWidth)
        {

            if (maxWidth < image.Width)
            {
                var ratio = (double)maxWidth / image.Width;

                var newWidth = (int)(image.Width * ratio);
                var newHeight = (int)(image.Height * ratio);
                var newImage = new Bitmap(newWidth, newHeight);
                using (var g = Graphics.FromImage(newImage))
                {
                    g.DrawImage(image, 0, 0, newWidth, newHeight);
                }
                return newImage;
            }
            else
                return image;
        }
        //
        public void ResizeImage(string FileName, string fileExtention, int fileLenght, int maxWidth, Bitmap bmpPostedImage, string SaveLocation)
        {
            try
            {
                if (fileExtention == "image/png" || fileExtention == "image/jpeg" || fileExtention == "image/x-png" || fileExtention == "image/jpg" || fileExtention == "image/gif")
                {
                    System.Drawing.Image objImage = ScaleImageW(bmpPostedImage, maxWidth);
                    objImage.Save(SaveLocation, ImageFormat.Jpeg);
                }
            }
            catch (Exception ex)
            {
            }
        }
        //
        public void ResizeImageH(string FileName, string fileExtention, int fileLenght, int maxHeight, Bitmap bmpPostedImage, string SaveLocation)
        {
            try
            {
                if (fileExtention == "image/png" || fileExtention == "image/jpeg" || fileExtention == "image/x-png" || fileExtention == "image/jpg" || fileExtention == "image/gif")
                {
                    System.Drawing.Image objImage = ScaleImage(bmpPostedImage, maxHeight);

                    objImage.Save(SaveLocation, ImageFormat.Jpeg);
                }
            }
            catch (Exception ex)
            {
            }
        }

        public bool ExcuteQuery_TRAM(String name, string ma,string ten,string dc,string mt,int id)
        {
            try
            {
                SqlConnection connection = new SqlConnection(conn);
                SqlCommand command = new SqlCommand(name, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@ma_tran", ma));
                command.Parameters.Add(new SqlParameter("@ten_tram", ten));
                command.Parameters.Add(new SqlParameter("@dia_chi",dc));
                command.Parameters.Add(new SqlParameter("@mo_ta", mt));
                command.Parameters.Add(new SqlParameter("@id_donvi", id));
                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
                connection.Dispose();
                return true;
            }
            catch
            {
                return false;
            }

        }

    }
}
