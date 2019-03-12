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
    public class DAL_AD:Class1
    {
        Class1 db = new Class1();
        public bool ExcuteQuery_AD(String name, DTO_AD ad)
        {
            try
            {
                SqlConnection connection = new SqlConnection(conn);
                SqlCommand command = new SqlCommand(name, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@name_user",ad.NameUser));
                command.Parameters.Add(new SqlParameter("@matkhau",ad.Password));
                command.Parameters.Add(new SqlParameter("@tenhienthi",ad.NameDisplay));
                command.Parameters.Add(new SqlParameter("@gioitinh",ad.Sex));
                command.Parameters.Add(new SqlParameter("@sdt",ad.SDT));
                command.Parameters.Add(new SqlParameter("@ngaysinh",ad.NgaySinh));
                command.Parameters.Add(new SqlParameter("@id_donvi",ad.DonVi));
                command.Parameters.Add(new SqlParameter("@anhdaidien",ad.Avartar));
                command.Parameters.Add(new SqlParameter("@khoatk",ad.KhoaTK));
                command.Parameters.Add(new SqlParameter("@xoatk",ad.XoaTK));
                command.Parameters.Add(new SqlParameter("@ngay_tao",ad.NgayTao));
                command.Parameters.Add(new SqlParameter("@ngay_cap_nhat",ad.NgayCapNhat));
                command.Parameters.Add(new SqlParameter("@id_supper",ad.Supper));
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

        public bool KhoaTK(String name,String value,string name_user)
        {
            try
            {
                SqlConnection connection = new SqlConnection(conn);
                SqlCommand command = new SqlCommand(name, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@name_user", name_user));
                command.Parameters.Add(new SqlParameter("@khoatk",value));
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
        public bool XoaTK(String name, String value, string name_user)
        {
            try
            {
                SqlConnection connection = new SqlConnection(conn);
                SqlCommand command = new SqlCommand(name, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@name_user", name_user));
                command.Parameters.Add(new SqlParameter("@xoatk", value));
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
        public bool ResetMK(String name, String value, string name_user)
        {
            try
            {
                SqlConnection connection = new SqlConnection(conn);
                SqlCommand command = new SqlCommand(name, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@name_user", name_user));
                command.Parameters.Add(new SqlParameter("@matkhau", value));
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

        public bool Refresh_account(string name,string user,string value)
        {
            try
            {
                SqlConnection connection = new SqlConnection(conn);
                SqlCommand command = new SqlCommand(name, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@name_user", user));
                command.Parameters.Add(new SqlParameter("@xoatk", value));
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
        public bool Unlock_account(string name, string user, string value)
        {
            try
            {
                SqlConnection connection = new SqlConnection(conn);
                SqlCommand command = new SqlCommand(name, connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@name_user", user));
                command.Parameters.Add(new SqlParameter("@khoatk", value));
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