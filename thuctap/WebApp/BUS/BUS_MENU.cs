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
    public class BUS_MENU
    {
        DAL_MENU menu = new DAL_MENU();

        public bool Query(String name, DTO_MENU da)
        {
            return menu.Query(name, da);
        }
        public bool Delete(String name,string da)
        {
            return menu.Delete(name, da);
        }
    }
}