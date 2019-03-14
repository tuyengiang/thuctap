using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MyNews;
using WebApp.DTO;
using System.Data.SqlClient;
using System.Data;
namespace WebApp.DAL
{
    public class DAL_NO:Class1
    {
        Class1 db = new Class1();
        public bool ExcuteQuery_NO(String name, DTO_NO dv)
        {
            try
            {
                SqlConnection connection = new SqlConnection(conn);
                SqlCommand command = new SqlCommand(name, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@title", dv.TITLE));
                command.Parameters.Add(new SqlParameter("@content", dv.CONTENT));
                command.Parameters.Add(new SqlParameter("@id_user", dv.USER));
                command.Parameters.Add(new SqlParameter("@created_at", dv.CREATE));
                command.Parameters.Add(new SqlParameter("@updated_at", dv.UPDATE));
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
        public bool Update_NO(String name, DTO_NO dv,string id)
        {
            try
            {
                SqlConnection connection = new SqlConnection(conn);
                SqlCommand command = new SqlCommand(name, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@id", id));
                command.Parameters.Add(new SqlParameter("@title", dv.TITLE));
                command.Parameters.Add(new SqlParameter("@content", dv.CONTENT));
                command.Parameters.Add(new SqlParameter("@id_user", dv.USER));
                command.Parameters.Add(new SqlParameter("@created_at", dv.CREATE));
                command.Parameters.Add(new SqlParameter("@updated_at", dv.UPDATE));
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
        public bool Delete_no(String name, string ma)
        {
            try
            {
                SqlConnection connection = new SqlConnection(conn);
                SqlCommand command = new SqlCommand(name, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@id", ma));
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