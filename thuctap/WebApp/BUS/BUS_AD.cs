using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebApp;
using MyNews;
using WebApp.DAL;
using WebApp.DTO;
namespace WebApp.BUS
{
    public class BUS_AD
    {
        DAL_AD ad = new DAL_AD();

        public bool Query(String name, DTO_AD da)
        {
            return ad.ExcuteQuery_AD(name, da);
        }
        public bool Khoa(String name, String value,String name_user)
        {
            return ad.KhoaTK(name, value,name_user);
        }
        public bool Xoa(String name, String value, String name_user)
        {
            return ad.XoaTK(name, value, name_user);
        }
        public bool MatKhau(String name, String value, String name_user)
        {
            return ad.ResetMK(name, value, name_user);
        }

        public bool refresh(string name,string user,string value)
        {
            return ad.Refresh_account(name,user,value);
        }
        public bool unlock(string name, string user, string value)
        {
            return ad.Unlock_account(name, user, value);
        }
    }
}