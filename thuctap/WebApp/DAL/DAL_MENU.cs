using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebApp.DTO;
using System.Data;
using System.Data.SqlClient;
using MyNews;

namespace WebApp.DAL
{
    public class DAL_MENU:Class1
    {
        Class1 db = new Class1();
        public bool Query(String name, DTO_MENU menu)
        {
            try
            {
                SqlConnection connection = new SqlConnection(conn);
                SqlCommand command = new SqlCommand(name, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@name", menu.NAME));
                command.Parameters.Add(new SqlParameter("@link", menu.LINK));
                command.Parameters.Add(new SqlParameter("@id_Menu", menu.ID_MENU));
                command.Parameters.Add(new SqlParameter("@icon", menu.ICON));
                command.Parameters.Add(new SqlParameter("@icon_angle", menu.ICON_TO));
                command.Parameters.Add(new SqlParameter("@toggle", menu.TOGGLE));
                command.Parameters.Add(new SqlParameter("@toggle_id", menu.TO_ID));
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
        public bool Delete(String name, String value)
        {
            try
            {
                SqlConnection connection = new SqlConnection(conn);
                SqlCommand command = new SqlCommand(name, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@ID", value));
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