using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApp.DTO
{
    public class DTO_TRAM
    {
        private string ma_tram;
        private string ten_tram;
        private int don_vi;
        private string dia_chi;
        private string mo_ta;

        public string MA
        {
            get { return ma_tram; }
            set { ma_tram = value; }
        }
        public string TEN
        {
            get { return ten_tram; }
            set { ten_tram = value; }
        }
        
        public string DIA_CHI
        {
            get { return dia_chi; }
            set { dia_chi = value; }
        }
        public string MO_TA
        {
            get { return mo_ta; }
            set { mo_ta = value; }
        }

        public int DON_VI
        {
            get { return don_vi; }
            set { don_vi = value; }
        }
        public DTO_TRAM(string ma,string ten,string dc,string mt, int dv)
        {
            this.ma_tram = ma;
            this.ten_tram = ten;
            this.dia_chi = dc;
            this.mo_ta = mt;
            this.don_vi = dv;
        }

    }
}