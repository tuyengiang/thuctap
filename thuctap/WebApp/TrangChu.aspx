<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Trangchu.aspx.cs" MasterPageFile="~/SiteAdmin.Master" Inherits="WebApp.Trangchu" %>
         <asp:Content ID="Content1" ContentPlaceHolderID="headerTitle" runat="server">
             <title>VNPT Hệ thống quản lý thiết bị viễn thông</title>
         </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
            <form runat="server" id="form1">
                <div class="row">
                    <div class="breadcrumb">
                        <a href="/Trangchu.aspx"><i class="fa fa-home"></i> Trang chủ</a>
                        <i class="fa fa-angle-right"></i>
                        <a href="/Admin/TrangChu.aspx">Bảng tin</a>
                    </div>
                </div><!--breadcrum-->
                <div class="row">
                    <div class="col-sm-12 col-xs-12 col-md-6 tin-tuc">
                        <div class="title-bt"><i class="fa fa-bullhorn"></i> Thông báo</div>
                    </div>
                </div>
             </form>
        </asp:Content>

