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
        public string GetColumnVal(string Query, string ColumnName)
        {
            string RetVal = "";
            ConnectionString();
            using (cmd = new SqlCommand(Query, con))
            {
               
                sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    RetVal = sdr[ColumnName].ToString();
                    break;
                }
                sdr.Close();
                close();
            }

            return RetVal;
        }
        public void bindDatalist(DataList dtl, string sql)
        {
            ConnectionString();
            SqlDataAdapter da = new SqlDataAdapter(sql, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dtl.DataSource = dt;
            dtl.DataBind();
            close();

        }
        public void binRepeater(Repeater dtl, string sql)
        {
            ConnectionString();
            SqlDataAdapter da = new SqlDataAdapter(sql, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dtl.DataSource = dt;
            dtl.DataBind();
            close();

        }
        public void bindListview(ListView dtl, string sql)
        {
            ConnectionString();
            SqlDataAdapter da = new SqlDataAdapter(sql, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dtl.DataSource = dt;
            dtl.DataBind();
            close();

        }
        public void bindDropdow(DropDownList dtl, string sql, string name, string value)
        {
            ConnectionString();
            SqlDataAdapter da = new SqlDataAdapter(sql, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dtl.DataSource = dt;
            dtl.DataTextField = name;
            dtl.DataValueField = value;
            dtl.DataBind();
            close();

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
       
      
        public static DataTable BindStoreProcedure2Para(string procedure, string para1, string value1, string para2, string value2)
        {
            DataTable dt = new DataTable();
            //string conn = WebConfigurationManager.ConnectionStrings["ConnectionToMyNews"].ConnectionString;
            SqlConnection connection = new SqlConnection(conn);
            SqlCommand command = new SqlCommand(procedure, connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add(new SqlParameter(para1, value1));
            command.Parameters.Add(new SqlParameter(para2, value2));
            connection.Open();
            SqlDataAdapter da = new SqlDataAdapter(command);
            da.Fill(dt);
            connection.Close();
            connection.Dispose();
            return dt;
        }
        public static DataTable BindStoreProcedure(string procedure)
        {
            DataTable dt = new DataTable();
            SqlConnection connection = new SqlConnection(conn);
            SqlCommand command = new SqlCommand(procedure, connection);
            command.CommandType = CommandType.StoredProcedure;
            //command.Parameters.Add(new SqlParameter(para1, value1));
            //command.Parameters.Add(new SqlParameter(para2, value2));
            connection.Open();
            SqlDataAdapter da = new SqlDataAdapter(command);
            da.Fill(dt);
            connection.Close();
            connection.Dispose();
            return dt;
        }
        public DataTable ExecuteSelectProcedure(string ProcedureName, object[] args)
        {
            ConnectionString();
            DataTable dt = new DataTable();
            SqlCommand command = new SqlCommand(ProcedureName, con);
            command.CommandType = CommandType.StoredProcedure;

         
            SqlCommandBuilder.DeriveParameters(command);

            if (args != null)
            {
                for (int i = 0; i < args.Length; i++)
                {
                    command.Parameters[i + 1].Value = args[i].ToString();
                }
            }

            SqlDataAdapter da = new SqlDataAdapter(command);
            da.Fill(dt);
            close();
            return dt;
        }
        public int ExecuteCRUDProcedure(string ProcedureName, object[] args)
        {
            ConnectionString();
            DataTable dt = new DataTable();
            SqlCommand command = new SqlCommand(ProcedureName, con);
            command.CommandType = CommandType.StoredProcedure;

           

            SqlCommandBuilder.DeriveParameters(command);

            if (args != null)
            {
                for (int i = 0; i < args.Length; i++)
                {
                    command.Parameters[i + 1].Value = args[i].ToString();
                }
            }

            int kq = command.ExecuteNonQuery();
            close();
            return kq;
        }

        public string ExecuteCRUDProcedureReturn(string ProcedureName, object[] args)
        {
            ConnectionString();
            DataTable dt = new DataTable();
            SqlCommand command = new SqlCommand(ProcedureName, con);
            command.CommandType = CommandType.StoredProcedure;

            object[] parameters = GetParameterName(ProcedureName);
            if (parameters != null)
            {
                for (int i = 0; i < parameters.Length; i++)
                {
                  
                    command.Parameters.Add(new SqlParameter(parameters[i].ToString(), args[i].ToString()));
                }
            }

            command.Parameters.Add("@id", SqlDbType.Int).Direction = ParameterDirection.Output;
            
            command.ExecuteNonQuery();
            //
            string id = command.Parameters["@id"].Value.ToString();

            close();
            return id;
        }
        public int ExecuteScalarProcedure(string ProcedureName, object[] args)
        {
            ConnectionString();
            DataTable dt = new DataTable();
            SqlCommand command = new SqlCommand(ProcedureName, con);
            command.CommandType = CommandType.StoredProcedure;

            SqlCommandBuilder.DeriveParameters(command);

            if (args != null)
            {
                for (int i = 0; i < args.Length; i++)
                {
                    command.Parameters[i + 1].Value = args[i].ToString();
                }
            }
           

            object id = command.ExecuteScalar();

            close();
            return int.Parse(id.ToString());
        }

        


        public DataTable ExecuteSelectProcedure1(string ProcedureName, object[] args)
        {
            ConnectionString();
            DataTable dt = new DataTable();
            SqlCommand command = new SqlCommand(ProcedureName, con);
            command.CommandType = CommandType.StoredProcedure;
            SqlCommandBuilder.DeriveParameters(command);
            int row_num = command.Parameters.Count;

            if (row_num > 0)
            {
                for (int i = 1; i < row_num; i++)
                {
                    string s = command.Parameters[i].ToString();
                    command.Parameters.Add(new SqlParameter(s, args[i - 1].ToString()));
                }
            }

          
            SqlDataAdapter da = new SqlDataAdapter(command);
            da.Fill(dt);
            close();
            return dt;
        }
        public object[] GetParameterName(string procedureName)
        {
            object[] args = null;
            string sql = "select PARAMETER_NAME from INFORMATION_SCHEMA.PARAMETERS where SPECIFIC_NAME= '" + procedureName + "' and PARAMETER_MODE='IN'";
            DataTable dt = GetDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                args = new object[dt.Rows.Count];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    args[i] = dt.Rows[i]["PARAMETER_NAME"].ToString();
                }
            }
            return args;
        }
        public DataTable GetDataTable(string sql)
        {
            DataTable dt = new DataTable(); ;
            ConnectionString();
            SqlDataAdapter da = new SqlDataAdapter(sql, con);
            da.Fill(dt);
            close();
            return dt;
        }


        public static string subString(string text, int length)
        {
            string s = "";
            if (text.Length <= length)
            {
                s = text;
            }
            else
            {
                s = text.Substring(0, length) + "...";
            }
            return s;
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

        public void DeleteFile(string fileName)
        {
            //string fileName = ("i:/Website/WebSite3/Mag/" + cell.Text);

            if (fileName != null || fileName != string.Empty)
            {
                //fileName = Server.MapPath("~"+ fileName);
                if ((System.IO.File.Exists(fileName)))
                {
                    System.IO.File.Delete(fileName);
                }
            }
        }
        public string FormatText(string a)
        {
            string b = "";
            string c = "";
            if (a.Length == 6)
            {
                c = a.Insert(3, ",");
            }
            else
            {
                for (int i = a.Length / 3; i > 0; i--)
                {
                    b += a.Substring(a.Length - 3 * i, 3) + ",";

                }
                b = a.Substring(0, a.Length % 3) + "," + b;
                c = b.Substring(0, b.Length - 1);
            }
            return c;
        }

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



       
    }
}
