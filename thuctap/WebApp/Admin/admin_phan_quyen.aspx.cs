using MyNews;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
namespace WebApp.Admin
{
    public partial class admin_phan_quyen : System.Web.UI.Page
    {
        Class1 db = new Class1();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadUser();
                ShowMenu();
                int n = ListMenu.Items.Count;
                ListMenuUser.Text = n.ToString();
            }

        }

        private void loadUser()
        {
            String sql = "Select * from Account";
            DSuser.DataSource = db.bindDataTable(sql);
            DSuser.DataTextField = "name_user";
            DSuser.DataValueField = "id_user";
            DSuser.DataBind();
        }

        
        private void ShowMenu()
        {
            String sql = "Select * from menu";
            ListMenu.DataSource = db.bindDataTable(sql);
            ListMenu.DataTextField = "name";
            ListMenu.DataValueField = "ID";
            ListMenu.DataBind();
        }

        protected void btnChoose_Click(object sender, EventArgs e)
        {
            for (int i = 0; i <= ListMenu.Items.Count - 1; i++)
            {
                if (ListMenu.Items[i].Selected)
                {
                    ListMenuUser.Items.Add(ListMenu.Items[i]);
                    ListMenu.Items.Remove(ListMenu.Items[i]);
                }
            }
        }

        protected void btnMove_Click(object sender, EventArgs e)
        {
            for (int i = 0; i <= ListMenuUser.Items.Count - 1; i++)
            {
                if (ListMenuUser.Items[i].Selected)
                {
                    ListMenu.Items.Add(ListMenuUser.Items[i]);
                    ListMenuUser.Items.Remove(ListMenuUser.Items[i]);
                }
            }
        }
    }
}