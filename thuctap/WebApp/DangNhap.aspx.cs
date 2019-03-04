using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Net.Mail;

namespace MyNews.Admin
{
    public partial class DangNhap : System.Web.UI.Page
    {
        string username = "";
        string pass = "";
        Class1 db = new Class1();
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["UserName"] = null;
            Session["username"] = null;
            Session["ID"] = null;
            Session["Menu"] = null;
           
        }

        protected void btndangnhap_Click(object sender, EventArgs e)
        {
            // Loại bỏ ký tự đặc biệt
                username = txtuser.Text.Trim().Replace("'", "''").Replace("or", ".").Replace(">", ".").Replace("<", ".").Replace("=", ".");
                pass = txtpass.Text.Trim().Replace("'", "''").Replace("or", ".").Replace(">", ".").Replace("<", ".").Replace("=", ".");
                string pass1 = db.MD5Hash(pass);
                // string sql = "select * from user where username = '"+ username +"' and  password = '"+ pass1 +"'"
                //DataTable dt = db.bindDataTable(sql);

                //DataTable dt = db.ExecuteSelectProcedure("SelectAdmin", new object[] { username, pass1 });
                //if (dt.Rows.Count > 0)
                //{

                //    Response.Redirect("~/admin_donvitinh.aspx");
                //}
                //else
                //{
                   
                //    lblThongBao.Text = "Đăng nhập không thành công !";
                //    txtuser.Focus();
                //    return;

                //}

                Response.Redirect("~/TrangChu.aspx");
        }

    }
}
