using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApp.DTO
{
    public class DTO_NO
    {
        private string title;
        private string content;
        private int id_user;
        private DateTime create;
        private DateTime update;

        public string TITLE
        {
            get { return title; }
            set { title = value; }
        }
        public string CONTENT
        {
            get { return content; }
            set { content = value; }
        }
        public int USER
        {
            get { return id_user; }
            set { id_user = value; }
        }
        public DateTime CREATE
        {
            get { return create; }
            set { create = value; }
        }
        public DateTime UPDATE
        {
            get { return update; }
            set { update = value; }
        }

        public DTO_NO(string title,string content,int id_user,DateTime create,DateTime update)
        {
            this.title = title;
            this.content = content;
            this.id_user = id_user;
            this.create = create;
            this.update = update;
        }
    }
}