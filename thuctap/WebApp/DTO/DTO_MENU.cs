using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApp.DTO
{
    public class DTO_MENU
    {
        private string name;
        private string link;
        private int id_Menu;
        private string icon;
        private string icon_toggle;
        private string toggle;
        private string toggle_id;

        public string NAME
        {
            get { return name; }
            set { name = value; }
        }
        public string ICON
        {
            get { return icon; }
            set { icon = value; }
        }
        public string LINK
        {
            get { return link; }
            set { link = value; }
        }
        public int ID_MENU
        {
            get { return id_Menu; }
            set { id_Menu = value; }
        }
        public string ICON_TO
        {
            get { return icon_toggle; }
            set { icon_toggle = value; }
        }
        public string TOGGLE
        {
            get { return toggle; }
            set { toggle = value; }
        }
        public string TO_ID
        {
            get { return toggle_id; }
            set { toggle_id = value; }
        }

        public DTO_MENU(string name,string link,int id,string icon,string icon_tg,string tg,string tg_id)
        {
            this.name = name;
            this.link = link;
            this.id_Menu = id;
            this.icon = icon;
            this.icon_toggle = icon_tg;
            this.toggle = tg;
            this.toggle_id = tg_id;
        }

    }
}