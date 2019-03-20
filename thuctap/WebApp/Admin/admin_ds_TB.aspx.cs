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
namespace WebApp.Admin
{
    public partial class admin_ds_TB : System.Web.UI.Page
    {
        Class1 db = new Class1();
        BUS_ThietB bus_tb = new BUS_ThietB();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hienthi();
                loadDropdown();
                loadTb();
                loaddv();
                loadDropdown_edit();
                loadTb_edit();
                loaddv_edit();
                loadTB();
                txt_ngay_nhan_edit.Text = DateTime.Now.ToString();
            }
        }
        public void hienthi()
        {
            if (Session["username"]!=null)
            {
                if (Request.QueryString["ma_loaiTB"]!=null)
                {
                    String value = Request.QueryString["ma_loaiTB"];
                    String id = "SELECT id_loaiTB FROM loai_TB Where ma_loaiTB='" + value.ToString() + "'";
                    String d = "";
                    foreach (DataRow dt in db.bindDataTable(id).Rows)
                    {
                        d = dt["id_loaiTB"].ToString();
                    }
                    String sql = "SELECT *,nha_tram.ten_tram,case trangthai_thietbi when 'True' Then N'Đang hoạt động' When 'False' Then N'Không hoạt động' end as trang_thai FROM thiet_bi,nha_tram where thiet_bi.id_tram=nha_tram.id_tram and thiet_bi.id_loaitb='" + d.ToString() + "' and thiet_bi.inserted=1";
                    DataView dv = new DataView(db.bindDataTable(sql));
                    example.DataSource = dv;
                    example.DataBind();
                }
                else if (Request.QueryString["ma_tran"] != null)
                {
                    String value = Request.QueryString["ma_tran"];
                    String id = "SELECT id_tram FROM nha_tram Where ma_tran='" + value.ToString() + "'";
                    String d = "";
                    foreach (DataRow dt in db.bindDataTable(id).Rows)
                    {
                        d = dt["id_tram"].ToString();
                    }
                    String sql = "SELECT *,nha_tram.ten_tram,case trangthai_thietbi when 'True' Then N'Đang hoạt động' When 'False' Then N'Không hoạt động' end as trang_thai FROM thiet_bi,nha_tram where thiet_bi.id_tram=nha_tram.id_tram and thiet_bi.id_tram='" + d.ToString() + "' and thiet_bi.inserted=1";
                    DataView dv = new DataView(db.bindDataTable(sql));
                    example.DataSource = dv;
                    example.DataBind();
                }
                else
                {
                    string user = Session["username"].ToString();
                    string id_donvi = "SELECT id_donvi from Account WHERE name_user='" + user + "'";
                    foreach (DataRow dt in db.bindDataTable(id_donvi).Rows)
                    {
                        string id = dt["id_donvi"].ToString();
                        String tram = "SELECT id_tram from nha_tram where id_donvi='" + id + "'";
                        foreach (DataRow dt1 in db.bindDataTable(tram).Rows)
                        {
                            string id_tram = dt1["id_tram"].ToString();
                            String sql = "SELECT *,nha_tram.ten_tram,case trangthai_thietbi when 'True' Then N'Đang hoạt động' When 'False' Then N'Không hoạt động' end as trang_thai FROM thiet_bi,nha_tram where thiet_bi.id_tram=nha_tram.id_tram and thiet_bi.id_tram='" + id_tram + "' and thiet_bi.inserted=1";
                            DataView dv = new DataView(db.bindDataTable(sql));
                            example.DataSource = dv;
                            example.DataBind();
                        }
                    }
                }
            }
            else
            {
                Response.Redirect("~/DangNhap.aspx");
            }
            
        }
        private void loadDropdown()
        {
            if (Session["username"] != null)
            {
                String u= "Select id_donvi from Account where name_user='" + Session["username"].ToString() + "'";

                foreach (DataRow dt in db.bindDataTable(u).Rows)
                {
                    int ma = Convert.ToInt32(dt["id_donvi"].ToString());
                    txt_matb.Text = ma.ToString();
                    String sql = "Select ten_tram,id_tram from nha_tram where id_donvi='" + ma + "' and status=1";
                    id_tram.DataSource = db.bindDataTable(sql);
                    id_tram.DataTextField = "ten_tram";
                    id_tram.DataValueField = "id_tram";
                    id_tram.DataBind();
                }
            }

               
        }
        private void loadTB()
        {
            String sql = "Select * from loai_TB";
            searchDV.DataSource = db.bindDataTable(sql);
            searchDV.DataTextField = "ten_loaiTB";
            searchDV.DataValueField = "id_loaiTB";
            searchDV.DataBind();
        }
        private void loadTb()
        {
            String sql = "Select * from loai_TB";
            id_loaitb.DataSource = db.bindDataTable(sql);
            id_loaitb.DataTextField = "ten_loaiTB";
            id_loaitb.DataValueField = "id_loaiTB";
            id_loaitb.DataBind();
        }
        private void loaddv()
        {
            String sql = "Select * from donvi_tinh";
            id_dvtinh.DataSource = db.bindDataTable(sql);
            id_dvtinh.DataTextField = "ten_dvtinh";
            id_dvtinh.DataValueField = "id_dvtinh";
            id_dvtinh.DataBind();
        }
        private void loadDropdown_edit()
        {
            if (Session["username"] != null)
            {
                String u = "Select id_donvi from Account where name_user='" + Session["username"].ToString() + "'";

                foreach (DataRow dt in db.bindDataTable(u).Rows)
                {
                    int ma = Convert.ToInt32(dt["id_donvi"].ToString());
                    txt_matb.Text = ma.ToString();
                    String sql = "Select ten_tram,id_tram from nha_tram where id_donvi='" + ma + "' and status=1";
                    id_tram_edit.DataSource = db.bindDataTable(sql);
                    id_tram_edit.DataTextField = "ten_tram";
                    id_tram_edit.DataValueField = "id_tram";
                    id_tram_edit.DataBind();
                }
            }

        }
        private void loadTb_edit()
        {
            String sql = "Select * from loai_TB";
            id_loaitb_edit.DataSource = db.bindDataTable(sql);
            id_loaitb_edit.DataTextField = "ten_loaiTB";
            id_loaitb_edit.DataValueField = "id_loaiTB";
            id_loaitb_edit.DataBind();
        }
        private void loaddv_edit()
        {
            String sql = "Select * from donvi_tinh";
            id_dvtinh_edit.DataSource = db.bindDataTable(sql);
            id_dvtinh_edit.DataTextField = "ten_dvtinh";
            id_dvtinh_edit.DataValueField = "id_dvtinh";
            id_dvtinh_edit.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                String sql = "Select ma_thietbi,serinumber from thiet_bi where ma_thietbi='" + txt_matb.Text + "' and thiet_bi.inserted=1";
                String ma = "";
                String n = "";
                foreach (DataRow dt in db.bindDataTable(sql).Rows)
                {
                    ma = dt["ma_thietbi"].ToString();
                    n = dt["serinumber"].ToString();
                }
                if (ma == txt_matb.Text)
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Mã thiết bị đã tồn tại !!!', 'error');", true);
                }
                else {
                    if (n == txt_seri.Text)
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Seri thiết bị đã tồn tại !!!', 'error');", true);
                    }
                    else
                    {
                        DateTime date = DateTime.Now;
                        int dvtinh = Convert.ToInt32(id_dvtinh.Text);
                        int soluong = Convert.ToInt32(txt_soluong.Text);
                        int id_loai = Convert.ToInt32(id_loaitb.SelectedValue.ToString());
                        int tram = Convert.ToInt32(id_tram.SelectedValue.ToString());
                        string user = Session["username"].ToString();
                        String id = "SELECT id_user FROM Account WHERE name_user='" + user + "'";
                        DateTime d = Convert.ToDateTime(ngay_nhan.Text);
                        int id_user;
                        foreach (DataRow dt in db.bindDataTable(id).Rows)
                        {
                            id_user = Convert.ToInt32(dt["id_user"]);
                            DTO_ThietB dtb = new DTO_ThietB(txt_matb.Text, txt_tentb.Text, dvtinh, soluong, txt_seri.Text, trang_thai.SelectedValue.ToString(), d, date, date, id_user, id_user, id_loai, tram,1);
                            if (bus_tb.Query("_Insert_TB", dtb))
                            {
                                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Thêm thiết bị thành công !!!', 'success');", true);
                                hienthi();
                                clearAll();
                            }
                            else
                            {
                                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Thêm thiết bị thất bại !!!', 'error');", true);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }

        public void clearAll()
        {
            txt_matb.Text = "";
            txt_tentb.Text = "";
            txt_seri.Text = "";
            txt_soluong.Text = "";

        }

        protected void example_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "chinhsua")
            {
                BinData(e.CommandArgument.ToString());
                txt_ngay_nhan_edit.Text = DateTime.Now.ToString("dd-MM-yyyy");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalAddEdit();", true);
            }
            else if (e.CommandName == "xoa")
            {
                txt_delete.Text = e.CommandArgument.ToString();
                GetData(e.CommandArgument.ToString());
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalAddDelete();", true);
            }
           
        }

        public void BinData(String ma)
        {
            String Sql = "SELECT * FROM thiet_bi WHERE ma_thietbi='" + ma.ToString() + "'";
            foreach (DataRow dt in db.bindDataTable(Sql).Rows)
            {
                txt_matb_edit.Text = dt["ma_thietbi"].ToString();
                txt_tentb_edit.Text = dt["ten_thietbi"].ToString();
                txt_seri_edit.Text = dt["serinumber"].ToString();
                id_dvtinh_edit.Text = dt["id_dvtinh"].ToString();
                id_loaitb_edit.Text = dt["id_loaitb"].ToString();
                txt_ngay_nhan_edit.Text = dt["ngay_nhan"].ToString();
                id_tram_edit.Text = dt["id_tram"].ToString();
                trang_thai_edit.Text = dt["trangthai_thietbi"].ToString();
                txt_soluong_edit.Text = dt["soluong"].ToString();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            DateTime date = DateTime.Now;
            int dvtinh = Convert.ToInt32(id_dvtinh_edit.Text);
            int soluong = Convert.ToInt32(txt_soluong_edit.Text);
            int id_loai = Convert.ToInt32(id_loaitb_edit.SelectedValue.ToString());
            int tram = Convert.ToInt32(id_tram_edit.SelectedValue.ToString());
            string user = Session["username"].ToString();
            String id = "SELECT id_user FROM Account WHERE name_user='" + user + "'";// lấy thông tin người đang đăng nhập vào hệ thống
            String u="SELECT nguoitao FROM thiet_bi WHERE ma_thietbi='"+txt_matb_edit.Text+"'"; // lấy thông tin id người tạo thiết b
            DateTime d = Convert.ToDateTime(txt_ngay_nhan_edit.Text);
            int id_user, user_create;
            foreach (DataRow dt1 in db.bindDataTable(u).Rows)
            {
                user_create = Convert.ToInt32(dt1["nguoitao"].ToString());
                foreach (DataRow dt in db.bindDataTable(id).Rows)
                {
                    id_user = Convert.ToInt32(dt["id_user"].ToString());
                    DTO_ThietB dtb = new DTO_ThietB(txt_matb_edit.Text, txt_tentb_edit.Text, dvtinh, soluong, txt_seri_edit.Text, trang_thai_edit.SelectedValue.ToString(), d, date, date, user_create, id_user, id_loai, tram,1);
                    if (bus_tb.Query("_Update_TB", dtb))
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Cập nhật thiết bị thành công !!!', 'success');", true);
                        hienthi();
                        clearAll();
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Cập nhật thiết bị thất bại !!!', 'error');", true);
                    }
                }
            }
        }

        protected void txt_ngay_nhan_edit_TextChanged(object sender, EventArgs e)
        {
            txt_ngay_nhan_edit.Text= DateTime.Now.ToString();
        }
        public void GetData(String ma)
        {
            String sql = "Select * from thiet_bi where ma_thietbi='" + ma.ToString() + "'";
            foreach (DataRow dt in db.bindDataTable(sql).Rows)
            {
                txt_ten.Text = dt["ten_thietbi"].ToString();
            }
        }

        protected void btnDelete_1_Click(object sender, EventArgs e)
        {
            if (bus_tb.Delete("_Delete_TB", txt_delete.Text,"0"))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Xóa thiết bị thành công !!!', 'success');", true);
                hienthi();
                clearAll();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Xóa thiết bị thất bại !!!', 'error');", true);
            }
        }
        
        protected void example_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            example.PageIndex = e.NewPageIndex;   //trang hien tai
            int trang_thu = e.NewPageIndex;      //the hien trang thu may
            int so_dong = example.PageSize;       //moi trang co bao nhieu dong
            stt = trang_thu * so_dong + 1;
            hienthi();
        }

        protected void example_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            
        }

        protected void searchDV_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                string user = Session["username"].ToString();
                string id_donvi = "SELECT id_donvi from Account WHERE name_user='" + user + "'";
                foreach (DataRow dt in db.bindDataTable(id_donvi).Rows)
                {
                    string id = dt["id_donvi"].ToString();
                    String tram = "SELECT id_tram from nha_tram where id_donvi='" + id + "'";
                    foreach (DataRow dt1 in db.bindDataTable(tram).Rows)
                    {
                        string id_tram = dt1["id_tram"].ToString();
                        String sql = "SELECT *,nha_tram.ten_tram,case trangthai_thietbi when 'True' Then N'Đang hoạt động' When 'False' Then N'Không hoạt động' end as trang_thai FROM thiet_bi,nha_tram where thiet_bi.id_tram=nha_tram.id_tram and thiet_bi.inserted=1 and thiet_bi.id_tram='" + id_tram + "' and id_loaitb='" + searchDV.SelectedValue.ToString() + "'";
                        DataView dv = new DataView(db.bindDataTable(sql));
                        example.DataSource = dv;
                        example.DataBind();
                    }
                }
            }
            else
            {
                Response.Redirect("~/DangNhap.aspx");
            }
        }

        protected void btn_refresh_Click(object sender, EventArgs e)
        {
            hienthi();
        }

        protected void SearchStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (SearchStatus.SelectedValue.ToString()=="NULL")
            {
                hienthi();
            }
            else
            {
                if (Session["username"] != null)
                {
                    string user = Session["username"].ToString();
                    string id_donvi = "SELECT id_donvi from Account WHERE name_user='" + user + "'";
                    foreach (DataRow dt in db.bindDataTable(id_donvi).Rows)
                    {
                        string id = dt["id_donvi"].ToString();
                        String tram = "SELECT id_tram from nha_tram where id_donvi='" + id + "'";
                        foreach (DataRow dt1 in db.bindDataTable(tram).Rows)
                        {
                            string id_tram = dt1["id_tram"].ToString();
                            String sql = "SELECT *,nha_tram.ten_tram,case trangthai_thietbi when 'True' Then N'Đang hoạt động' When 'False' Then N'Không hoạt động' end as trang_thai FROM thiet_bi,nha_tram where thiet_bi.id_tram=nha_tram.id_tram and thiet_bi.inserted=1 and thiet_bi.id_tram='" + id_tram + "' and trangthai_thietbi='" + SearchStatus.SelectedValue.ToString() + "'";
                            DataView dv = new DataView(db.bindDataTable(sql));
                            example.DataSource = dv;
                            example.DataBind();
                        }
                    }
                }
                else
                {
                    Response.Redirect("~/DangNhap.aspx");
                }
            }
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
                case "tentb":
                    if (Session["username"] != null)
                    {
                        string user = Session["username"].ToString();
                        string id_donvi = "SELECT id_donvi from Account WHERE name_user='" + user + "'";
                        foreach (DataRow dt in db.bindDataTable(id_donvi).Rows)
                        {
                            string id = dt["id_donvi"].ToString();
                            String tram = "SELECT id_tram from nha_tram where id_donvi='" + id + "'";
                            foreach (DataRow dt1 in db.bindDataTable(tram).Rows)
                            {
                                string id_tram = dt1["id_tram"].ToString();
                                String sql = "SELECT *,nha_tram.ten_tram,case trangthai_thietbi when 'True' Then N'Đang hoạt động' When 'False' Then N'Không hoạt động' end as trang_thai FROM thiet_bi,nha_tram where thiet_bi.id_tram=nha_tram.id_tram and thiet_bi.id_tram='" + id_tram + "' and thiet_bi.inserted=1 and ten_thietbi like '%" + inputSearch.Text + "%'";
                                DataView dv = new DataView(db.bindDataTable(sql));
                                example.DataSource = dv;
                                example.DataBind();
                            }
                        }
                    }
                    else
                    {
                        Response.Redirect("~/DangNhap.aspx");
                    }
                    break;
                case "matb":
                    if (Session["username"] != null)
                    {
                        string user = Session["username"].ToString();
                        string id_donvi = "SELECT id_donvi from Account WHERE name_user='" + user + "'";
                        foreach (DataRow dt in db.bindDataTable(id_donvi).Rows)
                        {
                            string id = dt["id_donvi"].ToString();
                            String tram = "SELECT id_tram from nha_tram where id_donvi='" + id + "'";
                            foreach (DataRow dt1 in db.bindDataTable(tram).Rows)
                            {
                                string id_tram = dt1["id_tram"].ToString();
                                String sql = "SELECT *,nha_tram.ten_tram,case trangthai_thietbi when 'True' Then N'Đang hoạt động' When 'False' Then N'Không hoạt động' end as trang_thai FROM thiet_bi,nha_tram where thiet_bi.id_tram=nha_tram.id_tram and thiet_bi.id_tram='" + id_tram + "' and thiet_bi.inserted=1 and ma_thietbi like '%" + inputSearch.Text + "%'";
                                DataView dv = new DataView(db.bindDataTable(sql));
                                example.DataSource = dv;
                                example.DataBind();
                            }
                        }
                    }
                    else
                    {
                        Response.Redirect("~/DangNhap.aspx");
                    }
                    break;
            }
        }

        int stt = 1;
        public string get_stt()
        {
            return Convert.ToString(stt++);
        } 
        protected void example_PageIndexChanging1(object sender, GridViewPageEventArgs e)
        {
            if (searchSelect.SelectedValue == "tentb")
            {
                example.PageIndex = e.NewPageIndex;
                int trang_thu = e.NewPageIndex;
                int so_dong = example.PageSize;
                stt = trang_thu * so_dong + 1;
                if (Session["username"] != null)
                {
                    string user = Session["username"].ToString();
                    string id_donvi = "SELECT id_donvi from Account WHERE name_user='" + user + "'";
                    foreach (DataRow dt in db.bindDataTable(id_donvi).Rows)
                    {
                        string id = dt["id_donvi"].ToString();
                        String tram = "SELECT id_tram from nha_tram where id_donvi='" + id + "'";
                        foreach (DataRow dt1 in db.bindDataTable(tram).Rows)
                        {
                            string id_tram = dt1["id_tram"].ToString();
                            String sql = "SELECT *,nha_tram.ten_tram,case trangthai_thietbi when 'True' Then N'Đang hoạt động' When 'False' Then N'Không hoạt động' end as trang_thai FROM thiet_bi,nha_tram where thiet_bi.id_tram=nha_tram.id_tram and thiet_bi.id_tram='" + id_tram + "' and thiet_bi.inserted=1 and ten_thietbi like '%" + inputSearch.Text + "%'";
                            DataView dv = new DataView(db.bindDataTable(sql));
                            example.DataSource = dv;
                            example.DataBind();
                        }
                    }
                }
                else
                {
                    Response.Redirect("~/DangNhap.aspx");
                }
            }
            else if (searchSelect.SelectedValue == "matb")
            {
                example.PageIndex = e.NewPageIndex;
                int trang_thu = e.NewPageIndex;
                int so_dong = example.PageSize;
                stt = trang_thu * so_dong + 1;
                if (Session["username"] != null)
                {
                    string user = Session["username"].ToString();
                    string id_donvi = "SELECT id_donvi from Account WHERE name_user='" + user + "'";
                    foreach (DataRow dt in db.bindDataTable(id_donvi).Rows)
                    {
                        string id = dt["id_donvi"].ToString();
                        String tram = "SELECT id_tram from nha_tram where id_donvi='" + id + "'";
                        foreach (DataRow dt1 in db.bindDataTable(tram).Rows)
                        {
                            string id_tram = dt1["id_tram"].ToString();
                            String sql = "SELECT *,nha_tram.ten_tram,case trangthai_thietbi when 'True' Then N'Đang hoạt động' When 'False' Then N'Không hoạt động' end as trang_thai FROM thiet_bi,nha_tram where thiet_bi.id_tram=nha_tram.id_tram and thiet_bi.id_tram='" + id_tram + "' and thiet_bi.inserted=1 and ma_thietbi like '%" + inputSearch.Text + "%'";
                            DataView dv = new DataView(db.bindDataTable(sql));
                            example.DataSource = dv;
                            example.DataBind();
                        }
                    }
                }
                else
                {
                    Response.Redirect("~/DangNhap.aspx");
                }
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
    }
}