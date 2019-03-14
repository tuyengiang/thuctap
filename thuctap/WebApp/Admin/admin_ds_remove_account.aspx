<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_ds_remove_account.aspx.cs" MasterPageFile="~/SiteAdmin.Master" Inherits="WebApp.Admin.admin_ds_remove_account" %>
<asp:Content ID="don_vi_1" ContentPlaceHolderID="headerTitle" runat="server">
            <title>VNPT - Khôi phục tài khoản</title>
</asp:Content>
<asp:Content ID="don_vi_2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
       <div class="row">
            <div class="breadcrumb">
                <a href="/Trangchu.aspx"><i class="fa fa-home"></i> Trang chủ</a>
                <i class="fa fa-angle-right"></i>
                <a href="/Admin/admin_ds_remove_account.aspx">Danh sách tài khoản bị xóa</a>
            </div>
           <a href="/Admin/admin_add_Account.aspx" class="btn btn-primary"><i class="fa fa-angle-left"></i> Quay trở lại</a>
      </div><!--breadcrum-->
         <div class="row">
            <div class="table-responsive">
                  <asp:GridView ID="example" runat="server" CssClass="table table-bordered table-hover" style="width:100%" AutoGenerateColumns="False" OnRowCommand="example_RowCommand" OnRowDataBound="example_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="name_user" HeaderText="Tên tài khoản" SortExpression="ma_donvi" />
                            <asp:BoundField DataField="tenhienthi" HeaderText="Tên hiển thị" SortExpression="ten_donvi" />
                            <asp:BoundField DataField="sdt" HeaderText="Số điện thoại" SortExpression="dia_chi" />
                            <asp:BoundField DataField="ten_donvi" HeaderText="Đơn vị" SortExpression="dia_chi" />
                            <asp:BoundField DataField="gioitinhA" HeaderText="Giới tính" SortExpression="dia_chi" />
                            <asp:BoundField DataField="name_super" HeaderText="Quyền hạn" SortExpression="dia_chi" />
                            <asp:TemplateField HeaderText="Chức năng">
                                <ItemTemplate>
                                     <asp:LinkButton ID="btnReset" runat="server" CommandArgument='<%#Eval("name_user") %>' CssClass="btn btn-warning"  data-target="#myMoDelete" CommandName="refresh" title="Khôi phục tài khoản"><i class="fa  fa-recycle"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                         </Columns>
                   </asp:GridView>
              </div>
            </div>
        <div class="row">
            <div class="modal fade" id="myMoDelete" role="dialog">
                    <div class="modal-dialog">
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                          <h4 class="modal-title">Khôi phục tài khoản</h4>
                        </div>
                        <div class="modal-body">
                            <asp:TextBox ID="txt_delete" runat="server" Enabled="False" Visible="False"></asp:TextBox>
                            <h4 style="font-weight:normal;">Bạn có muốn khôi phục tài khoản  <span style="padding-left:5px;padding-right:5px;color:#ff3333;"><asp:Label ID="txt_ten" runat="server" Text="Label"></asp:Label></span>không ?</h4>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn btn-success" OnClick="btnRefresh_Click"><i class="fa fa-refresh"></i> Khôi phục</asp:LinkButton>
                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-sign-out"></i> Đóng</button>
                        </div>
                      </div>
      
                    </div>
                </div><!--modal-delete-->
            </div><!--modal-->
        </div>
        </div>
    </form>
</asp:Content>