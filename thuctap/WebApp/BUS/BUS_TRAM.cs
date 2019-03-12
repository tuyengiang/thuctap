using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebApp.DTO;
using WebApp.DAL;
using System.Data;
using System.Data.SqlClient;
using MyNews;
namespace WebApp.BUS
{
    public class BUS_TRAM
    {
        DAL_TRAM tr = new DAL_TRAM();

        public bool Query(string name, DTO_TRAM a)
        {
            return tr.ExcuteQuery_TRAM(name,a);
        }
        public bool Delete(string name,string tram)
        {
            return tr.DELETE_TRAM(name, tram);
        }
    }
}