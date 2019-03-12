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
    public class BUS_ThietB
    {
        DAL_ThietB dal_thietB = new DAL_ThietB();

        public bool Query(String name, DTO_ThietB tb)
        {
            return dal_thietB.ExcuteQuery_P(name, tb);
        }
        public bool Delete(String name,String ma)
        {
            return dal_thietB.Delete(name, ma);
        }
    }
}