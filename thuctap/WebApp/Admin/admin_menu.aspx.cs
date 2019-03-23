using MyNews;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using WebApp.DTO;
using WebApp.DAL;
using WebApp.BUS;
using System.Text;
using MyNews;
namespace WebApp.Admin
{
    public partial class admin_menu : System.Web.UI.Page
    {
        Class1 db = new Class1();
        BUS_MENU menu = new BUS_MENU();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hienthi();
                loaddv();
            }
        }
        public void hienthi()
        {
            String sql = "select * from menu";
            DataView dv = new DataView(db.bindDataTable(sql));
            example.DataSource = dv;
            example.DataBind();
        }
        private void loaddv()
        {
            String sql = "Select * from menu where id_Menu=0";
            MenuCha.DataSource = db.bindDataTable(sql);
            MenuCha.DataTextField = "--- Menu cha----";
            MenuCha.DataValueField = "NULL";
            MenuCha.DataTextField = "name";
            MenuCha.DataValueField = "id";
            MenuCha.DataBind();
            MenuCha.Items.Insert(0,"--- Chọn Menu ---");
        }

        protected void hoatAnh_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(hoatAnh.SelectedValue.ToString()== "collapse")
            {
                txt_submenu.Enabled = true;
                txt_nameha.Enabled = true;
            }
        }
        public void clearAll()
        {
            txt_name.Text = "";
            txt_url.Text = "";
            txt_icon.Text = "";
            txt_submenu.Text = "";
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                String sql = "Select name from menu where name='" + txt_name.Text + "'";
                String ma = "";
                foreach (DataRow dt in db.bindDataTable(sql).Rows)
                {
                    ma = dt["name"].ToString();
                }
                if (ma == txt_name.Text)
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Menu đã tồn tại !!!', 'error');", true);
                }
                else
                {
                    int dv = Convert.ToInt32(MenuCha.SelectedValue.ToString());
                    DTO_MENU m = new DTO_MENU(txt_name.Text,txt_url.Text,dv,txt_icon.Text,txt_submenu.Text,hoatAnh.SelectedValue.ToString(), txt_nameha.Text);
                    if (menu.Query("_Insert_Menu", m))
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Thêm menu thành công !!!', 'success');", true);
                        hienthi();
                        clearAll();
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Thêm menu thất bại !!!', 'error');", true);
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }

        protected void example_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "xoa")
            {
                txt_xoa.Text = e.CommandArgument.ToString();
                String sql = "Select name from menu where ID='" + txt_xoa.Text + "'";
                foreach (DataRow dt in db.bindDataTable(sql).Rows)
                {
                    String user = dt["name"].ToString();
                    txt_ten2.Text = user.ToString();
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalAddDelete();", true);
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (menu.Delete("_Delete_Menu", txt_xoa.Text))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Xóa menu thành công !!!', 'success');", true);
                hienthi();
                clearAll();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Xóa menu thất bại !!!', 'error');", true);
            }
        }
    }
}