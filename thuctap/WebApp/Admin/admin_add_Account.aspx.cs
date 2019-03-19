using MyNews;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using WebApp;
using WebApp.DTO;
using WebApp.DAL;
using WebApp.BUS;
using System.IO;

namespace WebApp.Admin
{
    public partial class admin_add_Account : System.Web.UI.Page
    {
        Class1 db = new Class1();
        BUS_AD bus = new BUS_AD();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hienthi();
                loadDropdown();
                loadUser();
                loadSearch();
            }
        }
        public void hienthi()
        {
            String sql = "SELECT Account.*, don_vi.ten_donvi,group_user.name_super,case gioitinh when 'False' then N'Nữ' when 'True' then N'Nam' end as gioitinhA,case khoatk when 'False' then N'Mở khóa' when 'True' then N'Đang khóa' end as khoa,case xoatk when 'False' then N'Hoạt động' when 'True' then N'Không hoạt động' end as xoa FROM Account,don_vi,group_user Where Account.id_donvi=don_vi.id_donvi AND Account.id_supper=group_user.id_supper";
            DataView dv = new DataView(db.bindDataTable(sql));
            example.DataSource = dv;
            example.DataBind();
        }
        private void loadDropdown()
        {
            String sql = "Select * from don_vi";
            id_donvi.DataSource = db.bindDataTable(sql);
            id_donvi.DataTextField = "ten_donvi";
            id_donvi.DataValueField = "id_donvi";
            id_donvi.DataBind();
        }
        private void loadSearch()
        {
            String sql = "Select * from don_vi";
            searchDV.DataSource = db.bindDataTable(sql);
            searchDV.DataTextField = "ten_donvi";
            searchDV.DataValueField = "id_donvi";
            searchDV.DataBind();
        }
        private void loadUser()
        {
            String sql = "Select * from group_user";
            id_supper.DataSource = db.bindDataTable(sql);
            id_supper.DataTextField = "name_super";
            id_supper.DataValueField = "id_supper";
            id_supper.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string sql = "SELECT name_user FROM Account WHERE name_user='" + txt_username.Text + "'";
            String user = "";
            foreach (DataRow dt in db.bindDataTable(sql).Rows)
            {
                user = dt["name_user"].ToString();
            }

            if (user != txt_username.Text)
            {
                DateTime date = DateTime.Now;
                string fullfilename = "";
                string filename = "/images/user/default.jpg";
                if (FileUpload1.HasFile)
                {
                    fullfilename = Path.GetFileName(FileUpload1.FileName);
                    fullfilename = fullfilename.Replace(" ", "_");
                    Guid uid = Guid.NewGuid();
                    string SaveLocation = Server.MapPath("~/images/user/") + "" + uid + fullfilename;
                    string fileExtention = FileUpload1.PostedFile.ContentType;
                    int fileLenght = FileUpload1.PostedFile.ContentLength;
                    System.Drawing.Bitmap bmpPostedImage = new System.Drawing.Bitmap(FileUpload1.PostedFile.InputStream);
                    db.ResizeImage(fullfilename, fileExtention, fileLenght, 600, bmpPostedImage, SaveLocation);
                    filename = "/images/user/" + uid + fullfilename;
                }
                else
                {
                    filename = "/images/user/default.jpg";
                }

                int dvi = Convert.ToInt32(id_donvi.SelectedValue.ToString());
                int supper = Convert.ToInt32(id_supper.SelectedValue.ToString());
                DateTime n = Convert.ToDateTime(txt_ngaysinh.Text);
                String pass = db.MD5Hash(txt_password.Text);
                DTO_AD ad = new DTO_AD(txt_username.Text, pass, txt_name.Text, gioi_tinh.SelectedValue.ToString(), Convert.ToInt32(txt_sdt.Text), n, dvi, filename.ToString(), "False", "False", date, date, supper);
                if (bus.Query("_Insert_Account", ad))
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Thêm tài khoản thành công !!!', 'success');", true);
                    hienthi();
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Thêm tài khoản thất bại !!!', 'error');", true);
                }
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Tài khoản đã tồn tại !!!', 'error');", true);
            }
        }
        protected void example_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton btnXoa = (LinkButton)e.Row.FindControl("btnDelete");
                LinkButton btnKhoiPhuc = (LinkButton)e.Row.FindControl("btnRecycle");
                LinkButton btnkhoa = (LinkButton)e.Row.FindControl("btnKhoa");
                LinkButton btnunlock = (LinkButton)e.Row.FindControl("btnunlock");

                string xoatk = DataBinder.Eval(e.Row.DataItem, "xoatk").ToString();

                if(xoatk == "True")
                {
                    btnXoa.Visible = false;
                    btnKhoiPhuc.Visible = true;
                    btnkhoa.Visible = false;
                }
                else
                {
                    btnXoa.Visible = true;
                    btnKhoiPhuc.Visible = false;
                    btnkhoa.Visible = true;
                }
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton btnkhoa = (LinkButton)e.Row.FindControl("btnKhoa");
                LinkButton btnunlock = (LinkButton)e.Row.FindControl("btunlock");
                string khoatk = DataBinder.Eval(e.Row.DataItem, "khoatk").ToString();
                if (khoatk == "True")
                {
                    btnkhoa.Visible = false;
                    btnunlock.Visible = true;
                }
                else
                {
                    btnkhoa.Visible = true;
                    btnunlock.Visible = false;
                }
            }

        }
        protected void example_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "khoa")
            {
                string ma = e.CommandArgument.ToString();
                txt_ten.Text = ma.ToString();
                txt_khoa.Text = ma.ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalAddKhoa();", true);
            }
            else if (e.CommandName == "xoa")
            {
                string ma = e.CommandArgument.ToString();
                txt_ten2.Text = ma.ToString();
                txt_xoa.Text = ma.ToString();
               
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalAddDelete();", true);
                
            }
            else if (e.CommandName == "resset")
            {
                string ma = e.CommandArgument.ToString();
                txt_resset.Text = ma.ToString();
                txt_passnew.Text = "12345678";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalAddEdit();", true);
            }
            else if(e.CommandName== "recory")
            {
                string ma = e.CommandArgument.ToString();
                title_kp.Text = ma.ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalKP();", true);
            }
            else if (e.CommandName == "mo")
            {
                string ma = e.CommandArgument.ToString();
                title_un.Text = ma.ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalUN();", true);
            }
        }
        protected void btnKkhoaTK_Click(object sender, EventArgs e)
        {
            if (bus.Khoa("_Khoa_Account", "True", txt_khoa.Text))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Khóa tài khoản thành công !!!', 'success');", true);
                hienthi();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Khóa tài khoản thất bại !!!', 'error');", true);
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (bus.Xoa("_Xoa_Account", "True", txt_xoa.Text))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Xóa tài khoản thành công !!!', 'success');", true);
                
                hienthi();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Xóa tài khoản thất bại !!!', 'error');", true);
            }
        }

        protected void btnResset_Click(object sender, EventArgs e)
        {
            string pass = db.MD5Hash(txt_passnew.Text);
            if (bus.MatKhau("_Resset_Account", pass, txt_resset.Text))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Resset mật khẩu thành công !!!', 'success');", true);
                hienthi();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Resset mật khẩu thất bại !!!', 'error');", true);
            }
        }

       

        protected void searchDV_SelectedIndexChanged(object sender, EventArgs e)
        {
            String sql = "SELECT Account.*, don_vi.ten_donvi,group_user.name_super,case gioitinh when 'False' then N'Nữ' when 'True' then N'Nam' end as gioitinhA FROM Account,don_vi,group_user Where Account.id_donvi=don_vi.id_donvi AND Account.id_supper=group_user.id_supper AND Account.id_donvi='" + searchDV.SelectedValue.ToString()+"' ";
            DataView dv = new DataView(db.bindDataTable(sql));
            example.DataSource = dv;
            example.DataBind();
        }

        protected void btn_refresh_Click(object sender, EventArgs e)
        {
            hienthi();
        }
        
        
        public void BindSeach(String sql)
        {
            DataView dv = new DataView(db.bindDataTable(sql));
            example.DataSource = dv;
            example.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            String item = searchSelect.SelectedValue.ToString();
            switch (item)
            {
                case "tentk":
                    String sql = "SELECT Account.*, don_vi.ten_donvi,group_user.name_super,case gioitinh when 'False' then N'Nữ' when 'True' then N'Nam' end as gioitinhA FROM Account,don_vi,group_user Where Account.id_donvi=don_vi.id_donvi AND Account.id_supper=group_user.id_supper and name_user like '%" + inputSearch.Text + "%'";
                    BindSeach(sql);
                    break;
                case "tenht":
                    String sql3 = "SELECT Account.*, don_vi.ten_donvi,group_user.name_super,case gioitinh when 'False' then N'Nữ' when 'True' then N'Nam' end as gioitinhA FROM Account,don_vi,group_user Where Account.id_donvi=don_vi.id_donvi AND Account.id_supper=group_user.id_supper and Account.tenhienthi like 'N%" + inputSearch.Text + "%'";
                    BindSeach(sql3);
                    break;
            }
        }
        int stt = 1;
        public string get_stt()
        {
            return Convert.ToString(stt++);
        }
        protected void example_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (searchSelect.SelectedValue=="tentk")
            {
                example.PageIndex = e.NewPageIndex;
                int trang_thu = e.NewPageIndex;
                int so_dong = example.PageSize;
                stt = trang_thu * so_dong + 1;
                String sql = "SELECT Account.*, don_vi.ten_donvi,group_user.name_super,case gioitinh when 'False' then N'Nữ' when 'True' then N'Nam' end as gioitinhA FROM Account,don_vi,group_user Where Account.id_donvi=don_vi.id_donvi AND Account.id_supper=group_user.id_supper and name_user like '%" + inputSearch.Text + "%'";
                BindSeach(sql);
            }
            else if (searchSelect.SelectedValue == "tenht")
            {
                example.PageIndex = e.NewPageIndex;
                int trang_thu = e.NewPageIndex;
                int so_dong = example.PageSize;
                stt = trang_thu * so_dong + 1;
                String sql = "SELECT Account.*, don_vi.ten_donvi,group_user.name_super,case gioitinh when 'False' then N'Nữ' when 'True' then N'Nam' end as gioitinhA FROM Account,don_vi,group_user Where Account.id_donvi=don_vi.id_donvi AND Account.id_supper=group_user.id_supper and Account.tenhienthi like '%" + inputSearch.Text + "%'";
                BindSeach(sql);
            }
            else
            {
                example.PageIndex = e.NewPageIndex;
                int trang_thu = e.NewPageIndex;
                int so_dong = example.PageSize;
                stt = trang_thu * so_dong + 1;
                hienthi();
            }
        }

        protected void btnRecy_Click(object sender, EventArgs e)
        {
            if (bus.refresh("_Refresh_Account", title_kp.Text, "False"))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Khôi phục tài khoản thành công !!!', 'success');", true);
                hienthi();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Khôi phục tài khoản thất bại !!!', 'error');", true);
            }
        }

        protected void Unlock_Click(object sender, EventArgs e)
        {
            if (bus.unlock("_Unlock_Account", title_un.Text, "False"))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Mở khóa tài khoản thành công !!!', 'success');", true);
                hienthi();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Mở khóa tài khoản thất bại !!!', 'error');", true);
            }
        }

        protected void example_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow) e.Row.ID
                = e.Row.RowIndex.ToString();
        }
    }
}