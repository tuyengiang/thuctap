﻿using MyNews;
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
namespace WebApp.Admin
{
    public partial class admin_loai_thietbi : System.Web.UI.Page
    {
        Class1 db = new Class1();
        BUS_LTB bus_ltb = new BUS_LTB();
        public void hienthi()
        {
            String sql = "SELECT ma_loaiTB, ten_loaiTB,LTB.mota_tb, COUNT(tb.id_loaitb) AS Soluong  FROM dbo.loai_TB LTB LEFT JOIN dbo.thiet_bi tb ON tb.id_loaitb = LTB.id_loaiTB GROUP BY ma_loaiTB, LTB.ten_loaiTB,LTB.mota_tb  ORDER BY LTB.ma_loaiTB";
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
                String sql = "Select ma_loaiTB from loai_TB where ma_loaiTB='" + txt_maloaiTB.Text + "'";
                String ma = "";
                foreach (DataRow dt in db.bindDataTable(sql).Rows)
                {
                    ma = dt["ma_loaiTB"].ToString();
                }
                if (ma == txt_maloaiTB.Text)
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Mã loại thiết bị đã tồn tại !!!', 'error');", true);
                }
                else
                {
                    DTO_LTB tb = new DTO_LTB(txt_maloaiTB.Text, txt_tenloaiTB.Text, txt_mota.Text);
                    if (bus_ltb.Query("_Insert_loaiTB", tb))
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Thêm loại thiết bị thành công !!!', 'success');", true);
                        hienthi();
                        ClearAll();
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Thêm loại thiết bị thất bại !!!', 'error');", true);
                    }
                }

            }catch(Exception ex) { }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string ma = txt_delete.Text;
            if (bus_ltb.Delete("_Delete_loaiTB", ma))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Xóa loại thiết bị thành công !!!', 'success');", true);
                hienthi();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Xóa loại thiết bị thất bại !!!', 'error');", true);

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
            else if (e.CommandName == "xoa")
            {
                string ma = e.CommandArgument.ToString();
                GetData(ma);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalAddDelete();", true);
            }
        }
        public void BindInfo(string ma)
        {
            String sql = "Select * from loai_TB where ma_loaiTB='" + ma.ToString() + "'";
            foreach (DataRow dt in db.bindDataTable(sql).Rows)
            {
                txt_maloaiTB_edit.Text = dt["ma_loaiTB"].ToString();
                txt_tenloaiTB_edit.Text = dt["ten_loaiTB"].ToString();
                txt_mota_edit.Text = dt["mota_tb"].ToString();
            }
        }

        public void GetData(String ma)
        {
            String sql = "Select * from loai_TB where ma_loaiTB='" + ma.ToString() + "'";
            foreach (DataRow dt in db.bindDataTable(sql).Rows)
            {
                txt_ten.Text = dt["ten_loaiTB"].ToString();
                txt_delete.Text = dt["ma_loaiTB"].ToString();
            }
        }

        public void ClearAll()
        {
            txt_maloaiTB.Text = "";
            txt_tenloaiTB.Text = "";
            txt_mota.Text = "";
        }

        protected void btnEditChange_Click(object sender, EventArgs e)
        {
            DTO_LTB tb = new DTO_LTB(txt_maloaiTB_edit.Text, txt_tenloaiTB_edit.Text, txt_mota_edit.Text);
            if (bus_ltb.Query("_Update_loaiTB", tb))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Cập nhật loại thiết bị thành công !!!', 'success');", true);
                hienthi();
                ClearAll();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Cập nhật loại thiết bị thất bại !!!', 'error');", true);
            }
        }
        public void Search(String ma)
        {
            String sql = "SELECT *,case trang_thai when 'False' then N'Không có thiết bị' when 'True' then N'Có thiết bị' end as trang_thaiA FROM loai_TB where CONCAT('ma_loaiTB','ten_loaiTB') LIKE '%" + ma.ToString() + "%'";
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
                case "maloai":
                    String sql = "SELECT ma_loaiTB, ten_loaiTB,LTB.mota_tb, COUNT(tb.id_loaitb) AS Soluong  FROM dbo.loai_TB LTB LEFT JOIN dbo.thiet_bi tb ON tb.id_loaitb = LTB.id_loaiTB WHERE ma_loaiTB like '%" + inputSearch.Text + "%' GROUP BY ma_loaiTB, LTB.ten_loaiTB,LTB.mota_tb  ORDER BY LTB.ma_loaiTB";
                    BindSeach(sql);
                    break;
                case "tenloai":
                    String sql2 = "SELECT ma_loaiTB, ten_loaiTB,LTB.mota_tb, COUNT(tb.id_loaitb) AS Soluong  FROM dbo.loai_TB LTB LEFT JOIN dbo.thiet_bi tb ON tb.id_loaitb = LTB.id_loaiTB WHERE ten_loaiTB like '%" + inputSearch.Text + "%' GROUP BY ma_loaiTB, LTB.ten_loaiTB,LTB.mota_tb  ORDER BY LTB.ma_loaiTB";
                    BindSeach(sql2);
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
            example.PageIndex = e.NewPageIndex;
            int trang_thu = e.NewPageIndex;
            int so_dong = example.PageSize;
            stt = trang_thu * so_dong + 1;
            hienthi();
        }
    }
}