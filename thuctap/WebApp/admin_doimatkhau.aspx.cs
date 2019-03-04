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
using System.IO;

namespace MyNews
{
    public partial class admin_doimatkhau : System.Web.UI.Page
    {
        Class1 db = new Class1();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               
            }

        }

        protected void btnChange_Click(object sender, EventArgs e)
        {
            DataTable dt = db.ExecuteSelectProcedure("ChekLoginAdmin", new object[] { Session["ID"].ToString(), txtOldPass.Text.Trim() });
            if (dt.Rows.Count > 0)
            {
                db.ExecuteSelectProcedure("ChangePass", new object[] { Session["ID"].ToString(), txtNewPass.Text.Trim() });
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "alert('Mật khẩu đã được thay đổi !');", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "alert('Sai mật khẩu !');", true);
            }
        }

    }
}