<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/SiteAdmin.Master" CodeBehind="admin_phan_quyen.aspx.cs" Inherits="WebApp.Admin.admin_phan_quyen" %>
<asp:Content ID="Account_1" ContentPlaceHolderID="headerTitle" runat="server">
    <title>VNPT - Phân quyền tài khoản</title>
</asp:Content>
<asp:Content ID="Account_2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
        <div class="row">
                <div class="breadcrumb">
                    <a href="/Trangchu.aspx"><i class="fa fa-home"></i> Trang chủ</a>
                    <i class="fa fa-angle-right"></i>
                    <a href="/Admin/admin_phan_quyen.aspx">Phân quyền tài khoản</a>
                </div>
        </div><!--breadcrum-->
         <div class="row" id="form">
            <div class="col-xs-12 col-sm-12 col-md-4">
                <div class="form-group">
                     <asp:DropDownList ID="DSuser" runat="server" CssClass="form-control"  AutoPostBack="true"></asp:DropDownList>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-4">
                <span><asp:LinkButton ID="btnSave" ValidationGroup="Search" runat="server" CssClass="btn btn-success"><i class="fa fa-save"></i> Lưu lại</asp:LinkButton></span>
                <span><asp:LinkButton ID="btn_refresh" ValidationGroup="Refresh" runat="server" CssClass="btn btn-primary"><i class="fa fa-refresh"></i> Refresh</asp:LinkButton></span>
            </div>
         </div>
            
         <div class="row">
             <div class="col-md-5 list__views-left">
                 <div class="listView">
                     <div class="h2-title">Menu</div>
                     <div class="list">
                         <asp:ListBox ID="ListMenu" runat="server" SelectionMode="Multiple"></asp:ListBox>
                     </div>
                 </div>
             </div>
             <div class="col-md-2">
                 <asp:LinkButton ID="btnChoose" runat="server" CssClass="btn btn-success" OnClick="btnChoose_Click"><i class="fa fa-angle-double-right"></i> Chuyển</asp:LinkButton>
                 <br />
                 <asp:LinkButton ID="btnMove" runat="server" CssClass="btn btn-success" OnClick="btnMove_Click"><i class="fa fa-angle-double-left"></i> Chuyển</asp:LinkButton>
             </div>
             <div class="col-md-5 list__views-right">
                  <div class="listView">
                     <div class="h2-title">Menu User</div>
                      <div class="list">
                          <asp:ListBox ID="ListMenuUser" runat="server" SelectionMode="Multiple"></asp:ListBox>
                     </div>
                 </div>
             </div>
         </div>
    </form>
</asp:Content>
