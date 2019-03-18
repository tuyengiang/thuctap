using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MyNews;
using WebApp;
using WebApp.DTO;
using System.Data;
using System.Data.SqlClient;
namespace WebApp.DAL
{
    public class DAL_ThietB:Class1
    {
        Class1 db = new Class1();
        public bool ExcuteQuery_P(String name, DTO_ThietB tb)
        {
            try
            {
                SqlConnection connection = new SqlConnection(conn);
                SqlCommand command = new SqlCommand(name, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@ma_thietbi", tb.MATB));
                command.Parameters.Add(new SqlParameter("@ten_thietbi", tb.TENTB));
                command.Parameters.Add(new SqlParameter("@id_dvtinh", tb.ID_DV));
                command.Parameters.Add(new SqlParameter("@soluong", tb.COUNT));
                command.Parameters.Add(new SqlParameter("@serinumber", tb.SERI));
                command.Parameters.Add(new SqlParameter("@trangthai_thietbi", tb.STATUS));
                command.Parameters.Add(new SqlParameter("@ngay_nhan", tb.NGAYNHAP));
                command.Parameters.Add(new SqlParameter("@ngaytao", tb.NGAYTAO));
                command.Parameters.Add(new SqlParameter("@ngaysua", tb.NGAYSUA));
                command.Parameters.Add(new SqlParameter("@nguoitao", tb.USER_CREATE));
                command.Parameters.Add(new SqlParameter("@nguoisua", tb.USER_EDIT));
                command.Parameters.Add(new SqlParameter("@id_loaitb", tb.LOAITB));
                command.Parameters.Add(new SqlParameter("@id_tram", tb.TRAM));
                command.Parameters.Add(new SqlParameter("@inserted", tb.INSERTED));
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

        public bool Delete(String name, String tb,String value)
        {
            try
            {
                SqlConnection connection = new SqlConnection(conn);
                SqlCommand command = new SqlCommand(name, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@ma_thietbi", tb));
                command.Parameters.Add(new SqlParameter("@inserted", value));
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