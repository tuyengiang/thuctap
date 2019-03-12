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

namespace WebApp.Admin
{
    public partial class admin_ds_remove_account : System.Web.UI.Page
    {
        Class1 db = new Class1();
        BUS_AD bus = new BUS_AD();
        protected void Page_Load(object sender, EventArgs e)
        {
            hienthi();
        }
        public void hienthi()
        {
            String sql = "SELECT Account.*, don_vi.ten_donvi,group_user.name_super,case gioitinh when 'False' then N'Nữ' when 'True' then N'Nam' end as gioitinhA FROM Account,don_vi,group_user Where Account.id_donvi=don_vi.id_donvi AND Account.id_supper=group_user.id_supper AND xoatk='True'";
            DataView dv = new DataView(db.bindDataTable(sql));
            example.DataSource = dv;
            example.DataBind();
        }

        protected void example_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "refresh")
            {
                String ma = e.CommandArgument.ToString();
                txt_ten.Text = ma;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalAddDelete();", true);
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            if (bus.refresh("_Refresh_Account",txt_ten.Text,"False"))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Khôi phục tài khoản thành công !!!', 'success');", true);
                hienthi();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "$.notify('Khôi phục tài khoản thất bại !!!', 'error');", true);
            }
        }
    }
}