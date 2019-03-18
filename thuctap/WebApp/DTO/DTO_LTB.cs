using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApp.DTO
{
    public class DTO_LTB
    {
        private string _ma_loaiTB;
        private string _ten_loaiTB;
        private string _mo_ta;

        public string MaLoaiTB
        {
            get { return _ma_loaiTB;  }
            set { _ma_loaiTB = value; }
        }

        public string TenLoaiTB
        {
            get { return _ten_loaiTB; }
            set { _ten_loaiTB = value; }
        }
        
        public string MoTa
        {
            get { return _mo_ta; }
            set { _mo_ta = value; }
        }

        public DTO_LTB(string pma,string pten,string pmota)
        {
            this._ma_loaiTB = pma;
            this._ten_loaiTB = pten;
            this._mo_ta = pmota;
        }
    }
}