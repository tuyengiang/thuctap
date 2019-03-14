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
    public class BUS_NO
    {
        DAL_NO no = new DAL_NO();
        public bool Query(String name, DTO_NO noti)
        {
            return no.ExcuteQuery_NO(name, noti);
        }
        public bool Delete(String name, string id)
        {
            return no.Delete_no(name, id);
        }
        public bool update(String name, DTO_NO noti, string id)
        {
            return no.Update_NO(name,noti, id);
        }
    }
}