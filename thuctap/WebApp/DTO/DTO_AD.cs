using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApp.DTO
{
    public class DTO_AD
    {
        private string name_user;
        private string name_display;
        private string password;
        private string sex;
        private int sdt;
        private DateTime ngaysinh;
        private int don_vi;
        private DateTime ngay_tao;
        private DateTime ngay_cap_nhat;
        private string avatar;
        private int supper;
        private String khoatk;
        private String xoatk;

        public String NameUser
        {
            get { return name_user; }
            set { name_user = value; }
        }
        public String NameDisplay
        {
            get { return name_display; }
            set { name_display = value; }
        }
        public String Password
        {
            get { return password; }
            set { password = value; }
        }
        public String Sex
        {
            get { return sex; }
            set { sex = value; }
        }
        public int SDT
        {
            get { return sdt; }
            set { sdt = value; }
        }
        public DateTime NgaySinh
        {
            get { return ngaysinh; }
            set { ngaysinh = value; }
        }
        public int DonVi
        {
            get { return don_vi; }
            set { don_vi = value; }
        }
        public DateTime NgayTao
        {
            get { return ngay_tao; }
            set { ngay_tao = value; }
        }
        public DateTime NgayCapNhat
        {
            get { return ngay_cap_nhat; }
            set { ngay_cap_nhat = value; }
        }
        public String Avartar
        {
            get { return avatar; }
            set { avatar = value; }
        }
        public int Supper
        {
            get { return supper; }
            set { supper = value; }
        }
        public String XoaTK
        {
            get { return xoatk; }
            set { xoatk = value; }
        }
        public String KhoaTK
        {
            get { return khoatk; }
            set { khoatk = value; }
        }



        public DTO_AD (string pname,string pmk, string pht,string sex,int sdt, DateTime birth, int dv,string avatar, string k, string x,DateTime create, DateTime update,int supper)
        {
            this.name_user = pname;
            this.password = pmk;
            this.name_display = pht;
            this.sex = sex;
            this.sdt = sdt;
            this.ngaysinh = birth;
            this.don_vi = dv;
            this.avatar = avatar;
            this.khoatk = k;
            this.xoatk = x;
            this.ngay_tao =create;
            this.ngay_cap_nhat =update;
            this.supper = supper;
        }
    }
}