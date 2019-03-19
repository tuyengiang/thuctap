using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebApp;
using WebApp.DTO;
using System.Data;
using System.Data.SqlClient;
using MyNews;

namespace WebApp.DAL
{
    public class DAL_TRAM:Class1
    {
        Class1 db = new Class1();
        public bool ExcuteQuery_TRAM(String name, DTO_TRAM tram)
        {
            try
            {
                SqlConnection connection = new SqlConnection(conn);
                SqlCommand command = new SqlCommand(name, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@ma_tran", tram.MA));
                command.Parameters.Add(new SqlParameter("@ten_tram", tram.TEN));
                command.Parameters.Add(new SqlParameter("@dia_chi", tram.DIA_CHI));
                command.Parameters.Add(new SqlParameter("@mo_ta", tram.MO_TA));
                command.Parameters.Add(new SqlParameter("@id_donvi",tram.DON_VI));
                command.Parameters.Add(new SqlParameter("@status", tram.STATUS));
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

        public bool DELETE_TRAM(String name, string tram,int id)
        {
            try
            {
                SqlConnection connection = new SqlConnection(conn);
                SqlCommand command = new SqlCommand(name, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@ma_tran", tram));
                command.Parameters.Add(new SqlParameter("@status",id));
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