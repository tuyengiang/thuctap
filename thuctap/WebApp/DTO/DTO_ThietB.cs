using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApp.DTO
{
    public class DTO_ThietB
    {
        private String ma_thietbi;
        private String ten_thietbi;
        private int id_dvtinh;
        private int soluong;
        private String seri;
        private string trang_thai;
        private DateTime ngay_nhan;
        private DateTime ngaytao;
        private DateTime ngaysua;
        private int nguoitao;
        private int nguoisua;
        private int id_loaiTb;
        private int id_tram;

        public string MATB
        {
            get { return ma_thietbi; }
            set { ma_thietbi = value; }
        }

        public string TENTB
        {
            get { return ten_thietbi; }
            set { ten_thietbi = value; }
        }
        public int ID_DV
        {
            get { return id_dvtinh; }
            set { id_dvtinh = value; }
        }
        public int COUNT
        {
            get { return soluong; }
            set { soluong = value; }
        }

        public string SERI
        {
            get { return seri; }
            set { seri = value; }
        }
        public string STATUS
        {
            get { return trang_thai; }
            set { trang_thai = value; }
        }
        public DateTime NGAYNHAP
        {
            get { return ngay_nhan; }
            set { ngay_nhan = value; }
        }
        public DateTime NGAYTAO
        {
            get { return ngaytao; }
            set { ngaytao = value; }
        }
        public DateTime NGAYSUA
        {
            get { return ngaysua; }
            set { ngaysua = value; }
        }
        public int USER_CREATE
        {
            get { return nguoitao; }
            set { nguoitao = value; }
        }
        public int USER_EDIT {
            get { return nguoisua;  }
            set { nguoisua = value; }
        }
        public int LOAITB
        {
            get { return id_loaiTb; }
            set { id_loaiTb = value; }
        }

        public int TRAM
        {
            get { return id_tram; }
            set { id_tram = value; }
        }

        public DTO_ThietB( String ma_thietbi,String ten_thietbi,int id_dvtinh,int soluong,String seri,string trang_thai,DateTime ngay_nhan,DateTime ngaytao, DateTime ngaysua, int nguoitao, int nguoisua, int id_loaiTb, int id_tram)
        {
            this.ma_thietbi = ma_thietbi;
            this.ten_thietbi = ten_thietbi;
            this.id_dvtinh = id_dvtinh;
            this.soluong = soluong;
            this.seri = seri;
            this.trang_thai = trang_thai;
            this.ngay_nhan = ngay_nhan;
            this.ngaytao = ngaytao;
            this.ngaysua = ngaysua;
            this.nguoitao = nguoitao;
            this.nguoisua = nguoisua;
            this.id_loaiTb = id_loaiTb;
            this.id_tram = id_tram;
        }
    }
}