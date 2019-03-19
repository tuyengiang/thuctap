using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApp;
using WebApp.DTO;
using WebApp.DAL;
using WebApp.BUS;
using System.IO;
using MyNews;
using System.Data;
using System.Data.SqlClient;
namespace WebApp.Admin
{
    public partial class admin_notification : System.Web.UI.Page
    {
        Class1 db = new Class1();
        BUS_NO bus = new BUS_NO();
        public void hienthi()
        {
            String sql = "SELECT *,Account.name_user FROM notification,Account WHERE Account.id_user = notification.id_user";
            DataView dv = new DataView(db.bindDataTable(sql));
            example.DataSource = dv;
            example.DataBind();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            hienthi();
        }

        protected void example_RowDataBound(object sender, GridViewRowEventArgs e)
        {
           
        }

       

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string user = Session["username"].ToString();
            String sql = "Select* from Account where name_user='" + user + "'";
            int id;
            foreach (DataRow dt in db.bindDataTable(sql).Rows)
            {
                id = Convert.ToInt32(dt["id_user"].ToString());

                DateTime date = DateTime.Now;
                DTO_NO no = new DTO_NO(txt_title.Text, txt_content.Text, id, date, date);
                if (bus.Query("_Insert_noti", no))
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Thêm thông báo thành công !!!', 'success');", true);
                    hienthi();
                    clearAll();
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Thêm thông báo thất bại !!!', 'error');", true);
                }
            }
        }

        public void clearAll()
        {
            txt_title.Text = "";
            txt_content.Text = "";
        }

        protected void example_RowCommand1(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "chinhsua")
            {
                String id = e.CommandArgument.ToString();
                txt_id.Text = id;
                getData(id);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalAddEdit();", true);
            }
            else if (e.CommandName == "xoa")
            {
                String id = e.CommandArgument.ToString();
                txt_delete.Text = id;
                getname(id);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalAddDelete();", true);
            }
            else if (e.CommandName == "view")
            {
                String id = e.CommandArgument.ToString();
                getView(id);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalAddView();", true);
            }
        }
        public void getData(String id)
        {
            String sql = "SELECT * FROM notification WHERE id='" + id.ToString() + "'";
            foreach (DataRow dt in db.bindDataTable(sql).Rows)
            {
                txt_title_edit.Text = dt["title"].ToString();
                txt_content_edit.Text = dt["content"].ToString();
            }
        }
        public void getView(String id)
        {
            String sql = "SELECT * FROM notification WHERE id='" + id.ToString() + "'";
            foreach (DataRow dt in db.bindDataTable(sql).Rows)
            {
                title.Text = dt["title"].ToString();
                content.Text = dt["content"].ToString();
            }
        }
        public void getname(String id)
        {
            String sql = "SELECT * FROM notification WHERE id='" + id.ToString() + "'";
            foreach (DataRow dt in db.bindDataTable(sql).Rows)
            {
                txt_ten.Text = dt["title"].ToString();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {

            string user = Session["username"].ToString();
            String sql = "Select* from Account where name_user='" + user + "'";
            int id;

            foreach (DataRow dt in db.bindDataTable(sql).Rows)
            {
                id = Convert.ToInt32(dt["id_user"].ToString());

                DateTime date = DateTime.Now;
                DTO_NO no = new DTO_NO(txt_title_edit.Text, txt_content_edit.Text, id, date, date);
                if (bus.update("_Update_noti",no,txt_id.Text))
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Cập nhật thông báo thành công !!!', 'success');", true);
                    hienthi();
                    clearAll();
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Cập nhật thông báo thất bại !!!', 'error');", true);
                }
            }
        }

        protected void btnDelete_1_Click(object sender, EventArgs e)
        {
            if (bus.Delete("_Delete_noti", txt_delete.Text))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Xóa thông báo thành công !!!', 'success');", true);
                hienthi();
                clearAll();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Xóa thông báo thất bại !!!', 'error');", true);
            }
        }
    }
}