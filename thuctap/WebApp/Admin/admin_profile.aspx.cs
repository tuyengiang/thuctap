using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using MyNews;

namespace WebApp.Admin
{
    public partial class admin_profile : System.Web.UI.Page
    {
        Class1 db = new Class1();
        String user = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                user = Session["username"].ToString();
                string sql = "select Account.*,don_vi.ten_donvi from Account,don_vi where Account.id_donvi=don_vi.id_donvi and name_user='" + user + "'";
                String name = "";
                String huyen = "";
                String avatar = "";
                foreach (DataRow user in db.bindDataTable(sql).Rows)
                {
                    name = user["tenhienthi"].ToString();
                    huyen = user["ten_donvi"].ToString();
                    avatar = user["anhdaidien"].ToString();
                }
                avatar_account.ImageUrl = avatar.ToString();
                show();
            }
            else
            {
                Response.Redirect("~/DangNhap.aspx");
            }
        }

        public void show()
        {
            String sql = "SELECT *,don_vi.ten_donvi FROM Account,don_vi WHERE Account.id_donvi=don_vi.id_donvi AND name_user='" + Session["username"].ToString() + "'";
            DataView dv = new DataView(db.bindDataTable(sql));
            Repeater1.DataSource = dv;
            Repeater1.DataBind();
        }
    }
}