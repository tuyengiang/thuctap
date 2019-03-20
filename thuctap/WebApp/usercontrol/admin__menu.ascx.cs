using MyNews;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
namespace WebApp.usercontrol
{
    public partial class admin__menu : System.Web.UI.UserControl
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
                username.Text = name;
                avatar_user.ImageUrl = avatar;
                getMenu();
            }
            else
            {
                Response.Redirect("~/DangNhap.aspx");
            }
        }

        public void getMenu()
        {
            String sql = "SELECT * FROM menu where id_Menu=0";
            DataView dv = new DataView(db.bindDataTable(sql));
            rptMenu.DataSource = dv;
            rptMenu.DataBind();
        }


       

        protected void rptMenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            DataRowView dv = e.Item.DataItem as DataRowView;
            if (dv != null)
            {
                Repeater rpt_sub = e.Item.FindControl("rpt_Sub") as Repeater;
                int id_menu = (int)dv.Row["ID"];
                string sql = "SELECT * FROM menu WHERE id_Menu='" + id_menu+ "'";
                DataView dt = new DataView(db.bindDataTable(sql));
                rpt_sub.DataSource = dt;
                rpt_sub.DataBind();

            }
        }

        


    }
}