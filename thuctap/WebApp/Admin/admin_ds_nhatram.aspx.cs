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
        BUS_ThietB bus_tb = new BUS_ThietB();
        public void hienthi()
        {
            String sql = "SELECT nt.ma_tran,nt.ten_tram,nt.dia_chi,nt.mo_ta,dv.ten_donvi ,COUNT(tb.id_loaitb) AS SoLuong FROM dbo.nha_tram nt LEFT JOIN dbo.thiet_bi tb ON tb.id_tram = nt.id_tram JOIN dbo.don_vi dv ON dv.id_donvi = nt.id_donvi WHERE nt.status=1 GROUP BY nt.ma_tran, nt.ten_tram,nt.dia_chi,nt.mo_ta,dv.ten_donvi ORDER BY nt.ma_tran";
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
                loadSearch();
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
        private void loadSearch()
        {
            String sql = "Select * from don_vi";
            searchDV.DataSource = db.bindDataTable(sql);
            searchDV.DataTextField = "ten_donvi";
            searchDV.DataValueField = "id_donvi";
            searchDV.DataBind();
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
                String sql = "Select ma_tran from nha_tram where ma_tran='" + txt_matram.Text + "' and status=1";
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
                    DTO_TRAM tr = new DTO_TRAM(txt_matram.Text, txt_tentram.Text, txt_diachi.Text, txt_mota.Text,dv,1);
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
           String sql = "SELECT id_tram from nha_tram where ma_tran='" + ma + "'";
           string id;
           foreach (DataRow dt in db.bindDataTable(sql).Rows)
           {
                if (bus.Delete("_Delete_Tram", ma, 0))
                {
                    id = dt["id_tram"].ToString();
                    if (id!=null)
                    {
                        int a = Convert.ToInt32(id);
                        if (bus_tb.Delete_tb_tram("_Update_TB_TRAM", a, 0))
                        {
                            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Xóa trạm thành công !!!', 'success');", true);
                            hienthi();
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Xóa  trạm thành công !!!', 'success');", true);
                        hienthi();
                    }
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Xóa trạm thất bại !!!', 'error');", true);

                }
            }
           
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int dv = Convert.ToInt32(id_donvi_edit.SelectedValue.ToString());
            DTO_TRAM tr = new DTO_TRAM(txt_ma_edit.Text, txt_ten_edit.Text, txt_diachi_edit.Text, txt_mota_edit.Text, dv,1);
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

        protected void searchDV_SelectedIndexChanged(object sender, EventArgs e)
        {
            String sql = "SELECT dv.id_donvi,nt.ma_tran,nt.ten_tram,nt.dia_chi,nt.mo_ta,dv.ten_donvi ,COUNT(tb.id_loaitb) AS SoLuong FROM dbo.nha_tram nt LEFT JOIN dbo.thiet_bi tb ON tb.id_tram = nt.id_tram JOIN dbo.don_vi dv ON dv.id_donvi = nt.id_donvi WHERE status=1 and dv.id_donvi='"+searchDV.SelectedValue.ToString()+"' GROUP BY dv.id_donvi,nt.ma_tran, nt.ten_tram,nt.dia_chi,nt.mo_ta,dv.ten_donvi ORDER BY nt.ma_tran";
            DataView dv = new DataView(db.bindDataTable(sql));
            example.DataSource = dv;
            example.DataBind();
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
            switch (item) {
                case "madv":
                    String sql = "SELECT nt.ma_tran,nt.ten_tram,nt.dia_chi,nt.mo_ta,dv.ten_donvi ,COUNT(tb.id_loaitb) AS SoLuong FROM dbo.nha_tram nt LEFT JOIN dbo.thiet_bi tb ON tb.id_tram = nt.id_tram JOIN dbo.don_vi dv ON dv.id_donvi = nt.id_donvi WHERE nt.status=1 and  nt.ma_tran like '%" + inputSearch.Text + "%' GROUP BY nt.ma_tran, nt.ten_tram,nt.dia_chi,nt.mo_ta,dv.ten_donvi ORDER BY nt.ma_tran";
                    BindSeach(sql);
                    break;
                case "tendv":
                    String sql2 = "SELECT nt.ma_tran,nt.ten_tram,nt.dia_chi,nt.mo_ta,dv.ten_donvi ,COUNT(tb.id_loaitb) AS SoLuong FROM dbo.nha_tram nt LEFT JOIN dbo.thiet_bi tb ON tb.id_tram = nt.id_tram JOIN dbo.don_vi dv ON dv.id_donvi = nt.id_donvi WHERE nt.status=1 and  nt.ten_tram like '%" + inputSearch.Text + "%' GROUP BY nt.ma_tran, nt.ten_tram,nt.dia_chi,nt.mo_ta,dv.ten_donvi ORDER BY nt.ma_tran";
                    BindSeach(sql2);
                    break;
                case "diachi":
                    String sql3 = "SELECT nt.ma_tran,nt.ten_tram,nt.dia_chi,nt.mo_ta,dv.ten_donvi ,COUNT(tb.id_loaitb) AS SoLuong FROM dbo.nha_tram nt LEFT JOIN dbo.thiet_bi tb ON tb.id_tram = nt.id_tram JOIN dbo.don_vi dv ON dv.id_donvi = nt.id_donvi WHERE nt.status=1 and  nt.dia_chi like '%" + inputSearch.Text + "%' GROUP BY nt.ma_tran, nt.ten_tram,nt.dia_chi,nt.mo_ta,dv.ten_donvi ORDER BY nt.ma_tran";
                    BindSeach(sql3);
                    break;
            }

        }

        protected void btn_refresh_Click(object sender, EventArgs e)
        {
            hienthi();
        }

        int stt = 1;
        public string get_stt()
        {
            return Convert.ToString(stt++);
        }
        protected void example_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (searchSelect.SelectedValue == "madv")
            {
                example.PageIndex = e.NewPageIndex;
                int trang_thu = e.NewPageIndex;
                int so_dong = example.PageSize;
                stt = trang_thu * so_dong + 1;
                String sql = "SELECT nt.ma_tran,nt.ten_tram,nt.dia_chi,nt.mo_ta,dv.ten_donvi ,COUNT(tb.id_loaitb) AS SoLuong FROM dbo.nha_tram nt LEFT JOIN dbo.thiet_bi tb ON tb.id_tram = nt.id_tram JOIN dbo.don_vi dv ON dv.id_donvi = nt.id_donvi WHERE nt.status=1 and  nt.ma_tran like '%" + inputSearch.Text + "%' GROUP BY nt.ma_tran, nt.ten_tram,nt.dia_chi,nt.mo_ta,dv.ten_donvi ORDER BY nt.ma_tran";
                BindSeach(sql);
            }
            else if (searchSelect.SelectedValue == "tendv")
            {
                example.PageIndex = e.NewPageIndex;
                int trang_thu = e.NewPageIndex;
                int so_dong = example.PageSize;
                stt = trang_thu * so_dong + 1;
                String sql2 = "SELECT nt.ma_tran,nt.ten_tram,nt.dia_chi,nt.mo_ta,dv.ten_donvi ,COUNT(tb.id_loaitb) AS SoLuong FROM dbo.nha_tram nt LEFT JOIN dbo.thiet_bi tb ON tb.id_tram = nt.id_tram JOIN dbo.don_vi dv ON dv.id_donvi = nt.id_donvi WHERE nt.status=1 and  nt.ten_tram like '%" + inputSearch.Text + "%' GROUP BY nt.ma_tran, nt.ten_tram,nt.dia_chi,nt.mo_ta,dv.ten_donvi ORDER BY nt.ma_tran";
                BindSeach(sql2);
            }
            else if (searchSelect.SelectedValue == "diachi")
            {
                example.PageIndex = e.NewPageIndex;
                int trang_thu = e.NewPageIndex;
                int so_dong = example.PageSize;
                stt = trang_thu * so_dong + 1;
                String sql3 = "SELECT nt.ma_tran,nt.ten_tram,nt.dia_chi,nt.mo_ta,dv.ten_donvi ,COUNT(tb.id_loaitb) AS SoLuong FROM dbo.nha_tram nt LEFT JOIN dbo.thiet_bi tb ON tb.id_tram = nt.id_tram JOIN dbo.don_vi dv ON dv.id_donvi = nt.id_donvi WHERE nt.status=1 and  nt.dia_chi like '%" + inputSearch.Text + "%' GROUP BY nt.ma_tran, nt.ten_tram,nt.dia_chi,nt.mo_ta,dv.ten_donvi ORDER BY nt.ma_tran";
                BindSeach(sql3);
            }
            else
            {
                example.PageIndex = e.NewPageIndex;   //trang hien tai
                int trang_thu = e.NewPageIndex;      //the hien trang thu may
                int so_dong = example.PageSize;       //moi trang co bao nhieu dong
                stt = trang_thu * so_dong + 1;
                hienthi();
            }
        }

        protected void example_PageIndexChanging1(object sender, GridViewPageEventArgs e)
        {

        }
    }
}