using MyNews;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp
{
    public partial class admin_ds_don_vi : System.Web.UI.Page
    {
        Class1 db = new Class1();
        public void hienthi()
        {
            String sql = "SELECT * FROM don_vi";
            DataView dv = new DataView(db.bindDataTable(sql));
            rptData.DataSource = dv;
            rptData.DataBind();

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            hienthi();
        }
    }
}