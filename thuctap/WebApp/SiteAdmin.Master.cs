using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text.RegularExpressions;
using System.IO;
namespace MyNews
{
    public partial class SiteAdmin : System.Web.UI.MasterPage
    {
        Class1 db = new Class1();
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (Session["ID"] != null)
            {
                CheckBox2.Checked = false;
                if (!IsPostBack)
                {
                    lblHoTen.Text = Session["DisplayName"].ToString();
                    BindInfo(Session["ID"].ToString());
                    //rpt.DataSource = db.ExecuteSelectProcedure("SelectContact", new object[] { });
                    //rpt.DataBind();
                }
                // hiển thị thông báo
                DataTable dtSapHetHan = db.ExecuteSelectProcedure("_Select_TonKho", new object[] { 0, 0, 0, 0, DateTime.Now.ToString("dd/MM/yyyy"), 2 });
                lblNotify.Text = dtSapHetHan.Rows.Count.ToString();

                // hiển thị thông báo
                DataTable dtHetHan = db.ExecuteSelectProcedure("_Select_TonKho", new object[] { 0, 0, 0, 0, DateTime.Now.ToString("dd/MM/yyyy"), 3 });
                lblHetHan.Text = dtHetHan.Rows.Count.ToString();
            }
            else
            {
                Response.Redirect("/dangnhap");
            }
        }
        protected void CheckBox2_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox2.Checked = true;
        }
        public void BindInfo(string userid)
        {
            DataTable dt = db.ExecuteSelectProcedure("SelectAdminId", new object[] { userid });
            txtPhone.Text = dt.Rows[0]["phone"].ToString();
            txtAddress.Text = dt.Rows[0]["address"].ToString();
            txtName.Text = dt.Rows[0]["name"].ToString();
            txtEmail.Text = dt.Rows[0]["email"].ToString();
            imgAvatar.ImageUrl = "~" + dt.Rows[0]["avatar"].ToString();
            Label3.Text = dt.Rows[0]["avatar"].ToString();
            lblDonVi.Text = dt.Rows[0]["tendonvi"].ToString();
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["ID"] = null;
            Session["DisplayName"] = null;
            Session["Menu"] = null;
            Response.Redirect("/dangnhap");
        }

        protected void btnChange_Click(object sender, EventArgs e)
        {
            DataTable dt = db.ExecuteSelectProcedure("ChekLoginAdmin", new object[] { Session["ID"].ToString(), db.MD5Hash(txtOldPass.Text.Trim()) });
            if (dt.Rows.Count > 0)
            {
                db.ExecuteSelectProcedure("ChangePass", new object[] { Session["ID"].ToString(), db.MD5Hash(txtNewPass.Text.Trim()) });
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "alert('Mật khẩu đã được thay đổi !');", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "alert('Sai mật khẩu !');", true);
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtName.Text))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "alert('Chưa nhập tên !');", true);
            }
            else if (string.IsNullOrEmpty(txtEmail.Text))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "alert('Chưa nhập email !');", true);
            }
            else if (!Regex.IsMatch(txtEmail.Text, @"^(\w+@\w+\.\w+)$"))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "alert('Định dạng email không đúng!');", true);
            }
            else if (string.IsNullOrEmpty(txtPhone.Text))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "alert('Chưa nhập số điện thoại !');", true);
            }
            else if (!Regex.IsMatch(txtPhone.Text, @"^(0\d{9,10})$"))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "alert('Định dạng số điện thoại không đúng !');", true);
            }
            else if (string.IsNullOrEmpty(txtAddress.Text))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "alert('Chưa nhập địa chỉ !');", true);
            }
            else
            {
                string fullfilename = "";
                string filename = "/images/dummy.png";
                if (CheckBox2.Checked == true)
                {
                    if (FileUpload1.HasFile)
                    {
                        fullfilename = Path.GetFileName(FileUpload1.FileName);
                        fullfilename = fullfilename.Replace(" ", "_");
                        //FileUpload1.SaveAs(Server.MapPath("~/anh/" + fullfilename));
                        //filename = "/anh/" + fullfilename;

                        Guid uid = Guid.NewGuid();
                        string SaveLocation = Server.MapPath("~/avatar/") + "" + uid + fullfilename;
                        string fileExtention = FileUpload1.PostedFile.ContentType;
                        int fileLenght = FileUpload1.PostedFile.ContentLength;
                        System.Drawing.Bitmap bmpPostedImage = new System.Drawing.Bitmap(FileUpload1.PostedFile.InputStream);
                        db.ResizeImage(fullfilename, fileExtention, fileLenght, 600, bmpPostedImage, SaveLocation);
                        filename = "/avatar/" + uid + fullfilename;
                    }
                    else
                    {
                        filename = "/images/dummy.png";
                    }
                }
                else
                {
                    filename = Label3.Text;
                }
                int kq = db.ExecuteCRUDProcedure("UpdateAdmin_Info", new object[] { Session["ID"].ToString(), txtEmail.Text.Trim(), txtName.Text.Trim(), txtPhone.Text.Trim(), txtAddress.Text.Trim(), filename });
                lblHoTen.Text = txtName.Text.Trim();
                Session["DisplayName"] = txtName.Text;

                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "myalert", "alert('Cập nhật thành công !');", true);

                //Response.Redirect("/home");
            }
        }
    }
}