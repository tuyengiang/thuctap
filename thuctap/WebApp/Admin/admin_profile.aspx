<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_profile.aspx.cs" MasterPageFile="~/SiteAdmin.Master" Inherits="WebApp.Admin.admin_profile" %>
<asp:Content ID="loai_Tb_1" ContentPlaceHolderID="headerTitle" runat="server">
    <title>Thông tin tài khoản</title>
</asp:Content>
<asp:Content ID="loai_Tb_2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
        <div class="row">
                <div class="breadcrumb">
                    <a href="/Trangchu.aspx"><i class="fa fa-home"></i> Trang chủ</a>
                    <i class="fa fa-angle-right"></i>
                    <a href="/admin_profile.aspx">Thông tin tài khoản</a>
                </div>
          </div>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-3 col-md-offset-3">
                <div class="avatar-user-profile">
                    <asp:Image ID="avatar_account" runat="server" />
                </div>
            </div>
            <div class="col-md-4" id="profile-info">
                    <table>
                        <asp:Repeater ID="Repeater1" runat="server">
                             <ItemTemplate>
                                 <p class="title">Tên tài khoản: <%#Eval("name_user") %></p>
                                 <p class="title">Tên hiển thị: <%#Eval("tenhienthi") %></p>
                                 <p class="title">Số điện thoại: <a href="+tel:0<%#Eval("sdt") %>">0<%#Eval("sdt") %></a></p>
                                 <p class="title">Đơn vị: <%#Eval("ten_donvi") %></p>
                             </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </div>
            </div>
    </form>
</asp:Content>
