using MyNews;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApp.DTO;
using WebApp.DAL;
using WebApp.BUS;
using System.Text;

namespace WebApp
{
    public partial class admin_ds_don_vi : System.Web.UI.Page
    {
        Class1 db = new Class1();
        BUS_DV bus_dv = new BUS_DV();
        public void hienthi()
        {
            String sql = "SELECT * FROM don_vi";
            DataView dv = new DataView(db.bindDataTable(sql));
            example.DataSource = dv;
            example.DataBind();

        }

        
        protected void Page_Load(object sender, EventArgs e)
        {
            hienthi();
            
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                    
                    DTO_DV dv = new DTO_DV(txt_madv.Text, txt_tendv.Text, txt_diachi.Text, txt_mota.Text);
                    if (bus_dv.Query("_Insert_donvi", dv))
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Thêm đơn vị thành công !!!', 'success');", true);
                        hienthi();
                        clearAll();
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Thêm đơn vị thất bại !!!', 'error');", true);
                    }
                
            }
            catch(Exception ex)
            {

            }
        }
        
        protected void btnDelete_Click1(object sender, EventArgs e)
        {
            String ma = txt_delete.Text;
            
            if (bus_dv.Delete("_Delete_Donvi", ma))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Xóa đơn vị thành công !!!', 'success');", true);
                hienthi();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Xóa đơn vị thất bại !!!', 'error');", true);
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {

            try
            {
                DTO_DV dv = new DTO_DV(txt_madv_edit.Text, txt_tendv_edit.Text, txt_diachi_edit.Text, txt_mota_edit.Text);
                if (bus_dv.Query("_Update_donvi", dv))
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Cập nhật đơn vị thành công !!!', 'success');", true);
                    hienthi();
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Cập nhật đơn vị thất bại !!!', 'error');", true);
                }
            }
            catch (Exception ex)
            {

            }
        }
        protected void example_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "chinhsua")
            {
                string ma = e.CommandArgument.ToString();
                BindInfo(ma);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalAddEdit();", true);
            }
            else if(e.CommandName == "xoa")
            {
                string ma = e.CommandArgument.ToString();
                GetData(ma);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalAddDelete();", true);
            }
        }

        public void BindInfo(string ma)
        {
            String sql = "Select * from don_vi where ma_donvi='" + ma.ToString() +"'";
            foreach(DataRow dt in db.bindDataTable(sql).Rows)
            {
                txt_madv_edit.Text= dt["ma_donvi"].ToString();
                txt_tendv_edit.Text = dt["ten_donvi"].ToString();
                txt_diachi_edit.Text = dt["dia_chi"].ToString();
                txt_mota_edit.Text = dt["mo_ta"].ToString();
            }
        }

        public void GetData(String ma)
        {
            String sql = "Select * from don_vi where ma_donvi='" + ma.ToString() + "'";
            foreach (DataRow dt in db.bindDataTable(sql).Rows)
            {
                txt_ten.Text = dt["ten_donvi"].ToString();
                txt_delete.Text = dt["ma_donvi"].ToString();
            }
        }

        public void clearAll()
        {
            txt_madv.Text = "";
            txt_tendv.Text = "";
            txt_diachi.Text = "";
            txt_mota.Text = "";
        }

       
        int stt = 1;
        public string get_stt()
        {
            return Convert.ToString(stt++);
        }

        protected void example_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
           
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
                case "madv":
                    String sql = "SELECT * FROM don_vi WHERE ma_donvi LIKE '%"+inputSearch.Text+"%'";
                    BindSeach(sql);
                    break;
                case "tendv":
                    String sql2 = "SELECT * FROM don_vi WHERE ten_donvi LIKE '%" + inputSearch.Text + "%'";
                    BindSeach(sql2);
                    break;
                case "diachi":
                    String sql3 = "SELECT * FROM don_vi WHERE dia_chi LIKE '%" + inputSearch.Text + "%'";
                    BindSeach(sql3);
                    break;
                case "NULL":
                    hienthi();
                    break;
            }
        }

        protected void btn_refresh_Click(object sender, EventArgs e)
        {
            hienthi();
        }

        protected void example_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (searchSelect.SelectedValue == "madv")
            {
                example.PageIndex = e.NewPageIndex;
                int trang_thu = e.NewPageIndex;
                int so_dong = example.PageSize;
                stt = trang_thu * so_dong + 1;
                String sql = "SELECT * FROM don_vi WHERE ma_donvi LIKE '%" + inputSearch.Text + "%'";
                BindSeach(sql);
            }
            else if (searchSelect.SelectedValue == "tendv")
            {
                example.PageIndex = e.NewPageIndex;
                int trang_thu = e.NewPageIndex;
                int so_dong = example.PageSize;
                stt = trang_thu * so_dong + 1;
                String sql2 = "SELECT * FROM don_vi WHERE ten_donvi LIKE '%" + inputSearch.Text + "%'";
                BindSeach(sql2);
            }
            else if (searchSelect.SelectedValue == "diachi")
            {
                example.PageIndex = e.NewPageIndex;
                int trang_thu = e.NewPageIndex;
                int so_dong = example.PageSize;
                stt = trang_thu * so_dong + 1;
                String sql3 = "SELECT * FROM don_vi WHERE dia_chi LIKE '%" + inputSearch.Text + "%'";
                BindSeach(sql3);
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
    }
}