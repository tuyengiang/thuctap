using MyNews;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WebApp
{
    public partial class admin_ds_don_vi : System.Web.UI.Page
    {
        Class1 db = new Class1();
        public void hienthi()
        {
            ds.DataSource = db.ExecuteSelectProcedure("__Select_donvi", new object[] {  });
            ds.DataBind();

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            hienthi();
        }

        protected void btn_add_Click3(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txt_madv.Text))
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "alert('Chưa nhập mã đơn vị !');", true);
                }
                else if (string.IsNullOrEmpty(txt_tendv.Text))
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "alert('Chưa nhập tên đơn vị !');", true);
                }
                else if (string.IsNullOrEmpty(txt_diachi.Text))
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "alert('Chưa nhập địa chỉ !');", true);
                }
                else if (string.IsNullOrEmpty(txt_mota.Text))
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "alert('Chưa nhập thông tin mô tả !');", true);
                }
                else
                {
                    db.ExecuteCRUDProcedure("_Insert_donvi", new object[] { txt_madv.Text, txt_tendv.Text, txt_diachi.Text, txt_mota.Text });
                    hienthi();
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "alert('Thêm đơn vị thành công !');", true);
                }
            }catch(Exception ex)
            {

            }

        }

        
    }
}