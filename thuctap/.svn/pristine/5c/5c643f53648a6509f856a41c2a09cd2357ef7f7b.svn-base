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

namespace MyNews
{
    public partial class admin_footer : System.Web.UI.UserControl
    {
        Class1 db = new Class1();
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dt = db.ExecuteSelectProcedure("SelectContact", new object[] { });
            rpt.DataSource = dt;
            rpt.DataBind();

         

            //rptPhone.DataSource = db.ExecuteSelectProcedure("SelectSupport", new object[] { "hotline" });
            //rptPhone.DataBind();

            //BindGioiThieu();
            //BindCS();
            //BindTin();
        }

        //public void BindGioiThieu()
        //{
        //    DataTable dt = db.ExecuteSelectProcedure("SelectNews1", new object[] { "1" });
        //    rpt1.DataSource = dt;
        //    rpt1.DataBind();
        //}
        //public void BindCS()
        //{
        //    DataTable dt = db.ExecuteSelectProcedure("SelectNews1", new object[] { "28" });
        //    rpt2.DataSource = dt;
        //    rpt2.DataBind();
        //}
        //public void BindTin()
        //{
        //    DataTable dt = db.ExecuteSelectProcedure("SelectTopNewsGroup", new object[] { 5, "2" });
        //    rpt3.DataSource = dt;
        //    rpt3.DataBind();
        //}
    }
}