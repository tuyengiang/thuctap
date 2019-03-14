using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApp.DTO;
using WebApp.DAL;
using WebApp.BUS;
using System.Text;
using MyNews;
using System.Data;
using System.Data.SqlClient;
using WebApp.DTO;
using WebApp.DAL;
using WebApp.BUS;
using System.Text;
using MyNews;
using System.Data;
using System.Data.SqlClient;
namespace WebApp.Admin
{
    public partial class admin_ds_nhatram : System.Web.UI.Page
    {
        Class1 db = new Class1();
        BUS_TRAM bus = new BUS_TRAM();
        public void hienthi()
        {
            String sql = "SELECT *,don_vi.ten_donvi FROM nha_tram,don_vi where nha_tram.id_donvi=don_vi.id_donvi";
            DataView dv = new DataView(db.bindDataTable(sql));
            example.DataSource = dv;
            example.DataBind();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hienthi();
                loadDropdown();
                loadDropdown2();
            }
        }
        private void loadDropdown()
        {
            String sql = "Select * from don_vi";
            id_donviSelect.DataSource = db.bindDataTable(sql);
            id_donviSelect.DataTextField = "ten_donvi";
            id_donviSelect.DataValueField = "id_donvi";
            id_donviSelect.DataBind();
        }
        private void loadDropdown2()
        {
            String sql = "Select * from don_vi";
            id_donvi_edit.DataSource = db.bindDataTable(sql);
            id_donvi_edit.DataTextField = "ten_donvi";
            id_donvi_edit.DataValueField = "id_donvi";
            id_donvi_edit.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                String sql = "Select ma_tran from nha_tram where ma_tran='" + txt_matram.Text + "'";
                String ma = "";
                foreach (DataRow dt in db.bindDataTable(sql).Rows)
                {
                    ma = dt["ma_tran"].ToString();
                }
                if (ma == txt_matram.Text)
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Mã trạm đã tồn tại !!!', 'error');", true);
                }
                else
                {
                    int dv = Convert.ToInt32(id_donviSelect.SelectedValue.ToString());
                    DTO_TRAM tr = new DTO_TRAM(txt_matram.Text, txt_tentram.Text, txt_diachi.Text, txt_mota.Text,dv);
                    if (bus.Query("_Insert_tram", tr))
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Thêm nhà trạm thành công !!!', 'success');", true);
                        hienthi();
                        clearAll();
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Thêm nhà trạm thất bại !!!', 'error');", true);
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }

        public void clearAll()
        {
            txt_matram.Text = "";
            txt_tentram.Text = "";
            txt_diachi.Text = "";
            txt_mota.Text = "";
        }

        public void BindData(String ma)
        {
            String sql = "SELECT * FROM nha_tram WHERE ma_tran='" + ma.ToString() + "'";
            foreach(DataRow dt in db.bindDataTable(sql).Rows)
            {
                txt_ten_edit.Text = dt["ten_tram"].ToString();
                id_donvi_edit.Text= dt["id_donvi"].ToString();
                txt_mota_edit.Text = dt["mo_ta"].ToString();
                txt_diachi_edit.Text = dt["dia_chi"].ToString();
            }
        }
        protected void example_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "xoa")
            {
                string ma = e.CommandArgument.ToString();
                GetData(ma);
                txt_delete.Text = ma.ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalAddDelete();", true);
            }
            else if (e.CommandName == "chinhsua")
            {
                string ma = e.CommandArgument.ToString();
                txt_ma_edit.Text = ma;
                BindData(ma);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalAddEdit();", true);
            }
        }
        public void GetData(String ma)
        {
            String sql = "Select * from nha_tram where ma_tran='" + ma.ToString() + "'";
            foreach (DataRow dt in db.bindDataTable(sql).Rows)
            {
                txt_ten.Text = dt["ten_tram"].ToString();
            }
        }

        protected void btnDelete_1_Click(object sender, EventArgs e)
        {
            string ma = txt_delete.Text;
            if (bus.Delete("_Delete_Tram", ma))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Xóa loại trạm thành công !!!', 'success');", true);
                hienthi();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Xóa loại trạm thất bại !!!', 'error');", true);

            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int dv = Convert.ToInt32(id_donvi_edit.SelectedValue.ToString());
            DTO_TRAM tr = new DTO_TRAM(txt_ma_edit.Text, txt_ten_edit.Text, txt_diachi_edit.Text, txt_mota_edit.Text, dv);
            if (bus.Query("_Update_tram", tr))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Cập nhật nhà trạm thành công !!!', 'success');", true);
                hienthi();
                clearAll();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Cập nhật nhà trạm thất bại !!!', 'error');", true);
            }
        }

       
        protected void example_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }
        }
    }
}