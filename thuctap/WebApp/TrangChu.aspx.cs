﻿using MyNews;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
namespace WebApp
{
    public partial class Trangchu : System.Web.UI.Page
    {
        Class1 db = new Class1();
        protected void Page_Load(object sender, EventArgs e)
        {
            hienthi();
        }

        public void hienthi()
        {
            String sql = "select * from notification";
            DataView dv = new DataView(db.bindDataTable(sql));
            rptNoti.DataSource = dv;
            rptNoti.DataBind();
        }
       
        protected void btnChange_Click(object sender, EventArgs e)
        {
            
        }
    }
}